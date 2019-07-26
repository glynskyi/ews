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
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart' as complex;
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/MeetingMessage.dart';
import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/MeetingResponseSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';

/// <summary>
/// Represents a response to a meeting request. Properties available on meeting messages are defined in the MeetingMessageSchema class.
/// </summary>
//    [ServiceObjectDefinition(XmlElementNames.MeetingResponse)]
class MeetingResponse extends MeetingMessage {
  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingResponse"/> class.
  /// </summary>
  /// <param name="parentAttachment">The parent attachment.</param>
  MeetingResponse.withAttachment(ItemAttachment parentAttachment) : super.withAttachment(parentAttachment);

  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingResponse"/> class.
  /// </summary>
  /// <param name="service">EWS service to which this object belongs.</param>
  MeetingResponse(ExchangeService service) : super(service);

  /// <summary>
  /// Binds to an existing meeting response and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the meeting response.</param>
  /// <param name="id">The Id of the meeting response to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>A MeetingResponse instance representing the meeting response corresponding to the specified Id.</returns>
  static Future<MeetingResponse> BindWithItemIdAndPropertySet(
      ExchangeService service, ItemId id, PropertySet propertySet) {
    return service.BindToItemGeneric<MeetingResponse>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing meeting response and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the meeting response.</param>
  /// <param name="id">The Id of the meeting response to bind to.</param>
  /// <returns>A MeetingResponse instance representing the meeting response corresponding to the specified Id.</returns>
  static Future<MeetingResponse> BindWithItemId(ExchangeService service, ItemId id) {
    return MeetingResponse.BindWithItemIdAndPropertySet(service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return MeetingResponseSchema.Instance;
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
  /// Gets the start time of the appointment.
  /// </summary>
// DateTime get Start => this.PropertyBag[MeetingResponseSchema.Start];

  /// <summary>
  /// Gets the end time of the appointment.
  /// </summary>
// DateTime get End => this.PropertyBag[MeetingResponseSchema.End];

  /// <summary>
  /// Gets the location of this appointment.
  /// </summary>
  String get Location => this.PropertyBag[MeetingResponseSchema.Location];

  /// <summary>
  /// Gets the recurrence pattern for this meeting request.
  /// </summary>
  complex.Recurrence get Recurrence => this.PropertyBag[AppointmentSchema.Recurrence];

  /// <summary>
  /// Gets the proposed start time of the appointment.
  /// </summary>
// DateTime get ProposedStart =>this.PropertyBag[MeetingResponseSchema.ProposedStart];

  /// <summary>
  /// Gets the proposed end time of the appointment.
  /// </summary>
// DateTime get ProposedEnd => this.PropertyBag[MeetingResponseSchema.ProposedEnd];

  /// <summary>
  /// Gets the Enhanced location object.
  /// </summary>
  complex.EnhancedLocation get EnhancedLocation => this.PropertyBag[MeetingResponseSchema.EnhancedLocation];

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(XmlElementNames.MeetingResponse);
  }
}
