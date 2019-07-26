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

import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/MeetingMessageSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/MeetingRequestType.dart' as enumerations;
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';

/// <summary>
/// Field URIs for MeetingRequest.
/// </summary>
/* private */ class MeetingRequestSchemaFieldUris
{
  static const String MeetingRequestType = "meetingRequest:MeetingRequestType";
  static const String IntendedFreeBusyStatus = "meetingRequest:IntendedFreeBusyStatus";
  static const String ChangeHighlights = "meetingRequest:ChangeHighlights";
}


    /// <summary>
    /// Represents the schema for meeting requests.
    /// </summary>
//    [Schema]
 class MeetingRequestSchema extends MeetingMessageSchema
    {
    
        /// <summary>
        /// Defines the MeetingRequestType property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition MeetingRequestType =
            new GenericPropertyDefinition<enumerations.MeetingRequestType>.withUri(
                XmlElementNames.MeetingRequestType,
                MeetingRequestSchemaFieldUris.MeetingRequestType,
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IntendedFreeBusyStatus property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition IntendedFreeBusyStatus =
//            new GenericPropertyDefinition<LegacyFreeBusyStatus>(
//                XmlElementNames.IntendedFreeBusyStatus,
//                MeetingRequestSchemaFieldUris.IntendedFreeBusyStatus,
//                [PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the ChangeHighlights property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition ChangeHighlights =
//            new ComplexPropertyDefinition<ChangeHighlights>.withUri(
//                XmlElementNames.ChangeHighlights,
//                MeetingRequestSchemaFieldUris.ChangeHighlights,
//                ExchangeVersion.Exchange2013,
//                () { return new ChangeHighlights(); });

        /// <summary>
        /// Enhanced Location property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition EnhancedLocation =
            AppointmentSchema.EnhancedLocation;

        /// <summary>
        /// Defines the Start property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition Start =
//            AppointmentSchema.Start;

        /// <summary>
        /// Defines the End property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition End =
//            AppointmentSchema.End;

        /// <summary>
        /// Defines the OriginalStart property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition OriginalStart =
//            AppointmentSchema.OriginalStart;

        /// <summary>
        /// Defines the IsAllDayEvent property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsAllDayEvent =
            AppointmentSchema.IsAllDayEvent;

        /// <summary>
        /// Defines the LegacyFreeBusyStatus property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition LegacyFreeBusyStatus =
//            AppointmentSchema.LegacyFreeBusyStatus;

        /// <summary>
        /// Defines the Location property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Location =
            AppointmentSchema.Location;

        /// <summary>
        /// Defines the When property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition When =
            AppointmentSchema.When;

        /// <summary>
        /// Defines the IsMeeting property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsMeeting =
            AppointmentSchema.IsMeeting;

        /// <summary>
        /// Defines the IsCancelled property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsCancelled =
            AppointmentSchema.IsCancelled;

        /// <summary>
        /// Defines the IsRecurring property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsRecurring =
            AppointmentSchema.IsRecurring;

        /// <summary>
        /// Defines the MeetingRequestWasSent property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition MeetingRequestWasSent =
            AppointmentSchema.MeetingRequestWasSent;

        /// <summary>
        /// Defines the AppointmentType property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AppointmentType =
            AppointmentSchema.AppointmentType;

        /// <summary>
        /// Defines the MyResponseType property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition MyResponseType =
            AppointmentSchema.MyResponseType;

        /// <summary>
        /// Defines the Organizer property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition Organizer =
//            AppointmentSchema.Organizer;

        /// <summary>
        /// Defines the RequiredAttendees property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition RequiredAttendees =
            AppointmentSchema.RequiredAttendees;

        /// <summary>
        /// Defines the OptionalAttendees property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition OptionalAttendees =
            AppointmentSchema.OptionalAttendees;

        /// <summary>
        /// Defines the Resources property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Resources =
            AppointmentSchema.Resources;

        /// <summary>
        /// Defines the ConflictingMeetingCount property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ConflictingMeetingCount =
            AppointmentSchema.ConflictingMeetingCount;

        /// <summary>
        /// Defines the AdjacentMeetingCount property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AdjacentMeetingCount =
            AppointmentSchema.AdjacentMeetingCount;

        /// <summary>
        /// Defines the ConflictingMeetings property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ConflictingMeetings =
            AppointmentSchema.ConflictingMeetings;

        /// <summary>
        /// Defines the AdjacentMeetings property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AdjacentMeetings =
            AppointmentSchema.AdjacentMeetings;

        /// <summary>
        /// Defines the Duration property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition Duration =
//            AppointmentSchema.Duration;

        /// <summary>
        /// Defines the TimeZone property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition TimeZone =
            AppointmentSchema.TimeZone;

        /// <summary>
        /// Defines the AppointmentReplyTime property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AppointmentReplyTime =
            AppointmentSchema.AppointmentReplyTime;

        /// <summary>
        /// Defines the AppointmentSequenceNumber property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AppointmentSequenceNumber =
            AppointmentSchema.AppointmentSequenceNumber;

        /// <summary>
        /// Defines the AppointmentState property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AppointmentState =
            AppointmentSchema.AppointmentState;

        /// <summary>
        /// Defines the Recurrence property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition Recurrence =
            AppointmentSchema.Recurrence;

        /// <summary>
        /// Defines the FirstOccurrence property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition FirstOccurrence =
//            AppointmentSchema.FirstOccurrence;

        /// <summary>
        /// Defines the LastOccurrence property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition LastOccurrence =
//            AppointmentSchema.LastOccurrence;

        /// <summary>
        /// Defines the ModifiedOccurrences property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition ModifiedOccurrences =
//            AppointmentSchema.ModifiedOccurrences;

        /// <summary>
        /// Defines the DeletedOccurrences property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition DeletedOccurrences =
//            AppointmentSchema.DeletedOccurrences;

        /// <summary>
        /// Defines the MeetingTimeZone property.
        /// </summary>
//        static PropertyDefinition MeetingTimeZone =
//            AppointmentSchema.MeetingTimeZone;

        /// <summary>
        /// Defines the StartTimeZone property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition StartTimeZone =
//            AppointmentSchema.StartTimeZone;

        /// <summary>
        /// Defines the EndTimeZone property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition EndTimeZone =
//            AppointmentSchema.EndTimeZone;

        /// <summary>
        /// Defines the ConferenceType property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ConferenceType =
            AppointmentSchema.ConferenceType;

        /// <summary>
        /// Defines the AllowNewTimeProposal property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition AllowNewTimeProposal =
            AppointmentSchema.AllowNewTimeProposal;

        /// <summary>
        /// Defines the IsOnlineMeeting property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsOnlineMeeting =
            AppointmentSchema.IsOnlineMeeting;

        /// <summary>
        /// Defines the MeetingWorkspaceUrl property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition MeetingWorkspaceUrl =
            AppointmentSchema.MeetingWorkspaceUrl;

        /// <summary>
        /// Defines the NetShowUrl property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition NetShowUrl =
            AppointmentSchema.NetShowUrl;

        // This must be after the declaration of property definitions
        static MeetingRequestSchema Instance = new MeetingRequestSchema();

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

//            this.RegisterProperty(MeetingRequestType);
//            this.RegisterProperty(IntendedFreeBusyStatus);
//            this.RegisterProperty(ChangeHighlights);

//            this.RegisterProperty(Start);
//            this.RegisterProperty(End);
//            this.RegisterProperty(OriginalStart);
            this.RegisterProperty(IsAllDayEvent);
//            this.RegisterProperty(LegacyFreeBusyStatus);
            this.RegisterProperty(Location);
            this.RegisterProperty(When);
            this.RegisterProperty(IsMeeting);
            this.RegisterProperty(IsCancelled);
            this.RegisterProperty(IsRecurring);
            this.RegisterProperty(MeetingRequestWasSent);
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
//            this.RegisterProperty(Duration);
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
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="MeetingRequestSchema"/> class.
        /// </summary>
        MeetingRequestSchema()
            : super()
        {
        }
    }
