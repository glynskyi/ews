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




    /// <summary>
    /// Represents the schema for Conversation.
    /// </summary>
    [Schema]
 class ConversationSchema : ServiceObjectSchema
    {
        /// <summary>
        /// Field URIs for Item.
        /// </summary>
        /* private */ static class FieldUris
        {
 const String ConversationId = "conversation:ConversationId";
 const String ConversationTopic = "conversation:ConversationTopic";
 const String UniqueRecipients = "conversation:UniqueRecipients";
 const String GlobalUniqueRecipients = "conversation:GlobalUniqueRecipients";
 const String UniqueUnreadSenders = "conversation:UniqueUnreadSenders";
 const String GlobalUniqueUnreadSenders = "conversation:GlobalUniqueUnreadSenders";
 const String UniqueSenders = "conversation:UniqueSenders";
 const String GlobalUniqueSenders = "conversation:GlobalUniqueSenders";
 const String LastDeliveryTime = "conversation:LastDeliveryTime";
 const String GlobalLastDeliveryTime = "conversation:GlobalLastDeliveryTime";
 const String Categories = "conversation:Categories";
 const String GlobalCategories = "conversation:GlobalCategories";
 const String FlagStatus = "conversation:FlagStatus";
 const String GlobalFlagStatus = "conversation:GlobalFlagStatus";
 const String HasAttachments = "conversation:HasAttachments";
 const String GlobalHasAttachments = "conversation:GlobalHasAttachments";
 const String MessageCount = "conversation:MessageCount";
 const String GlobalMessageCount = "conversation:GlobalMessageCount";
 const String UnreadCount = "conversation:UnreadCount";
 const String GlobalUnreadCount = "conversation:GlobalUnreadCount";
 const String Size = "conversation:Size";
 const String GlobalSize = "conversation:GlobalSize";
 const String ItemClasses = "conversation:ItemClasses";
 const String GlobalItemClasses = "conversation:GlobalItemClasses";
 const String Importance = "conversation:Importance";
 const String GlobalImportance = "conversation:GlobalImportance";
 const String ItemIds = "conversation:ItemIds";
 const String GlobalItemIds = "conversation:GlobalItemIds";
 const String LastModifiedTime = "conversation:LastModifiedTime";
 const String InstanceKey = "conversation:InstanceKey";
 const String Preview = "conversation:Preview";
 const String IconIndex = "conversation:IconIndex";
 const String GlobalIconIndex = "conversation:GlobalIconIndex";
 const String DraftItemIds = "conversation:DraftItemIds";
 const String HasIrm = "conversation:HasIrm";
 const String GlobalHasIrm = "conversation:GlobalHasIrm";
        }

        /// <summary>
        /// Defines the Id property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Id =
            new ComplexPropertyDefinition<ConversationId>(
                XmlElementNames.ConversationId,
                FieldUris.ConversationId,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new ConversationId(); });

        /// <summary>
        /// Defines the Topic property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Topic =
            new StringPropertyDefinition(
                XmlElementNames.ConversationTopic,
                FieldUris.ConversationTopic,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the UniqueRecipients property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition UniqueRecipients =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.UniqueRecipients,
                FieldUris.UniqueRecipients,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(); });

        /// <summary>
        /// Defines the GlobalUniqueRecipients property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalUniqueRecipients =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.GlobalUniqueRecipients,
                FieldUris.GlobalUniqueRecipients,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(); });

        /// <summary>
        /// Defines the UniqueUnreadSenders property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition UniqueUnreadSenders =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.UniqueUnreadSenders,
                FieldUris.UniqueUnreadSenders,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(); });

        /// <summary>
        /// Defines the GlobalUniqueUnreadSenders property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalUniqueUnreadSenders =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.GlobalUniqueUnreadSenders,
                FieldUris.GlobalUniqueUnreadSenders,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(); });

        /// <summary>
        /// Defines the UniqueSenders property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition UniqueSenders =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.UniqueSenders,
                FieldUris.UniqueSenders,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(); });

        /// <summary>
        /// Defines the GlobalUniqueSenders property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalUniqueSenders =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.GlobalUniqueSenders,
                FieldUris.GlobalUniqueSenders,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(); });

        /// <summary>
        /// Defines the LastDeliveryTime property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition LastDeliveryTime =
            new DateTimePropertyDefinition(
                XmlElementNames.LastDeliveryTime,
                FieldUris.LastDeliveryTime,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the GlobalLastDeliveryTime property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalLastDeliveryTime =
            new DateTimePropertyDefinition(
                XmlElementNames.GlobalLastDeliveryTime,
                FieldUris.GlobalLastDeliveryTime,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the Categories property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Categories =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.Categories,
                FieldUris.Categories,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(); });

        /// <summary>
        /// Defines the GlobalCategories property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalCategories =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.GlobalCategories,
                FieldUris.GlobalCategories,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(); });

        /// <summary>
        /// Defines the FlagStatus property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition FlagStatus =
            new GenericPropertyDefinition<ConversationFlagStatus>(
                XmlElementNames.FlagStatus,
                FieldUris.FlagStatus,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the GlobalFlagStatus property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalFlagStatus =
            new GenericPropertyDefinition<ConversationFlagStatus>(
                XmlElementNames.GlobalFlagStatus,
                FieldUris.GlobalFlagStatus,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the HasAttachments property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition HasAttachments =
            new BoolPropertyDefinition(
                XmlElementNames.HasAttachments,
                FieldUris.HasAttachments,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the GlobalHasAttachments property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalHasAttachments =
            new BoolPropertyDefinition(
                XmlElementNames.GlobalHasAttachments,
                FieldUris.GlobalHasAttachments,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the MessageCount property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition MessageCount =
            new IntPropertyDefinition(
                XmlElementNames.MessageCount,
                FieldUris.MessageCount,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the GlobalMessageCount property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalMessageCount =
            new IntPropertyDefinition(
                XmlElementNames.GlobalMessageCount,
                FieldUris.GlobalMessageCount,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the UnreadCount property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition UnreadCount =
            new IntPropertyDefinition(
                XmlElementNames.UnreadCount,
                FieldUris.UnreadCount,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the GlobalUnreadCount property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalUnreadCount =
            new IntPropertyDefinition(
                XmlElementNames.GlobalUnreadCount,
                FieldUris.GlobalUnreadCount,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

                /// <summary>
        /// Defines the Size property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Size =
            new IntPropertyDefinition(
                XmlElementNames.Size,
                FieldUris.Size,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the GlobalSize property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalSize =
            new IntPropertyDefinition(
                XmlElementNames.GlobalSize,
                FieldUris.GlobalSize,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the ItemClasses property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition ItemClasses =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.ItemClasses,
                FieldUris.ItemClasses,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(XmlElementNames.ItemClass); });

        /// <summary>
        /// Defines the GlobalItemClasses property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalItemClasses =
            new ComplexPropertyDefinition<StringList>(
                XmlElementNames.GlobalItemClasses,
                FieldUris.GlobalItemClasses,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new StringList(XmlElementNames.ItemClass); });

        /// <summary>
        /// Defines the Importance property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Importance =
            new GenericPropertyDefinition<Importance>(
                XmlElementNames.Importance,
                FieldUris.Importance,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the GlobalImportance property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalImportance =
            new GenericPropertyDefinition<Importance>(
                XmlElementNames.GlobalImportance,
                FieldUris.GlobalImportance,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1);

        /// <summary>
        /// Defines the ItemIds property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition ItemIds =
            new ComplexPropertyDefinition<ItemIdCollection>(
                XmlElementNames.ItemIds,
                FieldUris.ItemIds,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new ItemIdCollection(); });

        /// <summary>
        /// Defines the GlobalItemIds property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalItemIds =
            new ComplexPropertyDefinition<ItemIdCollection>(
                XmlElementNames.GlobalItemIds,
                FieldUris.GlobalItemIds,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2010_SP1,
                delegate() { return new ItemIdCollection(); });

        /// <summary>
        /// Defines the LastModifiedTime property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition LastModifiedTime =
            new DateTimePropertyDefinition(
                XmlElementNames.LastModifiedTime,
                FieldUris.LastModifiedTime,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013);

        /// <summary>
        /// Defines the InstanceKey property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition InstanceKey =
            new ByteArrayPropertyDefinition(
                XmlElementNames.InstanceKey,
                FieldUris.InstanceKey,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013);

        /// <summary>
        /// Defines the Preview property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Preview =
            new StringPropertyDefinition(
                XmlElementNames.Preview,
                FieldUris.Preview,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013);

        /// <summary>
        /// Defines the IconIndex property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition IconIndex =
            new GenericPropertyDefinition<IconIndex>(
                XmlElementNames.IconIndex,
                FieldUris.IconIndex,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013);

        /// <summary>
        /// Defines the GlobalIconIndex property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalIconIndex =
            new GenericPropertyDefinition<IconIndex>(
                XmlElementNames.GlobalIconIndex,
                FieldUris.GlobalIconIndex,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013);

        /// <summary>
        /// Defines the DraftItemIds property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition DraftItemIds =
            new ComplexPropertyDefinition<ItemIdCollection>(
                XmlElementNames.DraftItemIds,
                FieldUris.DraftItemIds,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013,
                delegate { return new ItemIdCollection(); });

        /// <summary>
        /// Defines the HasIrm property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition HasIrm =
            new BoolPropertyDefinition(
                XmlElementNames.HasIrm,
                FieldUris.HasIrm,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013);

        /// <summary>
        /// Defines the GlobalHasIrm property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GlobalHasIrm =
            new BoolPropertyDefinition(
                XmlElementNames.GlobalHasIrm,
                FieldUris.GlobalHasIrm,
                PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013);

        // This must be declared after the property definitions
        static readonly ConversationSchema Instance = new ConversationSchema();

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
            this.RegisterProperty(InstanceKey);
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
        ConversationSchema()
            : super()
        {
        }
    }
