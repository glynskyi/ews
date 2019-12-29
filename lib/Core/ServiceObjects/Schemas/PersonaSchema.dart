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

import 'package:ews/ComplexProperties/AttributedStringCollection.dart';
import 'package:ews/ComplexProperties/AttributionCollection.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/DateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IntPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';

/// <summary>
/// FieldURIs for persona.
/// </summary>
class _PersonaSchemaFieldUris {
  static const String PersonaId = "persona:PersonaId";
  static const String PersonaType = "persona:PersonaType";
  static const String CreationTime = "persona:CreationTime";
  static const String DisplayNameFirstLastHeader =
      "persona:DisplayNameFirstLastHeader";
  static const String DisplayNameLastFirstHeader =
      "persona:DisplayNameLastFirstHeader";
  static const String DisplayName = "persona:DisplayName";
  static const String DisplayNameFirstLast = "persona:DisplayNameFirstLast";
  static const String DisplayNameLastFirst = "persona:DisplayNameLastFirst";
  static const String FileAs = "persona:FileAs";
  static const String Generation = "persona:Generation";
  static const String DisplayNamePrefix = "persona:DisplayNamePrefix";
  static const String GivenName = "persona:GivenName";
  static const String Surname = "persona:Surname";
  static const String Title = "persona:Title";
  static const String CompanyName = "persona:CompanyName";
  static const String EmailAddress = "persona:EmailAddress";
  static const String EmailAddresses = "persona:EmailAddresses";
  static const String ImAddress = "persona:ImAddress";
  static const String HomeCity = "persona:HomeCity";
  static const String WorkCity = "persona:WorkCity";
  static const String Alias = "persona:Alias";
  static const String RelevanceScore = "persona:RelevanceScore";
  static const String Attributions = "persona:Attributions";
  static const String OfficeLocations = "persona:OfficeLocations";
  static const String ImAddresses = "persona:ImAddresses";
  static const String Departments = "persona:Departments";
  static const String ThirdPartyPhotoUrls = "persona:ThirdPartyPhotoUrls";
}

/// <summary>
/// Persona schema
/// </summary>
//    [Schema]
class PersonaSchema extends ItemSchema {
  /// <summary>
  /// Defines the PersonaId property.
  /// </summary>
  static PropertyDefinition PersonaId =
      new ComplexPropertyDefinition<ItemId>.withUriAndFlags(
          XmlElementNames.PersonaId,
          _PersonaSchemaFieldUris.PersonaId,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1, () {
    return new ItemId();
  });

  /// <summary>
  /// Defines the PersonaType property.
  /// </summary>
  static PropertyDefinition PersonaType = new StringPropertyDefinition(
      XmlElementNames.PersonaType,
      _PersonaSchemaFieldUris.PersonaType,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the CreationTime property.
  /// </summary>
  static PropertyDefinition CreationTime =
      new DateTimePropertyDefinition.withUriAndFlags(
          XmlElementNames.CreationTime,
          _PersonaSchemaFieldUris.CreationTime,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the DisplayNameFirstLastHeader property.
  /// </summary>
  static PropertyDefinition DisplayNameFirstLastHeader =
      new StringPropertyDefinition(
          XmlElementNames.DisplayNameFirstLastHeader,
          _PersonaSchemaFieldUris.DisplayNameFirstLastHeader,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the DisplayNameLastFirstHeader property.
  /// </summary>
  static PropertyDefinition DisplayNameLastFirstHeader =
      new StringPropertyDefinition(
          XmlElementNames.DisplayNameLastFirstHeader,
          _PersonaSchemaFieldUris.DisplayNameLastFirstHeader,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the DisplayName property.
  /// </summary>
  static PropertyDefinition DisplayName = new StringPropertyDefinition(
      XmlElementNames.DisplayName,
      _PersonaSchemaFieldUris.DisplayName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the DisplayNameFirstLast property.
  /// </summary>
  static PropertyDefinition DisplayNameFirstLast = new StringPropertyDefinition(
      XmlElementNames.DisplayNameFirstLast,
      _PersonaSchemaFieldUris.DisplayNameFirstLast,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the DisplayNameLastFirst property.
  /// </summary>
  static PropertyDefinition DisplayNameLastFirst = new StringPropertyDefinition(
      XmlElementNames.DisplayNameLastFirst,
      _PersonaSchemaFieldUris.DisplayNameLastFirst,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the FileAs property.
  /// </summary>
  static PropertyDefinition FileAs = new StringPropertyDefinition(
      XmlElementNames.FileAs,
      _PersonaSchemaFieldUris.FileAs,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the Generation property.
  /// </summary>
  static PropertyDefinition Generation = new StringPropertyDefinition(
      XmlElementNames.Generation,
      _PersonaSchemaFieldUris.Generation,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the DisplayNamePrefix property.
  /// </summary>
  static PropertyDefinition DisplayNamePrefix = new StringPropertyDefinition(
      XmlElementNames.DisplayNamePrefix,
      _PersonaSchemaFieldUris.DisplayNamePrefix,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the GivenName property.
  /// </summary>
  static PropertyDefinition GivenName = new StringPropertyDefinition(
      XmlElementNames.GivenName,
      _PersonaSchemaFieldUris.GivenName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the Surname property.
  /// </summary>
  static PropertyDefinition Surname = new StringPropertyDefinition(
      XmlElementNames.Surname,
      _PersonaSchemaFieldUris.Surname,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the Title property.
  /// </summary>
  static PropertyDefinition Title = new StringPropertyDefinition(
      XmlElementNames.Title,
      _PersonaSchemaFieldUris.Title,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the CompanyName property.
  /// </summary>
  static PropertyDefinition CompanyName = new StringPropertyDefinition(
      XmlElementNames.CompanyName,
      _PersonaSchemaFieldUris.CompanyName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the EmailAddress property.
  /// </summary>
//  static PropertyDefinition EmailAddress =
//      new ComplexPropertyDefinition<PersonaEmailAddress>.withUriAndFlags(
//          XmlElementNames.EmailAddress,
//          _PersonaSchemaFieldUris.EmailAddress,
//          [
//            PropertyDefinitionFlags.AutoInstantiateOnRead,
//            PropertyDefinitionFlags.CanSet,
//            PropertyDefinitionFlags.CanUpdate,
//            PropertyDefinitionFlags.CanDelete,
//            PropertyDefinitionFlags.CanFind
//          ],
//          ExchangeVersion.Exchange2013_SP1, () {
//    return new PersonaEmailAddress();
//  });

  /// <summary>
  /// Defines the EmailAddresses property.
  /// </summary>
//  static PropertyDefinition EmailAddresses =
//      new ComplexPropertyDefinition<PersonaEmailAddressCollection>(
//          XmlElementNames.EmailAddresses,
//          _PersonaSchemaFieldUris.EmailAddresses,
//          [
//            PropertyDefinitionFlags.AutoInstantiateOnRead,
//            PropertyDefinitionFlags.CanSet,
//            PropertyDefinitionFlags.CanUpdate,
//            PropertyDefinitionFlags.CanDelete,
//            PropertyDefinitionFlags.CanFind
//          ],
//          ExchangeVersion.Exchange2013_SP1, () {
//    return new PersonaEmailAddressCollection();
//  });

  /// <summary>
  /// Defines the ImAddress property.
  /// </summary>
  static PropertyDefinition ImAddress = new StringPropertyDefinition(
      XmlElementNames.ImAddress,
      _PersonaSchemaFieldUris.ImAddress,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the HomeCity property.
  /// </summary>
  static PropertyDefinition HomeCity = new StringPropertyDefinition(
      XmlElementNames.HomeCity,
      _PersonaSchemaFieldUris.HomeCity,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the WorkCity property.
  /// </summary>
  static PropertyDefinition WorkCity = new StringPropertyDefinition(
      XmlElementNames.WorkCity,
      _PersonaSchemaFieldUris.WorkCity,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the Alias property.
  /// </summary>
  static PropertyDefinition Alias = new StringPropertyDefinition(
      XmlElementNames.Alias,
      _PersonaSchemaFieldUris.Alias,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2013_SP1);

  /// <summary>
  /// Defines the RelevanceScore property.
  /// </summary>
  static PropertyDefinition RelevanceScore =
      new IntPropertyDefinition.withFlagsAndNullable(
          XmlElementNames.RelevanceScore,
          _PersonaSchemaFieldUris.RelevanceScore,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1,
          true);

  /// <summary>
  /// Defines the Attributions property
  /// </summary>
  static PropertyDefinition Attributions =
      new ComplexPropertyDefinition<AttributionCollection>.withUriAndFlags(
          XmlElementNames.Attributions,
          _PersonaSchemaFieldUris.Attributions,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1, () {
    return new AttributionCollection();
  });

  /// <summary>
  /// Defines the OfficeLocations property.
  /// </summary>
  static PropertyDefinition OfficeLocations =
      new ComplexPropertyDefinition<AttributedStringCollection>.withUriAndFlags(
          XmlElementNames.OfficeLocations,
          _PersonaSchemaFieldUris.OfficeLocations,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1, () {
    return new AttributedStringCollection();
  });

  /// <summary>
  /// Defines the ImAddresses property.
  /// </summary>
  static PropertyDefinition ImAddresses =
      new ComplexPropertyDefinition<AttributedStringCollection>.withUriAndFlags(
          XmlElementNames.ImAddresses,
          _PersonaSchemaFieldUris.ImAddresses,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1, () {
    return new AttributedStringCollection();
  });

  /// <summary>
  /// Defines the Departments property.
  /// </summary>
  static PropertyDefinition Departments =
      new ComplexPropertyDefinition<AttributedStringCollection>.withUriAndFlags(
          XmlElementNames.Departments,
          _PersonaSchemaFieldUris.Departments,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1, () {
    return new AttributedStringCollection();
  });

  /// <summary>
  /// Defines the ThirdPartyPhotoUrls property.
  /// </summary>
  static PropertyDefinition ThirdPartyPhotoUrls =
      new ComplexPropertyDefinition<AttributedStringCollection>.withUriAndFlags(
          XmlElementNames.ThirdPartyPhotoUrls,
          _PersonaSchemaFieldUris.ThirdPartyPhotoUrls,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2013_SP1, () {
    return new AttributedStringCollection();
  });

  // This must be declared after the property definitions
  static PersonaSchema Instance = new PersonaSchema();

  /// <summary>
  /// Registers properties.
  /// </summary>
  /// <remarks>
  /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
  /// </remarks>
  @override
  void RegisterProperties() {
    super.RegisterProperties();

    this.RegisterProperty(PersonaId);
    this.RegisterProperty(PersonaType);
    this.RegisterProperty(CreationTime);
    this.RegisterProperty(DisplayNameFirstLastHeader);
    this.RegisterProperty(DisplayNameLastFirstHeader);
    this.RegisterProperty(DisplayName);
    this.RegisterProperty(DisplayNameFirstLast);
    this.RegisterProperty(DisplayNameLastFirst);
    this.RegisterProperty(FileAs);
    this.RegisterProperty(Generation);
    this.RegisterProperty(DisplayNamePrefix);
    this.RegisterProperty(GivenName);
    this.RegisterProperty(Surname);
    this.RegisterProperty(Title);
    this.RegisterProperty(CompanyName);
//    this.RegisterProperty(EmailAddress);
//    this.RegisterProperty(EmailAddresses);
    this.RegisterProperty(ImAddress);
    this.RegisterProperty(HomeCity);
    this.RegisterProperty(WorkCity);
    this.RegisterProperty(Alias);
    this.RegisterProperty(RelevanceScore);
    this.RegisterProperty(Attributions);
    this.RegisterProperty(OfficeLocations);
    this.RegisterProperty(ImAddresses);
    this.RegisterProperty(Departments);
    this.RegisterProperty(ThirdPartyPhotoUrls);
  }

  /// <summary>
  /// constructor
  /// </summary>
  PersonaSchema() : super() {}
}
