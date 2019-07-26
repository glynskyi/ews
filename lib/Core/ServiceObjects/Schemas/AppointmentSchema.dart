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

import 'package:ews/ComplexProperties/AttendeeCollection.dart';
import 'package:ews/ComplexProperties/EmailAddress.dart';
import 'package:ews/ComplexProperties/EnhancedLocation.dart' as complex;
import 'package:ews/ComplexProperties/ItemCollection.dart';
import 'package:ews/Core/ServiceObjects/Items/Appointment.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AppointmentType.dart' as enumerations;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/ResponseType.dart';
import 'package:ews/PropertyDefinitions/BoolPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ContainedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/DateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IntPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/MeetingTimeZonePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/RecurrencePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ScopedDateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StartTimeZonePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/TimeSpanPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/TimeZonePropertyDefinition.dart';

/// <summary>
/// Field URIs for Appointment.
/// </summary>
/* private */ class FieldUris
{
  static const String Start = "calendar:Start";
  static const String End = "calendar:End";
  static const String OriginalStart = "calendar:OriginalStart";
  static const String IsAllDayEvent = "calendar:IsAllDayEvent";
  static const String LegacyFreeBusyStatus = "calendar:LegacyFreeBusyStatus";
  static const String Location = "calendar:Location";
  static const String When = "calendar:When";
  static const String IsMeeting = "calendar:IsMeeting";
  static const String IsCancelled = "calendar:IsCancelled";
  static const String IsRecurring = "calendar:IsRecurring";
  static const String MeetingRequestWasSent = "calendar:MeetingRequestWasSent";
  static const String IsResponseRequested = "calendar:IsResponseRequested";
  static const String CalendarItemType = "calendar:CalendarItemType";
  static const String MyResponseType = "calendar:MyResponseType";
  static const String Organizer = "calendar:Organizer";
  static const String RequiredAttendees = "calendar:RequiredAttendees";
  static const String OptionalAttendees = "calendar:OptionalAttendees";
  static const String Resources = "calendar:Resources";
  static const String ConflictingMeetingCount = "calendar:ConflictingMeetingCount";
  static const String AdjacentMeetingCount = "calendar:AdjacentMeetingCount";
  static const String ConflictingMeetings = "calendar:ConflictingMeetings";
  static const String AdjacentMeetings = "calendar:AdjacentMeetings";
  static const String Duration = "calendar:Duration";
  static const String TimeZone = "calendar:TimeZone";
  static const String AppointmentReplyTime = "calendar:AppointmentReplyTime";
  static const String AppointmentSequenceNumber = "calendar:AppointmentSequenceNumber";
  static const String AppointmentState = "calendar:AppointmentState";
  static const String Recurrence = "calendar:Recurrence";
  static const String FirstOccurrence = "calendar:FirstOccurrence";
  static const String LastOccurrence = "calendar:LastOccurrence";
  static const String ModifiedOccurrences = "calendar:ModifiedOccurrences";
  static const String DeletedOccurrences = "calendar:DeletedOccurrences";
  static const String MeetingTimeZone = "calendar:MeetingTimeZone";
  static const String StartTimeZone = "calendar:StartTimeZone";
  static const String EndTimeZone = "calendar:EndTimeZone";
  static const String ConferenceType = "calendar:ConferenceType";
  static const String AllowNewTimeProposal = "calendar:AllowNewTimeProposal";
  static const String IsOnlineMeeting = "calendar:IsOnlineMeeting";
  static const String MeetingWorkspaceUrl = "calendar:MeetingWorkspaceUrl";
  static const String NetShowUrl = "calendar:NetShowUrl";
  static const String Uid = "calendar:UID";
  static const String RecurrenceId = "calendar:RecurrenceId";
  static const String DateTimeStamp = "calendar:DateTimeStamp";
  static const String EnhancedLocation = "calendar:EnhancedLocation";
  static const String JoinOnlineMeetingUrl = "calendar:JoinOnlineMeetingUrl";
  static const String OnlineMeetingSettings = "calendar:OnlineMeetingSettings";
}


    /// <summary>
    /// Represents the schema for appointment and meeting requests.
    /// </summary>
//    [Schema]
// TODO : restore missed schema properties
 class AppointmentSchema extends ItemSchema
    {
     

        /// <summary>
        /// Defines the StartTimeZone property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition StartTimeZone =
            new StartTimeZonePropertyDefinition(
                XmlElementNames.StartTimeZone,
                FieldUris.StartTimeZone,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the EndTimeZone property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition EndTimeZone =
            new TimeZonePropertyDefinition(
                XmlElementNames.EndTimeZone,
                FieldUris.EndTimeZone,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2010);

        /// <summary>
        /// Defines the Start property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Start =
            new ScopedDateTimePropertyDefinition.withUriAndFlags(
                XmlElementNames.Start,
                FieldUris.Start,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1,
                (ExchangeVersion version)
                {
                    return AppointmentSchema.StartTimeZone;
                });

        /// <summary>
        /// Defines the End property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition End =
            new ScopedDateTimePropertyDefinition.withUriAndFlags(
                XmlElementNames.End,
                FieldUris.End,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1,
                (ExchangeVersion version)
                {
                    return version == ExchangeVersion.Exchange2007_SP1 ? AppointmentSchema.StartTimeZone : AppointmentSchema.EndTimeZone;
                });

        /// <summary>
        /// Defines the OriginalStart property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition OriginalStart =
//            new DateTimePropertyDefinition.withUriAndFlags(
//                XmlElementNames.OriginalStart,
//                FieldUris.OriginalStart,
//                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsAllDayEvent property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsAllDayEvent =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsAllDayEvent,
                FieldUris.IsAllDayEvent,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the LegacyFreeBusyStatus property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition LegacyFreeBusyStatus =
//            new GenericPropertyDefinition<LegacyFreeBusyStatus>.withFlags(
//                XmlElementNames.LegacyFreeBusyStatus,
//                FieldUris.LegacyFreeBusyStatus,
//                [PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate, PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the Location property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Location =
            new StringPropertyDefinition(
                XmlElementNames.Location,
                FieldUris.Location,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the When property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition When =
            new StringPropertyDefinition(
                XmlElementNames.When,
                FieldUris.When,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsMeeting property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsMeeting =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsMeeting,
                FieldUris.IsMeeting,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsCancelled property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsCancelled =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsCancelled,
                FieldUris.IsCancelled,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsRecurring property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsRecurring =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsRecurring,
                FieldUris.IsRecurring,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the MeetingRequestWasSent property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition MeetingRequestWasSent =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.MeetingRequestWasSent,
                FieldUris.MeetingRequestWasSent,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsResponseRequested property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsResponseRequested =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsResponseRequested,
                FieldUris.IsResponseRequested,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the AppointmentType property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AppointmentType =
            new GenericPropertyDefinition<enumerations.AppointmentType>.withUriAndFlags(
                XmlElementNames.CalendarItemType,
                FieldUris.CalendarItemType,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the MyResponseType property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition MyResponseType =
            new GenericPropertyDefinition<MeetingResponseType>.withUriAndFlags(
                XmlElementNames.MyResponseType,
                FieldUris.MyResponseType,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the Organizer property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Organizer =
            new ContainedPropertyDefinition<EmailAddress>.withUriAndFlags(
                XmlElementNames.Organizer,
                FieldUris.Organizer,
                XmlElementNames.Mailbox,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1,
                () { return new EmailAddress(); });

        /// <summary>
        /// Defines the RequiredAttendees property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition RequiredAttendees =
            new ComplexPropertyDefinition<AttendeeCollection>.withUriAndFlags(
                XmlElementNames.RequiredAttendees,
                FieldUris.RequiredAttendees,
                [PropertyDefinitionFlags.AutoInstantiateOnRead , PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete],
                ExchangeVersion.Exchange2007_SP1,
                () { return new AttendeeCollection(); });

        /// <summary>
        /// Defines the OptionalAttendees property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition OptionalAttendees =
            new ComplexPropertyDefinition<AttendeeCollection>.withUriAndFlags(
                XmlElementNames.OptionalAttendees,
                FieldUris.OptionalAttendees,
                [PropertyDefinitionFlags.AutoInstantiateOnRead , PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete],
                ExchangeVersion.Exchange2007_SP1,
                () { return new AttendeeCollection(); });

        /// <summary>
        /// Defines the Resources property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Resources =
            new ComplexPropertyDefinition<AttendeeCollection>.withUriAndFlags(
                XmlElementNames.Resources,
                FieldUris.Resources,
                [PropertyDefinitionFlags.AutoInstantiateOnRead , PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete],
                ExchangeVersion.Exchange2007_SP1,
                () { return new AttendeeCollection(); });

        /// <summary>
        /// Defines the ConflictingMeetingCount property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ConflictingMeetingCount =
            new IntPropertyDefinition(
                XmlElementNames.ConflictingMeetingCount,
                FieldUris.ConflictingMeetingCount,
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the AdjacentMeetingCount property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AdjacentMeetingCount =
            new IntPropertyDefinition(
                XmlElementNames.AdjacentMeetingCount,
                FieldUris.AdjacentMeetingCount,
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the ConflictingMeetings property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ConflictingMeetings =
            new ComplexPropertyDefinition<ItemCollection<Appointment>>.withUri(
                XmlElementNames.ConflictingMeetings,
                FieldUris.ConflictingMeetings,
                ExchangeVersion.Exchange2007_SP1,
                () { return new ItemCollection<Appointment>(); });

        /// <summary>
        /// Defines the AdjacentMeetings property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AdjacentMeetings =
            new ComplexPropertyDefinition<ItemCollection<Appointment>>.withUri(
                XmlElementNames.AdjacentMeetings,
                FieldUris.AdjacentMeetings,
                ExchangeVersion.Exchange2007_SP1,
                () { return new ItemCollection<Appointment>(); });

        /// <summary>
        /// Defines the Duration property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Duration =
            new TimeSpanPropertyDefinition.withUriAndFlags(
                XmlElementNames.Duration,
                FieldUris.Duration,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the TimeZone property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition TimeZone =
            new StringPropertyDefinition(
                XmlElementNames.TimeZone,
                FieldUris.TimeZone,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the AppointmentReplyTime property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AppointmentReplyTime =
            new DateTimePropertyDefinition.withUriAndFlags(
                XmlElementNames.AppointmentReplyTime,
                FieldUris.AppointmentReplyTime,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the AppointmentSequenceNumber property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AppointmentSequenceNumber =
            new IntPropertyDefinition(
                XmlElementNames.AppointmentSequenceNumber,
                FieldUris.AppointmentSequenceNumber,
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the AppointmentState property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AppointmentState =
            new IntPropertyDefinition.withUriAndFlags(
                XmlElementNames.AppointmentState,
                FieldUris.AppointmentState,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the Recurrence property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Recurrence =
            new RecurrencePropertyDefinition(
                XmlElementNames.Recurrence,
                FieldUris.Recurrence,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the FirstOccurrence property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition FirstOccurrence =
//            new ComplexPropertyDefinition<OccurrenceInfo>.withUri(
//                XmlElementNames.FirstOccurrence,
//                FieldUris.FirstOccurrence,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new OccurrenceInfo(); });

        /// <summary>
        /// Defines the LastOccurrence property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition LastOccurrence =
//            new ComplexPropertyDefinition<OccurrenceInfo>(
//                XmlElementNames.LastOccurrence,
//                FieldUris.LastOccurrence,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new OccurrenceInfo(); });

        /// <summary>
        /// Defines the ModifiedOccurrences property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition ModifiedOccurrences =
//            new ComplexPropertyDefinition<OccurrenceInfoCollection>(
//                XmlElementNames.ModifiedOccurrences,
//                FieldUris.ModifiedOccurrences,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new OccurrenceInfoCollection(); });

        /// <summary>
        /// Defines the DeletedOccurrences property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition DeletedOccurrences =
//            new ComplexPropertyDefinition<DeletedOccurrenceInfoCollection>(
//                XmlElementNames.DeletedOccurrences,
//                FieldUris.DeletedOccurrences,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new DeletedOccurrenceInfoCollection(); });

        /// <summary>
        /// Defines the MeetingTimeZone property.
        /// </summary>
        static PropertyDefinition MeetingTimeZone =
            new MeetingTimeZonePropertyDefinition.withUriAndFlags(
                XmlElementNames.MeetingTimeZone,
                FieldUris.MeetingTimeZone,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the ConferenceType property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ConferenceType =
            new IntPropertyDefinition.withUriAndFlags(
                XmlElementNames.ConferenceType,
                FieldUris.ConferenceType,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the AllowNewTimeProposal property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AllowNewTimeProposal =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.AllowNewTimeProposal,
                FieldUris.AllowNewTimeProposal,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsOnlineMeeting property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsOnlineMeeting =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsOnlineMeeting,
                FieldUris.IsOnlineMeeting,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the MeetingWorkspaceUrl property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition MeetingWorkspaceUrl =
            new StringPropertyDefinition(
                XmlElementNames.MeetingWorkspaceUrl,
                FieldUris.MeetingWorkspaceUrl,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the NetShowUrl property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition NetShowUrl =
            new StringPropertyDefinition(
                XmlElementNames.NetShowUrl,
                FieldUris.NetShowUrl,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the iCalendar Uid property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ICalUid =
            new StringPropertyDefinition(
                XmlElementNames.Uid,
                FieldUris.Uid,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the iCalendar RecurrenceId property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ICalRecurrenceId =
            new DateTimePropertyDefinition.withUriAndFlagsANdNullable(
                XmlElementNames.RecurrenceId,
                FieldUris.RecurrenceId,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1,
                true);  // isNullable

        /// <summary>
        /// Defines the iCalendar DateTimeStamp property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ICalDateTimeStamp =
            new DateTimePropertyDefinition.withUriAndFlagsANdNullable(
                XmlElementNames.DateTimeStamp,
                FieldUris.DateTimeStamp,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1,
                true);  // isNullable

        /// <summary>
        /// Enhanced Location property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition EnhancedLocation =
            new ComplexPropertyDefinition<complex.EnhancedLocation>.withUriAndFlags(
                XmlElementNames.EnhancedLocation,
                FieldUris.EnhancedLocation,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2013,
                () { return new complex.EnhancedLocation(); });

        /// <summary>
        /// JoinOnlineMeetingUrl property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition JoinOnlineMeetingUrl =
            new StringPropertyDefinition(
                XmlElementNames.JoinOnlineMeetingUrl,
                FieldUris.JoinOnlineMeetingUrl,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2013);

        /// <summary>
        /// OnlineMeetingSettings property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition OnlineMeetingSettings =
//            new ComplexPropertyDefinition<OnlineMeetingSettings>(
//                XmlElementNames.OnlineMeetingSettings,
//                FieldUris.OnlineMeetingSettings,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2013,
//                () { return new OnlineMeetingSettings(); });

        /// <summary>
        /// Instance of schema.
        /// </summary>
        /// <remarks>
        /// This must be after the declaration of property definitions.
        /// </remarks>
        static AppointmentSchema Instance = new AppointmentSchema();

        /// <summary>
        /// Registers properties.
        /// </summary>
        /// <remarks>
        /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
        /// </remarks>
@override
        void RegisterProperties()
        {
            super.RegisterProperties();

            this.RegisterProperty(ICalUid);
            this.RegisterProperty(ICalRecurrenceId);
            this.RegisterProperty(ICalDateTimeStamp);
            this.RegisterProperty(Start);
            this.RegisterProperty(End);
//            this.RegisterProperty(OriginalStart);
            this.RegisterProperty(IsAllDayEvent);
//            this.RegisterProperty(LegacyFreeBusyStatus);
            this.RegisterProperty(Location);
            this.RegisterProperty(When);
            this.RegisterProperty(IsMeeting);
            this.RegisterProperty(IsCancelled);
            this.RegisterProperty(IsRecurring);
            this.RegisterProperty(MeetingRequestWasSent);
            this.RegisterProperty(IsResponseRequested);
            this.RegisterProperty(AppointmentType);
            this.RegisterProperty(MyResponseType);
//            this.RegisterProperty(Organizer);
            this.RegisterProperty(RequiredAttendees);
            this.RegisterProperty(OptionalAttendees);
            this.RegisterProperty(Resources);
            this.RegisterProperty(ConflictingMeetingCount);
            this.RegisterProperty(AdjacentMeetingCount);
            this.RegisterProperty(ConflictingMeetings);
            this.RegisterProperty(AdjacentMeetings);
            this.RegisterProperty(Duration);
            this.RegisterProperty(TimeZone);
            this.RegisterProperty(AppointmentReplyTime);
            this.RegisterProperty(AppointmentSequenceNumber);
            this.RegisterProperty(AppointmentState);
            this.RegisterProperty(Recurrence);
//            this.RegisterProperty(FirstOccurrence);
//            this.RegisterProperty(LastOccurrence);
//            this.RegisterProperty(ModifiedOccurrences);
//            this.RegisterProperty(DeletedOccurrences);
//            this.RegisterInternalProperty(MeetingTimeZone);
//            this.RegisterProperty(StartTimeZone);
//            this.RegisterProperty(EndTimeZone);
            this.RegisterProperty(ConferenceType);
            this.RegisterProperty(AllowNewTimeProposal);
            this.RegisterProperty(IsOnlineMeeting);
            this.RegisterProperty(MeetingWorkspaceUrl);
            this.RegisterProperty(NetShowUrl);
            this.RegisterProperty(EnhancedLocation);
            this.RegisterProperty(JoinOnlineMeetingUrl);
//            this.RegisterProperty(OnlineMeetingSettings);
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AppointmentSchema"/> class.
        /// </summary>
        AppointmentSchema()
            : super()
        {
        }
    }
