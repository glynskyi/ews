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

import 'dart:async';
import 'dart:core';

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/ServiceRequestBase.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';
import 'package:synchronized/synchronized.dart';

/// <summary>
/// Enumeration of reasons that a hanging request may disconnect.
/// </summary>
enum HangingRequestDisconnectReason {
  /// <summary>The server cleanly closed the connection.</summary>
  Clean,

  /// <summary>The client closed the connection.</summary>
  UserInitiated,

  /// <summary>The connection timed out do to a lack of a heartbeat received.</summary>
  Timeout,

  /// <summary>An exception occurred on the connection</summary>
  Exception
}

/// <summary>
/// Represents a collection of arguments for the HangingServiceRequestBase.HangingRequestDisconnectHandler
/// delegate method.
/// </summary>
class HangingRequestDisconnectEventArgs // : EventArgs
{
  /// <summary>
  /// Initializes a new instance of the <see cref="HangingRequestDisconnectEventArgs"/> class.
  /// </summary>
  /// <param name="reason">The reason.</param>
  /// <param name="exception">The exception.</param>
  HangingRequestDisconnectEventArgs.withException(
      HangingRequestDisconnectReason reason, Error exception) {
    this.Reason = reason;
    this.Exception = exception;
  }

  /// <summary>
  /// Gets the reason that the user was disconnected.
  /// </summary>
  HangingRequestDisconnectReason Reason;

  /// <summary>
  /// Gets the exception that caused the disconnection. Can be null.
  /// </summary>
  Error Exception;
}

/// <summary>
/// Callback delegate to handle asynchronous responses.
/// </summary>
/// <param name="response">Response received from the server</param>
typedef void HandleResponseObject(Object response);

/// <summary>
/// Delegate method to handle a hanging request disconnection.
/// </summary>
/// <param name="sender">The object invoking the delegate.</param>
/// <param name="args">Event data.</param>
typedef void HangingRequestDisconnectHandler(Object sender, HangingRequestDisconnectEventArgs args);

/// <summary>
/// Represents an abstract, hanging service request.
/// </summary>
abstract class HangingServiceRequestBase extends ServiceRequestBase {
  static const _BufferSize = 4096;

  /// <summary>
  /// Test switch to log all bytes that come across the wire.
  /// Helpful when parsing fails before certain bytes hit the trace logs.
  /// </summary>
  static bool LogAllWireBytes = false;

  /// <summary>
  /// Callback delegate to handle response objects
  /// </summary>
  HandleResponseObject _responseHandler;

  /// <summary>
  /// Response from the server.
  /// </summary>
  IEwsHttpWebResponse _response;

  /// <summary>
  /// Request to the server.
  /// </summary>
  IEwsHttpWebRequest _request;

  /// <summary>
  /// Expected minimum frequency in responses, in milliseconds.
  /// </summary>
  int heartbeatFrequencyMilliseconds;

  /// <summary>
  /// lock object
  /// </summary>
  final _lockObject = new Lock();

  /// <summary>
  /// Occurs when the hanging request is disconnected.
  /// </summary>
  // todo : restore events
//        event HangingRequestDisconnectHandler OnDisconnect;

  /// <summary>
  /// Initializes a new instance of the <see cref="HangingServiceRequestBase"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="handler">Callback delegate to handle response objects</param>
  /// <param name="heartbeatFrequency">Frequency at which we expect heartbeats, in milliseconds.</param>
  HangingServiceRequestBase(
      ExchangeService service, HandleResponseObject handler, int heartbeatFrequency)
      : super(service) {
    this._responseHandler = handler;
    this.heartbeatFrequencyMilliseconds = heartbeatFrequency;
  }

  /// <summary>
  /// Exectures the request.
  /// </summary>
  Future<void> InternalExecute() {
    throw NotImplementedException("InternalExecute");
//            return lockObject.synchronized(() async {
//                this.response = await this.ValidateAndEmitRequest(this.request);
//
//                this.InternalOnConnect();
//            });
//            lock (this.lockObject)
//            {
//                this.response = this.ValidateAndEmitRequest(out this.request);
//
//                this.InternalOnConnect();
//            }
  }

  /// <summary>
  /// Parses the responses.
  /// </summary>
  /// <param name="state">The state.</param>
  void _ParseResponses(Object state) {
    throw NotImplementedException("ParseResponses");
//            try
//            {
//                Uuid traceId = Uuid.empty();
//                HangingTraceStream tracingStream = null;
//                MemoryStream responseCopy = null;
//
//                try
//                {
//                    bool traceEwsResponse = this.Service.IsTraceEnabledFor(TraceFlags.EwsResponse);
//
//
//                    {
//                        responseStream.ReadTimeout = 2 * this.heartbeatFrequencyMilliseconds;
//                        tracingStream = new HangingTraceStream(responseStream, this.Service);
//
//                        // EwsServiceMultiResponseXmlReader.Create causes a read.
//                        if (traceEwsResponse)
//                        {
//                            responseCopy = new MemoryStream();
//                            tracingStream.SetResponseCopy(responseCopy);
//                        }
//
//                        EwsServiceMultiResponseXmlReader ewsXmlReader = EwsServiceMultiResponseXmlReader.Create(tracingStream, this.Service);
//
//                        while (this.IsConnected)
//                        {
//                            object responseObject = null;
//                            if (traceEwsResponse)
//                            {
//                                try
//                                {
//                                    responseObject = this.ReadResponseWithHeaders(ewsXmlReader, this.response.Headers);
//                                }
//                                finally
//                                {
//                                    this.Service.TraceXml(TraceFlags.EwsResponse, responseCopy);
//                                }
//
//                                // reset the stream collector.
//                                responseCopy.Close();
//                                responseCopy = new MemoryStream();
//                                tracingStream.SetResponseCopy(responseCopy);
//                            }
//                            else
//                            {
//                                responseObject = this.ReadResponseWithHeaders(ewsXmlReader, this.response.Headers);
//                            }
//
//                            this.responseHandler(responseObject);
//                        }
//                    }
//                }
//                on TimeoutException catch ( ex)
//                {
//                    // The connection timed out.
//                    this.DisconnectWithException(HangingRequestDisconnectReason.Timeout, ex);
//                    return;
//                }
//                on IOException catch ( ex)
//                {
//                    // Stream is closed, so disconnect.
//                    this.DisconnectWithException(HangingRequestDisconnectReason.Exception, ex);
//                    return;
//                }
//                on HttpException catch ( ex)
//                {
//                    // Stream is closed, so disconnect.
//                    this.DisconnectWithException(HangingRequestDisconnectReason.Exception, ex);
//                    return;
//                }
//                on WebException catch ( ex)
//                {
//                    // Stream is closed, so disconnect.
//                    this.DisconnectWithException(HangingRequestDisconnectReason.Exception, ex);
//                    return;
//                }
//                on ObjectDisposedException catch ( ex)
//                {
//                    // Stream is closed, so disconnect.
//                    this.DisconnectWithException(HangingRequestDisconnectReason.Exception, ex);
//                    return;
//                }
//                on NotSupportedException
//                {
//                    // This is thrown if we close the stream during a read operation due to a user method call.
//                    // Trying to delay closing until the read finishes simply results in a long-running connection.
//                    this.DisconnectWithException(HangingRequestDisconnectReason.UserInitiated, null);
//                    return;
//                }
//                on XmlException catch ( ex)
//                {
//                    // Thrown if server returned no XML document.
//                    this.DisconnectWithException(HangingRequestDisconnectReason.UserInitiated, ex);
//                    return;
//                }
//                finally
//                {
//                    if (responseCopy != null)
//                    {
//                        responseCopy.Dispose();
//                        responseCopy = null;
//                    }
//                }
//            }
//            on ServiceLocalException catch ( exception)
//            {
//                this.DisconnectWithException(HangingRequestDisconnectReason.Exception, exception);
//            }
  }

  /// <summary>
  /// Gets a value indicating whether this instance is connected.
  /// </summary>
  /// <value><c>true</c> if this instance is connected; otherwise, <c>false</c>.</value>
  bool IsConnected;

  /// <summary>
  /// Disconnects the request.
  /// </summary>
  void Disconnect() {
    throw NotImplementedException("Disconnect");
//            lock (this.lockObject)
//            {
//                this.request.Abort();
//                this.response.Close();
//                this.Disconnect(HangingRequestDisconnectReason.UserInitiated, null);
//            }
  }

  /// <summary>
  /// Disconnects the request with the specified reason and exception.
  /// </summary>
  /// <param name="reason">The reason.</param>
  /// <param name="exception">The exception.</param>
  void DisconnectWithException(HangingRequestDisconnectReason reason, Exception exception) {
    if (this.IsConnected) {
      this._response.Close();
      this._InternalOnDisconnect(reason, exception);
    }
  }

  /// <summary>
  /// Perform any bookkeeping needed when we connect
  /// </summary>
  void _InternalOnConnect() {
    throw NotImplementedException("InternalOnConnect");
//            if (!this.IsConnected)
//            {
//                this.IsConnected = true;
//
//                // Trace Http headers
//                this.Service.ProcessHttpResponseHeaders(
//                    TraceFlags.EwsResponseHttpHeaders,
//                    this.response);
//
//                ThreadPool.QueueUserWorkItem(
//                    new WaitCallback(this.ParseResponses));
//            }
  }

  /// <summary>
  /// Perform any bookkeeping needed when we disconnect (cleanly or forcefully)
  /// </summary>
  /// <param name="reason"></param>
  /// <param name="exception"></param>
  void _InternalOnDisconnect(HangingRequestDisconnectReason reason, Exception exception) {
    throw NotImplementedException("InternalOnDisconnect");
//            if (this.IsConnected)
//            {
//                this.IsConnected = false;
//
//                this.OnDisconnect(
//                    this,
//                    new HangingRequestDisconnectEventArgs.withException(reason, exception));
//            }
  }

  /// <summary>
  /// Reads any preamble data not part of the core response.
  /// </summary>
  /// <param name="ewsXmlReader">The EwsServiceXmlReader.</param>
  @override
  void ReadPreamble(EwsServiceXmlReader ewsXmlReader) {
    // Do nothing.
  }
}
