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

import 'dart:core';

import 'package:ews/Attributes/ServiceObjectDefinitionAttribute.dart';
import 'package:ews/ComplexProperties/AttachmentCollection.dart';
import 'package:ews/ComplexProperties/ExtendedPropertyCollection.dart';
import 'package:ews/ComplexProperties/Flag.dart';
import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/ComplexProperties/MimeContent.dart' as complex;
import 'package:ews/ComplexProperties/StringList.dart';
import 'package:ews/ComplexProperties/TextBody.dart' as complex;
import 'package:ews/ComplexProperties/UniqueBody.dart' as complex;
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AffectedTaskOccurrence.dart';
import 'package:ews/Enumerations/ConflictResolutionMode.dart';
import 'package:ews/Enumerations/DeleteMode.dart';
import 'package:ews/Enumerations/EffectiveRights.dart' as enumerations;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/Importance.dart' as complex;
import 'package:ews/Enumerations/MessageDisposition.dart';
import 'package:ews/Enumerations/SendCancellationsMode.dart';
import 'package:ews/Enumerations/SendInvitationsMode.dart';
import 'package:ews/Enumerations/SendInvitationsOrCancellationsMode.dart';
import 'package:ews/Enumerations/Sensitivity.dart' as enumerations;
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart';
import 'package:ews/Exceptions/InvalidOperationException.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/PropertyDefinitions/ExtendedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/misc/OutParam.dart';

/// <summary>
/// Represents a generic item. Properties available on items are defined in the ItemSchema class.
/// </summary>
//    [Attachable]
//    [ServiceObjectDefinition(XmlElementNames.Item)]
class Item extends ServiceObject {
  ItemAttachment _parentAttachment;

  /// <summary>
  /// Initializes an unsaved local instance of <see cref="Item"/>. To bind to an existing item, use Item.Bind() instead.
  /// </summary>
  /// <param name="service">The ExchangeService object to which the item will be bound.</param>
  Item(ExchangeService service) : super(service);

  /// <summary>
  /// Initializes a new instance of the <see cref="Item"/> class.
  /// </summary>
  /// <param name="parentAttachment">The parent attachment.</param>
  Item.withAttachment(ItemAttachment parentAttachment)
      : super(parentAttachment.Service) {
    EwsUtilities.Assert(
        parentAttachment != null, "Item.ctor", "parentAttachment is null");

    this._parentAttachment = parentAttachment;
  }

  /// <summary>
  /// Binds to an existing item, whatever its actual type is, and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the item.</param>
  /// <param name="id">The Id of the item to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>An Item instance representing the item corresponding to the specified Id.</returns>
  static Future<Item> BindWithPropertySet(
      ExchangeService service, ItemId id, PropertySet propertySet) {
    return service.BindToItemGeneric<Item>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing item, whatever its actual type is, and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the item.</param>
  /// <param name="id">The Id of the item to bind to.</param>
  /// <returns>An Item instance representing the item corresponding to the specified Id.</returns>
  static Future<Item> Bind(ExchangeService service, ItemId id) {
    return Item.BindWithPropertySet(
        service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return ItemSchema.Instance;
  }

  /// <summary>
  /// Gets the minimum required server version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(XmlElementNames.Item);
  }

  /// <summary>
  /// Throws exception if this is attachment.
  /// </summary>
  void ThrowIfThisIsAttachment() {
    if (this.IsAttachment) {
      throw new InvalidOperationException(
          "Strings.OperationDoesNotSupportAttachments");
    }
  }

  /// <summary>
  /// The property definition for the Id of this object.
  /// </summary>
  /// <returns>A PropertyDefinition instance.</returns>
  @override
  PropertyDefinition GetIdPropertyDefinition() {
    return ItemSchema.Id;
  }

  /// <summary>
  /// Loads the specified set of properties on the object.
  /// </summary>
  /// <param name="propertySet">The properties to load.</param>
  @override
  Future<void> InternalLoad(PropertySet propertySet) {
    this.ThrowIfThisIsNew();
    this.ThrowIfThisIsAttachment();

    return this.Service.InternalLoadPropertiesForItems(
        [this], propertySet, ServiceErrorHandling.ThrowOnError);
  }

  /// <summary>
  /// Deletes the object.
  /// </summary>
  /// <param name="deleteMode">The deletion mode.</param>
  /// <param name="sendCancellationsMode">Indicates whether meeting cancellation messages should be sent.</param>
  /// <param name="affectedTaskOccurrences">Indicate which occurrence of a recurring task should be deleted.</param>
  /// <param name="suppressReadReceipts">Whether to suppress read receipts</param>
  Future<void> InternalDelete(
      DeleteMode deleteMode,
      SendCancellationsMode sendCancellationsMode,
      AffectedTaskOccurrence affectedTaskOccurrences,
      [bool suppressReadReceipts = false]) {
    this.ThrowIfThisIsNew();
    this.ThrowIfThisIsAttachment();

    // If sendCancellationsMode is null, use the default value that's appropriate for item type.
    if (sendCancellationsMode == null) {
      sendCancellationsMode = this.DefaultSendCancellationsMode;
    }

    // If affectedTaskOccurrences is null, use the default value that's appropriate for item type.
    if (affectedTaskOccurrences == null) {
      affectedTaskOccurrences = this.DefaultAffectedTaskOccurrences;
    }

    return this.Service.DeleteItem(this.Id, deleteMode, sendCancellationsMode,
        affectedTaskOccurrences, suppressReadReceipts);
  }

  /// <summary>
  /// Create item.
  /// </summary>
  /// <param name="parentFolderId">The parent folder id.</param>
  /// <param name="messageDisposition">The message disposition.</param>
  /// <param name="sendInvitationsMode">The send invitations mode.</param>
  Future<void> InternalCreate(
      FolderId parentFolderId,
      MessageDisposition messageDisposition,
      SendInvitationsMode sendInvitationsMode) async {
    this.ThrowIfThisIsNotNew();
    this.ThrowIfThisIsAttachment();

    if (this.IsNew || this.IsDirty) {
      await this.Service.CreateItem(
          this,
          parentFolderId,
          messageDisposition,
          sendInvitationsMode != null
              ? sendInvitationsMode
              : this.DefaultSendInvitationsMode);

      await this.Attachments.Save();
    }
  }

  /// <summary>
  /// Update item.
  /// </summary>
  /// <param name="parentFolderId">The parent folder id.</param>
  /// <param name="conflictResolutionMode">The conflict resolution mode.</param>
  /// <param name="messageDisposition">The message disposition.</param>
  /// <param name="sendInvitationsOrCancellationsMode">The send invitations or cancellations mode.</param>
  /// <returns>Updated item.</returns>
//        Item InternalUpdate(
//            FolderId parentFolderId,
//            ConflictResolutionMode conflictResolutionMode,
//            MessageDisposition? messageDisposition,
//            SendInvitationsOrCancellationsMode? sendInvitationsOrCancellationsMode)
//        {
//            return this.InternalUpdate(parentFolderId, conflictResolutionMode, messageDisposition, sendInvitationsOrCancellationsMode, false);
//        }

  /// <summary>
  /// Update item.
  /// </summary>
  /// <param name="parentFolderId">The parent folder id.</param>
  /// <param name="conflictResolutionMode">The conflict resolution mode.</param>
  /// <param name="messageDisposition">The message disposition.</param>
  /// <param name="sendInvitationsOrCancellationsMode">The send invitations or cancellations mode.</param>
  /// <param name="suppressReadReceipts">Whether to suppress read receipts</param>
  /// <returns>Updated item.</returns>
  Future<Item> InternalUpdate(
      FolderId parentFolderId,
      ConflictResolutionMode conflictResolutionMode,
      MessageDisposition messageDisposition,
      SendInvitationsOrCancellationsMode sendInvitationsOrCancellationsMode,
      [bool suppressReadReceipts = false]) async {
    this.ThrowIfThisIsNew();
    this.ThrowIfThisIsAttachment();

    Item returnedItem = null;

    if (this.IsDirty && this.PropertyBag.GetIsUpdateCallNecessary()) {
      returnedItem = await this.Service.UpdateItem(
          this,
          parentFolderId,
          conflictResolutionMode,
          messageDisposition,
          sendInvitationsOrCancellationsMode ??
              this.DefaultSendInvitationsOrCancellationsMode,
          suppressReadReceipts);
    }

    // Regardless of whether item is dirty or not, if it has unprocessed
    // attachment changes, validate them and process now.
    if (this.HasUnprocessedAttachmentChanges()) {
      this.Attachments.Validate();
      await this.Attachments.Save();
    }

    return returnedItem;
  }

  /// <summary>
  /// Gets a value indicating whether this instance has unprocessed attachment collection changes.
  /// </summary>
  bool HasUnprocessedAttachmentChanges() {
    return this.Attachments.HasUnprocessedChanges();
  }

  /// <summary>
  /// Gets the parent attachment of this item.
  /// </summary>
  ItemAttachment get ParentAttachment => this._parentAttachment;

  /// <summary>
  /// Gets Id of the root item for this item.
  /// </summary>
  ItemId get RootItemId {
    if (this.IsAttachment && this.ParentAttachment.Owner != null) {
      return this.ParentAttachment.Owner.RootItemId;
    } else {
      return this.Id;
    }
  }

  /// <summary>
  /// Deletes the item. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="deleteMode">The deletion mode.</param>
  /// <param name="suppressReadReceipts">Whether to suppress read receipts</param>
  Future<void> Delete(DeleteMode deleteMode,
      [bool suppressReadReceipts = false]) {
    return this.InternalDelete(deleteMode, null, null, suppressReadReceipts);
  }

  /// <summary>
  /// Saves this item in a specific folder. Calling this method results in at least one call to EWS.
  /// Mutliple calls to EWS might be made if attachments have been added.
  /// </summary>
  /// <param name="parentFolderId">The Id of the folder in which to save this item.</param>
  Future<void> SaveWithFolderId(FolderId parentFolderId) {
//            EwsUtilities.ValidateParam(parentFolderId, "parentFolderId");

    return this
        .InternalCreate(parentFolderId, MessageDisposition.SaveOnly, null);
  }

  /// <summary>
  /// Saves this item in a specific folder. Calling this method results in at least one call to EWS.
  /// Mutliple calls to EWS might be made if attachments have been added.
  /// </summary>
  /// <param name="parentFolderName">The name of the folder in which to save this item.</param>
  Future<void> SaveWithWellKnownFolderName(
      WellKnownFolderName parentFolderName) {
    return this.InternalCreate(
        new FolderId.fromWellKnownFolder(parentFolderName),
        MessageDisposition.SaveOnly,
        null);
  }

  /// <summary>
  /// Saves this item in the default folder based on the item's type (for example, an e-mail message is saved to the Drafts folder).
  /// Calling this method results in at least one call to EWS. Mutliple calls to EWS might be made if attachments have been added.
  /// </summary>
  Future<void> Save() {
    return this.InternalCreate(null, MessageDisposition.SaveOnly, null);
  }

  /// <summary>
  /// Applies the local changes that have been made to this item. Calling this method results in at least one call to EWS.
  /// Mutliple calls to EWS might be made if attachments have been added or removed.
  /// </summary>
  /// <param name="conflictResolutionMode">The conflict resolution mode.</param>
  /// <param name="suppressReadReceipts">Whether to suppress read receipts</param>
  Future<Item> Update(ConflictResolutionMode conflictResolutionMode,
      [bool suppressReadReceipts = false]) {
    return this.InternalUpdate(null /* parentFolder */, conflictResolutionMode,
        MessageDisposition.SaveOnly, null, suppressReadReceipts);
  }

  /// <summary>
  /// Creates a copy of this item in the specified folder. Calling this method results in a call to EWS.
  /// <para>
  /// Copy returns null if the copy operation is across two mailboxes or between a mailbox and a
  /// public folder.
  /// </para>
  /// </summary>
  /// <param name="destinationFolderId">The Id of the folder in which to create a copy of this item.</param>
  /// <returns>The copy of this item.</returns>
// Item Copy(FolderId destinationFolderId)
//        {
//            this.ThrowIfThisIsNew();
//            this.ThrowIfThisIsAttachment();
//
//            EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");
//
//            return this.Service.CopyItem(this.Id, destinationFolderId);
//        }

  /// <summary>
  /// Creates a copy of this item in the specified folder. Calling this method results in a call to EWS.
  /// <para>
  /// Copy returns null if the copy operation is across two mailboxes or between a mailbox and a
  /// public folder.
  /// </para>
  /// </summary>
  /// <param name="destinationFolderName">The name of the folder in which to create a copy of this item.</param>
  /// <returns>The copy of this item.</returns>
// Item Copy(WellKnownFolderName destinationFolderName)
//        {
//            return this.Copy(new FolderId(destinationFolderName));
//        }

  /// <summary>
  /// Moves this item to a the specified folder. Calling this method results in a call to EWS.
  /// <para>
  /// Move returns null if the move operation is across two mailboxes or between a mailbox and a
  /// public folder.
  /// </para>
  /// </summary>
  /// <param name="destinationFolderId">The Id of the folder to which to move this item.</param>
  /// <returns>The moved copy of this item.</returns>
// Item Move(FolderId destinationFolderId)
//        {
//            this.ThrowIfThisIsNew();
//            this.ThrowIfThisIsAttachment();
//
////            EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");
//
//            return this.Service.MoveItem(this.Id, destinationFolderId);
//        }

  /// <summary>
  /// Moves this item to a the specified folder. Calling this method results in a call to EWS.
  /// <para>
  /// Move returns null if the move operation is across two mailboxes or between a mailbox and a
  /// public folder.
  /// </para>
  /// </summary>
  /// <param name="destinationFolderName">The name of the folder to which to move this item.</param>
  /// <returns>The moved copy of this item.</returns>
// Item Move(WellKnownFolderName destinationFolderName)
//        {
//            return this.Move(new FolderId(destinationFolderName));
//        }

  /// <summary>
  /// Sets the extended property.
  /// </summary>
  /// <param name="extendedPropertyDefinition">The extended property definition.</param>
  /// <param name="value">The value.</param>
  void SetExtendedProperty(
      ExtendedPropertyDefinition extendedPropertyDefinition, Object value) {
    this
        .ExtendedProperties
        .SetExtendedProperty(extendedPropertyDefinition, value);
  }

  /// <summary>
  /// Removes an extended property.
  /// </summary>
  /// <param name="extendedPropertyDefinition">The extended property definition.</param>
  /// <returns>True if property was removed.</returns>
  bool RemoveExtendedProperty(
      ExtendedPropertyDefinition extendedPropertyDefinition) {
    return this
        .ExtendedProperties
        .RemoveExtendedProperty(extendedPropertyDefinition);
  }

  /// <summary>
  /// Gets a list of extended properties defined on this object.
  /// </summary>
  /// <returns>Extended properties collection.</returns>
  @override
  ExtendedPropertyCollection GetExtendedProperties() {
    return this.ExtendedProperties;
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  @override
  void Validate() {
    super.Validate();

    this.Attachments.Validate();

    // Flag parameter is only valid for Exchange2013 or higher
    //
    OutParam<Flag> flagOutParam = new OutParam<Flag>();
    if (this.TryGetPropertyGeneric<Flag>(ItemSchema.Flag, flagOutParam) &&
        flagOutParam.param != null) {
      if (this.Service.RequestedServerVersion.index <
          ExchangeVersion.Exchange2013.index) {
        throw new ServiceVersionException("""string.Format(
                            Strings.ParameterIncompatibleWithRequestVersion,
                            "Flag",
                            ExchangeVersion.Exchange2013)""");
      }

      flagOutParam.param.Validate();
    }
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
    // Starting E14SP2, attachment will be sent along with CreateItem requests.
    // if the attachment used to require the Timezone header, CreateItem request should do so too.
    //
    if (!isUpdateOperation &&
        (this.Service.RequestedServerVersion.index >=
            ExchangeVersion.Exchange2010_SP2.index)) {
      for (ItemAttachment itemAttachment
          in this.Attachments.OfType<ItemAttachment>()) {
        if ((itemAttachment.Item != null) &&
            itemAttachment.Item.GetIsTimeZoneHeaderRequired(
                false /* isUpdateOperation */)) {
          return true;
        }
      }
    }

    return super.GetIsTimeZoneHeaderRequired(isUpdateOperation);
  }

  /// <summary>
  /// Gets a value indicating whether the item is an attachment.
  /// </summary>
  bool get IsAttachment => this._parentAttachment != null;

  /// <summary>
  /// Gets a value indicating whether this object is a real store item, or if it's a local object
  /// that has yet to be saved.
  /// </summary>
  @override
  bool get IsNew {
    // Item attachments don't have an Id, need to check whether the
    // parentAttachment is new or not.
    if (this.IsAttachment) {
      return this.ParentAttachment.IsNew;
    } else {
      return super.IsNew;
    }
  }

  /// <summary>
  /// Gets the Id of this item.
  /// </summary>
  ItemId get Id => this.PropertyBag[this.GetIdPropertyDefinition()];

  /// <summary>
  /// Get or sets the MIME content of this item.
  /// </summary>
  complex.MimeContent get MimeContent =>
      this.PropertyBag[ItemSchema.MimeContent];

  set MimeContent(complex.MimeContent value) {
    this.PropertyBag[ItemSchema.MimeContent] = value;
  }

  /// <summary>
  /// Get or sets the MimeContentUTF8 of this item.
  /// </summary>
// MimeContentUTF8 MimeContentUTF8
//        {
//            get { return (MimeContentUTF8)this.PropertyBag[ItemSchema.MimeContentUTF8]; }
//            set { this.PropertyBag[ItemSchema.MimeContentUTF8] = value; }
//        }

  /// <summary>
  /// Gets the Id of the parent folder of this item.
  /// </summary>
  FolderId get ParentFolderId => this.PropertyBag[ItemSchema.ParentFolderId];

  /// <summary>
  /// Gets or sets the sensitivity of this item.
  /// </summary>
  enumerations.Sensitivity get Sensitivity =>
      this.PropertyBag[ItemSchema.Sensitivity];

  set Sensitivity(enumerations.Sensitivity value) {
    this.PropertyBag[ItemSchema.Sensitivity] = value;
  }

  /// <summary>
  /// Gets a list of the attachments to this item.
  /// </summary>
  AttachmentCollection get Attachments =>
      this.PropertyBag[ItemSchema.Attachments];

  /// <summary>
  /// Gets the time when this item was received.
  /// </summary>
  DateTime get DateTimeReceived =>
      this.PropertyBag[ItemSchema.DateTimeReceived];

  /// <summary>
  /// Gets the size of this item.
  /// </summary>
  int get Size => this.PropertyBag[ItemSchema.Size];

  /// <summary>
  /// Gets or sets the list of categories associated with this item.
  /// </summary>
  StringList get Categories => this.PropertyBag[ItemSchema.Categories];

  set Categories(StringList value) =>
      this.PropertyBag[ItemSchema.Culture] = value;

  /// <summary>
  /// Gets or sets the culture associated with this item.
  /// </summary>
// String Culture
//        {
//            get { return (string)this.PropertyBag[ItemSchema.Culture]; }
//            set {  }
//        }

  /// <summary>
  /// Gets or sets the importance of this item.
  /// </summary>

  complex.Importance get Importance => this.PropertyBag[ItemSchema.Importance];

  set Importance(complex.Importance value) =>
      this.PropertyBag[ItemSchema.Importance] = value;

  /// <summary>
  /// Gets or sets the In-Reply-To reference of this item.
  /// </summary>
// String InReplyTo
//        {
//            get { return (string)this.PropertyBag[ItemSchema.InReplyTo]; }
//            set { this.PropertyBag[ItemSchema.InReplyTo] = value; }
//        }

  /// <summary>
  /// Gets a value indicating whether the message has been submitted to be sent.
  /// </summary>
  bool get IsSubmitted => this.PropertyBag[ItemSchema.IsSubmitted];

  /// <summary>
  /// Gets a value indicating whether this is an associated item.
  /// </summary>
  bool get IsAssociated => this.PropertyBag[ItemSchema.IsAssociated];

  /// <summary>
  /// Gets a value indicating whether the item is is a draft. An item is a draft when it has not yet been sent.
  /// </summary>
  bool get IsDraft => this.PropertyBag[ItemSchema.IsDraft];

  /// <summary>
  /// Gets a value indicating whether the item has been sent by the current authenticated user.
  /// </summary>
  bool get IsFromMe => this.PropertyBag[ItemSchema.IsFromMe];

  /// <summary>
  /// Gets a value indicating whether the item is a resend of another item.
  /// </summary>
  bool get IsResend => this.PropertyBag[ItemSchema.IsResend];

  /// <summary>
  /// Gets a value indicating whether the item has been modified since it was created.
  /// </summary>
  bool get IsUnmodified => this.PropertyBag[ItemSchema.IsUnmodified];

  /// <summary>
  /// Gets a list of Internet headers for this item.
  /// </summary>
// InternetMessageHeaderCollection get InternetMessageHeaders => this.PropertyBag[ItemSchema.InternetMessageHeaders];

  /// <summary>
  /// Gets the date and time this item was sent.
  /// </summary>
  DateTime get DateTimeSent => this.PropertyBag[ItemSchema.DateTimeSent];

  /// <summary>
  /// Gets the date and time this item was created.
  /// </summary>
  DateTime get DateTimeCreated => this.PropertyBag[ItemSchema.DateTimeCreated];

  /// <summary>
  /// Gets a value indicating which response actions are allowed on this item. Examples of response actions are Reply and Forward.
  /// </summary>
// ResponseActions get AllowedResponseActions => this.PropertyBag[ItemSchema.AllowedResponseActions];

  /// <summary>
  /// Gets or sets the date and time when the reminder is due for this item.
  /// </summary>
// DateTime ReminderDueBy
//        {
//            get { return (DateTime)this.PropertyBag[ItemSchema.ReminderDueBy]; }
//            set { this.PropertyBag[ItemSchema.ReminderDueBy] = value; }
//        }

  /// <summary>
  /// Gets or sets a value indicating whether a reminder is set for this item.
  /// </summary>
// bool IsReminderSet
//        {
//            get { return (bool)this.PropertyBag[ItemSchema.IsReminderSet]; }
//            set { this.PropertyBag[ItemSchema.IsReminderSet] = value; }
//        }

  /// <summary>
  /// Gets or sets the number of minutes before the start of this item when the reminder should be triggered.
  /// </summary>
// int ReminderMinutesBeforeStart
//        {
//            get { return (int)this.PropertyBag[ItemSchema.ReminderMinutesBeforeStart]; }
//            set { this.PropertyBag[ItemSchema.ReminderMinutesBeforeStart] = value; }
//        }

  /// <summary>
  /// Gets a text summarizing the Cc receipients of this item.
  /// </summary>
// String get DisplayCc => this.PropertyBag[ItemSchema.DisplayCc];

  /// <summary>
  /// Gets a text summarizing the To recipients of this item.
  /// </summary>
// String get DisplayTo => this.PropertyBag[ItemSchema.DisplayTo];

  /// <summary>
  /// Gets a value indicating whether the item has attachments.
  /// </summary>
  bool get HasAttachments => this.PropertyBag[ItemSchema.HasAttachments];

  /// <summary>
  /// Gets or sets the body of this item.
  /// </summary>
  MessageBody get Body => this.PropertyBag[ItemSchema.Body];

  set Body(MessageBody value) => this.PropertyBag[ItemSchema.Body] = value;

  /// <summary>
  /// Gets or sets the custom class name of this item.
  /// </summary>
  String get ItemClass => this.PropertyBag[ItemSchema.ItemClass];

  set ItemClass(String value) => this.PropertyBag[ItemSchema.ItemClass] = value;

  String get ICalUid => this.PropertyBag[AppointmentSchema.ICalUid];

  /// <summary>
  /// Gets or sets the subject of this item.
  /// </summary>
  String get Subject => this.PropertyBag[ItemSchema.Subject];

  set Subject(String value) => this.SetSubject(value);

  /// <summary>

  /// </summary>
  String get WebClientReadFormQueryString =>
      this.PropertyBag[ItemSchema.WebClientReadFormQueryString];

  /// <summary>

  /// </summary>
  String get WebClientEditFormQueryString =>
      this.PropertyBag[ItemSchema.WebClientEditFormQueryString];

  /// <summary>
  /// Gets a list of extended properties defined on this item.
  /// </summary>
  ExtendedPropertyCollection get ExtendedProperties =>
      this.PropertyBag[ServiceObjectSchema.ExtendedProperties];

  /// <summary>
  /// Gets a value indicating the effective rights the current authenticated user has on this item.
  /// </summary>
// enumerations.EffectiveRights get EffectiveRights => this.PropertyBag[ItemSchema.EffectiveRights];

  /// <summary>
  /// Gets the name of the user who last modified this item.
  /// </summary>
  String get LastModifiedName => this.PropertyBag[ItemSchema.LastModifiedName];

  /// <summary>
  /// Gets the date and time this item was last modified.
  /// </summary>
  DateTime get LastModifiedTime =>
      this.PropertyBag[ItemSchema.LastModifiedTime];

  /// <summary>
  /// Gets the Id of the conversation this item is part of.
  /// </summary>
// ConversationId get ConversationId => this.PropertyBag[ItemSchema.ConversationId];

  /// <summary>
  /// Gets the body part that is unique to the conversation this item is part of.
  /// </summary>
  complex.UniqueBody get UniqueBody => this.PropertyBag[ItemSchema.UniqueBody];

  /// <summary>
  /// Gets the store entry id.
  /// </summary>
// Uint8List get StoreEntryId => this.PropertyBag[ItemSchema.StoreEntryId];

  /// <summary>
  /// Gets the item instance key.
  /// </summary>
// Uint8List get InstanceKey =>  this.PropertyBag[ItemSchema.InstanceKey];

  /// <summary>
  /// Get or set the Flag value for this item.
  /// </summary>
// Flag Flag
//        {
//            get { return (Flag)this.PropertyBag[ItemSchema.Flag]; }
//            set { this.PropertyBag[ItemSchema.Flag] = value; }
//        }

  /// <summary>
  /// Gets the normalized body of the item.
  /// </summary>
// NormalizedBody get NormalizedBody => this.PropertyBag[ItemSchema.NormalizedBody];

  /// <summary>
  /// Gets the EntityExtractionResult of the item.
  /// </summary>
// EntityExtractionResult get EntityExtractionResult => this.PropertyBag[ItemSchema.EntityExtractionResult];

  /// <summary>
  /// Gets or sets the policy tag.
  /// </summary>
// PolicyTag PolicyTag
//        {
//            get { return (PolicyTag)this.PropertyBag[ItemSchema.PolicyTag]; }
//            set { this.PropertyBag[ItemSchema.PolicyTag] = value; }
//        }

  /// <summary>
  /// Gets or sets the archive tag.
  /// </summary>
// ArchiveTag ArchiveTag
//        {
//            get { return (ArchiveTag)this.PropertyBag[ItemSchema.ArchiveTag]; }
//            set { this.PropertyBag[ItemSchema.ArchiveTag] = value; }
//        }

  /// <summary>
  /// Gets the retention date.
  /// </summary>
// DateTime get RetentionDate => this.PropertyBag[ItemSchema.RetentionDate];

  /// <summary>
  /// Gets the item Preview.
  /// </summary>
  String get Preview => this.PropertyBag[ItemSchema.Preview];

  /// <summary>
  /// Gets the text body of the item.
  /// </summary>
  complex.TextBody get TextBody => this.PropertyBag[ItemSchema.TextBody];

  /// <summary>
  /// Gets the icon index.
  /// </summary>
// IconIndex get IconIndex = >this.PropertyBag[ItemSchema.IconIndex];

  /// <summary>
  /// Gets or sets the list of hashtags associated with this item.
  /// </summary>
// StringList Hashtags
//        {
//            get { return (StringList)this.PropertyBag[ItemSchema.Hashtags]; }
//            set { this.PropertyBag[ItemSchema.Hashtags] = value; }
//        }

  /// <summary>
  /// Gets the Mentions associated with the message.
  /// </summary>
// EmailAddressCollection Mentions
//        {
//            get { return (EmailAddressCollection)this.PropertyBag[ItemSchema.Mentions]; }
//            set { this.PropertyBag[ItemSchema.Mentions] = value; }
//        }

  /// <summary>
  /// Gets a value indicating whether the item mentions me.
  /// </summary>
// bool get MentionedMe =>this.PropertyBag[ItemSchema.MentionedMe];

  /// <summary>
  /// Gets the default setting for how to treat affected task occurrences on Delete.
  /// Subclasses will override this for different default behavior.
  /// </summary>
  AffectedTaskOccurrence get DefaultAffectedTaskOccurrences => null;

  /// <summary>
  /// Gets the default setting for sending cancellations on Delete.
  /// Subclasses will override this for different default behavior.
  /// </summary>
  SendCancellationsMode get DefaultSendCancellationsMode => null;

  /// <summary>
  /// Gets the default settings for sending invitations on Save.
  /// Subclasses will override this for different default behavior.
  /// </summary>
  SendInvitationsMode get DefaultSendInvitationsMode => null;

  /// <summary>
  /// Gets the default settings for sending invitations or cancellations on Update.
  /// Subclasses will override this for different default behavior.
  /// </summary>
  SendInvitationsOrCancellationsMode
      get DefaultSendInvitationsOrCancellationsMode => null;

  /// <summary>
  /// Sets the subject.
  /// </summary>
  /// <param name="subject">The subject.</param>
  void SetSubject(String subject) {
    this.PropertyBag[ItemSchema.Subject] = subject;
  }
}
