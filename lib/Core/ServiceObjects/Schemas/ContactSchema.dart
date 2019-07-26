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

import 'package:ews/ComplexProperties/CompleteName.dart' as complex;
import 'package:ews/ComplexProperties/EmailAddress.dart';
import 'package:ews/ComplexProperties/EmailAddressCollection.dart';
import 'package:ews/ComplexProperties/EmailAddressDictionary.dart';
import 'package:ews/ComplexProperties/StringList.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ContactSource.dart' as complex;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/FileAsMapping.dart' as enumerations;
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/BoolPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ContainedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/DateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IndexedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';

/// <summary>
/// ContactSchemaFieldUris for contacts.
/// </summary>
/* private */
class ContactSchemaFieldUris {
  static const String FileAs = "contacts:FileAs";
  static const String FileAsMapping = "contacts:FileAsMapping";
  static const String DisplayName = "contacts:DisplayName";
  static const String GivenName = "contacts:GivenName";
  static const String Initials = "contacts:Initials";
  static const String MiddleName = "contacts:MiddleName";
  static const String NickName = "contacts:Nickname";
  static const String CompleteName = "contacts:CompleteName";
  static const String CompanyName = "contacts:CompanyName";
  static const String EmailAddress = "contacts:EmailAddress";
  static const String EmailAddresses = "contacts:EmailAddresses";
  static const String PhysicalAddresses = "contacts:PhysicalAddresses";
  static const String PhoneNumber = "contacts:PhoneNumber";
  static const String PhoneNumbers = "contacts:PhoneNumbers";
  static const String AssistantName = "contacts:AssistantName";
  static const String Birthday = "contacts:Birthday";
  static const String BusinessHomePage = "contacts:BusinessHomePage";
  static const String Children = "contacts:Children";
  static const String Companies = "contacts:Companies";
  static const String ContactSource = "contacts:ContactSource";
  static const String Department = "contacts:Department";
  static const String Generation = "contacts:Generation";
  static const String ImAddress = "contacts:ImAddress";
  static const String ImAddresses = "contacts:ImAddresses";
  static const String JobTitle = "contacts:JobTitle";
  static const String Manager = "contacts:Manager";
  static const String Mileage = "contacts:Mileage";
  static const String OfficeLocation = "contacts:OfficeLocation";
  static const String PhysicalAddressCity = "contacts:PhysicalAddress:City";
  static const String PhysicalAddressCountryOrRegion = "contacts:PhysicalAddress:CountryOrRegion";
  static const String PhysicalAddressState = "contacts:PhysicalAddress:State";
  static const String PhysicalAddressStreet = "contacts:PhysicalAddress:Street";
  static const String PhysicalAddressPostalCode = "contacts:PhysicalAddress:PostalCode";
  static const String PostalAddressIndex = "contacts:PostalAddressIndex";
  static const String Profession = "contacts:Profession";
  static const String SpouseName = "contacts:SpouseName";
  static const String Surname = "contacts:Surname";
  static const String WeddingAnniversary = "contacts:WeddingAnniversary";
  static const String HasPicture = "contacts:HasPicture";
  static const String PhoneticFullName = "contacts:PhoneticFullName";
  static const String PhoneticFirstName = "contacts:PhoneticFirstName";
  static const String PhoneticLastName = "contacts:PhoneticLastName";
  static const String Alias = "contacts:Alias";
  static const String Notes = "contacts:Notes";
  static const String Photo = "contacts:Photo";
  static const String UserSMIMECertificate = "contacts:UserSMIMECertificate";
  static const String MSExchangeCertificate = "contacts:MSExchangeCertificate";
  static const String DirectoryId = "contacts:DirectoryId";
  static const String ManagerMailbox = "contacts:ManagerMailbox";
  static const String DirectReports = "contacts:DirectReports";
}

/// <summary>
/// Represents the schem for contacts.
/// </summary>
//    [Schema]
class ContactSchema extends ItemSchema {
  /// <summary>
  /// Defines the FileAs property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition FileAs = new StringPropertyDefinition(
      XmlElementNames.FileAs,
      ContactSchemaFieldUris.FileAs,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the FileAsMapping property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition FileAsMapping = new GenericPropertyDefinition<enumerations.FileAsMapping>.withUriAndFlags(
      XmlElementNames.FileAsMapping,
      ContactSchemaFieldUris.FileAsMapping,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the DisplayName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition DisplayName = new StringPropertyDefinition(
      XmlElementNames.DisplayName,
      ContactSchemaFieldUris.DisplayName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the GivenName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition GivenName = new StringPropertyDefinition(
      XmlElementNames.GivenName,
      ContactSchemaFieldUris.GivenName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Initials property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Initials = new StringPropertyDefinition(
      XmlElementNames.Initials,
      ContactSchemaFieldUris.Initials,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the MiddleName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition MiddleName = new StringPropertyDefinition(
      XmlElementNames.MiddleName,
      ContactSchemaFieldUris.MiddleName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the NickName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition NickName = new StringPropertyDefinition(
      XmlElementNames.NickName,
      ContactSchemaFieldUris.NickName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the CompleteName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition CompleteName = new ComplexPropertyDefinition<complex.CompleteName>.withUriAndFlags(
      XmlElementNames.CompleteName,
      ContactSchemaFieldUris.CompleteName,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1, () {
    return new complex.CompleteName();
  });

  /// <summary>
  /// Defines the CompanyName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition CompanyName = new StringPropertyDefinition(
      XmlElementNames.CompanyName,
      ContactSchemaFieldUris.CompanyName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the EmailAddresses property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition EmailAddresses = new ComplexPropertyDefinition<EmailAddressDictionary>.withUriAndFlags(
      XmlElementNames.EmailAddresses,
      ContactSchemaFieldUris.EmailAddresses,
      [
        PropertyDefinitionFlags.AutoInstantiateOnRead,
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate
      ],
      ExchangeVersion.Exchange2007_SP1, () {
    return new EmailAddressDictionary();
  });

  /// <summary>
  /// Defines the PhysicalAddresses property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition PhysicalAddresses =
//            new ComplexPropertyDefinition<PhysicalAddressDictionary>(
//                XmlElementNames.PhysicalAddresses,
//                ContactSchemaFieldUris.PhysicalAddresses,
//                [PropertyDefinitionFlags.AutoInstantiateOnRead, PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate],
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new PhysicalAddressDictionary(); });

  /// <summary>
  /// Defines the PhoneNumbers property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition PhoneNumbers =
//            new ComplexPropertyDefinition<PhoneNumberDictionary>.withUriAndFlags(
//                XmlElementNames.PhoneNumbers,
//                ContactSchemaFieldUris.PhoneNumbers,
//                [PropertyDefinitionFlags.AutoInstantiateOnRead, PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate],
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new PhoneNumberDictionary(); });

  /// <summary>
  /// Defines the AssistantName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition AssistantName = new StringPropertyDefinition(
      XmlElementNames.AssistantName,
      ContactSchemaFieldUris.AssistantName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Birthday property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Birthday = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.Birthday,
      ContactSchemaFieldUris.Birthday,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the BusinessHomePage property.
  /// </summary>
  /// <remarks>
  /// Defined as anyURI in the EWS schema. String is fine here.
  /// </remarks>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition BusinessHomePage = new StringPropertyDefinition(
      XmlElementNames.BusinessHomePage,
      ContactSchemaFieldUris.BusinessHomePage,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Children property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Children = new ComplexPropertyDefinition<StringList>.withUriAndFlags(
      XmlElementNames.Children,
      ContactSchemaFieldUris.Children,
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
  /// Defines the Companies property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Companies = new ComplexPropertyDefinition<StringList>.withUriAndFlags(
      XmlElementNames.Companies,
      ContactSchemaFieldUris.Companies,
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
  /// Defines the ContactSource property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition ContactSource = new GenericPropertyDefinition<complex.ContactSource>.withUriAndFlags(
      XmlElementNames.ContactSource,
      ContactSchemaFieldUris.ContactSource,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Department property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Department = new StringPropertyDefinition(
      XmlElementNames.Department,
      ContactSchemaFieldUris.Department,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Generation property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Generation = new StringPropertyDefinition(
      XmlElementNames.Generation,
      ContactSchemaFieldUris.Generation,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ImAddresses property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition ImAddresses =
//            new ComplexPropertyDefinition<ImAddressDictionary>(
//                XmlElementNames.ImAddresses,
//                ContactSchemaFieldUris.ImAddresses,
//                [PropertyDefinitionFlags.AutoInstantiateOnRead, PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate],
//                ExchangeVersion.Exchange2007_SP1,
//                () { return new ImAddressDictionary(); });

  /// <summary>
  /// Defines the JobTitle property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition JobTitle = new StringPropertyDefinition(
      XmlElementNames.JobTitle,
      ContactSchemaFieldUris.JobTitle,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Manager property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Manager = new StringPropertyDefinition(
      XmlElementNames.Manager,
      ContactSchemaFieldUris.Manager,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Mileage property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Mileage = new StringPropertyDefinition(
      XmlElementNames.Mileage,
      ContactSchemaFieldUris.Mileage,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the OfficeLocation property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition OfficeLocation = new StringPropertyDefinition(
      XmlElementNames.OfficeLocation,
      ContactSchemaFieldUris.OfficeLocation,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the PostalAddressIndex property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition PostalAddressIndex =
//            new GenericPropertyDefinition<PhysicalAddressIndex>(
//                XmlElementNames.PostalAddressIndex,
//                ContactSchemaFieldUris.PostalAddressIndex,
//                [PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate, PropertyDefinitionFlags.CanDelete, PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Profession property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Profession = new StringPropertyDefinition(
      XmlElementNames.Profession,
      ContactSchemaFieldUris.Profession,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the SpouseName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition SpouseName = new StringPropertyDefinition(
      XmlElementNames.SpouseName,
      ContactSchemaFieldUris.SpouseName,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Surname property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Surname = new StringPropertyDefinition(
      XmlElementNames.Surname,
      ContactSchemaFieldUris.Surname,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the WeddingAnniversary property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition WeddingAnniversary = new DateTimePropertyDefinition.withUriAndFlags(
      XmlElementNames.WeddingAnniversary,
      ContactSchemaFieldUris.WeddingAnniversary,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the HasPicture property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition HasPicture = new BoolPropertyDefinition.withUriAndFlags(XmlElementNames.HasPicture,
      ContactSchemaFieldUris.HasPicture, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2010);

  /// <summary>
  /// Defines the PhoneticFullName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition PhoneticFullName = new StringPropertyDefinition(XmlElementNames.PhoneticFullName,
      ContactSchemaFieldUris.PhoneticFullName, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the PhoneticFirstName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition PhoneticFirstName = new StringPropertyDefinition(XmlElementNames.PhoneticFirstName,
      ContactSchemaFieldUris.PhoneticFirstName, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the PhoneticLastName property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition PhoneticLastName = new StringPropertyDefinition(XmlElementNames.PhoneticLastName,
      ContactSchemaFieldUris.PhoneticLastName, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the Alias property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Alias = new StringPropertyDefinition(
      XmlElementNames.Alias, ContactSchemaFieldUris.Alias, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the Notes property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Notes = new StringPropertyDefinition(
      XmlElementNames.Notes, ContactSchemaFieldUris.Notes, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the Photo property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition Photo =
//            new ByteArrayPropertyDefinition(
//                XmlElementNames.Photo,
//                ContactSchemaFieldUris.Photo,
//                [PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the UserSMIMECertificate property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition UserSMIMECertificate =
//            new ComplexPropertyDefinition<ByteArrayArray>(
//                XmlElementNames.UserSMIMECertificate,
//                ContactSchemaFieldUris.UserSMIMECertificate,
//                [PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2010_SP1,
//                () { return new ByteArrayArray(); });

  /// <summary>
  /// Defines the MSExchangeCertificate property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
// static PropertyDefinition MSExchangeCertificate =
//            new ComplexPropertyDefinition<ByteArrayArray>(
//                XmlElementNames.MSExchangeCertificate,
//                ContactSchemaFieldUris.MSExchangeCertificate,
//                [PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2010_SP1,
//                () { return new ByteArrayArray(); });

  /// <summary>
  /// Defines the DirectoryId property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition DirectoryId = new StringPropertyDefinition(XmlElementNames.DirectoryId,
      ContactSchemaFieldUris.DirectoryId, [PropertyDefinitionFlags.CanFind], ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the ManagerMailbox property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition ManagerMailbox = new ContainedPropertyDefinition<EmailAddress>.withUriAndFlags(
      XmlElementNames.ManagerMailbox,
      ContactSchemaFieldUris.ManagerMailbox,
      XmlElementNames.Mailbox,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1, () {
    return new EmailAddress();
  });

  /// <summary>
  /// Defines the DirectReports property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition DirectReports = new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
      XmlElementNames.DirectReports,
      ContactSchemaFieldUris.DirectReports,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1, () {
    return new EmailAddressCollection();
  });

  /// <summary>
  /// Defines the EmailAddress1 property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition EmailAddress1 =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.EmailAddress, "EmailAddress1");

  /// <summary>
  /// Defines the EmailAddress2 property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition EmailAddress2 =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.EmailAddress, "EmailAddress2");

  /// <summary>
  /// Defines the EmailAddress3 property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition EmailAddress3 =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.EmailAddress, "EmailAddress3");

  /// <summary>
  /// Defines the ImAddress1 property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition ImAddress1 = new IndexedPropertyDefinition(ContactSchemaFieldUris.ImAddress, "ImAddress1");

  /// <summary>
  /// Defines the ImAddress2 property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition ImAddress2 = new IndexedPropertyDefinition(ContactSchemaFieldUris.ImAddress, "ImAddress2");

  /// <summary>
  /// Defines the ImAddress3 property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition ImAddress3 = new IndexedPropertyDefinition(ContactSchemaFieldUris.ImAddress, "ImAddress3");

  /// <summary>
  /// Defines the AssistentPhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition AssistantPhone =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "AssistantPhone");

  /// <summary>
  /// Defines the BusinessFax property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition BusinessFax = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "BusinessFax");

  /// <summary>
  /// Defines the BusinessPhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition BusinessPhone =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "BusinessPhone");

  /// <summary>
  /// Defines the BusinessPhone2 property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition BusinessPhone2 =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "BusinessPhone2");

  /// <summary>
  /// Defines the Callback property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition Callback = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "Callback");

  /// <summary>
  /// Defines the CarPhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition CarPhone = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "CarPhone");

  /// <summary>
  /// Defines the CompanyMainPhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition CompanyMainPhone =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "CompanyMainPhone");

  /// <summary>
  /// Defines the HomeFax property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition HomeFax = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "HomeFax");

  /// <summary>
  /// Defines the HomePhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition HomePhone = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "HomePhone");

  /// <summary>
  /// Defines the HomePhone2 property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition HomePhone2 = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "HomePhone2");

  /// <summary>
  /// Defines the Isdn property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition Isdn = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "Isdn");

  /// <summary>
  /// Defines the MobilePhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition MobilePhone = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "MobilePhone");

  /// <summary>
  /// Defines the OtherFax property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition OtherFax = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "OtherFax");

  /// <summary>
  /// Defines the OtherTelephone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition OtherTelephone =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "OtherTelephone");

  /// <summary>
  /// Defines the Pager property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition Pager = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "Pager");

  /// <summary>
  /// Defines the PrimaryPhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition PrimaryPhone = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "PrimaryPhone");

  /// <summary>
  /// Defines the RadioPhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition RadioPhone = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "RadioPhone");

  /// <summary>
  /// Defines the Telex property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition Telex = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "Telex");

  /// <summary>
  /// Defines the TtyTddPhone property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition TtyTddPhone = new IndexedPropertyDefinition(ContactSchemaFieldUris.PhoneNumber, "TtyTddPhone");

  /// <summary>
  /// Defines the BusinessAddressStreet property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition BusinessAddressStreet =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressStreet, "Business");

  /// <summary>
  /// Defines the BusinessAddressCity property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition BusinessAddressCity =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressCity, "Business");

  /// <summary>
  /// Defines the BusinessAddressState property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition BusinessAddressState =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressState, "Business");

  /// <summary>
  /// Defines the BusinessAddressCountryOrRegion property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition BusinessAddressCountryOrRegion =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressCountryOrRegion, "Business");

  /// <summary>
  /// Defines the BusinessAddressPostalCode property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition BusinessAddressPostalCode =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressPostalCode, "Business");

  /// <summary>
  /// Defines the HomeAddressStreet property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition HomeAddressStreet =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressStreet, "Home");

  /// <summary>
  /// Defines the HomeAddressCity property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition HomeAddressCity =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressCity, "Home");

  /// <summary>
  /// Defines the HomeAddressState property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition HomeAddressState =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressState, "Home");

  /// <summary>
  /// Defines the HomeAddressCountryOrRegion property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition HomeAddressCountryOrRegion =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressCountryOrRegion, "Home");

  /// <summary>
  /// Defines the HomeAddressPostalCode property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition HomeAddressPostalCode =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressPostalCode, "Home");

  /// <summary>
  /// Defines the OtherAddressStreet property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition OtherAddressStreet =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressStreet, "Other");

  /// <summary>
  /// Defines the OtherAddressCity property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition OtherAddressCity =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressCity, "Other");

  /// <summary>
  /// Defines the OtherAddressState property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition OtherAddressState =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressState, "Other");

  /// <summary>
  /// Defines the OtherAddressCountryOrRegion property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition OtherAddressCountryOrRegion =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressCountryOrRegion, "Other");

  /// <summary>
  /// Defines the OtherAddressPostalCode property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static IndexedPropertyDefinition OtherAddressPostalCode =
      new IndexedPropertyDefinition(ContactSchemaFieldUris.PhysicalAddressPostalCode, "Other");

  // This must be declared after the property definitions
  static ContactSchema Instance = new ContactSchema();

  /// <summary>
  /// Registers properties.
  /// </summary>
  /// <remarks>
  /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
  /// </remarks>
  @override
  void RegisterProperties() {
    super.RegisterProperties();

    this.RegisterProperty(FileAs);
    this.RegisterProperty(FileAsMapping);
    this.RegisterProperty(DisplayName);
    this.RegisterProperty(GivenName);
    this.RegisterProperty(Initials);
    this.RegisterProperty(MiddleName);
    this.RegisterProperty(NickName);
    this.RegisterProperty(CompleteName);
    this.RegisterProperty(CompanyName);
    this.RegisterProperty(EmailAddresses);
//            this.RegisterProperty(PhysicalAddresses);
//            this.RegisterProperty(PhoneNumbers);
    this.RegisterProperty(AssistantName);
    this.RegisterProperty(Birthday);
    this.RegisterProperty(BusinessHomePage);
    this.RegisterProperty(Children);
    this.RegisterProperty(Companies);
    this.RegisterProperty(ContactSource);
    this.RegisterProperty(Department);
    this.RegisterProperty(Generation);
//    this.RegisterProperty(ImAddresses);
    this.RegisterProperty(JobTitle);
    this.RegisterProperty(Manager);
    this.RegisterProperty(Mileage);
    this.RegisterProperty(OfficeLocation);
//    this.RegisterProperty(PostalAddressIndex);
    this.RegisterProperty(Profession);
    this.RegisterProperty(SpouseName);
    this.RegisterProperty(Surname);
    this.RegisterProperty(WeddingAnniversary);
    this.RegisterProperty(HasPicture);
    this.RegisterProperty(PhoneticFullName);
    this.RegisterProperty(PhoneticFirstName);
    this.RegisterProperty(PhoneticLastName);
    this.RegisterProperty(Alias);
    this.RegisterProperty(Notes);
//            this.RegisterProperty(Photo);
//            this.RegisterProperty(UserSMIMECertificate);
//            this.RegisterProperty(MSExchangeCertificate);
    this.RegisterProperty(DirectoryId);
    this.RegisterProperty(ManagerMailbox);
    this.RegisterProperty(DirectReports);

    this.RegisterIndexedProperty(EmailAddress1);
    this.RegisterIndexedProperty(EmailAddress2);
    this.RegisterIndexedProperty(EmailAddress3);
    this.RegisterIndexedProperty(ImAddress1);
    this.RegisterIndexedProperty(ImAddress2);
    this.RegisterIndexedProperty(ImAddress3);
    this.RegisterIndexedProperty(AssistantPhone);
    this.RegisterIndexedProperty(BusinessFax);
    this.RegisterIndexedProperty(BusinessPhone);
    this.RegisterIndexedProperty(BusinessPhone2);
    this.RegisterIndexedProperty(Callback);
    this.RegisterIndexedProperty(CarPhone);
    this.RegisterIndexedProperty(CompanyMainPhone);
    this.RegisterIndexedProperty(HomeFax);
    this.RegisterIndexedProperty(HomePhone);
    this.RegisterIndexedProperty(HomePhone2);
    this.RegisterIndexedProperty(Isdn);
    this.RegisterIndexedProperty(MobilePhone);
    this.RegisterIndexedProperty(OtherFax);
    this.RegisterIndexedProperty(OtherTelephone);
    this.RegisterIndexedProperty(Pager);
    this.RegisterIndexedProperty(PrimaryPhone);
    this.RegisterIndexedProperty(RadioPhone);
    this.RegisterIndexedProperty(Telex);
    this.RegisterIndexedProperty(TtyTddPhone);
    this.RegisterIndexedProperty(BusinessAddressStreet);
    this.RegisterIndexedProperty(BusinessAddressCity);
    this.RegisterIndexedProperty(BusinessAddressState);
    this.RegisterIndexedProperty(BusinessAddressCountryOrRegion);
    this.RegisterIndexedProperty(BusinessAddressPostalCode);
    this.RegisterIndexedProperty(HomeAddressStreet);
    this.RegisterIndexedProperty(HomeAddressCity);
    this.RegisterIndexedProperty(HomeAddressState);
    this.RegisterIndexedProperty(HomeAddressCountryOrRegion);
    this.RegisterIndexedProperty(HomeAddressPostalCode);
    this.RegisterIndexedProperty(OtherAddressStreet);
    this.RegisterIndexedProperty(OtherAddressCity);
    this.RegisterIndexedProperty(OtherAddressState);
    this.RegisterIndexedProperty(OtherAddressCountryOrRegion);
    this.RegisterIndexedProperty(OtherAddressPostalCode);
  }

  ContactSchema() : super() {}
}
