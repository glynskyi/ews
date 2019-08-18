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

import 'package:ews/ComplexProperties/ConversationId.dart' as complex;
import 'package:ews/ComplexProperties/Flag.dart' as complex;
import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/ComplexProperties/MimeContent.dart' as complex;
import 'package:ews/ComplexProperties/StringList.dart';
import 'package:ews/ComplexProperties/TextBody.dart' as complex;
import 'package:ews/ComplexProperties/UniqueBody.dart' as complex;
import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/Importance.dart' as complex;
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/Sensitivity.dart' as enumerations;
import 'package:ews/PropertyDefinitions/AttachmentsPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/BoolPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/DateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/EffectiveRightsPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IntPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ScopedDateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';

/// <summary>
/// Field URIs for Item.
/// </summary>
class _ItemSchemaFieldUris {
  static const String ItemId = "item:ItemId";
  static const String ParentFolderId = "item:ParentFolderId";
  static const String ItemClass = "item:ItemClass";
  static const String MimeContent = "item:MimeContent";
  static const String MimeContentUTF8 = "item:MimeContentUTF8";
  static const String Attachments = "item:Attachments";
  static const String Subject = "item:Subject";
  static const String DateTimeReceived = "item:DateTimeReceived";
  static const String Size = "item:Size";
  static const String Categories = "item:Categories";
  static const String HasAttachments = "item:HasAttachments";
  static const String Importance = "item:Importance";
  static const String InReplyTo = "item:InReplyTo";
  static const String InternetMessageHeaders = "item:InternetMessageHeaders";
  static const String IsAssociated = "item:IsAssociated";
  static const String IsDraft = "item:IsDraft";
  static const String IsFromMe = "item:IsFromMe";
  static const String IsResend = "item:IsResend";
  static const String IsSubmitted = "item:IsSubmitted";
  static const String IsUnmodified = "item:IsUnmodified";
  static const String DateTimeSent = "item:DateTimeSent";
  static const String DateTimeCreated = "item:DateTimeCreated";
  static const String Body = "item:Body";
  static const String ResponseObjects = "item:ResponseObjects";
  static const String Sensitivity = "item:Sensitivity";
  static const String ReminderDueBy = "item:ReminderDueBy";
  static const String ReminderIsSet = "item:ReminderIsSet";
  static const String ReminderMinutesBeforeStart = "item:ReminderMinutesBeforeStart";
  static const String DisplayTo = "item:DisplayTo";
  static const String DisplayCc = "item:DisplayCc";
  static const String Culture = "item:Culture";
  static const String EffectiveRights = "item:EffectiveRights";
  static const String LastModifiedName = "item:LastModifiedName";
  static const String LastModifiedTime = "item:LastModifiedTime";
  static const String WebClientReadFormQueryString = "item:WebClientReadFormQueryString";
  static const String WebClientEditFormQueryString = "item:WebClientEditFormQueryString";
  static const String ConversationId = "item:ConversationId";
  static const String UniqueBody = "item:UniqueBody";
  static const String StoreEntryId = "item:StoreEntryId";
  static const String InstanceKey = "item:InstanceKey";
  static const String NormalizedBody = "item:NormalizedBody";
  static const String EntityExtractionResult = "item:EntityExtractionResult";
  static const String Flag = "item:Flag";
  static const String PolicyTag = "item:PolicyTag";
  static const String ArchiveTag = "item:ArchiveTag";
  static const String RetentionDate = "item:RetentionDate";
  static const String Preview = "item:Preview";
  static const String TextBody = "item:TextBody";
  static const String IconIndex = "item:IconIndex";
  static const String Hashtags = "item:Hashtags";
  static const String Mentions = "item:Mentions";
  static const String MentionedMe = "item:MentionedMe";
}

/// <summary>
/// Represents the schema for generic items.
/// </summary>
//    [Schema]
class ItemSchema extends ServiceObjectSchema {
  /// <summary>
  /// Defines the Id property.
  /// </summary>
  static PropertyDefinition Id = new ComplexPropertyDefinition<ItemId>.withUriAndFlags(
      XmlElementNames.ItemId,
      _ItemSchemaFieldUris.ItemId,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1, () {
    return new ItemId();
  });

  /// <summary>
  /// Defines the Body property.
  /// </summary>
  static PropertyDefinition Body = new ComplexPropertyDefinition<MessageBody>.withUriAndFlags(
      XmlElementNames.Body,
      _ItemSchemaFieldUris.Body,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete
      ],
      ExchangeVersion.Exchange2007_SP1, () {
    return new MessageBody();
  });

  /// <summary>
  /// Defines the ItemClass property.
  /// </summary>
  static PropertyDefinition ItemClass = new StringPropertyDefinition(
      XmlElementNames.ItemClass,
      _ItemSchemaFieldUris.ItemClass,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Subject property.
  /// </summary>
  static PropertyDefinition Subject = new StringPropertyDefinition(
      XmlElementNames.Subject,
      _ItemSchemaFieldUris.Subject,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the MimeContent property.
  /// </summary>
  static PropertyDefinition MimeContent =
      new ComplexPropertyDefinition<complex.MimeContent>.withUriAndFlags(
          XmlElementNames.MimeContent,
          _ItemSchemaFieldUris.MimeContent,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.MustBeExplicitlyLoaded
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new complex.MimeContent();
  });

  /// <summary>
  /// Defines the MimeContentUTF8 property.
  /// </summary>
// static PropertyDefinition MimeContentUTF8 =
//            new ComplexPropertyDefinition<MimeContentUTF8>(
//                XmlElementNames.MimeContentUTF8,
//                ItemSchemaFieldUris.MimeContentUTF8,
//                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.MustBeExplicitlyLoaded,
//                ExchangeVersion.Exchange2013_SP1,
//                () { return new MimeContentUTF8(); });

  /// <summary>
  /// Defines the ParentFolderId property.
  /// </summary>
  static PropertyDefinition ParentFolderId =
      new ComplexPropertyDefinition<FolderId>.withUriAndFlags(
          XmlElementNames.ParentFolderId,
          _ItemSchemaFieldUris.ParentFolderId,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2007_SP1, () {
    return new FolderId();
  });

  /// <summary>
  /// Defines the Sensitivity property.
  /// </summary>
  static PropertyDefinition Sensitivity =
      new GenericPropertyDefinition<enumerations.Sensitivity>.withUriAndFlags(
          XmlElementNames.Sensitivity,
          _ItemSchemaFieldUris.Sensitivity,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Attachments property.
  /// </summary>
  static PropertyDefinition Attachments = new AttachmentsPropertyDefinition();

  /// <summary>
  /// Defines the DateTimeReceived property.
  /// </summary>
  static PropertyDefinition DateTimeReceived = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.DateTimeReceived,
      _ItemSchemaFieldUris.DateTimeReceived,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Size property.
  /// </summary>
  static PropertyDefinition Size = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.Size,
      _ItemSchemaFieldUris.Size,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Categories property.
  /// </summary>
  static PropertyDefinition Categories = new ComplexPropertyDefinition<StringList>.withUriAndFlags(
      XmlElementNames.Categories,
      _ItemSchemaFieldUris.Categories,
      [
        PropertyDefinitionFlags.AutoInstantiateOnRead,
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the Importance property.
  /// </summary>
  static PropertyDefinition Importance =
      new GenericPropertyDefinition<complex.Importance>.withUriAndFlags(
          XmlElementNames.Importance,
          _ItemSchemaFieldUris.Importance,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the InReplyTo property.
  /// </summary>
  static PropertyDefinition InReplyTo = new StringPropertyDefinition(
      XmlElementNames.InReplyTo,
      _ItemSchemaFieldUris.InReplyTo,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsSubmitted property.
  /// </summary>
  static PropertyDefinition IsSubmitted = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsSubmitted,
      _ItemSchemaFieldUris.IsSubmitted,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsAssociated property.
  /// </summary>
  static PropertyDefinition IsAssociated = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsAssociated,
      _ItemSchemaFieldUris.IsAssociated,
      [PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010);

  /// <summary>
  /// Defines the IsDraft property.
  /// </summary>
  static PropertyDefinition IsDraft = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsDraft,
      _ItemSchemaFieldUris.IsDraft,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsFromMe property.
  /// </summary>
  static PropertyDefinition IsFromMe = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsFromMe,
      _ItemSchemaFieldUris.IsFromMe,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsResend property.
  /// </summary>
  static PropertyDefinition IsResend = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsResend,
      _ItemSchemaFieldUris.IsResend,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsUnmodified property.
  /// </summary>
  static PropertyDefinition IsUnmodified = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsUnmodified,
      _ItemSchemaFieldUris.IsUnmodified,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the InternetMessageHeaders property.
  /// </summary>
// static PropertyDefinition InternetMessageHeaders =
//            new ComplexPropertyDefinition<InternetMessageHeaderCollection>(
//                XmlElementNames.InternetMessageHeaders,
//                ItemSchemaFieldUris.InternetMessageHeaders,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new InternetMessageHeaderCollection(); });

  /// <summary>
  /// Defines the DateTimeSent property.
  /// </summary>
  static PropertyDefinition DateTimeSent = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.DateTimeSent,
      _ItemSchemaFieldUris.DateTimeSent,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the DateTimeCreated property.
  /// </summary>
  static PropertyDefinition DateTimeCreated = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.DateTimeCreated,
      _ItemSchemaFieldUris.DateTimeCreated,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the AllowedResponseActions property.
  /// </summary>
// static PropertyDefinition AllowedResponseActions =
//            new ResponseObjectsPropertyDefinition(
//                XmlElementNames.ResponseObjects,
//                ItemSchemaFieldUris.ResponseObjects,
//                ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ReminderDueBy property.
  /// </summary>
  static PropertyDefinition ReminderDueBy = new ScopedDateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.ReminderDueBy,
      _ItemSchemaFieldUris.ReminderDueBy,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1, (ExchangeVersion version) {
    return AppointmentSchema.StartTimeZone;
  });

  /// <summary>
  /// Defines the IsReminderSet property.
  /// </summary>
  static PropertyDefinition IsReminderSet = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.ReminderIsSet, // Note: server-side the name is ReminderIsSet
      _ItemSchemaFieldUris.ReminderIsSet,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ReminderMinutesBeforeStart property.
  /// </summary>
  static PropertyDefinition ReminderMinutesBeforeStart = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.ReminderMinutesBeforeStart,
      _ItemSchemaFieldUris.ReminderMinutesBeforeStart,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the DisplayCc property.
  /// </summary>
  static PropertyDefinition DisplayCc = new StringPropertyDefinition(
      XmlElementNames.DisplayCc,
      _ItemSchemaFieldUris.DisplayCc,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the DisplayTo property.
  /// </summary>
  static PropertyDefinition DisplayTo = new StringPropertyDefinition(
      XmlElementNames.DisplayTo,
      _ItemSchemaFieldUris.DisplayTo,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the HasAttachments property.
  /// </summary>
  static PropertyDefinition HasAttachments = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.HasAttachments,
      _ItemSchemaFieldUris.HasAttachments,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Culture property.
  /// </summary>
  static PropertyDefinition Culture = new StringPropertyDefinition(
      XmlElementNames.Culture,
      _ItemSchemaFieldUris.Culture,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the EffectiveRights property.
  /// </summary>
  static PropertyDefinition EffectiveRights = new EffectiveRightsPropertyDefinition(
      XmlElementNames.EffectiveRights,
      _ItemSchemaFieldUris.EffectiveRights,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the LastModifiedName property.
  /// </summary>
  static PropertyDefinition LastModifiedName = new StringPropertyDefinition(
      XmlElementNames.LastModifiedName,
      _ItemSchemaFieldUris.LastModifiedName,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the LastModifiedTime property.
  /// </summary>
  static PropertyDefinition LastModifiedTime = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.LastModifiedTime,
      _ItemSchemaFieldUris.LastModifiedTime,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the WebClientReadFormQueryString property.
  /// </summary>
  static PropertyDefinition WebClientReadFormQueryString = new StringPropertyDefinition(
      XmlElementNames.WebClientReadFormQueryString,
      _ItemSchemaFieldUris.WebClientReadFormQueryString,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010);

  /// <summary>
  /// Defines the WebClientEditFormQueryString property.
  /// </summary>
  static PropertyDefinition WebClientEditFormQueryString = new StringPropertyDefinition(
      XmlElementNames.WebClientEditFormQueryString,
      _ItemSchemaFieldUris.WebClientEditFormQueryString,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010);

  /// <summary>
  /// Defines the ConversationId property.
  /// </summary>
  static PropertyDefinition ConversationId =
      new ComplexPropertyDefinition<complex.ConversationId>.withUriAndFlags(
          XmlElementNames.ConversationId,
          _ItemSchemaFieldUris.ConversationId,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010, () {
    return new complex.ConversationId();
  });

  /// <summary>
  /// Defines the UniqueBody property.
  /// </summary>
  static PropertyDefinition UniqueBody =
      new ComplexPropertyDefinition<complex.UniqueBody>.withUriAndFlags(
          XmlElementNames.UniqueBody,
          _ItemSchemaFieldUris.UniqueBody,
          [PropertyDefinitionFlags.MustBeExplicitlyLoaded],
          ExchangeVersion.Exchange2010, () {
    return new complex.UniqueBody();
  });

  /// <summary>
  /// Defines the StoreEntryId property.
  /// </summary>
// static PropertyDefinition StoreEntryId =
//            new ByteArrayPropertyDefinition(
//                XmlElementNames.StoreEntryId,
//                ItemSchemaFieldUris.StoreEntryId,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2010_SP2);

  /// <summary>
  /// Defines the InstanceKey property.
  /// </summary>
// static PropertyDefinition InstanceKey =
//            new ByteArrayPropertyDefinition(
//                XmlElementNames.InstanceKey,
//                ItemSchemaFieldUris.InstanceKey,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the NormalizedBody property.
  /// </summary>
// static PropertyDefinition NormalizedBody =
//            new ComplexPropertyDefinition<NormalizedBody>.withUriAndFlags(
//                XmlElementNames.NormalizedBody,
//                ItemSchemaFieldUris.NormalizedBody,
//                [PropertyDefinitionFlags.MustBeExplicitlyLoaded],
//                ExchangeVersion.Exchange2013,
//                () { return new NormalizedBody(); });

  /// <summary>
  /// Defines the EntityExtractionResult property.
  /// </summary>
// static PropertyDefinition EntityExtractionResult =
//            new ComplexPropertyDefinition<EntityExtractionResult>(
//                XmlElementNames.NlgEntityExtractionResult,
//                ItemSchemaFieldUris.EntityExtractionResult,
//                PropertyDefinitionFlags.MustBeExplicitlyLoaded,
//                ExchangeVersion.Exchange2013,
//                () { return new EntityExtractionResult(); });

  /// <summary>
  /// Defines the InternetMessageHeaders property.
  /// </summary>
  static PropertyDefinition Flag = new ComplexPropertyDefinition<complex.Flag>.withUriAndFlags(
      XmlElementNames.Flag,
      _ItemSchemaFieldUris.Flag,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013, () {
    return new complex.Flag();
  });

  /// <summary>
  /// Defines the PolicyTag property.
  /// </summary>
// static PropertyDefinition PolicyTag =
//            new ComplexPropertyDefinition<PolicyTag>.withUriAndFlags(
//                XmlElementNames.PolicyTag,
//                ItemSchemaFieldUris.PolicyTag,
//                [PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate, PropertyDefinitionFlags.CanDelete, PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2013,
//                () { return new PolicyTag(); });

  /// <summary>
  /// Defines the ArchiveTag property.
  /// </summary>
// static PropertyDefinition ArchiveTag =
//            new ComplexPropertyDefinition<ArchiveTag>(
//                XmlElementNames.ArchiveTag,
//                ItemSchemaFieldUris.ArchiveTag,
//                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2013,
//                () { return new ArchiveTag(); });

  /// <summary>
  /// Defines the RetentionDate property.
  /// </summary>
// static PropertyDefinition RetentionDate =
//            new DateTimePropertyDefinition(
//                XmlElementNames.RetentionDate,
//                ItemSchemaFieldUris.RetentionDate,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2013,
//                true);

  /// <summary>
  /// Defines the Preview property.
  /// </summary>
  static PropertyDefinition Preview = new StringPropertyDefinition(
      XmlElementNames.Preview,
      _ItemSchemaFieldUris.Preview,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the TextBody property.
  /// </summary>
  static PropertyDefinition TextBody =
      new ComplexPropertyDefinition<complex.TextBody>.withUriAndFlags(
          XmlElementNames.TextBody,
          _ItemSchemaFieldUris.TextBody,
          [PropertyDefinitionFlags.MustBeExplicitlyLoaded],
          ExchangeVersion.Exchange2013, () {
    return new complex.TextBody();
  });

  /// <summary>
  /// Defines the IconIndex property.
  /// </summary>
// static PropertyDefinition IconIndex =
//            new GenericPropertyDefinition<IconIndex>(
//                XmlElementNames.IconIndex,
//                ItemSchemaFieldUris.IconIndex,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the Hashtags property.
  /// </summary>
// static PropertyDefinition Hashtags =
//            new ComplexPropertyDefinition<StringList>(
//                XmlElementNames.Hashtags,
//                ItemSchemaFieldUris.Hashtags,
//                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete,
//                ExchangeVersion.Exchange2015,
//                () { return new StringList(); });

  /// <summary>
  /// Defines the Mentions property.
  /// </summary>
// static PropertyDefinition Mentions =
//            new ComplexPropertyDefinition<EmailAddressCollection>(
//                XmlElementNames.Mentions,
//                ItemSchemaFieldUris.Mentions,
//                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete,
//                ExchangeVersion.Exchange2015,
//                () { return new EmailAddressCollection(); });

  /// <summary>
  /// Defines the MentionedMe property.
  /// </summary>
// static PropertyDefinition MentionedMe =
//            new BoolPropertyDefinition(
//                XmlElementNames.MentionedMe,
//                ItemSchemaFieldUris.MentionedMe,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2015,
//                true);

  // This must be declared after the property definitions
  static ItemSchema Instance = new ItemSchema();

  /// <summary>
  /// Registers properties.
  /// </summary>
  /// <remarks>
  /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
  /// </remarks>
  @override
  void RegisterProperties() {
    super.RegisterProperties();

    // todo("restore property registration");
    this.RegisterProperty(MimeContent);
    this.RegisterProperty(Id);
    this.RegisterProperty(ParentFolderId);
    this.RegisterProperty(ItemClass);
    this.RegisterProperty(Subject);
    this.RegisterProperty(Sensitivity);
    this.RegisterProperty(Body);
    this.RegisterProperty(Attachments);
    this.RegisterProperty(DateTimeReceived);
    this.RegisterProperty(Size);
    this.RegisterProperty(Categories);
    this.RegisterProperty(Importance);
    this.RegisterProperty(InReplyTo);
    this.RegisterProperty(IsSubmitted);
    this.RegisterProperty(IsDraft);
    this.RegisterProperty(IsFromMe);
    this.RegisterProperty(IsResend);
    this.RegisterProperty(IsUnmodified);
//            this.RegisterProperty(InternetMessageHeaders);
    this.RegisterProperty(DateTimeSent);
    this.RegisterProperty(DateTimeCreated);
//            this.RegisterProperty(AllowedResponseActions);
    this.RegisterProperty(ReminderDueBy);
    this.RegisterProperty(IsReminderSet);
    this.RegisterProperty(ReminderMinutesBeforeStart);
    this.RegisterProperty(DisplayCc);
    this.RegisterProperty(DisplayTo);
    this.RegisterProperty(HasAttachments);
    this.RegisterProperty(ServiceObjectSchema.ExtendedProperties);
    this.RegisterProperty(Culture);
    this.RegisterProperty(EffectiveRights);
    this.RegisterProperty(LastModifiedName);
    this.RegisterProperty(LastModifiedTime);
    this.RegisterProperty(IsAssociated);
    this.RegisterProperty(WebClientReadFormQueryString);
    this.RegisterProperty(WebClientEditFormQueryString);
    this.RegisterProperty(ConversationId);
    this.RegisterProperty(UniqueBody);
    this.RegisterProperty(Flag);
//            this.RegisterProperty(StoreEntryId);
//            this.RegisterProperty(InstanceKey);
//            this.RegisterProperty(NormalizedBody);
//            this.RegisterProperty(EntityExtractionResult);
//            this.RegisterProperty(PolicyTag);
//            this.RegisterProperty(ArchiveTag);
//            this.RegisterProperty(RetentionDate);
    this.RegisterProperty(Preview);
    this.RegisterProperty(TextBody);
//            this.RegisterProperty(IconIndex);
//            this.RegisterProperty(MimeContentUTF8);
//
//            this.RegisterProperty(Hashtags);
//            this.RegisterProperty(Mentions);
//            this.RegisterProperty(MentionedMe);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ItemSchema"/> class.
  /// </summary>
  ItemSchema() : super();
}
