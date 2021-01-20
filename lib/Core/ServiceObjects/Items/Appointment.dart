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
import 'package:ews/ComplexProperties/EmailAddress.dart';
import 'package:ews/ComplexProperties/EnhancedLocation.dart' as complex;
import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ItemCollection.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart'
    as complex;
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/AcceptMeetingInvitationMessage.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/CancelMeetingMessage.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/DeclineMeetingInvitationMessage.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/ResponseMessage.dart';
import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AppointmentType.dart' as enumerations;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ResponseMessageType.dart';
import 'package:ews/Enumerations/ResponseType.dart';
import 'package:ews/Enumerations/SendCancellationsMode.dart';
import 'package:ews/Enumerations/SendInvitationsMode.dart';
import 'package:ews/Enumerations/SendInvitationsOrCancellationsMode.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Interfaces/ICalendarActionProvider.dart';
import 'package:ews/misc/CalendarActionResults.dart';
import 'package:ews/misc/TimeSpan.dart';

/// <summary>
/// Represents an appointment or a meeting. Properties available on appointments are defined in the AppointmentSchema class.
/// </summary>
//    [Attachable]
//    [ServiceObjectDefinition(XmlElementNames.CalendarItem)]
class Appointment extends Item implements ICalendarActionProvider {
  /// <summary>
  /// Initializes an unsaved local instance of <see cref="Appointment"/>. To bind to an existing appointment, use Appointment.Bind() instead.
  /// </summary>
  /// <param name="service">The ExchangeService instance to which this appointmtnt is bound.</param>
  Appointment(ExchangeService service) : super(service) {
    // If we're running against Exchange 2007, we need to explicitly preset
    // the StartTimeZone property since Exchange 2007 will otherwise scope
    // start and end to UTC.
    if (service.RequestedServerVersion == ExchangeVersion.Exchange2007_SP1) {
      // TODO : repair time zone
//                this.StartTimeZone = service.TimeZone;
    }
  }

  /// <summary>
  /// Initializes a new instance of Appointment.
  /// </summary>
  /// <param name="parentAttachment">Parent attachment.</param>
  /// <param name="isNew">If true, attachment is new.</param>
  Appointment.withAttachment(ItemAttachment parentAttachment, bool isNew)
      : super.withAttachment(parentAttachment) {
    // If we're running against Exchange 2007, we need to explicitly preset
    // the StartTimeZone property since Exchange 2007 will otherwise scope
    // start and end to UTC.
    if (parentAttachment.Service.RequestedServerVersion ==
        ExchangeVersion.Exchange2007_SP1) {
      if (isNew) {
        // TODO : repair time zone
//                    this.StartTimeZone = parentAttachment.Service.TimeZone;
      }
    }
  }

  /// <summary>
  /// Binds to an existing appointment and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the appointment.</param>
  /// <param name="id">The Id of the appointment to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>An Appointment instance representing the appointment corresponding to the specified Id.</returns>
  static Future<Appointment> BindWithItemIdAndPropertySet(
      ExchangeService service, ItemId id, PropertySet propertySet) {
    return service.BindToItemGeneric<Appointment>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing appointment and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the appointment.</param>
  /// <param name="id">The Id of the appointment to bind to.</param>
  /// <returns>An Appointment instance representing the appointment corresponding to the specified Id.</returns>
  static Future<Appointment> BindWithItemId(
      ExchangeService service, ItemId id) {
    return Appointment.BindWithItemIdAndPropertySet(
        service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// Binds to an occurence of an existing appointment and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the appointment.</param>
  /// <param name="recurringMasterId">The Id of the recurring master that the index represents an occurrence of.</param>
  /// <param name="occurenceIndex">The index of the occurrence.</param>
  /// <returns>An Appointment instance representing the appointment occurence corresponding to the specified occurence index .</returns>
// static Appointment BindToOccurrence(
//            ExchangeService service,
//            ItemId recurringMasterId,
//            int occurenceIndex)
//        {
//            return Appointment.BindToOccurrence(
//                service,
//                recurringMasterId,
//                occurenceIndex,
//                PropertySet.FirstClassProperties);
//        }

  /// <summary>
  /// Binds to an occurence of an existing appointment and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the appointment.</param>
  /// <param name="recurringMasterId">The Id of the recurring master that the index represents an occurrence of.</param>
  /// <param name="occurenceIndex">The index of the occurrence.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>An Appointment instance representing the appointment occurence corresponding to the specified occurence index.</returns>
// static Future<Appointment> BindToOccurrence(
//            ExchangeService service,
//            ItemId recurringMasterId,
//            int occurenceIndex,
//            PropertySet propertySet)
//        {
//            AppointmentOccurrenceId occurenceId = new AppointmentOccurrenceId(recurringMasterId.UniqueId, occurenceIndex);
//            return Appointment.BindWithItemIdAndPropertySet(
//                service,
//                occurenceId,
//                propertySet);
//        }

  /// <summary>
  /// Binds to the master appointment of a recurring series and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the appointment.</param>
  /// <param name="occurrenceId">The Id of one of the occurrences in the series.</param>
  /// <returns>An Appointment instance representing the master appointment of the recurring series to which the specified occurrence belongs.</returns>
// static Appointment BindToRecurringMaster(ExchangeService service, ItemId occurrenceId)
//        {
//            return Appointment.BindToRecurringMaster(
//                service,
//                occurrenceId,
//                PropertySet.FirstClassProperties);
//        }

  /// <summary>
  /// Binds to the master appointment of a recurring series and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the appointment.</param>
  /// <param name="occurrenceId">The Id of one of the occurrences in the series.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>An Appointment instance representing the master appointment of the recurring series to which the specified occurrence belongs.</returns>
// static Appointment BindToRecurringMaster(
//            ExchangeService service,
//            ItemId occurrenceId,
//            PropertySet propertySet)
//            {
//                RecurringAppointmentMasterId recurringMasterId = new RecurringAppointmentMasterId(occurrenceId.UniqueId);
//                return Appointment.Bind(
//                    service,
//                    recurringMasterId,
//                    propertySet);
//            }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return AppointmentSchema.Instance;
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
  /// Gets a value indicating whether a time zone SOAP header should be emitted in a CreateItem
  /// or UpdateItem request so this item can be property saved or updated.
  /// </summary>
  /// <param name="isUpdateOperation">Indicates whether the operation being petrformed is an update operation.</param>
  /// <returns>
  ///     <c>true</c> if a time zone SOAP header should be emitted; otherwise, <c>false</c>.
  /// </returns>
  @override
  bool GetIsTimeZoneHeaderRequired(bool isUpdateOperation) {
    if (isUpdateOperation) {
      return false;
    } else {
//                bool isStartTimeZoneSetOrUpdated = this.PropertyBag.IsPropertyUpdated(AppointmentSchema.StartTimeZone);
//                bool isEndTimeZoneSetOrUpdated = this.PropertyBag.IsPropertyUpdated(AppointmentSchema.EndTimeZone);

//                if (isStartTimeZoneSetOrUpdated && isEndTimeZoneSetOrUpdated)
      if (true) {
        // todo restore time zone info
        print(".. skip time zone info");
        return false;
        // If both StartTimeZone and EndTimeZone have been set or updated and are the same as the service's
        // time zone, we emit the time zone header and StartTimeZone and EndTimeZone are not emitted.
//                    TimeZoneInfo startTimeZone;
//                    TimeZoneInfo endTimeZone;

//                    this.PropertyBag.TryGetProperty<TimeZoneInfo>(AppointmentSchema.StartTimeZone, out startTimeZone);
//                    this.PropertyBag.TryGetProperty<TimeZoneInfo>(AppointmentSchema.EndTimeZone, out endTimeZone);

//                    return startTimeZone == this.Service.TimeZone || endTimeZone == this.Service.TimeZone;
      } else {
        return true;
      }
    }
  }

  /// <summary>
  /// Determines whether properties defined with ScopedDateTimePropertyDefinition require custom time zone scoping.
  /// </summary>
  /// <returns>
  ///     <c>true</c> if this item type requires custom scoping for scoped date/time properties; otherwise, <c>false</c>.
  /// </returns>
  @override
  bool GetIsCustomDateTimeScopingRequired() {
    return true;
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  @override
  void Validate() {
    super.Validate();

    //  Make sure that if we're on the Exchange2007_SP1 schema version, if any of the following
    //  properties are set or updated:
    //      o   Start
    //      o   End
    //      o   IsAllDayEvent
    //      o   Recurrence
    //  ... then, we must send the MeetingTimeZone element (which is generated from StartTimeZone for
    //  Exchange2007_SP1 requests (see StartTimeZonePropertyDefinition.cs).  If the StartTimeZone isn't
    //  in the property bag, then throw, because clients must supply the proper time zone - either by
    //  loading it from a currently-existing appointment, or by setting it directly.  Otherwise, to dirty
    //  the StartTimeZone property, we just set it to its current value.
    if ((this.Service.RequestedServerVersion ==
            ExchangeVersion.Exchange2007_SP1) &&
        !this.Service.Exchange2007CompatibilityMode) {
//              throw UnimplementedError("Appointment.Validate");
      if (this.PropertyBag.IsPropertyUpdated(AppointmentSchema.Start) ||
          this.PropertyBag.IsPropertyUpdated(AppointmentSchema.End) ||
          this.PropertyBag.IsPropertyUpdated(AppointmentSchema.IsAllDayEvent) ||
          this.PropertyBag.IsPropertyUpdated(AppointmentSchema.Recurrence)) {
        //  If the property isn't in the property bag, throw....
        if (!this.PropertyBag.Contains(AppointmentSchema.StartTimeZone)) {
          // TODO fix Appointment.Validate
//          throw new ServiceLocalException("Strings.StartTimeZoneRequired");
        }

        //  Otherwise, set the time zone to its current value to force it to be sent with the request.
//                    this.StartTimeZone = this.StartTimeZone;
        // TODO fix Appointment.Validate
        print("TODO(fix Appointment.Validate)");
      }
    }
  }

  /// <summary>
  /// Creates a reply response to the organizer and/or attendees of the meeting.
  /// </summary>
  /// <param name="replyAll">Indicates whether the reply should go to the organizer only or to all the attendees.</param>
  /// <returns>A ResponseMessage representing the reply response that can subsequently be modified and sent.</returns>
  ResponseMessage CreateReply(bool replyAll) {
    this.ThrowIfThisIsNew();

    return new ResponseMessage(this,
        replyAll ? ResponseMessageType.ReplyAll : ResponseMessageType.Reply);
  }

  /// <summary>
  /// Replies to the organizer and/or the attendees of the meeting. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="bodyPrefix">The prefix to prepend to the body of the meeting.</param>
  /// <param name="replyAll">Indicates whether the reply should go to the organizer only or to all the attendees.</param>
  void Reply(MessageBody bodyPrefix, bool replyAll) {
    ResponseMessage responseMessage = this.CreateReply(replyAll);

    responseMessage.BodyPrefix = bodyPrefix;

    responseMessage.SendAndSaveCopy();
  }

  /// <summary>
  /// Creates a forward message from this appointment.
  /// </summary>
  /// <returns>A ResponseMessage representing the forward response that can subsequently be modified and sent.</returns>
  ResponseMessage CreateForward() {
    this.ThrowIfThisIsNew();

    return new ResponseMessage(this, ResponseMessageType.Forward);
  }

  /// <summary>
  /// Forwards the appointment. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="bodyPrefix">The prefix to prepend to the original body of the message.</param>
  /// <param name="toRecipients">The recipients to forward the appointment to.</param>
// void Forward(MessageBody bodyPrefix, params EmailAddress[] toRecipients)
//        {
//            this.Forward(bodyPrefix, (Iterable<EmailAddress>)toRecipients);
//        }

  /// <summary>
  /// Forwards the appointment. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="bodyPrefix">The prefix to prepend to the original body of the message.</param>
  /// <param name="toRecipients">The recipients to forward the appointment to.</param>
// void Forward(MessageBody bodyPrefix, Iterable<EmailAddress> toRecipients)
//        {
//            ResponseMessage responseMessage = this.CreateForward();
//
//            responseMessage.BodyPrefix = bodyPrefix;
//            responseMessage.ToRecipients.AddRange(toRecipients);
//
//            responseMessage.SendAndSaveCopy();
//        }

  /// <summary>
  /// Saves this appointment in the specified folder. Calling this method results in at least one call to EWS.
  /// Mutliple calls to EWS might be made if attachments have been added.
  /// </summary>
  /// <param name="destinationFolderName">The name of the folder in which to save this appointment.</param>
  /// <param name="sendInvitationsMode">Specifies if and how invitations should be sent if this appointment is a meeting.</param>
  Future<void> SaveWithWellKnownFolderAndSendInvitationsMode(
      WellKnownFolderName destinationFolderName,
      SendInvitationsMode sendInvitationsMode) {
    return this.InternalCreate(
        new FolderId.fromWellKnownFolder(destinationFolderName),
        null,
        sendInvitationsMode);
  }

  /// <summary>
  /// Saves this appointment in the specified folder. Calling this method results in at least one call to EWS.
  /// Mutliple calls to EWS might be made if attachments have been added.
  /// </summary>
  /// <param name="destinationFolderId">The Id of the folder in which to save this appointment.</param>
  /// <param name="sendInvitationsMode">Specifies if and how invitations should be sent if this appointment is a meeting.</param>
  Future<void> SaveWithFolderIdAndInvitationsMode(
      FolderId destinationFolderId, SendInvitationsMode sendInvitationsMode) {
    EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");

    return this.InternalCreate(destinationFolderId, null, sendInvitationsMode);
  }

  /// <summary>
  /// Saves this appointment in the Calendar folder. Calling this method results in at least one call to EWS.
  /// Mutliple calls to EWS might be made if attachments have been added.
  /// </summary>
  /// <param name="sendInvitationsMode">Specifies if and how invitations should be sent if this appointment is a meeting.</param>
  Future<void> SaveWithSendInvitationsMode(
      SendInvitationsMode sendInvitationsMode) {
    return this.InternalCreate(null, null, sendInvitationsMode);
  }

  /// <summary>
  /// Applies the local changes that have been made to this appointment. Calling this method results in at least one call to EWS.
  /// Mutliple calls to EWS might be made if attachments have been added or removed.
  /// </summary>
  /// <param name="conflictResolutionMode">Specifies how conflicts should be resolved.</param>
  /// <param name="sendInvitationsOrCancellationsMode">Specifies if and how invitations or cancellations should be sent if this appointment is a meeting.</param>
// void Update(
//            ConflictResolutionMode conflictResolutionMode,
//            SendInvitationsOrCancellationsMode sendInvitationsOrCancellationsMode)
//        {
//            this.InternalUpdate(
//                null,
//                conflictResolutionMode,
//                null,
//                sendInvitationsOrCancellationsMode);
//        }

  /// <summary>
  /// Deletes this appointment. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="deleteMode">The deletion mode.</param>
  /// <param name="sendCancellationsMode">Specifies if and how cancellations should be sent if this appointment is a meeting.</param>
// Future<void> Delete(DeleteMode deleteMode, SendCancellationsMode sendCancellationsMode)
//        {
//            this.InternalDelete(
//                deleteMode,
//                sendCancellationsMode,
//                null);
//        }

  /// <summary>
  /// Creates a local meeting acceptance message that can be customized and sent.
  /// </summary>
  /// <param name="tentative">Specifies whether the meeting will be tentatively accepted.</param>
  /// <returns>An AcceptMeetingInvitationMessage representing the meeting acceptance message. </returns>
  AcceptMeetingInvitationMessage CreateAcceptMessage(bool tentative) {
    return new AcceptMeetingInvitationMessage(this, tentative);
  }

  /// <summary>
  /// Creates a local meeting cancellation message that can be customized and sent.
  /// </summary>
  /// <returns>A CancelMeetingMessage representing the meeting cancellation message. </returns>
  CancelMeetingMessage CreateCancelMeetingMessage() {
    return new CancelMeetingMessage(this);
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
  /// Cancels the meeting and sends cancellation messages to all attendees. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="cancellationMessageText">Cancellation message text sent to all attendees.</param>
  /// <returns>
  /// A CalendarActionResults object containing the various items that were created or modified as a
  /// results of this operation.
  /// </returns>
  Future<CalendarActionResults> CancelMeeting(
      [String? cancellationMessageText = null]) {
    throw NotImplementedException("CancelMeeting");
//            CancelMeetingMessage cancelMsg = this.CreateCancelMeetingMessage();
//            cancelMsg.Body = cancellationMessageText;
//            return cancelMsg.SendAndSaveCopy();
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
  /// Gets the default setting for sending cancellations on Delete.
  /// </summary>
  /// <returns>If Delete() is called on Appointment, we want to send cancellations and save a copy.</returns>
  @override
  SendCancellationsMode get DefaultSendCancellationsMode =>
      SendCancellationsMode.SendToAllAndSaveCopy;

  /// <summary>
  /// Gets the default settings for sending invitations on Save.
  /// </summary>
  @override
  SendInvitationsMode get DefaultSendInvitationsMode =>
      SendInvitationsMode.SendToAllAndSaveCopy;

  /// <summary>
  /// Gets the default settings for sending invitations or cancellations on Update.
  /// </summary>
  @override
  SendInvitationsOrCancellationsMode
      get DefaultSendInvitationsOrCancellationsMode =>
          SendInvitationsOrCancellationsMode.SendToAllAndSaveCopy;

  /// <summary>
  /// Gets or sets the start time of the appointment.
  /// </summary>
  DateTime? get Start => this.PropertyBag[AppointmentSchema.Start] as DateTime?;

  set Start(DateTime? value) =>
      this.PropertyBag[AppointmentSchema.Start] = value;

  /// <summary>
  /// Gets or sets the end time of the appointment.
  /// </summary>
  DateTime? get End => this.PropertyBag[AppointmentSchema.End] as DateTime?;

  set End(DateTime? value) => this.PropertyBag[AppointmentSchema.End] = value;

  /// <summary>
  /// Gets the original start time of this appointment.
  /// </summary>
//        DateTime get OriginalStart => this.PropertyBag[AppointmentSchema.OriginalStart];

  /// <summary>
  /// Gets or sets a value indicating whether this appointment is an all day event.
  /// </summary>
  bool? get IsAllDayEvent =>
      this.PropertyBag[AppointmentSchema.IsAllDayEvent] as bool?;

  set IsAllDayEvent(bool? value) =>
      this.PropertyBag[AppointmentSchema.IsAllDayEvent] = value;

  /// <summary>
  /// Gets or sets a value indicating the free/busy status of the owner of this appointment.
  /// </summary>
//        LegacyFreeBusyStatus get LegacyFreeBusyStatus => this.PropertyBag[AppointmentSchema.LegacyFreeBusyStatus];
//        set LegacyFreeBusyStatus(LegacyFreeBusyStatus value) => this.PropertyBag[AppointmentSchema.LegacyFreeBusyStatus] = value;

  /// <summary>
  /// Gets or sets the location of this appointment.
  /// </summary>
  String? get Location =>
      this.PropertyBag[AppointmentSchema.Location] as String?;

  set Location(String? value) =>
      this.PropertyBag[AppointmentSchema.Location] = value;

  /// <summary>

  /// </summary>
  String? get When => this.PropertyBag[AppointmentSchema.When] as String?;

  /// <summary>
  /// Gets a value indicating whether the appointment is a meeting.
  /// </summary>
  bool? get IsMeeting => this.PropertyBag[AppointmentSchema.IsMeeting] as bool?;

  /// <summary>
  /// Gets a value indicating whether the appointment has been cancelled.
  /// </summary>
  bool? get IsCancelled =>
      this.PropertyBag[AppointmentSchema.IsCancelled] as bool?;

  /// <summary>
  /// Gets a value indicating whether the appointment is recurring.
  /// </summary>
  bool? get IsRecurring =>
      this.PropertyBag[AppointmentSchema.IsRecurring] as bool?;

  /// <summary>
  /// Gets a value indicating whether the meeting request has already been sent.
  /// </summary>
  bool? get MeetingRequestWasSent =>
      this.PropertyBag[AppointmentSchema.MeetingRequestWasSent] as bool?;

  /// <summary>
  /// Gets or sets a value indicating whether responses are requested when invitations are sent for this meeting.
  /// </summary>
  bool? get IsResponseRequested =>
      this.PropertyBag[AppointmentSchema.IsResponseRequested] as bool?;

  set IsResponseRequested(bool? value) =>
      this.PropertyBag[AppointmentSchema.IsResponseRequested] = value;

  /// <summary>
  /// Gets a value indicating the type of this appointment.
  /// </summary>
  enumerations.AppointmentType? get AppointmentType =>
      this.PropertyBag[AppointmentSchema.AppointmentType]
          as enumerations.AppointmentType?;

  /// <summary>
  /// Gets a value indicating what was the last response of the user that loaded this meeting.
  /// </summary>
  MeetingResponseType? get MyResponseType =>
      this.PropertyBag[AppointmentSchema.MyResponseType]
          as MeetingResponseType?;

  /// <summary>
  /// Gets the organizer of this meeting. The Organizer property is read-only and is only relevant for attendees.
  /// The organizer of a meeting is automatically set to the user that created the meeting.
  /// </summary>
  EmailAddress? get Organizer =>
      this.PropertyBag[AppointmentSchema.Organizer] as EmailAddress?;

  /// <summary>
  /// Gets a list of required attendees for this meeting.
  /// </summary>
  AttendeeCollection get RequiredAttendees =>
      this.PropertyBag[AppointmentSchema.RequiredAttendees]
          as AttendeeCollection;

  /// <summary>
  /// Gets a list of optional attendeed for this meeting.
  /// </summary>
  AttendeeCollection get OptionalAttendees =>
      this.PropertyBag[AppointmentSchema.OptionalAttendees]
          as AttendeeCollection;

  /// <summary>
  /// Gets a list of resources for this meeting.
  /// </summary>
  AttendeeCollection get Resources =>
      this.PropertyBag[AppointmentSchema.Resources] as AttendeeCollection;

  /// <summary>
  /// Gets the number of calendar entries that conflict with this appointment in the authenticated user's calendar.
  /// </summary>
  int? get ConflictingMeetingCount =>
      this.PropertyBag[AppointmentSchema.ConflictingMeetingCount] as int?;

  /// <summary>
  /// Gets the number of calendar entries that are adjacent to this appointment in the authenticated user's calendar.
  /// </summary>
  int? get AdjacentMeetingCount =>
      this.PropertyBag[AppointmentSchema.AdjacentMeetingCount] as int?;

  /// <summary>
  /// Gets a list of meetings that conflict with this appointment in the authenticated user's calendar.
  /// </summary>
  ItemCollection<Appointment>? get ConflictingMeetings =>
      this.PropertyBag[AppointmentSchema.ConflictingMeetings]
          as ItemCollection<Appointment>?;

  /// <summary>
  /// Gets a list of meetings that conflict with this appointment in the authenticated user's calendar.
  /// </summary>
  ItemCollection<Appointment>? get AdjacentMeetings =>
      this.PropertyBag[AppointmentSchema.AdjacentMeetings]
          as ItemCollection<Appointment>?;

  /// <summary>
  /// Gets the duration of this appointment.
  /// </summary>
  TimeSpan? get Duration =>
      this.PropertyBag[AppointmentSchema.Duration] as TimeSpan?;

  /// <summary>
  /// Gets the name of the time zone this appointment is defined in.
  /// </summary>
  String? get TimeZone =>
      this.PropertyBag[AppointmentSchema.TimeZone] as String?;

  /// <summary>
  /// Gets the time when the attendee replied to the meeting request.
  /// </summary>
  DateTime? get AppointmentReplyTime =>
      this.PropertyBag[AppointmentSchema.AppointmentReplyTime] as DateTime?;

  /// <summary>
  /// Gets the sequence number of this appointment.
  /// </summary>
  int? get AppointmentSequenceNumber =>
      this.PropertyBag[AppointmentSchema.AppointmentSequenceNumber] as int?;

  /// <summary>
  /// Gets the state of this appointment.
  /// </summary>
  int? get AppointmentState =>
      this.PropertyBag[AppointmentSchema.AppointmentState] as int?;

  /// <summary>
  /// Gets or sets the recurrence pattern for this appointment. Available recurrence pattern classes include
  /// Recurrence.DailyPattern, Recurrence.MonthlyPattern and Recurrence.YearlyPattern.
  /// </summary>
  complex.Recurrence? get Recurrence =>
      this.PropertyBag[AppointmentSchema.Recurrence] as complex.Recurrence?;

  set Recurrence(complex.Recurrence? value) {
    if (value != null) {
      if (value.IsRegenerationPattern) {
        throw new ServiceLocalException(
            "Strings.RegenerationPatternsOnlyValidForTasks");
      }
    }

    this.PropertyBag[AppointmentSchema.Recurrence] = value;
  }

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
  /// Gets or sets time zone of the start property of this appointment.
  /// </summary>
//        TimeZoneInfo get StartTimeZone => this.PropertyBag[AppointmentSchema.StartTimeZone];
//        set StartTimeZone(TimeZoneInfo value) => this.PropertyBag[AppointmentSchema.StartTimeZone] = value;

  /// <summary>
  /// Gets or sets time zone of the end property of this appointment.
  /// </summary>
//        TimeZoneInfo get EndTimeZone => this.PropertyBag[AppointmentSchema.EndTimeZone];
//        set EndTimeZone(TimeZoneInfo value) => this.PropertyBag[AppointmentSchema.EndTimeZone] = value;

  /// <summary>
  /// Gets or sets the type of conferencing that will be used during the meeting.
  /// </summary>
  int? get ConferenceType =>
      this.PropertyBag[AppointmentSchema.ConferenceType] as int?;

  set ConferenceType(int? value) =>
      this.PropertyBag[AppointmentSchema.ConferenceType] = value;

  /// <summary>
  /// Gets or sets a value indicating whether new time proposals are allowed for attendees of this meeting.
  /// </summary>
  bool? get AllowNewTimeProposal =>
      this.PropertyBag[AppointmentSchema.AllowNewTimeProposal] as bool?;

  set AllowNewTimeProposal(bool? value) =>
      this.PropertyBag[AppointmentSchema.AllowNewTimeProposal] = value;

  /// <summary>
  /// Gets or sets a value indicating whether this is an online meeting.
  /// </summary>
  bool? get IsOnlineMeeting =>
      this.PropertyBag[AppointmentSchema.IsOnlineMeeting] as bool?;

  set IsOnlineMeeting(bool? value) =>
      this.PropertyBag[AppointmentSchema.IsOnlineMeeting] = value;

  /// <summary>
  /// Gets or sets the URL of the meeting workspace. A meeting workspace is a shared Web site for planning meetings and tracking results.
  /// </summary>
  String? get MeetingWorkspaceUrl =>
      this.PropertyBag[AppointmentSchema.MeetingWorkspaceUrl] as String?;

  set MeetingWorkspaceUrl(String? value) =>
      this.PropertyBag[AppointmentSchema.MeetingWorkspaceUrl] = value;

  /// <summary>
  /// Gets or sets the URL of the Microsoft NetShow online meeting.
  /// </summary>
  String? get NetShowUrl =>
      this.PropertyBag[AppointmentSchema.NetShowUrl] as String?;

  set NetShowUrl(String? value) =>
      this.PropertyBag[AppointmentSchema.NetShowUrl] = value;

  /// <summary>
  /// Gets or sets the ICalendar Uid.
  /// </summary>
  String? get ICalUid => this.PropertyBag[AppointmentSchema.ICalUid] as String?;

  set ICalUid(String? value) =>
      this.PropertyBag[AppointmentSchema.ICalUid] = value;

  /// <summary>
  /// Gets the ICalendar RecurrenceId.
  /// </summary>
  DateTime? get ICalRecurrenceId =>
      this.PropertyBag[AppointmentSchema.ICalRecurrenceId] as DateTime?;

  /// <summary>
  /// Gets the ICalendar DateTimeStamp.
  /// </summary>
  DateTime? get ICalDateTimeStamp =>
      this.PropertyBag[AppointmentSchema.ICalDateTimeStamp] as DateTime?;

  /// <summary>
  /// Gets or sets the Enhanced location object.
  /// </summary>
  complex.EnhancedLocation? get EnhancedLocation =>
      this.PropertyBag[AppointmentSchema.EnhancedLocation]
          as complex.EnhancedLocation?;

  set EnhancedLocation(complex.EnhancedLocation? value) =>
      this.PropertyBag[AppointmentSchema.EnhancedLocation] = value;

  /// <summary>
  /// Gets the Url for joining an online meeting
  /// </summary>
  String? get JoinOnlineMeetingUrl =>
      this.PropertyBag[AppointmentSchema.JoinOnlineMeetingUrl] as String?;

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(XmlElementNames.CalendarItem);
  }

  /// <summary>
  /// Gets the Online Meeting Settings
  /// </summary>
//        OnlineMeetingSettings get OnlineMeetingSettings => this.PropertyBag[AppointmentSchema.OnlineMeetingSettings];

}
