/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/GetStreamingEventsRequest.dart';
import 'package:ews/Core/Requests/HangingServiceRequestBase.dart';
import 'package:ews/Core/Responses/GetStreamingEventsResponse.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceResult.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Exceptions/ObjectDisposedException.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Notifications/GetStreamingEventsResults.dart';
import 'package:ews/Notifications/NotificationEventArgs.dart';
import 'package:ews/Notifications/StreamingSubscription.dart';
import 'package:ews/Notifications/SubscriptionErrorEventArgs.dart';
import 'package:synchronized/synchronized.dart';

/// <summary>
/// Represents a delegate that is invoked when an error occurs within a streaming subscription connection.
/// </summary>
/// <param name="sender">The StreamingSubscriptionConnection instance within which the error occurred.</param>
/// <param name="args">The event data.</param>
typedef SubscriptionErrorDelegate = void Function(
    Object sender, SubscriptionErrorEventArgs args);

/// <summary>
/// Represents a delegate that is invoked when notifications are received from the server
/// </summary>
/// <param name="sender">The StreamingSubscriptionConnection instance that received the events.</param>
/// <param name="args">The event data.</param>
typedef NotificationEventDelegate = void Function(
    Object sender, NotificationEventArgs args);

/// <summary>
/// Represents a connection to an ongoing stream of events.
/// </summary>
class StreamingSubscriptionConnection // extends IDisposable
{
  /// <summary>
  /// Mapping of streaming id to subscriptions currently on the connection.
  /// </summary>
  Map<String, StreamingSubscription> _subscriptions = {};

  /// <summary>
  /// connection lifetime, in minutes
  /// </summary>
  late int _connectionTimeout;

  /// <summary>
  /// ExchangeService instance used to make the EWS call.
  /// </summary>
  late ExchangeService _session;

  /// <summary>
  /// Value indicating whether the class is disposed.
  /// </summary>
  bool _isDisposed = false;

  /// <summary>
  /// Currently used instance of a GetStreamingEventsRequest connected to EWS.
  /// </summary>
  GetStreamingEventsRequest? _currentHangingRequest;

  /// <summary>
  /// Lock object
  /// </summary>
  Lock _lockObject = new Lock();

  /// <summary>
  /// Occurs when notifications are received from the server.
  /// </summary>
  List<NotificationEventDelegate> OnNotificationEvent = [];

  /// <summary>
  /// Occurs when a subscription encounters an error.
  /// </summary>
// event SubscriptionErrorDelegate OnSubscriptionError;

  /// <summary>
  /// Occurs when a streaming subscription connection is disconnected from the server.
  /// </summary>
  List<SubscriptionErrorDelegate> OnDisconnect = [];

  /// <summary>
  /// Initializes a new instance of the <see cref="StreamingSubscriptionConnection"/> class.
  /// </summary>
  /// <param name="service">The ExchangeService instance this connection uses to connect to the server.</param>
  /// <param name="lifetime">The maximum time, in minutes, the connection will remain open. Lifetime must be between 1 and 30.</param>
  StreamingSubscriptionConnection(ExchangeService service, int lifetime) {
    EwsUtilities.ValidateParam(service, "service");

    EwsUtilities.ValidateClassVersion(
        service, ExchangeVersion.Exchange2010_SP1, this.runtimeType.toString());

    if (lifetime < 1 || lifetime > 30) {
      throw new RangeError.range(lifetime, 1, 30, "lifetime");
    }

    this._session = service;
    this._connectionTimeout = lifetime;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="StreamingSubscriptionConnection"/> class.
  /// </summary>
  /// <param name="service">The ExchangeService instance this connection uses to connect to the server.</param>
  /// <param name="subscriptions">The streaming subscriptions this connection is receiving events for.</param>
  /// <param name="lifetime">The maximum time, in minutes, the connection will remain open. Lifetime must be between 1 and 30.</param>
// StreamingSubscriptionConnection.withLifetime(
//            ExchangeService service,
//            Iterable<StreamingSubscription> subscriptions,
//            int lifetime) :
//            this(service, lifetime)
//        {
//            EwsUtilities.ValidateParamCollection(subscriptions, "subscriptions");
//
//            for (StreamingSubscription subscription in subscriptions)
//            {
//                this.subscriptions[subscription.Id] = subscription;
//            }
//        }

  /// <summary>
  /// Getting the current subscriptions in this connection.
  /// </summary>
  Iterable<StreamingSubscription> get CurrentSubscriptions {
    List<StreamingSubscription> result = <StreamingSubscription>[];

    result.addAll(this._subscriptions.values);

    return result;
  }

  /// <summary>
  /// Adds a subscription to this connection.
  /// </summary>
  /// <param name="subscription">The subscription to add.</param>
  /// <exception cref="InvalidOperationException">Thrown when AddSubscription is called while connected.</exception>
  void AddSubscription(StreamingSubscription subscription) {
    this.ThrowIfDisposed();

    EwsUtilities.ValidateParam(subscription, "subscription");

    this.ValidateConnectionState(
        false, "Strings.CannotAddSubscriptionToLiveConnection");

    if (this._subscriptions.containsKey(subscription.Id)) {
      return;
    }
    this._subscriptions[subscription.Id!] = subscription;
  }

  /// <summary>
  /// Removes the specified streaming subscription from the connection.
  /// </summary>
  /// <param name="subscription">The subscription to remove.</param>
  /// <exception cref="InvalidOperationException">Thrown when RemoveSubscription is called while connected.</exception>
  void RemoveSubscription(StreamingSubscription subscription) {
    this.ThrowIfDisposed();

    EwsUtilities.ValidateParam(subscription, "subscription");

    this.ValidateConnectionState(
        false, "Strings.CannotRemoveSubscriptionFromLiveConnection");

    this._subscriptions.remove(subscription.Id);
  }

  /// <summary>
  /// Opens this connection so it starts receiving events from the server.
  /// This results in a long-standing call to EWS.
  /// </summary>
  /// <exception cref="InvalidOperationException">Thrown when Open is called while connected.</exception>
  Future<void> Open() async {
    await this._lockObject.synchronized(() async {
      this.ThrowIfDisposed();

      this.ValidateConnectionState(
          false, "Strings.CannotCallConnectDuringLiveConnection");

      if (this._subscriptions.length == 0) {
        throw new ServiceLocalException("Strings.NoSubscriptionsOnConnection");
      }

      this._currentHangingRequest = new GetStreamingEventsRequest(
          this._session,
          this.HandleServiceResponseObject,
          this._subscriptions.keys,
          this._connectionTimeout);

      this._currentHangingRequest!.OnDisconnect.add(this._OnRequestDisconnect);

      await this._currentHangingRequest!.InternalExecute();
    });
  }

  /// <summary>
  /// Called when the request is disconnected.
  /// </summary>
  /// <param name="sender">The sender.</param>
  /// <param name="args">The <see cref="Microsoft.Exchange.WebServices.Data.HangingRequestDisconnectEventArgs"/> instance containing the event data.</param>
  Future<void> _OnRequestDisconnect(
      Object sender, HangingRequestDisconnectEventArgs args) async {
    this.InternalOnDisconnect(args.Exception);
  }

  /// <summary>
  /// Closes this connection so it stops receiving events from the server.
  /// This terminates a long-standing call to EWS.
  /// </summary>
  /// <exception cref="InvalidOperationException">Thrown when Close is called while not connected.</exception>
  Future<void> Close() async {
    await this._lockObject.synchronized(() async {
      this.ThrowIfDisposed();

      this.ValidateConnectionState(
          true, "Strings.CannotCallDisconnectWithNoLiveConnection");

      // Further down in the stack, this will result in a call to our OnRequestDisconnect event handler,
      // doing the necessary cleanup.
      await this._currentHangingRequest?.Disconnect();
    });
  }

  /// <summary>
  /// helper method called when the request disconnects.
  /// </summary>
  /// <param name="ex">The exception that caused the disconnection. May be null.</param>
  /* private */
  void InternalOnDisconnect(Object? ex) {
    this._currentHangingRequest = null;
    for (final delegate in OnDisconnect) {
      delegate(this, new SubscriptionErrorEventArgs(null, ex));
    }
  }

  /// <summary>
  /// Gets a value indicating whether this connection is opened
  /// </summary>
  bool get IsOpen {
    this.ThrowIfDisposed();
    if (this._currentHangingRequest == null) {
      return false;
    } else {
      return this._currentHangingRequest!.IsConnected;
    }
  }

  /// <summary>
  /// Validates the state of the connection.
  /// </summary>
  /// <param name="isConnectedExpected">Value indicating whether we expect to be currently connected.</param>
  /// <param name="errorMessage">The error message.</param>
  /* private */
  void ValidateConnectionState(bool isConnectedExpected, String errorMessage) {
    if ((isConnectedExpected && !this.IsOpen) ||
        (!isConnectedExpected && this.IsOpen)) {
      throw new ServiceLocalException(errorMessage);
    }
  }

  /// <summary>
  /// Handles the service response object.
  /// </summary>
  /// <param name="response">The response.</param>
  /* private */
  Future<void> HandleServiceResponseObject(Object response) async {
    GetStreamingEventsResponse gseResponse =
        response as GetStreamingEventsResponse;

    // if (gseResponse == null)
    // {
    //     throw new ArgumentException("gseResponse == null");
    // }
    // else
    // {
    if (gseResponse.Result == ServiceResult.Success ||
        gseResponse.Result == ServiceResult.Warning) {
      if (gseResponse.Results.Notifications.length > 0) {
        // We got notifications; dole them out.
        await this.IssueNotificationEvents(gseResponse);
      } else {
        //// This was just a heartbeat, nothing to do here.
      }
    } else if (gseResponse.Result == ServiceResult.Error) {
      if (gseResponse.ErrorSubscriptionIds == null ||
          gseResponse.ErrorSubscriptionIds.length == 0) {
        // General error
        this.IssueGeneralFailure(gseResponse);
      } else {
        // subscription-specific errors
        this.IssueSubscriptionFailures(gseResponse);
      }
    }
    // }
  }

  /// <summary>
  /// Issues the subscription failures.
  /// </summary>
  /// <param name="gseResponse">The GetStreamingEvents response.</param>
  /* private */
  void IssueSubscriptionFailures(GetStreamingEventsResponse gseResponse) {
    throw NotImplementedException("IssueSubscriptionFailures");

//            ServiceResponseException exception = new ServiceResponseException(gseResponse);
//
//            for (String id in gseResponse.ErrorSubscriptionIds)
//            {
//              StreamingSubscription subscription = null;
//
//                lock (this.lockObject)
//                {
//                    // Client can do any good or bad things in the below event handler
//                    if (this.subscriptions != null && this.subscriptions.containsKey(id))
//                    {
//                        subscription = this.subscriptions[id];
//                    }
//                }
//
//                if (subscription != null)
//                {
//                    SubscriptionErrorEventArgs eventArgs = new SubscriptionErrorEventArgs(
//                        subscription,
//                        exception);
//
//                    if (this.OnSubscriptionError != null)
//                    {
//                        this.OnSubscriptionError(this, eventArgs);
//                    }
//                }
//
//                if (gseResponse.ErrorCode != ServiceError.ErrorMissedNotificationEvents)
//                {
//                    // Client can do any good or bad things in the above event handler
//                    lock (this.lockObject)
//                    {
//                        if (this.subscriptions != null && this.subscriptions.containsKey(id))
//                        {
//                            // We are no longer servicing the subscription.
//                            this.subscriptions.remove(id);
//                        }
//                    }
//                }
//            }
  }

  /// <summary>
  /// Issues the general failure.
  /// </summary>
  /// <param name="gseResponse">The GetStreamingEvents response.</param>
  /* private */
  void IssueGeneralFailure(GetStreamingEventsResponse gseResponse) {
    throw NotImplementedException("IssueGeneralFailure");

//          SubscriptionErrorEventArgs eventArgs = new SubscriptionErrorEventArgs(
//                null,
//                new ServiceResponseException(gseResponse));
//
//            if (this.OnSubscriptionError != null)
//            {
//                this.OnSubscriptionError(this, eventArgs);
//            }
  }

  /// <summary>
  /// Issues the notification events.
  /// </summary>
  /// <param name="gseResponse">The GetStreamingEvents response.</param>
  /* private */
  Future<void> IssueNotificationEvents(
      GetStreamingEventsResponse gseResponse) async {
    for (NotificationGroup events in gseResponse.Results.Notifications) {
      StreamingSubscription? subscription = null;

      await this._lockObject.synchronized(() async {
        // Client can do any good or bad things in the below event handler
        if (this._subscriptions.containsKey(events.SubscriptionId)) {
          subscription = this._subscriptions[events.SubscriptionId];
        }
      });

      if (subscription != null) {
        NotificationEventArgs eventArgs =
            new NotificationEventArgs(subscription!, events.Events);

        for (final delegate in this.OnNotificationEvent) {
          delegate(this, eventArgs);
        }
      }
    }
  }

  /// <summary>
  /// Finalizes an instance of the StreamingSubscriptionConnection class.
  /// </summary>
//        ~StreamingSubscriptionConnection()
//        {
//            this.Dispose(false);
//        }

  /// <summary>
  /// Frees resources associated with this StreamingSubscriptionConnection.
  /// </summary>
  void Dispose() {
    this.DisposeWithFinalizer(true);
  }

  /// <summary>
  /// Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
  /// </summary>
  /// <param name="suppressFinalizer">Value indicating whether to suppress the garbage collector's finalizer..</param>
  /* private */
  void DisposeWithFinalizer(bool suppressFinalizer) {
    throw NotImplementedException("DisposeWithFinalizer");
//            if (suppressFinalizer)
//            {
//                GC.SuppressFinalize(this);
//            }
//
//            lock (this.lockObject)
//            {
//                if (!this.isDisposed)
//                {
//                    if (this.currentHangingRequest != null)
//                    {
//                        this.currentHangingRequest = null;
//                    }
//
//                    this.subscriptions = null;
//                    this.session = null;
//
//                    this.isDisposed = true;
//                }
//            }
  }

  /// <summary>
  /// Throws if disposed.
  /// </summary>
  /* private */
  void ThrowIfDisposed() {
    if (this._isDisposed) {
      throw new ObjectDisposedException(this.runtimeType.toString());
    }
  }
}
