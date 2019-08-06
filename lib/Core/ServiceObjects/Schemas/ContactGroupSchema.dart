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

import 'package:ews/ComplexProperties/GroupMemberCollection.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ContactSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';

/// <summary>
/// Field URIs for Members.
/// </summary>
/* private */
class _ContactGroupSchemaFieldUris {
  /// <summary>
  /// FieldUri for members.
  /// </summary>
  static const String Members = "distributionlist:Members";
}

/// <summary>
/// Represents the schema for contact groups.
/// </summary>
//    [Schema]
class ContactGroupSchema extends ItemSchema {
  /// <summary>
  /// Defines the DisplayName property.
  /// </summary>
//        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition DisplayName = ContactSchema.DisplayName;

  /// <summary>
  /// Defines the FileAs property.
  /// </summary>
//        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition FileAs = ContactSchema.FileAs;

  /// <summary>
  /// Defines the Members property.
  /// </summary>
//        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Members =
      new ComplexPropertyDefinition<GroupMemberCollection>.withUriAndFlags(
          XmlElementNames.Members,
          _ContactGroupSchemaFieldUris.Members,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate
          ],
          ExchangeVersion.Exchange2010, () {
    return new GroupMemberCollection();
  });

  /// <summary>
  /// This must be declared after the property definitions.
  /// </summary>
  static ContactGroupSchema Instance = new ContactGroupSchema();

  /// <summary>
  /// Initializes a new instance of the <see cref="ContactGroupSchema"/> class.
  /// </summary>
  ContactGroupSchema() : super() {}

  /// <summary>
  /// Registers properties.
  /// </summary>
  /// <remarks>
  /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
  /// </remarks>
  @override
  void RegisterProperties() {
    super.RegisterProperties();

    this.RegisterProperty(DisplayName);
    this.RegisterProperty(FileAs);
    this.RegisterProperty(Members);
  }
}
