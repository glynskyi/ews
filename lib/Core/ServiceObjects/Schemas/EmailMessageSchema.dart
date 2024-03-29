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

import 'package:ews/ComplexProperties/EmailAddress.dart';
import 'package:ews/ComplexProperties/EmailAddressCollection.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/BoolPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ByteArrayPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ContainedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';

/// <summary>
/// Field URIs for EmailMessage.
/// </summary>
class _EmailMessageSchemaFieldUris {
  static const String ConversationIndex = "message:ConversationIndex";
  static const String ConversationTopic = "message:ConversationTopic";
  static const String InternetMessageId = "message:InternetMessageId";
  static const String IsRead = "message:IsRead";
  static const String IsResponseRequested = "message:IsResponseRequested";
  static const String IsReadReceiptRequested = "message:IsReadReceiptRequested";
  static const String IsDeliveryReceiptRequested =
      "message:IsDeliveryReceiptRequested";
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
class EmailMessageSchema extends ItemSchema {
  /// <summary>
  /// Defines the ToRecipients property.
  /// </summary>
  static PropertyDefinition ToRecipients =
      new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
          XmlElementNames.ToRecipients,
          _EmailMessageSchemaFieldUris.ToRecipients,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new EmailAddressCollection();
  });

  /// <summary>
  /// Defines the BccRecipients property.
  /// </summary>
  static PropertyDefinition BccRecipients =
      new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
          XmlElementNames.BccRecipients,
          _EmailMessageSchemaFieldUris.BccRecipients,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new EmailAddressCollection();
  });

  /// <summary>
  /// Defines the CcRecipients property.
  /// </summary>
  static PropertyDefinition CcRecipients =
      new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
          XmlElementNames.CcRecipients,
          _EmailMessageSchemaFieldUris.CcRecipients,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new EmailAddressCollection();
  });

  /// <summary>
  /// Defines the ConversationIndex property.
  /// </summary>
  static PropertyDefinition ConversationIndex = new ByteArrayPropertyDefinition(
      XmlElementNames.ConversationIndex,
      _EmailMessageSchemaFieldUris.ConversationIndex,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ConversationTopic property.
  /// </summary>
  static PropertyDefinition ConversationTopic = new StringPropertyDefinition(
      XmlElementNames.ConversationTopic,
      _EmailMessageSchemaFieldUris.ConversationTopic,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the From property.
  /// </summary>
  static PropertyDefinition From =
      new ContainedPropertyDefinition<EmailAddress>.withUriAndFlags(
          XmlElementNames.From,
          _EmailMessageSchemaFieldUris.From,
          XmlElementNames.Mailbox,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new EmailAddress();
  });

  /// <summary>
  /// Defines the IsDeliveryReceiptRequested property.
  /// </summary>
  static PropertyDefinition IsDeliveryReceiptRequested =
      new BoolPropertyDefinition.withUriAndFlags(
          XmlElementNames.IsDeliveryReceiptRequested,
          _EmailMessageSchemaFieldUris.IsDeliveryReceiptRequested,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsRead property.
  /// </summary>
  static PropertyDefinition IsRead = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsRead,
      _EmailMessageSchemaFieldUris.IsRead,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsReadReceiptRequested property.
  /// </summary>
  static PropertyDefinition IsReadReceiptRequested =
      new BoolPropertyDefinition.withUriAndFlags(
          XmlElementNames.IsReadReceiptRequested,
          _EmailMessageSchemaFieldUris.IsReadReceiptRequested,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsResponseRequested property.
  /// </summary>
  static PropertyDefinition IsResponseRequested =
      new BoolPropertyDefinition.withFlagsAndNullable(
          XmlElementNames.IsResponseRequested,
          _EmailMessageSchemaFieldUris.IsResponseRequested,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1,
          true); // isNullable

  /// <summary>
  /// Defines the InternetMessageId property.
  /// </summary>
  static PropertyDefinition InternetMessageId = new StringPropertyDefinition(
      XmlElementNames.InternetMessageId,
      _EmailMessageSchemaFieldUris.InternetMessageId,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the References property.
  /// </summary>
  static PropertyDefinition References = new StringPropertyDefinition(
      XmlElementNames.References,
      _EmailMessageSchemaFieldUris.References,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ReplyTo property.
  /// </summary>
  static PropertyDefinition ReplyTo =
      new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
          XmlElementNames.ReplyTo,
          _EmailMessageSchemaFieldUris.ReplyTo,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new EmailAddressCollection();
  });

  /// <summary>
  /// Defines the Sender property.
  /// </summary>
  static PropertyDefinition Sender =
      new ContainedPropertyDefinition<EmailAddress>.withUriAndFlags(
          XmlElementNames.Sender,
          _EmailMessageSchemaFieldUris.Sender,
          XmlElementNames.Mailbox,
          [PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2007_SP1, () {
    return new EmailAddress();
  });

  /// <summary>
  /// Defines the ReceivedBy property.
  /// </summary>
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
// static PropertyDefinition ApprovalRequestData =
//            new ComplexPropertyDefinition<ApprovalRequestData>.withUri(
//                XmlElementNames.ApprovalRequestData,
//                EmailMessageSchemaFieldUris.ApprovalRequestData,
//                ExchangeVersion.Exchange2013,
//                () { return new ApprovalRequestData(); });

  /// <summary>
  /// Defines the VotingInformation property.
  /// </summary>
// static PropertyDefinition VotingInformation =
//            new ComplexPropertyDefinition<VotingInformation>.withUri(
//                XmlElementNames.VotingInformation,
//                EmailMessageSchemaFieldUris.VotingInformation,
//                ExchangeVersion.Exchange2013,
//                () { return new VotingInformation(); });

  /// <summary>
  /// Defines the Likers property
  /// </summary>
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
  void RegisterProperties() {
    super.RegisterProperties();

    this.RegisterProperty(Sender);
    this.RegisterProperty(ToRecipients);
    this.RegisterProperty(CcRecipients);
    this.RegisterProperty(BccRecipients);
    this.RegisterProperty(IsReadReceiptRequested);
    this.RegisterProperty(IsDeliveryReceiptRequested);
    this.RegisterProperty(ConversationIndex);
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
  EmailMessageSchema() : super() {}
}
