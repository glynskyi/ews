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

import 'dart:typed_data';

import 'package:ews/Attributes/ServiceObjectDefinitionAttribute.dart';
import 'package:ews/ComplexProperties/EmailAddress.dart';
import 'package:ews/ComplexProperties/EmailAddressCollection.dart';
import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/ResponseMessage.dart';
import 'package:ews/Core/ServiceObjects/Schemas/EmailMessageSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ConflictResolutionMode.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/MessageDisposition.dart';
import 'package:ews/Enumerations/ResponseMessageType.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart';

/// <summary>
/// Represents an e-mail message. Properties available on e-mail messages are defined in the EmailMessageSchema class.
/// </summary>
//    [Attachable]
//    [ServiceObjectDefinition(XmlElementNames.Message)]
class EmailMessage extends Item {
  /// <summary>
  /// Initializes an unsaved local instance of <see cref="EmailMessage"/>. To bind to an existing e-mail message, use EmailMessage.Bind() instead.
  /// </summary>
  /// <param name="service">The ExchangeService object to which the e-mail message will be bound.</param>
  EmailMessage(ExchangeService service) : super(service) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="EmailMessage"/> class.
  /// </summary>
  /// <param name="parentAttachment">The parent attachment.</param>
  EmailMessage.withAttachment(ItemAttachment parentAttachment)
      : super.withAttachment(parentAttachment) {}

  /// <summary>
  /// Binds to an existing e-mail message and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the e-mail message.</param>
  /// <param name="id">The Id of the e-mail message to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>An EmailMessage instance representing the e-mail message corresponding to the specified Id.</returns>
  static Future<EmailMessage> Bind(
      ExchangeService service, ItemId? id, PropertySet propertySet) {
    return service.BindToItemGeneric<EmailMessage>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing e-mail message and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the e-mail message.</param>
  /// <param name="id">The Id of the e-mail message to bind to.</param>
  /// <returns>An EmailMessage instance representing the e-mail message corresponding to the specified Id.</returns>
  static Future<EmailMessage> BindWithItemId(
      ExchangeService service, ItemId id) {
    return EmailMessage.Bind(service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return EmailMessageSchema.Instance;
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
  /// Send message.
  /// </summary>
  /// <param name="parentFolderId">The parent folder id.</param>
  /// <param name="messageDisposition">The message disposition.</param>
  Future<void> _InternalSend(
      FolderId? parentFolderId, MessageDisposition messageDisposition) async {
    this.ThrowIfThisIsAttachment();

    if (this.IsNew) {
      if ((this.Attachments.Count == 0) ||
          (messageDisposition == MessageDisposition.SaveOnly)) {
        await this.InternalCreate(parentFolderId, messageDisposition, null);
      } else {
        // If the message has attachments, save as a draft (and add attachments) before sending.
        await this.InternalCreate(
            null,
            // null means use the Drafts folder in the mailbox of the authenticated user.
            MessageDisposition.SaveOnly,
            null);

        await this.Service.SendItem(this, parentFolderId);
      }
    } else {
      // Regardless of whether item is dirty or not, if it has unprocessed
      // attachment changes, process them now.

      // Validate and save attachments before sending.
      if (this.HasUnprocessedAttachmentChanges()) {
        this.Attachments.Validate();
        await this.Attachments.Save();
      }

      if (this.PropertyBag.GetIsUpdateCallNecessary()) {
        await this.InternalUpdate(parentFolderId,
            ConflictResolutionMode.AutoResolve, messageDisposition, null);
      } else {
        await this.Service.SendItem(this, parentFolderId);
      }
    }
  }

  /// <summary>
  /// Creates a reply response to the message.
  /// </summary>
  /// <param name="replyAll">Indicates whether the reply should go to all of the original recipients of the message.</param>
  /// <returns>A ResponseMessage representing the reply response that can subsequently be modified and sent.</returns>
  ResponseMessage CreateReply(bool replyAll) {
    this.ThrowIfThisIsNew();

    return new ResponseMessage(this,
        replyAll ? ResponseMessageType.ReplyAll : ResponseMessageType.Reply);
  }

  /// <summary>
  /// Creates a forward response to the message.
  /// </summary>
  /// <returns>A ResponseMessage representing the forward response that can subsequently be modified and sent.</returns>
  ResponseMessage CreateForward() {
    this.ThrowIfThisIsNew();

    return new ResponseMessage(this, ResponseMessageType.Forward);
  }

  /// <summary>
  /// Replies to the message. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="bodyPrefix">The prefix to prepend to the original body of the message.</param>
  /// <param name="replyAll">Indicates whether the reply should be sent to all of the original recipients of the message.</param>
  void Reply(MessageBody bodyPrefix, bool replyAll) {
    ResponseMessage responseMessage = this.CreateReply(replyAll);

    responseMessage.BodyPrefix = bodyPrefix;

    responseMessage.SendAndSaveCopy();
  }

  /// <summary>
  /// Forwards the message. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="bodyPrefix">The prefix to prepend to the original body of the message.</param>
  /// <param name="toRecipients">The recipients to forward the message to.</param>
// void Forward(MessageBody bodyPrefix, List<EmailAddress> toRecipients)
//        {
//            this.Forward(bodyPrefix, (Iterable<EmailAddress>)toRecipients);
//        }

  /// <summary>
  /// Forwards the message. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="bodyPrefix">The prefix to prepend to the original body of the message.</param>
  /// <param name="toRecipients">The recipients to forward the message to.</param>
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
  /// Sends this e-mail message. Calling this method results in at least one call to EWS.
  /// </summary>
  Future<void> Send() async {
    await this._InternalSend(null, MessageDisposition.SendOnly);
  }

  /// <summary>
  /// Sends this e-mail message and saves a copy of it in the specified folder. SendAndSaveCopy does not work if the
  /// message has unsaved attachments. In that case, the message must first be saved and then sent. Calling this method
  /// results in a call to EWS.
  /// </summary>
  /// <param name="destinationFolderId">The Id of the folder in which to save the copy.</param>
  void SendAndSaveCopyWithFolderId(FolderId destinationFolderId) {
    EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");

    this._InternalSend(destinationFolderId, MessageDisposition.SendAndSaveCopy);
  }

  /// <summary>
  /// Sends this e-mail message and saves a copy of it in the specified folder. SendAndSaveCopy does not work if the
  /// message has unsaved attachments. In that case, the message must first be saved and then sent. Calling this method
  /// results in a call to EWS.
  /// </summary>
  /// <param name="destinationFolderName">The name of the folder in which to save the copy.</param>
  void SendAndSaveCopyWithWellKnownFolder(
      WellKnownFolderName destinationFolderName) {
    this._InternalSend(new FolderId.fromWellKnownFolder(destinationFolderName),
        MessageDisposition.SendAndSaveCopy);
  }

  /// <summary>
  /// Sends this e-mail message and saves a copy of it in the Sent Items folder. SendAndSaveCopy does not work if the
  /// message has unsaved attachments. In that case, the message must first be saved and then sent. Calling this method
  /// results in a call to EWS.
  /// </summary>
  Future<void> SendAndSaveCopy() {
    return this._InternalSend(
        new FolderId.fromWellKnownFolder(WellKnownFolderName.SentItems),
        MessageDisposition.SendAndSaveCopy);
  }

  /// <summary>
  /// Suppresses the read receipt on the message. Calling this method results in a call to EWS.
  /// </summary>
// void SuppressReadReceipt()
//        {
//            this.ThrowIfThisIsNew();
//
//            new SuppressReadReceipt(this).InternalCreate(null, null);
//        }

  /// <summary>
  /// Gets the list of To recipients for the e-mail message.
  /// </summary>
  EmailAddressCollection get ToRecipients =>
      this.PropertyBag[EmailMessageSchema.ToRecipients]
          as EmailAddressCollection;

  /// <summary>
  /// Gets the list of Bcc recipients for the e-mail message.
  /// </summary>
  EmailAddressCollection get BccRecipients =>
      this.PropertyBag[EmailMessageSchema.BccRecipients]
          as EmailAddressCollection;

  /// <summary>
  /// Gets the Likers associated with the message.
  /// </summary>
// EmailAddressCollection get Likers =>this.PropertyBag[EmailMessageSchema.Likers];

  /// <summary>
  /// Gets the list of Cc recipients for the e-mail message.
  /// </summary>
  EmailAddressCollection get CcRecipients =>
      this.PropertyBag[EmailMessageSchema.CcRecipients]
          as EmailAddressCollection;

  /// <summary>
  /// Gets the conversation topic of the e-mail message.
  /// </summary>
  String? get ConversationTopic =>
      this.PropertyBag[EmailMessageSchema.ConversationTopic] as String?;

  /// <summary>
  /// Gets the conversation index of the e-mail message.
  /// </summary>
  Uint8List? get ConversationIndex =>
      this.PropertyBag[EmailMessageSchema.ConversationIndex] as Uint8List?;

  /// <summary>
  /// Gets or sets the "on behalf" sender of the e-mail message.
  /// </summary>
  EmailAddress? get From =>
      this.PropertyBag[EmailMessageSchema.From] as EmailAddress?;

  set From(EmailAddress? value) =>
      this.PropertyBag[EmailMessageSchema.From] = value;

  /// <summary>
  /// Gets or sets a value indicating whether this is an associated message.
  /// </summary>
  bool? get IsAssociated => super.IsAssociated;

  // The "new" keyword is used to expose the setter only on Message types, because
  // EWS only supports creation of FAI Message types.  IsAssociated is a readonly
  // property of the Item type but it is used by the CreateItem web method for creating
  // associated messages.
//        set IsAssociated(bool value) => this.PropertyBag[EmailMessageSchema.IsAssociated] = value;

  /// <summary>
  /// Gets or sets a value indicating whether a read receipt is requested for the e-mail message.
  /// </summary>
  bool? get IsDeliveryReceiptRequested =>
      this.PropertyBag[EmailMessageSchema.IsDeliveryReceiptRequested] as bool?;

  set IsDeliveryReceiptRequested(bool? value) =>
      this.PropertyBag[EmailMessageSchema.IsDeliveryReceiptRequested] = value;

  /// <summary>
  /// Gets or sets a value indicating whether the e-mail message is read.
  /// </summary>
  bool? get IsRead => this.PropertyBag[EmailMessageSchema.IsRead] as bool?;

  set IsRead(bool? value) =>
      this.PropertyBag[EmailMessageSchema.IsRead] = value;

  /// <summary>
  /// Gets or sets a value indicating whether a read receipt is requested for the e-mail message.
  /// </summary>
  bool? get IsReadReceiptRequested =>
      this.PropertyBag[EmailMessageSchema.IsReadReceiptRequested] as bool?;

  set IsReadReceiptRequested(bool? value) =>
      this.PropertyBag[EmailMessageSchema.IsReadReceiptRequested] = value;

  /// <summary>
  /// Gets or sets a value indicating whether a response is requested for the e-mail message.
  /// </summary>
  bool? get IsResponseRequested =>
      this.PropertyBag[EmailMessageSchema.IsResponseRequested] as bool?;

  set IsResponseRequested(bool? value) =>
      this.PropertyBag[EmailMessageSchema.IsResponseRequested] = value;

  /// <summary>
  /// Gets the Internet Message Id of the e-mail message.
  /// </summary>
  String? get InternetMessageId =>
      this.PropertyBag[EmailMessageSchema.InternetMessageId] as String?;

  /// <summary>
  /// Gets or sets the references of the e-mail message.
  /// </summary>
  String? get References =>
      this.PropertyBag[EmailMessageSchema.References] as String?;

  set References(String? value) =>
      this.PropertyBag[EmailMessageSchema.References] = value;

  /// <summary>
  /// Gets a list of e-mail addresses to which replies should be addressed.
  /// </summary>
  EmailAddressCollection get ReplyTo =>
      this.PropertyBag[EmailMessageSchema.ReplyTo] as EmailAddressCollection;

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(XmlElementNames.Message);
  }

  /// <summary>
  /// Gets or sets the sender of the e-mail message.
  /// </summary>
  EmailAddress? get Sender =>
      this.PropertyBag[EmailMessageSchema.Sender] as EmailAddress?;

  set Sender(EmailAddress? value) =>
      this.PropertyBag[EmailMessageSchema.Sender] = value;

  /// <summary>
  /// Gets the ReceivedBy property of the e-mail message.
  /// </summary>
// EmailAddress get ReceivedBy => this.PropertyBag[EmailMessageSchema.ReceivedBy];

  /// <summary>
  /// Gets the ReceivedRepresenting property of the e-mail message.
  /// </summary>
//        EmailAddress get ReceivedRepresenting => this.PropertyBag[EmailMessageSchema.ReceivedRepresenting];

  /// <summary>
  /// Gets the ApprovalRequestData property of the e-mail message.
  /// </summary>
// complex.ApprovalRequestData get ApprovalRequestData => this.PropertyBag[EmailMessageSchema.ApprovalRequestData];

  /// <summary>
  /// Gets the VotingInformation property of the e-mail message.
  /// </summary>
// VotingInformation get VotingInformation => this.PropertyBag[EmailMessageSchema.VotingInformation];
}
