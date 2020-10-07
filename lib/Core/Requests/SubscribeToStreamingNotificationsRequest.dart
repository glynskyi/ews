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

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/SubscribeRequest.dart';
import 'package:ews/Core/Responses/SubscribeResponse.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Notifications/StreamingSubscription.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents a "Streaming" Subscribe request.
/// </summary>
class SubscribeToStreamingNotificationsRequest
    extends SubscribeRequest<StreamingSubscription> {
  /// <summary>
  /// Initializes a new instance of the <see cref="SubscribeToStreamingNotificationsRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  SubscribeToStreamingNotificationsRequest(ExchangeService service)
      : super(service) {}

  /// <summary>
  /// Validate request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();

    if (!StringUtils.IsNullOrEmpty(this.Watermark)) {
      throw new ArgumentException(
          "Watermarks cannot be used with StreamingSubscriptions., Watermark");
    }
  }

  /// <summary>
  /// Gets the name of the subscription XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetSubscriptionXmlElementName() {
    return XmlElementNames.StreamingSubscriptionRequest;
  }

  /// <summary>
  /// Internals the write elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void InternalWriteElementsToXml(EwsServiceXmlWriter writer) {}

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  @override
  SubscribeResponse<StreamingSubscription> CreateServiceResponse(
      ExchangeService service, int responseIndex) {
    return new SubscribeResponse<StreamingSubscription>(
        new StreamingSubscription(service));
  }

  /// <summary>
  /// Gets the request version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this request is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2010_SP1;
  }
}
