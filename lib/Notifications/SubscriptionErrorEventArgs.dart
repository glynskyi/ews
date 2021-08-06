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

import 'package:ews/Notifications/StreamingSubscription.dart';

/// <summary>
///
/// Provides data to a StreamingSubscriptionConnection's OnSubscriptionError and OnDisconnect events.
/// </summary>
class SubscriptionErrorEventArgs // extends EventArgs
{
  /// <summary>
  /// Initializes a new instance of the <see cref="SubscriptionErrorEventArgs"/> class.
  /// </summary>
  /// <param name="subscription">The subscription for which an error occurred. If subscription is null, the error applies to the entire connection.</param>
  /// <param name="exception">The exception representing the error. If exception is null, the connection was cleanly closed by the server.</param>
  SubscriptionErrorEventArgs(
      StreamingSubscription? subscription, Object? exception) {
    this.Subscription = subscription;
    this.Exception = exception;
  }

  /// <summary>
  /// Gets the subscription for which an error occurred. If Subscription is null, the error applies to the entire connection.
  /// </summary>
  StreamingSubscription? Subscription;

  /// <summary>
  /// Gets the exception representing the error. If Exception is null, the connection was cleanly closed by the server.
  /// </summary>
  Object? Exception;
}
