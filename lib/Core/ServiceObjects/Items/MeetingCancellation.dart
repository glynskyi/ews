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
import 'package:ews/ComplexProperties/EnhancedLocation.dart' as complex;
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart'
    as complex;
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/MeetingMessage.dart';
import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/MeetingCancellationSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';

/// <summary>
/// Represents a meeting cancellation message. Properties available on meeting messages are defined in the MeetingMessageSchema class.
/// </summary>
//    [ServiceObjectDefinition(XmlElementNames.MeetingCancellation)]
class MeetingCancellation extends MeetingMessage {
  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingCancellation"/> class.
  /// </summary>
  /// <param name="parentAttachment">The parent attachment.</param>
  MeetingCancellation.withAttachment(ItemAttachment parentAttachment)
      : super.withAttachment(parentAttachment) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingCancellation"/> class.
  /// </summary>
  /// <param name="service">EWS service to which this object belongs.</param>
  MeetingCancellation(ExchangeService service) : super(service) {}

  /// <summary>
  /// Binds to an existing meeting cancellation message and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the meeting cancellation message.</param>
  /// <param name="id">The Id of the meeting cancellation message to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>A MeetingCancellation instance representing the meeting cancellation message corresponding to the specified Id.</returns>
  static Future<MeetingCancellation> Bind(
      ExchangeService service, ItemId id, PropertySet propertySet) {
    return service.BindToItemGeneric<MeetingCancellation>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing meeting cancellation message and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the meeting cancellation message.</param>
  /// <param name="id">The Id of the meeting cancellation message to bind to.</param>
  /// <returns>A MeetingCancellation instance representing the meeting cancellation message corresponding to the specified Id.</returns>
  static Future<MeetingCancellation> BindWithItemId(
      ExchangeService service, ItemId id) {
    return MeetingCancellation.Bind(
        service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return MeetingCancellationSchema.Instance;
  }

  /// <summary>
  /// Removes the meeting associated with the cancellation message from the user's calendar.
  /// </summary>
  /// <returns>
  /// A CalendarActionResults object containing the various items that were created or modified as a
  /// results of this operation.
  /// </returns>
// CalendarActionResults RemoveMeetingFromCalendar()
//        {
//            return new CalendarActionResults(new RemoveFromCalendar(this).InternalCreate(null, null));
//        }

  /// <summary>
  /// Gets the minimum required server version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// Gets the start time of the appointment.
  /// </summary>
// DateTime get Start =>this.PropertyBag[MeetingCancellationSchema.Start];

  /// <summary>
  /// Gets the end time of the appointment.
  /// </summary>
// DateTime get  End => this.PropertyBag[MeetingCancellationSchema.End];

  /// <summary>
  /// Gets the location of this appointment.
  /// </summary>
// String get Location => this.PropertyBag[MeetingCancellationSchema.Location];

  /// <summary>
  /// Gets the recurrence pattern for this meeting request.
  /// </summary>
  complex.Recurrence get Recurrence =>
      this.PropertyBag[AppointmentSchema.Recurrence];

  /// <summary>
  /// Gets the Enhanced location object.
  /// </summary>
  complex.EnhancedLocation get EnhancedLocation =>
      this.PropertyBag[MeetingCancellationSchema.EnhancedLocation];

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(
        XmlElementNames.MeetingCancellation);
  }
}
