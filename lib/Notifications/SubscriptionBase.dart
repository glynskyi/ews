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
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents the base class for event subscriptions.
/// </summary>
abstract class SubscriptionBase {
  ExchangeService _service;

  String? _id;

  String? _watermark;

  /// <summary>
  /// Initializes a new instance of the <see cref="SubscriptionBase"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  SubscriptionBase(this._service);

  /// <summary>
  /// Initializes a new instance of the <see cref="SubscriptionBase"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="id">The id.</param>
  SubscriptionBase.withId(this._service, String id) {
    this._id = id;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="SubscriptionBase"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="id">The id.</param>
  /// <param name="watermark">The watermark.</param>
  SubscriptionBase.withIdAndWatermark(
      this._service, String id, String watermark) {
    EwsUtilities.ValidateParam(id, "id");

    this._id = id;
    this._watermark = watermark;
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  Future<void> LoadFromXml(EwsServiceXmlReader reader) async {
    this._id = await reader.ReadElementValueWithNamespace(
        XmlNamespace.Messages, XmlElementNames.SubscriptionId);

    if (this.UsesWatermark) {
      this._watermark = await reader.ReadElementValueWithNamespace(
          XmlNamespace.Messages, XmlElementNames.Watermark);
    }
  }

  /// <summary>
  /// Gets the session.
  /// </summary>
  /// <value>The session.</value>
  ExchangeService get Service => this._service;

  /// <summary>
  /// Gets the Id of the subscription.
  /// </summary>
  String? get Id => this._id;

  set Id(String? value) => this._id = value;

  /// <summary>
  /// Gets the latest watermark of the subscription. Watermark is always null for streaming subscriptions.
  /// </summary>
  String? get Watermark => this._watermark;

  set Watermark(String? value) => this._watermark = value;

  /// <summary>
  /// Gets whether or not this subscription uses watermarks.
  /// </summary>
  bool get UsesWatermark => true;
}
