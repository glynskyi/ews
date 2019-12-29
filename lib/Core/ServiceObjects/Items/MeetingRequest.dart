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
import 'package:ews/ComplexProperties/AttendeeCollection.dart';
import 'package:ews/ComplexProperties/EnhancedLocation.dart' as complex;
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ItemCollection.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart'
    as complex;
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/Appointment.dart';
import 'package:ews/Core/ServiceObjects/Items/MeetingMessage.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/AcceptMeetingInvitationMessage.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/DeclineMeetingInvitationMessage.dart';
import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/MeetingRequestSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AppointmentType.dart' as enumerations;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/MeetingRequestType.dart' as enumerations;
import 'package:ews/Enumerations/ResponseType.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Interfaces/ICalendarActionProvider.dart';
import 'package:ews/misc/CalendarActionResults.dart';

/// <summary>
/// Represents a meeting request that an attendee can accept or decline. Properties available on meeting requests are defined in the MeetingRequestSchema class.
/// </summary>
//    [ServiceObjectDefinition(XmlElementNames.MeetingRequest)]
class MeetingRequest extends MeetingMessage implements ICalendarActionProvider {
  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingRequest"/> class.
  /// </summary>
  /// <param name="parentAttachment">The parent attachment.</param>
  MeetingRequest.withAttachment(ItemAttachment parentAttachment)
      : super.withAttachment(parentAttachment) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingRequest"/> class.
  /// </summary>
  /// <param name="service">EWS service to which this object belongs.</param>
  MeetingRequest(ExchangeService service) : super(service) {}

  /// <summary>
  /// Binds to an existing meeting request and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the meeting request.</param>
  /// <param name="id">The Id of the meeting request to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>A MeetingRequest instance representing the meeting request corresponding to the specified Id.</returns>
  static Future<MeetingRequest> BindItemIdAndPropertySet(
      ExchangeService service, ItemId id, PropertySet propertySet) {
    return service.BindToItemGeneric<MeetingRequest>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing meeting request and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the meeting request.</param>
  /// <param name="id">The Id of the meeting request to bind to.</param>
  /// <returns>A MeetingRequest instance representing the meeting request corresponding to the specified Id.</returns>
  static Future<MeetingRequest> Bind(ExchangeService service, ItemId id) {
    return MeetingRequest.BindItemIdAndPropertySet(
        service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return MeetingRequestSchema.Instance;
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
  /// Creates a local meeting acceptance message that can be customized and sent.
  /// </summary>
  /// <param name="tentative">Specifies whether the meeting will be tentatively accepted.</param>
  /// <returns>An AcceptMeetingInvitationMessage representing the meeting acceptance message. </returns>
  AcceptMeetingInvitationMessage CreateAcceptMessage(bool tentative) {
    return new AcceptMeetingInvitationMessage(this, tentative);
  }

  /// <summary>
  /// Creates a local meeting declination message that can be customized and sent.
  /// </summary>
  /// <returns>A DeclineMeetingInvitation representing the meeting declination message. </returns>
  DeclineMeetingInvitationMessage CreateDeclineMessage() {
    return new DeclineMeetingInvitationMessage(this);
  }

  /// <summary>
  /// Accepts the meeting. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="sendResponse">Indicates whether to send a response to the organizer.</param>
  /// <returns>
  /// A CalendarActionResults object containing the various items that were created or modified as a
  /// results of this operation.
  /// </returns>
  Future<CalendarActionResults> Accept(bool sendResponse) {
    return this.InternalAccept(false, sendResponse);
  }

  /// <summary>
  /// Tentatively accepts the meeting. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="sendResponse">Indicates whether to send a response to the organizer.</param>
  /// <returns>
  /// A CalendarActionResults object containing the various items that were created or modified as a
  /// results of this operation.
  /// </returns>
  Future<CalendarActionResults> AcceptTentatively(bool sendResponse) {
    return this.InternalAccept(true, sendResponse);
  }

  /// <summary>
  /// Accepts the meeting.
  /// </summary>
  /// <param name="tentative">True if tentative accept.</param>
  /// <param name="sendResponse">Indicates whether to send a response to the organizer.</param>
  /// <returns>
  /// A CalendarActionResults object containing the various items that were created or modified as a
  /// results of this operation.
  /// </returns>
  Future<CalendarActionResults> InternalAccept(
      bool tentative, bool sendResponse) {
    throw NotImplementedException("InternalAccept");
//            AcceptMeetingInvitationMessage accept = this.CreateAcceptMessage(tentative);
//
//            if (sendResponse)
//            {
//                return accept.SendAndSaveCopy();
//            }
//            else
//            {
//                return accept.Save();
//            }
  }

  /// <summary>
  /// Declines the meeting invitation. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="sendResponse">Indicates whether to send a response to the organizer.</param>
  /// <returns>
  /// A CalendarActionResults object containing the various items that were created or modified as a
  /// results of this operation.
  /// </returns>
  Future<CalendarActionResults> Decline(bool sendResponse) {
    throw NotImplementedException("Decline");
//            DeclineMeetingInvitationMessage decline = this.CreateDeclineMessage();
//
//            if (sendResponse)
//            {
//                return decline.SendAndSaveCopy();
//            }
//            else
//            {
//                return decline.Save();
//            }
  }

  /// <summary>
  /// Gets the type of this meeting request.
  /// </summary>
  enumerations.MeetingRequestType get MeetingRequestType =>
      this.PropertyBag[MeetingRequestSchema.MeetingRequestType];

  /// <summary>
  /// Gets the a value representing the intended free/busy status of the meeting.
  /// </summary>
//        LegacyFreeBusyStatus get IntendedFreeBusyStatus => this.PropertyBag[MeetingRequestSchema.IntendedFreeBusyStatus];

  /// <summary>
  /// Gets the change highlights of the meeting request.
  /// </summary>
//        ChangeHighlights get ChangeHighlights => this.PropertyBag[MeetingRequestSchema.ChangeHighlights];

  /// <summary>
  /// Gets the Enhanced location object.
  /// </summary>
  complex.EnhancedLocation get EnhancedLocation =>
      this.PropertyBag[MeetingRequestSchema.EnhancedLocation];

  /// <summary>
  /// Gets the start time of the appointment.
  /// </summary>
//        DateTime get Start => this.PropertyBag[AppointmentSchema.Start];

  /// <summary>
  /// Gets the end time of the appointment.
  /// </summary>
//        DateTime get End => this.PropertyBag[AppointmentSchema.End];

  /// <summary>
  /// Gets the original start time of this appointment.
  /// </summary>
//        DateTime get OriginalStart => this.PropertyBag[AppointmentSchema.OriginalStart];

  /// <summary>
  /// Gets a value indicating whether this appointment is an all day event.
  /// </summary>
  bool get IsAllDayEvent => this.PropertyBag[AppointmentSchema.IsAllDayEvent];

  /// <summary>
  /// Gets a value indicating the free/busy status of the owner of this appointment.
  /// </summary>
//        LegacyFreeBusyStatus get LegacyFreeBusyStatus => this.PropertyBag[AppointmentSchema.LegacyFreeBusyStatus];

  /// <summary>
  /// Gets the location of this appointment.
  /// </summary>
  String get Location => this.PropertyBag[AppointmentSchema.Location];

  /// <summary>

  /// </summary>
  String get When => this.PropertyBag[AppointmentSchema.When];

  /// <summary>
  /// Gets a value indicating whether the appointment is a meeting.
  /// </summary>
  bool get IsMeeting => this.PropertyBag[AppointmentSchema.IsMeeting];

  /// <summary>
  ///  Gets a value indicating whether the appointment has been cancelled.
  /// </summary>
  bool get IsCancelled => this.PropertyBag[AppointmentSchema.IsCancelled];

  /// <summary>
  ///  Gets a value indicating whether the appointment is recurring.
  /// </summary>
  bool get IsRecurring => this.PropertyBag[AppointmentSchema.IsRecurring];

  /// <summary>
  ///  Gets a value indicating whether the meeting request has already been sent.
  /// </summary>
  bool get MeetingRequestWasSent =>
      this.PropertyBag[AppointmentSchema.MeetingRequestWasSent];

  /// <summary>
  /// Gets a value indicating the type of this appointment.
  /// </summary>
  enumerations.AppointmentType get AppointmentType =>
      this.PropertyBag[AppointmentSchema.AppointmentType];

  /// <summary>
  /// Gets a value indicating what was the last response of the user that loaded this meeting.
  /// </summary>
  MeetingResponseType get MyResponseType =>
      this.PropertyBag[AppointmentSchema.MyResponseType];

  /// <summary>
  /// Gets the organizer of this meeting.
  /// </summary>
//        EmailAddress get Organizer => this.PropertyBag[AppointmentSchema.Organizer];

  /// <summary>
  /// Gets a list of required attendees for this meeting.
  /// </summary>
  AttendeeCollection get RequiredAttendees =>
      this.PropertyBag[AppointmentSchema.RequiredAttendees];

  /// <summary>
  /// Gets a list of optional attendeed for this meeting.
  /// </summary>
  AttendeeCollection get OptionalAttendees =>
      this.PropertyBag[AppointmentSchema.OptionalAttendees];

  /// <summary>
  /// Gets a list of resources for this meeting.
  /// </summary>
  AttendeeCollection get Resources =>
      this.PropertyBag[AppointmentSchema.Resources];

  /// <summary>
  /// Gets the number of calendar entries that conflict with this appointment in the authenticated user's calendar.
  /// </summary>
  int get ConflictingMeetingCount =>
      this.PropertyBag[AppointmentSchema.ConflictingMeetingCount];

  /// <summary>
  /// Gets the number of calendar entries that are adjacent to this appointment in the authenticated user's calendar.
  /// </summary>
  int get AdjacentMeetingCount =>
      this.PropertyBag[AppointmentSchema.AdjacentMeetingCount];

  /// <summary>
  /// Gets a list of meetings that conflict with this appointment in the authenticated user's calendar.
  /// </summary>
  ItemCollection<Appointment> get ConflictingMeetings =>
      this.PropertyBag[AppointmentSchema.ConflictingMeetings];

  /// <summary>
  /// Gets a list of meetings that conflict with this appointment in the authenticated user's calendar.
  /// </summary>
  ItemCollection<Appointment> get AdjacentMeetings =>
      this.PropertyBag[AppointmentSchema.AdjacentMeetings];

  /// <summary>
  /// Gets the duration of this appointment.
  /// </summary>
//        TimeSpan get Duration => this.PropertyBag[AppointmentSchema.Duration];

  /// <summary>
  /// Gets the name of the time zone this appointment is defined in.
  /// </summary>
  String get TimeZone => this.PropertyBag[AppointmentSchema.TimeZone];

  /// <summary>
  /// Gets the time when the attendee replied to the meeting request.
  /// </summary>
  DateTime get AppointmentReplyTime =>
      this.PropertyBag[AppointmentSchema.AppointmentReplyTime];

  /// <summary>
  /// Gets the sequence number of this appointment.
  /// </summary>
  int get AppointmentSequenceNumber =>
      this.PropertyBag[AppointmentSchema.AppointmentSequenceNumber];

  /// <summary>
  /// Gets the state of this appointment.
  /// </summary>
  int get AppointmentState =>
      this.PropertyBag[AppointmentSchema.AppointmentState];

  /// <summary>
  /// Gets the recurrence pattern for this meeting request.
  /// </summary>
  complex.Recurrence get Recurrence =>
      this.PropertyBag[AppointmentSchema.Recurrence];

  /// <summary>
  /// Gets an OccurrenceInfo identifying the first occurrence of this meeting.
  /// </summary>
//        OccurrenceInfo get FirstOccurrence => this.PropertyBag[AppointmentSchema.FirstOccurrence];

  /// <summary>
  /// Gets an OccurrenceInfo identifying the last occurrence of this meeting.
  /// </summary>
//        OccurrenceInfo get LastOccurrence => this.PropertyBag[AppointmentSchema.LastOccurrence];

  /// <summary>
  /// Gets a list of modified occurrences for this meeting.
  /// </summary>
//        OccurrenceInfoCollection get ModifiedOccurrences => this.PropertyBag[AppointmentSchema.ModifiedOccurrences];

  /// <summary>
  /// Gets a list of deleted occurrences for this meeting.
  /// </summary>
//        DeletedOccurrenceInfoCollection get DeletedOccurrences => this.PropertyBag[AppointmentSchema.DeletedOccurrences];

  /// <summary>
  /// Gets time zone of the start property of this meeting request.
  /// </summary>
//        TimeZoneInfo get StartTimeZone => this.PropertyBag[AppointmentSchema.StartTimeZone];

  /// <summary>
  /// Gets time zone of the end property of this meeting request.
  /// </summary>
//        TimeZoneInfo get EndTimeZone => this.PropertyBag[AppointmentSchema.EndTimeZone];

  /// <summary>
  /// Gets the type of conferencing that will be used during the meeting.
  /// </summary>
  int get ConferenceType => this.PropertyBag[AppointmentSchema.ConferenceType];

  /// <summary>
  /// Gets a value indicating whether new time proposals are allowed for attendees of this meeting.
  /// </summary>
  bool get AllowNewTimeProposal =>
      this.PropertyBag[AppointmentSchema.AllowNewTimeProposal];

  /// <summary>
  /// Gets a value indicating whether this is an online meeting.
  /// </summary>
  bool get IsOnlineMeeting =>
      this.PropertyBag[AppointmentSchema.IsOnlineMeeting];

  /// <summary>
  /// Gets the URL of the meeting workspace. A meeting workspace is a shared Web site for planning meetings and tracking results.
  /// </summary>
  String get MeetingWorkspaceUrl =>
      this.PropertyBag[AppointmentSchema.MeetingWorkspaceUrl];

  /// <summary>
  /// Gets the URL of the Microsoft NetShow online meeting.
  /// </summary>
  String get NetShowUrl => this.PropertyBag[AppointmentSchema.NetShowUrl];

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(XmlElementNames.MeetingRequest);
  }
}
