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
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/MultiResponseServiceRequest.dart';
import 'package:ews/Core/Responses/SubscribeResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/EventType.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/Notifications/SubscriptionBase.dart';
import 'package:ews/misc/FolderIdWrapperList.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents an abstract Subscribe request.
/// </summary>
/// <typeparam name="TSubscription">The type of the subscription.</typeparam>
abstract class SubscribeRequest<TSubscription extends SubscriptionBase>
    extends MultiResponseServiceRequest<SubscribeResponse<TSubscription>> {
  /// <summary>
  /// Validate request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParam(this.FolderIds, "FolderIds");
    EwsUtilities.ValidateParamCollection(this.EventTypes, "EventTypes");
    this.FolderIds.Validate(this.Service.RequestedServerVersion);

    // Check that caller isn't trying to subscribe to Status events.
    if (this.EventTypes.where((eventType) => (eventType == EventType.Status)).length > 0) {
      throw new ServiceValidationException("Strings.CannotSubscribeToStatusEvents");
    }

    // If Watermark was specified, make sure it's not a blank string.
    if (!StringUtils.IsNullOrEmpty(this.Watermark)) {
      EwsUtilities.ValidateNonBlankStringParam(this.Watermark, "Watermark");
    }

    this
        .EventTypes
        .forEach((eventType) => EwsUtilities.ValidateEnumVersionValue(eventType, this.Service.RequestedServerVersion));
  }

  /// <summary>
  /// Gets the name of the subscription XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  String GetSubscriptionXmlElementName();

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return 1;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.Subscribe;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.SubscribeResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.SubscribeResponseMessage;
  }

  /// <summary>
  /// method to write XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void InternalWriteElementsToXml(EwsServiceXmlWriter writer);

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Messages, this.GetSubscriptionXmlElementName());

    if (this.FolderIds.Count == 0) {
      writer.WriteAttributeValue(XmlAttributeNames.SubscribeToAllFolders, true);
    }

    this.FolderIds.WriteToXml(writer, XmlNamespace.Types, XmlElementNames.FolderIds);

    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.EventTypes);
    for (EventType eventType in this.EventTypes) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.EventType, eventType);
    }
    writer.WriteEndElement();

    if (!StringUtils.IsNullOrEmpty(this.Watermark)) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Watermark, this.Watermark);
    }

    this.InternalWriteElementsToXml(writer);

    writer.WriteEndElement();
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="SubscribeRequest&lt;TSubscription&gt;"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  SubscribeRequest(ExchangeService service) : super(service, ServiceErrorHandling.ThrowOnError) {
    this.FolderIds = new FolderIdWrapperList();
    this.EventTypes = new List<EventType>();
  }

  /// <summary>
  /// Gets the folder ids.
  /// </summary>
  FolderIdWrapperList FolderIds;

  /// <summary>
  /// Gets the event types.
  /// </summary>
  List<EventType> EventTypes;

  /// <summary>
  /// Gets or sets the watermark.
  /// </summary>
  String Watermark;
}
