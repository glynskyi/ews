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
import 'package:ews/ComplexProperties/ImAddressDictionary.dart';
import 'package:ews/ComplexProperties/PhoneNumberDictionary.dart';
import 'package:ews/ComplexProperties/PhysicalAddressDictionary.dart';
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
class _ContactSchemaFieldUris {
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
  static const String PhysicalAddressCountryOrRegion =
      "contacts:PhysicalAddress:CountryOrRegion";
  static const String PhysicalAddressState = "contacts:PhysicalAddress:State";
  static const String PhysicalAddressStreet = "contacts:PhysicalAddress:Street";
  static const String PhysicalAddressPostalCode =
      "contacts:PhysicalAddress:PostalCode";
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
  static PropertyDefinition FileAs = new StringPropertyDefinition(
      XmlElementNames.FileAs,
      _ContactSchemaFieldUris.FileAs,
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
  static PropertyDefinition FileAsMapping =
      new GenericPropertyDefinition<enumerations.FileAsMapping>.withUriAndFlags(
          XmlElementNames.FileAsMapping,
          _ContactSchemaFieldUris.FileAsMapping,
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
  static PropertyDefinition DisplayName = new StringPropertyDefinition(
      XmlElementNames.DisplayName,
      _ContactSchemaFieldUris.DisplayName,
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
  static PropertyDefinition GivenName = new StringPropertyDefinition(
      XmlElementNames.GivenName,
      _ContactSchemaFieldUris.GivenName,
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
  static PropertyDefinition Initials = new StringPropertyDefinition(
      XmlElementNames.Initials,
      _ContactSchemaFieldUris.Initials,
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
  static PropertyDefinition MiddleName = new StringPropertyDefinition(
      XmlElementNames.MiddleName,
      _ContactSchemaFieldUris.MiddleName,
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
  static PropertyDefinition NickName = new StringPropertyDefinition(
      XmlElementNames.NickName,
      _ContactSchemaFieldUris.NickName,
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
  static PropertyDefinition CompleteName =
      new ComplexPropertyDefinition<complex.CompleteName>.withUriAndFlags(
          XmlElementNames.CompleteName,
          _ContactSchemaFieldUris.CompleteName,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2007_SP1, () {
    return new complex.CompleteName();
  });

  /// <summary>
  /// Defines the CompanyName property.
  /// </summary>
  static PropertyDefinition CompanyName = new StringPropertyDefinition(
      XmlElementNames.CompanyName,
      _ContactSchemaFieldUris.CompanyName,
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
  static PropertyDefinition EmailAddresses =
      new ComplexPropertyDefinition<EmailAddressDictionary>.withUriAndFlags(
          XmlElementNames.EmailAddresses,
          _ContactSchemaFieldUris.EmailAddresses,
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
  static PropertyDefinition PhysicalAddresses =
      new ComplexPropertyDefinition<PhysicalAddressDictionary>.withUriAndFlags(
          XmlElementNames.PhysicalAddresses,
          _ContactSchemaFieldUris.PhysicalAddresses,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new PhysicalAddressDictionary();
  });

  /// <summary>
  /// Defines the PhoneNumbers property.
  /// </summary>
  static PropertyDefinition PhoneNumbers =
      new ComplexPropertyDefinition<PhoneNumberDictionary>.withUriAndFlags(
          XmlElementNames.PhoneNumbers,
          _ContactSchemaFieldUris.PhoneNumbers,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new PhoneNumberDictionary();
  });

  /// <summary>
  /// Defines the AssistantName property.
  /// </summary>
  static PropertyDefinition AssistantName = new StringPropertyDefinition(
      XmlElementNames.AssistantName,
      _ContactSchemaFieldUris.AssistantName,
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
  static PropertyDefinition Birthday =
      new DateTimePropertyDefinition.withUriAndFlags(
          XmlElementNames.Birthday,
          _ContactSchemaFieldUris.Birthday,
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
  static PropertyDefinition BusinessHomePage = new StringPropertyDefinition(
      XmlElementNames.BusinessHomePage,
      _ContactSchemaFieldUris.BusinessHomePage,
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
  static PropertyDefinition Children =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.Children,
          _ContactSchemaFieldUris.Children,
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
  static PropertyDefinition Companies =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.Companies,
          _ContactSchemaFieldUris.Companies,
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
  static PropertyDefinition ContactSource =
      new GenericPropertyDefinition<complex.ContactSource>.withUriAndFlags(
          XmlElementNames.ContactSource,
          _ContactSchemaFieldUris.ContactSource,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Department property.
  /// </summary>
  static PropertyDefinition Department = new StringPropertyDefinition(
      XmlElementNames.Department,
      _ContactSchemaFieldUris.Department,
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
  static PropertyDefinition Generation = new StringPropertyDefinition(
      XmlElementNames.Generation,
      _ContactSchemaFieldUris.Generation,
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
  static PropertyDefinition ImAddresses =
      new ComplexPropertyDefinition<ImAddressDictionary>.withUriAndFlags(
          XmlElementNames.ImAddresses,
          _ContactSchemaFieldUris.ImAddresses,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new ImAddressDictionary();
  });

  /// <summary>
  /// Defines the JobTitle property.
  /// </summary>
  static PropertyDefinition JobTitle = new StringPropertyDefinition(
      XmlElementNames.JobTitle,
      _ContactSchemaFieldUris.JobTitle,
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
  static PropertyDefinition Manager = new StringPropertyDefinition(
      XmlElementNames.Manager,
      _ContactSchemaFieldUris.Manager,
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
  static PropertyDefinition Mileage = new StringPropertyDefinition(
      XmlElementNames.Mileage,
      _ContactSchemaFieldUris.Mileage,
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
  static PropertyDefinition OfficeLocation = new StringPropertyDefinition(
      XmlElementNames.OfficeLocation,
      _ContactSchemaFieldUris.OfficeLocation,
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
// static PropertyDefinition PostalAddressIndex =
//            new GenericPropertyDefinition<PhysicalAddressIndex>(
//                XmlElementNames.PostalAddressIndex,
//                ContactSchemaFieldUris.PostalAddressIndex,
//                [PropertyDefinitionFlags.CanSet, PropertyDefinitionFlags.CanUpdate, PropertyDefinitionFlags.CanDelete, PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Profession property.
  /// </summary>
  static PropertyDefinition Profession = new StringPropertyDefinition(
      XmlElementNames.Profession,
      _ContactSchemaFieldUris.Profession,
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
  static PropertyDefinition SpouseName = new StringPropertyDefinition(
      XmlElementNames.SpouseName,
      _ContactSchemaFieldUris.SpouseName,
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
  static PropertyDefinition Surname = new StringPropertyDefinition(
      XmlElementNames.Surname,
      _ContactSchemaFieldUris.Surname,
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
  static PropertyDefinition WeddingAnniversary =
      new DateTimePropertyDefinition.withUriAndFlags(
          XmlElementNames.WeddingAnniversary,
          _ContactSchemaFieldUris.WeddingAnniversary,
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
  static PropertyDefinition HasPicture =
      new BoolPropertyDefinition.withUriAndFlags(
          XmlElementNames.HasPicture,
          _ContactSchemaFieldUris.HasPicture,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010);

  /// <summary>
  /// Defines the PhoneticFullName property.
  /// </summary>
  static PropertyDefinition PhoneticFullName = new StringPropertyDefinition(
      XmlElementNames.PhoneticFullName,
      _ContactSchemaFieldUris.PhoneticFullName,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the PhoneticFirstName property.
  /// </summary>
  static PropertyDefinition PhoneticFirstName = new StringPropertyDefinition(
      XmlElementNames.PhoneticFirstName,
      _ContactSchemaFieldUris.PhoneticFirstName,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the PhoneticLastName property.
  /// </summary>
  static PropertyDefinition PhoneticLastName = new StringPropertyDefinition(
      XmlElementNames.PhoneticLastName,
      _ContactSchemaFieldUris.PhoneticLastName,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the Alias property.
  /// </summary>
  static PropertyDefinition Alias = new StringPropertyDefinition(
      XmlElementNames.Alias,
      _ContactSchemaFieldUris.Alias,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the Notes property.
  /// </summary>
  static PropertyDefinition Notes = new StringPropertyDefinition(
      XmlElementNames.Notes,
      _ContactSchemaFieldUris.Notes,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the Photo property.
  /// </summary>
// static PropertyDefinition Photo =
//            new ByteArrayPropertyDefinition(
//                XmlElementNames.Photo,
//                ContactSchemaFieldUris.Photo,
//                [PropertyDefinitionFlags.CanFind],
//                ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the UserSMIMECertificate property.
  /// </summary>
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
  static PropertyDefinition DirectoryId = new StringPropertyDefinition(
      XmlElementNames.DirectoryId,
      _ContactSchemaFieldUris.DirectoryId,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2010_SP1);

  /// <summary>
  /// Defines the ManagerMailbox property.
  /// </summary>
  static PropertyDefinition ManagerMailbox =
      new ContainedPropertyDefinition<EmailAddress>.withUriAndFlags(
          XmlElementNames.ManagerMailbox,
          _ContactSchemaFieldUris.ManagerMailbox,
          XmlElementNames.Mailbox,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new EmailAddress();
  });

  /// <summary>
  /// Defines the DirectReports property.
  /// </summary>
  static PropertyDefinition DirectReports =
      new ComplexPropertyDefinition<EmailAddressCollection>.withUriAndFlags(
          XmlElementNames.DirectReports,
          _ContactSchemaFieldUris.DirectReports,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2010_SP1, () {
    return new EmailAddressCollection();
  });

  /// <summary>
  /// Defines the EmailAddress1 property.
  /// </summary>
  static IndexedPropertyDefinition EmailAddress1 =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.EmailAddress, "EmailAddress1");

  /// <summary>
  /// Defines the EmailAddress2 property.
  /// </summary>
  static IndexedPropertyDefinition EmailAddress2 =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.EmailAddress, "EmailAddress2");

  /// <summary>
  /// Defines the EmailAddress3 property.
  /// </summary>
  static IndexedPropertyDefinition EmailAddress3 =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.EmailAddress, "EmailAddress3");

  /// <summary>
  /// Defines the ImAddress1 property.
  /// </summary>
  static IndexedPropertyDefinition ImAddress1 = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.ImAddress, "ImAddress1");

  /// <summary>
  /// Defines the ImAddress2 property.
  /// </summary>
  static IndexedPropertyDefinition ImAddress2 = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.ImAddress, "ImAddress2");

  /// <summary>
  /// Defines the ImAddress3 property.
  /// </summary>
  static IndexedPropertyDefinition ImAddress3 = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.ImAddress, "ImAddress3");

  /// <summary>
  /// Defines the AssistentPhone property.
  /// </summary>
  static IndexedPropertyDefinition AssistantPhone =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhoneNumber, "AssistantPhone");

  /// <summary>
  /// Defines the BusinessFax property.
  /// </summary>
  static IndexedPropertyDefinition BusinessFax = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "BusinessFax");

  /// <summary>
  /// Defines the BusinessPhone property.
  /// </summary>
  static IndexedPropertyDefinition BusinessPhone =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhoneNumber, "BusinessPhone");

  /// <summary>
  /// Defines the BusinessPhone2 property.
  /// </summary>
  static IndexedPropertyDefinition BusinessPhone2 =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhoneNumber, "BusinessPhone2");

  /// <summary>
  /// Defines the Callback property.
  /// </summary>
  static IndexedPropertyDefinition Callback = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "Callback");

  /// <summary>
  /// Defines the CarPhone property.
  /// </summary>
  static IndexedPropertyDefinition CarPhone = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "CarPhone");

  /// <summary>
  /// Defines the CompanyMainPhone property.
  /// </summary>
  static IndexedPropertyDefinition CompanyMainPhone =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhoneNumber, "CompanyMainPhone");

  /// <summary>
  /// Defines the HomeFax property.
  /// </summary>
  static IndexedPropertyDefinition HomeFax = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "HomeFax");

  /// <summary>
  /// Defines the HomePhone property.
  /// </summary>
  static IndexedPropertyDefinition HomePhone = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "HomePhone");

  /// <summary>
  /// Defines the HomePhone2 property.
  /// </summary>
  static IndexedPropertyDefinition HomePhone2 = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "HomePhone2");

  /// <summary>
  /// Defines the Isdn property.
  /// </summary>
  static IndexedPropertyDefinition Isdn = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "Isdn");

  /// <summary>
  /// Defines the MobilePhone property.
  /// </summary>
  static IndexedPropertyDefinition MobilePhone = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "MobilePhone");

  /// <summary>
  /// Defines the OtherFax property.
  /// </summary>
  static IndexedPropertyDefinition OtherFax = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "OtherFax");

  /// <summary>
  /// Defines the OtherTelephone property.
  /// </summary>
  static IndexedPropertyDefinition OtherTelephone =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhoneNumber, "OtherTelephone");

  /// <summary>
  /// Defines the Pager property.
  /// </summary>
  static IndexedPropertyDefinition Pager = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "Pager");

  /// <summary>
  /// Defines the PrimaryPhone property.
  /// </summary>
  static IndexedPropertyDefinition PrimaryPhone = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "PrimaryPhone");

  /// <summary>
  /// Defines the RadioPhone property.
  /// </summary>
  static IndexedPropertyDefinition RadioPhone = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "RadioPhone");

  /// <summary>
  /// Defines the Telex property.
  /// </summary>
  static IndexedPropertyDefinition Telex = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "Telex");

  /// <summary>
  /// Defines the TtyTddPhone property.
  /// </summary>
  static IndexedPropertyDefinition TtyTddPhone = new IndexedPropertyDefinition(
      _ContactSchemaFieldUris.PhoneNumber, "TtyTddPhone");

  /// <summary>
  /// Defines the BusinessAddressStreet property.
  /// </summary>
  static IndexedPropertyDefinition BusinessAddressStreet =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressStreet, "Business");

  /// <summary>
  /// Defines the BusinessAddressCity property.
  /// </summary>
  static IndexedPropertyDefinition BusinessAddressCity =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressCity, "Business");

  /// <summary>
  /// Defines the BusinessAddressState property.
  /// </summary>
  static IndexedPropertyDefinition BusinessAddressState =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressState, "Business");

  /// <summary>
  /// Defines the BusinessAddressCountryOrRegion property.
  /// </summary>
  static IndexedPropertyDefinition BusinessAddressCountryOrRegion =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressCountryOrRegion, "Business");

  /// <summary>
  /// Defines the BusinessAddressPostalCode property.
  /// </summary>
  static IndexedPropertyDefinition BusinessAddressPostalCode =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressPostalCode, "Business");

  /// <summary>
  /// Defines the HomeAddressStreet property.
  /// </summary>
  static IndexedPropertyDefinition HomeAddressStreet =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressStreet, "Home");

  /// <summary>
  /// Defines the HomeAddressCity property.
  /// </summary>
  static IndexedPropertyDefinition HomeAddressCity =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressCity, "Home");

  /// <summary>
  /// Defines the HomeAddressState property.
  /// </summary>
  static IndexedPropertyDefinition HomeAddressState =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressState, "Home");

  /// <summary>
  /// Defines the HomeAddressCountryOrRegion property.
  /// </summary>
  static IndexedPropertyDefinition HomeAddressCountryOrRegion =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressCountryOrRegion, "Home");

  /// <summary>
  /// Defines the HomeAddressPostalCode property.
  /// </summary>
  static IndexedPropertyDefinition HomeAddressPostalCode =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressPostalCode, "Home");

  /// <summary>
  /// Defines the OtherAddressStreet property.
  /// </summary>
  static IndexedPropertyDefinition OtherAddressStreet =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressStreet, "Other");

  /// <summary>
  /// Defines the OtherAddressCity property.
  /// </summary>
  static IndexedPropertyDefinition OtherAddressCity =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressCity, "Other");

  /// <summary>
  /// Defines the OtherAddressState property.
  /// </summary>
  static IndexedPropertyDefinition OtherAddressState =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressState, "Other");

  /// <summary>
  /// Defines the OtherAddressCountryOrRegion property.
  /// </summary>
  static IndexedPropertyDefinition OtherAddressCountryOrRegion =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressCountryOrRegion, "Other");

  /// <summary>
  /// Defines the OtherAddressPostalCode property.
  /// </summary>
  static IndexedPropertyDefinition OtherAddressPostalCode =
      new IndexedPropertyDefinition(
          _ContactSchemaFieldUris.PhysicalAddressPostalCode, "Other");

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
    this.RegisterProperty(PhysicalAddresses);
    this.RegisterProperty(PhoneNumbers);
    this.RegisterProperty(AssistantName);
    this.RegisterProperty(Birthday);
    this.RegisterProperty(BusinessHomePage);
    this.RegisterProperty(Children);
    this.RegisterProperty(Companies);
    this.RegisterProperty(ContactSource);
    this.RegisterProperty(Department);
    this.RegisterProperty(Generation);
    this.RegisterProperty(ImAddresses);
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
