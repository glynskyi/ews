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

import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/EffectiveRightsPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IntPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PermissionCollectionPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';

class FolderSchemaFieldUris {
  static const String FolderId = "folder:FolderId";
  static const String ParentFolderId = "folder:ParentFolderId";
  static const String DisplayName = "folder:DisplayName";
  static const String UnreadCount = "folder:UnreadCount";
  static const String TotalCount = "folder:TotalCount";
  static const String ChildFolderCount = "folder:ChildFolderCount";
  static const String FolderClass = "folder:FolderClass";
  static const String ManagedFolderInformation = "folder:ManagedFolderInformation";
  static const String EffectiveRights = "folder:EffectiveRights";
  static const String PermissionSet = "folder:PermissionSet";
  static const String PolicyTag = "folder:PolicyTag";
  static const String ArchiveTag = "folder:ArchiveTag";
  static const String DistinguishedFolderId = "folder:DistinguishedFolderId";
}

/// <summary>
/// Represents the schema for folders.
/// </summary>
//    [Schema]
class FolderSchema extends ServiceObjectSchema {
  /// <summary>
  /// Field URIs for folders.
  /// </summary>
  /* private */

  /// <summary>
  /// Defines the Id property.
  /// </summary>
  static PropertyDefinition Id = new ComplexPropertyDefinition<FolderId>.withUriAndFlags(
      XmlElementNames.FolderId,
      FolderSchemaFieldUris.FolderId,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1, () {
    return new FolderId();
  });

  /// <summary>
  /// Defines the FolderClass property.
  /// </summary>
  static PropertyDefinition FolderClass = new StringPropertyDefinition(
      XmlElementNames.FolderClass,
      FolderSchemaFieldUris.FolderClass,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ParentFolderId property.
  /// </summary>
  static PropertyDefinition ParentFolderId = ComplexPropertyDefinition<FolderId>.withUriAndFlags(
      XmlElementNames.ParentFolderId,
      FolderSchemaFieldUris.ParentFolderId,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1, () {
    return new FolderId();
  });

  /// <summary>
  /// Defines the ChildFolderCount property.
  /// </summary>
  static PropertyDefinition ChildFolderCount = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.ChildFolderCount,
      FolderSchemaFieldUris.ChildFolderCount,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the DisplayName property.
  /// </summary>
  static PropertyDefinition DisplayName = new StringPropertyDefinition(
      XmlElementNames.DisplayName,
      FolderSchemaFieldUris.DisplayName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the UnreadCount property.
  /// </summary>
  static PropertyDefinition UnreadCount = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.UnreadCount,
      FolderSchemaFieldUris.UnreadCount,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the TotalCount property.
  /// </summary>
  static PropertyDefinition TotalCount = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.TotalCount,
      FolderSchemaFieldUris.TotalCount,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ManagedFolderInformation property.
  /// </summary>
// static PropertyDefinition ManagedFolderInformation =
//            new ComplexPropertyDefinition<ManagedFolderInformation>(
//                XmlElementNames.ManagedFolderInformation,
//                FolderSchemaFieldUris.ManagedFolderInformation,
//                PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new ManagedFolderInformation(); });

  /// <summary>
  /// Defines the EffectiveRights property.
  /// </summary>
  static PropertyDefinition EffectiveRights = new EffectiveRightsPropertyDefinition(
      XmlElementNames.EffectiveRights,
      FolderSchemaFieldUris.EffectiveRights,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Permissions property.
  /// </summary>
  static PropertyDefinition Permissions = new PermissionSetPropertyDefinition(
      XmlElementNames.PermissionSet,
      FolderSchemaFieldUris.PermissionSet,
      [
        PropertyDefinitionFlags.AutoInstantiateOnRead,
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.MustBeExplicitlyLoaded
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the WellKnownFolderName property.
  /// </summary>
  static PropertyDefinition WellKnownFolderName = new StringPropertyDefinition(
      XmlElementNames.DistinguishedFolderId,
      FolderSchemaFieldUris.DistinguishedFolderId,
      [PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2013);

  /// <summary>
  /// Defines the PolicyTag property.
  /// </summary>
// static PropertyDefinition PolicyTag =
//            new ComplexPropertyDefinition<PolicyTag>(
//                XmlElementNames.PolicyTag,
//                FolderSchemaFieldUris.PolicyTag,
//                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2013,
//                () { return new PolicyTag(); });

  /// <summary>
  /// Defines the ArchiveTag property.
  /// </summary>
// static PropertyDefinition ArchiveTag =
//            new ComplexPropertyDefinition<ArchiveTag>(
//                XmlElementNames.ArchiveTag,
//                FolderSchemaFieldUris.ArchiveTag,
//                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
//                ExchangeVersion.Exchange2013,
//                () { return new ArchiveTag(); });

  // This must be declared after the property definitions
  static FolderSchema Instance = new FolderSchema();

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
    this.RegisterProperty(ParentFolderId);
    this.RegisterProperty(FolderClass);
    this.RegisterProperty(DisplayName);
    this.RegisterProperty(TotalCount);
    this.RegisterProperty(ChildFolderCount);
    this.RegisterProperty(ServiceObjectSchema.ExtendedProperties);
    // todo("fix property registering")
//            this.RegisterProperty(ManagedFolderInformation);
    this.RegisterProperty(EffectiveRights);
    this.RegisterProperty(Permissions);
    this.RegisterProperty(UnreadCount);
    this.RegisterProperty(WellKnownFolderName);
//            this.RegisterProperty(PolicyTag);
//            this.RegisterProperty(ArchiveTag);
  }
}
