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


import 'package:ews/ComplexProperties/ApprovalRequestData.dart' as complex;
import 'package:ews/ComplexProperties/EmailAddress.dart' as complex;
import 'package:ews/ComplexProperties/EmailAddress.dart';
import 'package:ews/ComplexProperties/EmailAddressCollection.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/BoolPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ContainedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';

class EmailMessageSchemaFieldUris
{
  static const String ConversationIndex = "message:ConversationIndex";
  static const String ConversationTopic = "message:ConversationTopic";
  static const String InternetMessageId = "message:InternetMessageId";
  static const String IsRead = "message:IsRead";
  static const String IsResponseRequested = "message:IsResponseRequested";
  static const String IsReadReceiptRequested = "message:IsReadReceiptRequested";
  static const String IsDeliveryReceiptRequested = "message:IsDeliveryReceiptRequested";
  static const String References = "message:References";
  static const String ReplyTo = "message:ReplyTo";
  static const String From = "message:From";
  static const String Sender = "message:Sender";
  static const String ToRecipients = "message:ToRecipients";
  static const String CcRecipients = "message:CcRecipients";
  static const String BccRecipients = "message:BccRecipients";
  static const String ReceivedBy = "message:ReceivedBy";
  static const String ReceivedRepresenting = "message:ReceivedRepresenting";
  static const String ApprovalRequestData = "message:ApprovalRequestData";
  static const String VotingInformation = "message:VotingInformation";
  static const String Likers = "message:Likers";
}

    /// <summary>
    /// Represents the schema for e-mail messages.
    /// </summary>
//    [Schema]
 class EmailMessageSchema extends ItemSchema
    {
        /// <summary>
        /// Field URIs for EmailMessage.
        /// </summary>
        /* private */ 

        /// <summary>
        /// Defines the ToRecipients property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ToRecipients =
            new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
                XmlElementNames.ToRecipients,
                EmailMessageSchemaFieldUris.ToRecipients,
                [PropertyDefinitionFlags.AutoInstantiateOnRead, PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate, PropertyDefinitionFlags.CanDelete],
                ExchangeVersion.Exchange2007_SP1,
                () { return new EmailAddressCollection(); });

        /// <summary>
        /// Defines the BccRecipients property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition BccRecipients =
            new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
                XmlElementNames.BccRecipients,
                EmailMessageSchemaFieldUris.BccRecipients,
                [PropertyDefinitionFlags.AutoInstantiateOnRead, PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate, PropertyDefinitionFlags.CanDelete],
                ExchangeVersion.Exchange2007_SP1,
                () { return new EmailAddressCollection(); });

        /// <summary>
        /// Defines the CcRecipients property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition CcRecipients =
            new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
                XmlElementNames.CcRecipients,
                EmailMessageSchemaFieldUris.CcRecipients,
                [PropertyDefinitionFlags.AutoInstantiateOnRead , PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete],
                ExchangeVersion.Exchange2007_SP1,
                () { return new EmailAddressCollection(); });

        /// <summary>
        /// Defines the ConversationIndex property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition ConversationIndex =
//            new ByteArrayPropertyDefinition(
//                XmlElementNames.ConversationIndex,
//                EmailMessageSchemaFieldUris.ConversationIndex,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the ConversationTopic property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ConversationTopic =
            new StringPropertyDefinition(
                XmlElementNames.ConversationTopic,
                EmailMessageSchemaFieldUris.ConversationTopic,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the From property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition From =
//            new ContainedPropertyDefinition<EmailAddress>(
//                XmlElementNames.From,
//                EmailMessageSchemaFieldUris.From,
//                XmlElementNames.Mailbox,
//                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new EmailAddress(); });

        /// <summary>
        /// Defines the IsDeliveryReceiptRequested property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsDeliveryReceiptRequested =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsDeliveryReceiptRequested,
                EmailMessageSchemaFieldUris.IsDeliveryReceiptRequested,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsRead property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsRead =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsRead,
                EmailMessageSchemaFieldUris.IsRead,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsReadReceiptRequested property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsReadReceiptRequested =
            new BoolPropertyDefinition.withUriAndFlags(
                XmlElementNames.IsReadReceiptRequested,
                EmailMessageSchemaFieldUris.IsReadReceiptRequested,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the IsResponseRequested property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition IsResponseRequested =
            new BoolPropertyDefinition.withFlagsAndNullable(
                XmlElementNames.IsResponseRequested,
                EmailMessageSchemaFieldUris.IsResponseRequested,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1,
                true);  // isNullable

        /// <summary>
        /// Defines the InternetMessageId property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition InternetMessageId =
            new StringPropertyDefinition(
                XmlElementNames.InternetMessageId,
                EmailMessageSchemaFieldUris.InternetMessageId,
                [PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the References property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition References =
            new StringPropertyDefinition(
                XmlElementNames.References,
                EmailMessageSchemaFieldUris.References,
                [PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete , PropertyDefinitionFlags.CanFind],
                ExchangeVersion.Exchange2007_SP1);

        /// <summary>
        /// Defines the ReplyTo property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static PropertyDefinition ReplyTo =
            new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
                XmlElementNames.ReplyTo,
                EmailMessageSchemaFieldUris.ReplyTo,
                [PropertyDefinitionFlags.AutoInstantiateOnRead , PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanUpdate , PropertyDefinitionFlags.CanDelete],
                ExchangeVersion.Exchange2007_SP1,
                () { return new EmailAddressCollection(); });

        /// <summary>
        /// Defines the Sender property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition Sender =
//            new ContainedPropertyDefinition<EmailAddress>(
//                XmlElementNames.Sender,
//                EmailMessageSchemaFieldUris.Sender,
//                XmlElementNames.Mailbox,
//                PropertyDefinitionFlags.CanSet , PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new EmailAddress(); });

        /// <summary>
        /// Defines the ReceivedBy property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition ReceivedBy =
//            new ContainedPropertyDefinition<EmailAddress>(
//                XmlElementNames.ReceivedBy,
//                EmailMessageSchemaFieldUris.ReceivedBy,
//                XmlElementNames.Mailbox,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new EmailAddress(); });

        /// <summary>
        /// Defines the ReceivedRepresenting property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition ReceivedRepresenting =
//            new ContainedPropertyDefinition<EmailAddress>(
//                XmlElementNames.ReceivedRepresenting,
//                EmailMessageSchemaFieldUris.ReceivedRepresenting,
//                XmlElementNames.Mailbox,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new EmailAddress(); });

        /// <summary>
        /// Defines the ApprovalRequestData property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition ApprovalRequestData =
//            new ComplexPropertyDefinition<ApprovalRequestData>.withUri(
//                XmlElementNames.ApprovalRequestData,
//                EmailMessageSchemaFieldUris.ApprovalRequestData,
//                ExchangeVersion.Exchange2013,
//                () { return new ApprovalRequestData(); });

        /// <summary>
        /// Defines the VotingInformation property.
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition VotingInformation =
//            new ComplexPropertyDefinition<VotingInformation>.withUri(
//                XmlElementNames.VotingInformation,
//                EmailMessageSchemaFieldUris.VotingInformation,
//                ExchangeVersion.Exchange2013,
//                () { return new VotingInformation(); });

        /// <summary>
        /// Defines the Likers property
        /// </summary>
        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition Likers =
//            new ComplexPropertyDefinition<EmailAddressCollection>.withUri(
//                XmlElementNames.Likers,
//                EmailMessageSchemaFieldUris.Likers,
//                PropertyDefinitionFlags.AutoInstantiateOnRead,
//                ExchangeVersion.Exchange2015,
//                () { return new EmailAddressCollection(); });

        // This must be after the declaration of property definitions
        static EmailMessageSchema Instance = new EmailMessageSchema();

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

//            this.RegisterProperty(Sender);
            this.RegisterProperty(ToRecipients);
            this.RegisterProperty(CcRecipients);
            this.RegisterProperty(BccRecipients);
            this.RegisterProperty(IsReadReceiptRequested);
            this.RegisterProperty(IsDeliveryReceiptRequested);
//            this.RegisterProperty(ConversationIndex);
            this.RegisterProperty(ConversationTopic);
//            this.RegisterProperty(From);
            this.RegisterProperty(InternetMessageId);
            this.RegisterProperty(IsRead);
            this.RegisterProperty(IsResponseRequested);
            this.RegisterProperty(References);
            this.RegisterProperty(ReplyTo);
//            this.RegisterProperty(ReceivedBy);
//            this.RegisterProperty(ReceivedRepresenting);
//            this.RegisterProperty(ApprovalRequestData);
//            this.RegisterProperty(VotingInformation);
//            this.RegisterProperty(Likers);
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="EmailMessageSchema"/> class.
        /// </summary>
        EmailMessageSchema()
            : super()
        {
        }
    }
