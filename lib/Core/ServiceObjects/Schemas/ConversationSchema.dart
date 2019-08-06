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

import 'package:ews/ComplexProperties/ConversationId.dart';
import 'package:ews/ComplexProperties/ItemIdCollection.dart';
import 'package:ews/ComplexProperties/StringList.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ConversationFlagStatus.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/IconIndex.dart' as enumerations;
import 'package:ews/Enumerations/Importance.dart' as enumerations;
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/BoolPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/DateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IntPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';

/// <summary>
/// Field URIs for Item.
/// </summary>
class _ConversationSchemaFieldUris {
  static const String ConversationId = "conversation:ConversationId";
  static const String ConversationTopic = "conversation:ConversationTopic";
  static const String UniqueRecipients = "conversation:UniqueRecipients";
  static const String GlobalUniqueRecipients = "conversation:GlobalUniqueRecipients";
  static const String UniqueUnreadSenders = "conversation:UniqueUnreadSenders";
  static const String GlobalUniqueUnreadSenders = "conversation:GlobalUniqueUnreadSenders";
  static const String UniqueSenders = "conversation:UniqueSenders";
  static const String GlobalUniqueSenders = "conversation:GlobalUniqueSenders";
  static const String LastDeliveryTime = "conversation:LastDeliveryTime";
  static const String GlobalLastDeliveryTime = "conversation:GlobalLastDeliveryTime";
  static const String Categories = "conversation:Categories";
  static const String GlobalCategories = "conversation:GlobalCategories";
  static const String FlagStatus = "conversation:FlagStatus";
  static const String GlobalFlagStatus = "conversation:GlobalFlagStatus";
  static const String HasAttachments = "conversation:HasAttachments";
  static const String GlobalHasAttachments = "conversation:GlobalHasAttachments";
  static const String MessageCount = "conversation:MessageCount";
  static const String GlobalMessageCount = "conversation:GlobalMessageCount";
  static const String UnreadCount = "conversation:UnreadCount";
  static const String GlobalUnreadCount = "conversation:GlobalUnreadCount";
  static const String Size = "conversation:Size";
  static const String GlobalSize = "conversation:GlobalSize";
  static const String ItemClasses = "conversation:ItemClasses";
  static const String GlobalItemClasses = "conversation:GlobalItemClasses";
  static const String Importance = "conversation:Importance";
  static const String GlobalImportance = "conversation:GlobalImportance";
  static const String ItemIds = "conversation:ItemIds";
  static const String GlobalItemIds = "conversation:GlobalItemIds";
  static const String LastModifiedTime = "conversation:LastModifiedTime";
  static const String InstanceKey = "conversation:InstanceKey";
  static const String Preview = "conversation:Preview";
  static const String IconIndex = "conversation:IconIndex";
  static const String GlobalIconIndex = "conversation:GlobalIconIndex";
  static const String DraftItemIds = "conversation:DraftItemIds";
  static const String HasIrm = "conversation:HasIrm";
  static const String GlobalHasIrm = "conversation:GlobalHasIrm";
}

/// <summary>
/// Represents the schema for Conversation.
/// </summary>
//    [Schema]
class ConversationSchema extends ServiceObjectSchema {
  /// <summary>
  /// Defines the Id property.
  /// </summary>
  static PropertyDefinition Id = new ComplexPropertyDefinition<ConversationId>.withUriAndFlags(
      XmlElementNames.ConversationId,
      _ConversationSchemaFieldUris.ConversationId,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1, () {
    return new ConversationId();
  });

  /// <summary>
  /// Defines the Topic property.
  /// </summary>
  static PropertyDefinition Topic = new StringPropertyDefinition(
      XmlElementNames.ConversationTopic,
      _ConversationSchemaFieldUris.ConversationTopic,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the UniqueRecipients property.
  /// </summary>
  static PropertyDefinition UniqueRecipients =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.UniqueRecipients,
          _ConversationSchemaFieldUris.UniqueRecipients,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the GlobalUniqueRecipients property.
  /// </summary>
  static PropertyDefinition GlobalUniqueRecipients =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.GlobalUniqueRecipients,
          _ConversationSchemaFieldUris.GlobalUniqueRecipients,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the UniqueUnreadSenders property.
  /// </summary>
  static PropertyDefinition UniqueUnreadSenders =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.UniqueUnreadSenders,
          _ConversationSchemaFieldUris.UniqueUnreadSenders,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the GlobalUniqueUnreadSenders property.
  /// </summary>
  static PropertyDefinition GlobalUniqueUnreadSenders =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.GlobalUniqueUnreadSenders,
          _ConversationSchemaFieldUris.GlobalUniqueUnreadSenders,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the UniqueSenders property.
  /// </summary>
  static PropertyDefinition UniqueSenders =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.UniqueSenders,
          _ConversationSchemaFieldUris.UniqueSenders,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the GlobalUniqueSenders property.
  /// </summary>
  static PropertyDefinition GlobalUniqueSenders =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.GlobalUniqueSenders,
          _ConversationSchemaFieldUris.GlobalUniqueSenders,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the LastDeliveryTime property.
  /// </summary>
  static PropertyDefinition LastDeliveryTime = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.LastDeliveryTime,
      _ConversationSchemaFieldUris.LastDeliveryTime,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the GlobalLastDeliveryTime property.
  /// </summary>
  static PropertyDefinition GlobalLastDeliveryTime = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.GlobalLastDeliveryTime,
      _ConversationSchemaFieldUris.GlobalLastDeliveryTime,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the Categories property.
  /// </summary>
  static PropertyDefinition Categories = new ComplexPropertyDefinition<StringList>.withUriAndFlags(
      XmlElementNames.Categories,
      _ConversationSchemaFieldUris.Categories,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the GlobalCategories property.
  /// </summary>
  static PropertyDefinition GlobalCategories =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.GlobalCategories,
          _ConversationSchemaFieldUris.GlobalCategories,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the FlagStatus property.
  /// </summary>
  static PropertyDefinition FlagStatus =
      new GenericPropertyDefinition<ConversationFlagStatus>.withUriAndFlags(
          XmlElementNames.FlagStatus,
          _ConversationSchemaFieldUris.FlagStatus,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the GlobalFlagStatus property.
  /// </summary>
  static PropertyDefinition GlobalFlagStatus =
      new GenericPropertyDefinition<ConversationFlagStatus>.withUriAndFlags(
          XmlElementNames.GlobalFlagStatus,
          _ConversationSchemaFieldUris.GlobalFlagStatus,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the HasAttachments property.
  /// </summary>
  static PropertyDefinition HasAttachments = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.HasAttachments,
      _ConversationSchemaFieldUris.HasAttachments,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the GlobalHasAttachments property.
  /// </summary>
  static PropertyDefinition GlobalHasAttachments = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.GlobalHasAttachments,
      _ConversationSchemaFieldUris.GlobalHasAttachments,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the MessageCount property.
  /// </summary>
  static PropertyDefinition MessageCount = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.MessageCount,
      _ConversationSchemaFieldUris.MessageCount,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the GlobalMessageCount property.
  /// </summary>
  static PropertyDefinition GlobalMessageCount = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.GlobalMessageCount,
      _ConversationSchemaFieldUris.GlobalMessageCount,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the UnreadCount property.
  /// </summary>
  static PropertyDefinition UnreadCount = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.UnreadCount,
      _ConversationSchemaFieldUris.UnreadCount,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the GlobalUnreadCount property.
  /// </summary>
  static PropertyDefinition GlobalUnreadCount = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.GlobalUnreadCount,
      _ConversationSchemaFieldUris.GlobalUnreadCount,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the Size property.
  /// </summary>
  static PropertyDefinition Size = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.Size,
      _ConversationSchemaFieldUris.Size,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the GlobalSize property.
  /// </summary>
  static PropertyDefinition GlobalSize = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.GlobalSize,
      _ConversationSchemaFieldUris.GlobalSize,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the ItemClasses property.
  /// </summary>
  static PropertyDefinition ItemClasses = new ComplexPropertyDefinition<StringList>.withUriAndFlags(
      XmlElementNames.ItemClasses,
      _ConversationSchemaFieldUris.ItemClasses,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1, () {
    return new StringList.fromElementName(XmlElementNames.ItemClass);
  });

  /// <summary>
  /// Defines the GlobalItemClasses property.
  /// </summary>
  static PropertyDefinition GlobalItemClasses =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.GlobalItemClasses,
          _ConversationSchemaFieldUris.GlobalItemClasses,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new StringList.fromElementName(XmlElementNames.ItemClass);
  });

  /// <summary>
  /// Defines the Importance property.
  /// </summary>
  static PropertyDefinition Importance =
      new GenericPropertyDefinition<enumerations.Importance>.withUriAndFlags(
          XmlElementNames.Importance,
          _ConversationSchemaFieldUris.Importance,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the GlobalImportance property.
  /// </summary>
  static PropertyDefinition GlobalImportance =
      new GenericPropertyDefinition<enumerations.Importance>.withUriAndFlags(
          XmlElementNames.GlobalImportance,
          _ConversationSchemaFieldUris.GlobalImportance,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the ItemIds property.
  /// </summary>
  static PropertyDefinition ItemIds =
      new ComplexPropertyDefinition<ItemIdCollection>.withUriAndFlags(
          XmlElementNames.ItemIds,
          _ConversationSchemaFieldUris.ItemIds,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new ItemIdCollection();
  });

  /// <summary>
  /// Defines the GlobalItemIds property.
  /// </summary>
  static PropertyDefinition GlobalItemIds =
      new ComplexPropertyDefinition<ItemIdCollection>.withUriAndFlags(
          XmlElementNames.GlobalItemIds,
          _ConversationSchemaFieldUris.GlobalItemIds,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new ItemIdCollection();
  });

  /// <summary>
  /// Defines the LastModifiedTime property.
  /// </summary>
  static PropertyDefinition LastModifiedTime = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.LastModifiedTime,
      _ConversationSchemaFieldUris.LastModifiedTime,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the InstanceKey property.
  /// </summary>
// static PropertyDefinition InstanceKey =
//            new ByteArrayPropertyDefinition(
//                XmlElementNames.InstanceKey,
//                FieldUris.InstanceKey,
//                [PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the Preview property.
  /// </summary>
  static PropertyDefinition Preview = new StringPropertyDefinition(
      XmlElementNames.Preview,
      _ConversationSchemaFieldUris.Preview,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the IconIndex property.
  /// </summary>
  static PropertyDefinition IconIndex =
      new GenericPropertyDefinition<enumerations.IconIndex>.withUriAndFlags(
          XmlElementNames.IconIndex,
          _ConversationSchemaFieldUris.IconIndex,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the GlobalIconIndex property.
  /// </summary>
  static PropertyDefinition GlobalIconIndex =
      new GenericPropertyDefinition<enumerations.IconIndex>.withUriAndFlags(
          XmlElementNames.GlobalIconIndex,
          _ConversationSchemaFieldUris.GlobalIconIndex,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the DraftItemIds property.
  /// </summary>
  static PropertyDefinition DraftItemIds =
      new ComplexPropertyDefinition<ItemIdCollection>.withUriAndFlags(
          XmlElementNames.DraftItemIds,
          _ConversationSchemaFieldUris.DraftItemIds,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2013, () {
    return new ItemIdCollection();
  });

  /// <summary>
  /// Defines the HasIrm property.
  /// </summary>
  static PropertyDefinition HasIrm = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.HasIrm,
      _ConversationSchemaFieldUris.HasIrm,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the GlobalHasIrm property.
  /// </summary>
  static PropertyDefinition GlobalHasIrm = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.GlobalHasIrm,
      _ConversationSchemaFieldUris.GlobalHasIrm,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2013);

  // This must be declared after the property definitions
  static ConversationSchema Instance = new ConversationSchema();

  /// <summary>
  /// Registers properties.
  /// </summary>
  /// <remarks>
  /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
  /// </remarks>
  @override
  void RegisterProperties() {
    super.RegisterProperties();

    this.RegisterProperty(Id);
    this.RegisterProperty(Topic);
    this.RegisterProperty(UniqueRecipients);
    this.RegisterProperty(GlobalUniqueRecipients);
    this.RegisterProperty(UniqueUnreadSenders);
    this.RegisterProperty(GlobalUniqueUnreadSenders);
    this.RegisterProperty(UniqueSenders);
    this.RegisterProperty(GlobalUniqueSenders);
    this.RegisterProperty(LastDeliveryTime);
    this.RegisterProperty(GlobalLastDeliveryTime);
    this.RegisterProperty(Categories);
    this.RegisterProperty(GlobalCategories);
    this.RegisterProperty(FlagStatus);
    this.RegisterProperty(GlobalFlagStatus);
    this.RegisterProperty(HasAttachments);
    this.RegisterProperty(GlobalHasAttachments);
    this.RegisterProperty(MessageCount);
    this.RegisterProperty(GlobalMessageCount);
    this.RegisterProperty(UnreadCount);
    this.RegisterProperty(GlobalUnreadCount);
    this.RegisterProperty(Size);
    this.RegisterProperty(GlobalSize);
    this.RegisterProperty(ItemClasses);
    this.RegisterProperty(GlobalItemClasses);
    this.RegisterProperty(Importance);
    this.RegisterProperty(GlobalImportance);
    this.RegisterProperty(ItemIds);
    this.RegisterProperty(GlobalItemIds);
    this.RegisterProperty(LastModifiedTime);
//    this.RegisterProperty(InstanceKey);
    this.RegisterProperty(Preview);
    this.RegisterProperty(IconIndex);
    this.RegisterProperty(GlobalIconIndex);
    this.RegisterProperty(DraftItemIds);
    this.RegisterProperty(HasIrm);
    this.RegisterProperty(GlobalHasIrm);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ConversationSchema"/> class.
  /// </summary>
  ConversationSchema() : super() {}
}
