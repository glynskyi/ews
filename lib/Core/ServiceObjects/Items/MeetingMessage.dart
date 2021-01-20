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
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/EmailMessage.dart';
import 'package:ews/Core/ServiceObjects/Schemas/MeetingMessageSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ResponseType.dart';

/// <summary>
/// Represents a meeting-related message. Properties available on meeting messages are defined in the MeetingMessageSchema class.
/// </summary>
//    [ServiceObjectDefinition(XmlElementNames.MeetingMessage)]
class MeetingMessage extends EmailMessage {
  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingMessage"/> class.
  /// </summary>
  /// <param name="parentAttachment">The parent attachment.</param>
  MeetingMessage.withAttachment(ItemAttachment parentAttachment)
      : super.withAttachment(parentAttachment) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingMessage"/> class.
  /// </summary>
  /// <param name="service">EWS service to which this object belongs.</param>
  MeetingMessage(ExchangeService service) : super(service) {}

  /// <summary>
  /// Binds to an existing meeting message and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the meeting message.</param>
  /// <param name="id">The Id of the meeting message to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>A MeetingMessage instance representing the meeting message corresponding to the specified Id.</returns>
  static Future<MeetingMessage> BindWithItemIdAndPropertySet(
      ExchangeService service, ItemId id, PropertySet propertySet) {
    return service.BindToItemGeneric<MeetingMessage>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing meeting message and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the meeting message.</param>
  /// <param name="id">The Id of the meeting message to bind to.</param>
  /// <returns>A MeetingMessage instance representing the meeting message corresponding to the specified Id.</returns>
  static Future<MeetingMessage> BindWithItemId(
      ExchangeService service, ItemId id) {
    return MeetingMessage.BindWithItemIdAndPropertySet(
        service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return MeetingMessageSchema.Instance;
  }

  /// <summary>
  /// Gets the minimum required server version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// Gets the Id of the appointment associated with the meeting message.
  /// </summary>
  ItemId? get AssociatedAppointmentId =>
      this.PropertyBag[MeetingMessageSchema.AssociatedAppointmentId] as ItemId?;

  /// <summary>
  /// Gets a value indicating whether the meeting message is delegated.
  /// </summary>
  bool? get IsDelegated =>
      this.PropertyBag[MeetingMessageSchema.IsDelegated] as bool?;

  /// <summary>
  /// Gets a value indicating whether the meeting message is out of date.
  /// </summary>
  bool? get IsOutOfDate =>
      this.PropertyBag[MeetingMessageSchema.IsOutOfDate] as bool?;

  /// <summary>
  ///  Gets a value indicating whether the meeting message has been processed by Exchange (i.e. Exchange has noted
  ///  the arrival of a meeting request and has created the associated meeting item in the calendar).
  /// </summary>
  bool? get HasBeenProcessed =>
      this.PropertyBag[MeetingMessageSchema.HasBeenProcessed] as bool?;

  /// <summary>
  /// Gets the isorganizer property for this meeting
  /// </summary>
  bool? get IsOrganizer =>
      this.PropertyBag[MeetingMessageSchema.IsOrganizer] as bool?;

  /// <summary>
  /// Gets the type of response the meeting message represents.
  /// </summary>
  MeetingResponseType? get ResponseType =>
      this.PropertyBag[MeetingMessageSchema.ResponseType]
          as MeetingResponseType?;

  /// <summary>
  /// Gets the ICalendar Uid.
  /// </summary>
  String? get ICalUid =>
      this.PropertyBag[MeetingMessageSchema.ICalUid] as String?;

  /// <summary>
  /// Gets the ICalendar RecurrenceId.
  /// </summary>
  DateTime? get ICalRecurrenceId =>
      this.PropertyBag[MeetingMessageSchema.ICalRecurrenceId] as DateTime?;

  /// <summary>
  /// Gets the ICalendar DateTimeStamp.
  /// </summary>
  DateTime? get ICalDateTimeStamp =>
      this.PropertyBag[MeetingMessageSchema.ICalDateTimeStamp] as DateTime?;

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(XmlElementNames.MeetingMessage);
  }
}
