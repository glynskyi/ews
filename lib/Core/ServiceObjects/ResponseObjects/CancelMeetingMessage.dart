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

import 'package:ews/Attributes/ServiceObjectDefinitionAttribute.dart';
import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/Items/MeetingCancellation.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/CalendarResponseMessageBase.dart';
import 'package:ews/Core/ServiceObjects/Schemas/CancelMeetingMessageSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';

/// <summary>
/// Represents a meeting cancellation message.
/// </summary>
//    [ServiceObjectDefinition(XmlElementNames.CancelCalendarItem, ReturnedByServer = false)]
class CancelMeetingMessage
    extends CalendarResponseMessageBase<MeetingCancellation> {
  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(
        XmlElementNames.CancelCalendarItem, false);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="CancelMeetingMessage"/> class.
  /// </summary>
  /// <param name="referenceItem">The reference item.</param>
  CancelMeetingMessage(Item referenceItem) : super(referenceItem) {}

  /// <summary>
  /// Gets the minimum required server version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return CancelMeetingMessageSchema.Instance;
  }

  /// <summary>
  /// Gets or sets the body of the response.
  /// </summary>
  MessageBody? get Body =>
      this.PropertyBag[CancelMeetingMessageSchema.Body] as MessageBody?;

  set Body(MessageBody? value) =>
      this.PropertyBag[CancelMeetingMessageSchema.Body] = value;
}
