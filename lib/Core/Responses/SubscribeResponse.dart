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

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Notifications/SubscriptionBase.dart';

/// <summary>
/// Represents the base response class to subscription creation operations.
/// </summary>
/// <typeparam name="TSubscription">Subscription type.</typeparam>
class SubscribeResponse<TSubscription extends SubscriptionBase> extends ServiceResponse {
  /* private */ TSubscription subscription;

  /// <summary>
  /// Initializes a new instance of the <see cref="SubscribeResponse&lt;TSubscription&gt;"/> class.
  /// </summary>
  /// <param name="subscription">The subscription.</param>
  SubscribeResponse(TSubscription subscription) : super() {
    EwsUtilities.Assert(subscription != null, "SubscribeResponse.ctor", "subscription is null");

    this.subscription = subscription;
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    super.ReadElementsFromXml(reader);

    this.subscription.LoadFromXml(reader);
  }

  /// <summary>
  /// Gets the subscription that was created.
  /// </summary>
  TSubscription get Subscription => this.subscription;
}
