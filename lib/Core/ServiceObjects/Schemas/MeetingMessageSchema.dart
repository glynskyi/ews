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

import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/EmailMessageSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/ResponseType.dart';
import 'package:ews/PropertyDefinitions/BoolPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';

class MeetingMessageSchemaFieldUris {
  static const String AssociatedCalendarItemId = "meeting:AssociatedCalendarItemId";
  static const String IsDelegated = "meeting:IsDelegated";
  static const String IsOutOfDate = "meeting:IsOutOfDate";
  static const String HasBeenProcessed = "meeting:HasBeenProcessed";
  static const String ResponseType = "meeting:ResponseType";
  static const String IsOrganizer = "cal:IsOrganizer";
}

/// <summary>
/// Represents the schema for meeting messages.
/// </summary>
//    [Schema]
class MeetingMessageSchema extends EmailMessageSchema {
  /// <summary>
  /// Field URIs for MeetingMessage.
  /// </summary>
  /* private */

  /// <summary>
  /// Defines the AssociatedAppointmentId property.
  /// </summary>
  static PropertyDefinition AssociatedAppointmentId = new ComplexPropertyDefinition<ItemId>.withUri(
      XmlElementNames.AssociatedCalendarItemId,
      MeetingMessageSchemaFieldUris.AssociatedCalendarItemId,
      ExchangeVersion.Exchange2007_SP1, () {
    return new ItemId();
  });

  /// <summary>
  /// Defines the IsDelegated property.
  /// </summary>
  static PropertyDefinition IsDelegated = new BoolPropertyDefinition.withUriAndFlags(XmlElementNames.IsDelegated,
      MeetingMessageSchemaFieldUris.IsDelegated, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsOutOfDate property.
  /// </summary>
  static PropertyDefinition IsOutOfDate = new BoolPropertyDefinition(
      XmlElementNames.IsOutOfDate, MeetingMessageSchemaFieldUris.IsOutOfDate, ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the HasBeenProcessed property.
  /// </summary>
  static PropertyDefinition HasBeenProcessed = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.HasBeenProcessed,
      MeetingMessageSchemaFieldUris.HasBeenProcessed,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ResponseType property.
  /// </summary>
  static PropertyDefinition ResponseType = new GenericPropertyDefinition<MeetingResponseType>.withUriAndFlags(
      XmlElementNames.ResponseType,
      MeetingMessageSchemaFieldUris.ResponseType,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the iCalendar Uid property.
  /// </summary>
  static PropertyDefinition ICalUid = AppointmentSchema.ICalUid;

  /// <summary>
  /// Defines the iCalendar RecurrenceId property.
  /// </summary>
  static PropertyDefinition ICalRecurrenceId = AppointmentSchema.ICalRecurrenceId;

  /// <summary>
  /// Defines the iCalendar DateTimeStamp property.
  /// </summary>
  static PropertyDefinition ICalDateTimeStamp = AppointmentSchema.ICalDateTimeStamp;

  /// <summary>
  /// Defines the IsOrganizer property.
  /// </summary>
  static PropertyDefinition IsOrganizer = new GenericPropertyDefinition<bool>.withUriAndFlags(XmlElementNames.IsOrganizer,
      MeetingMessageSchemaFieldUris.IsOrganizer, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2013);

  // This must be after the declaration of property definitions
  static MeetingMessageSchema Instance = new MeetingMessageSchema();

  /// <summary>
  /// Registers properties.
  /// </summary>
  /// <remarks>
  /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
  /// </remarks>
  @override
  void RegisterProperties() {
    super.RegisterProperties();

    this.RegisterProperty(AssociatedAppointmentId);
    this.RegisterProperty(IsDelegated);
    this.RegisterProperty(IsOutOfDate);
    this.RegisterProperty(HasBeenProcessed);
    this.RegisterProperty(ResponseType);
    this.RegisterProperty(ICalUid);
    this.RegisterProperty(ICalRecurrenceId);
    this.RegisterProperty(ICalDateTimeStamp);
    this.RegisterProperty(IsOrganizer);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingMessageSchema"/> class.
  /// </summary>
  MeetingMessageSchema() : super() {}
}
