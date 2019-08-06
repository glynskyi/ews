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

import 'package:ews/Core/ServiceObjects/Schemas/EmailMessageSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/DateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';

/// <summary>
/// Field URIs for PostItem.
/// </summary>
class _PostItemSchemaFieldUris {
  static const String PostedTime = "postitem:PostedTime";
}

/// <summary>
/// Represents the schema for post items.
/// </summary>
//    [Schema]
class PostItemSchema extends ItemSchema {
  /// <summary>
  /// Defines the ConversationIndex property.
  /// </summary>
// static PropertyDefinition ConversationIndex =
//            EmailMessageSchema.ConversationIndex;

  /// <summary>
  /// Defines the ConversationTopic property.
  /// </summary>
  static PropertyDefinition ConversationTopic = EmailMessageSchema.ConversationTopic;

  /// <summary>
  /// Defines the From property.
  /// </summary>
// static PropertyDefinition From =
//            EmailMessageSchema.From;

  /// <summary>
  /// Defines the InternetMessageId property.
  /// </summary>
  static PropertyDefinition InternetMessageId = EmailMessageSchema.InternetMessageId;

  /// <summary>
  /// Defines the IsRead property.
  /// </summary>
  static PropertyDefinition IsRead = EmailMessageSchema.IsRead;

  /// <summary>
  /// Defines the PostedTime property.
  /// </summary>
  static PropertyDefinition PostedTime = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.PostedTime,
      _PostItemSchemaFieldUris.PostedTime,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the References property.
  /// </summary>
  static PropertyDefinition References = EmailMessageSchema.References;

  /// <summary>
  /// Defines the Sender property.
  /// </summary>
  static PropertyDefinition Sender = EmailMessageSchema.Sender;

  // This must be after the declaration of property definitions
  static PostItemSchema Instance = new PostItemSchema();

  /// <summary>
  /// Registers properties.
  /// </summary>
  /// <remarks>
  /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
  /// </remarks>
  @override
  void RegisterProperties() {
    super.RegisterProperties();

//            this.RegisterProperty(ConversationIndex);
    this.RegisterProperty(ConversationTopic);
//            this.RegisterProperty(From);
    this.RegisterProperty(InternetMessageId);
    this.RegisterProperty(IsRead);
    this.RegisterProperty(PostedTime);
    this.RegisterProperty(References);
    this.RegisterProperty(Sender);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="PostItemSchema"/> class.
  /// </summary>
  PostItemSchema() : super() {}
}
