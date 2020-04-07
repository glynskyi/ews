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

import 'package:ews/ComplexProperties/DictionaryEntryProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/SimplePropertyBag.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/PhysicalAddressKey.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Schema definition for PhysicalAddress
/// </summary>
class _PhysicalAddressSchema {
  static const String Street = "Street";
  static const String City = "City";
  static const String State = "State";
  static const String CountryOrRegion = "CountryOrRegion";
  static const String PostalCode = "PostalCode";

  /// <summary>
  /// List of XML element names.
  /// </summary>
  static LazyMember<List<String>> _xmlElementNames =
      new LazyMember<List<String>>(() {
    List<String> result = new List<String>();
    result.add(Street);
    result.add(City);
    result.add(State);
    result.add(CountryOrRegion);
    result.add(PostalCode);
    return result;
  });

  /// <summary>
  /// Gets the XML element names.
  /// </summary>
  /// <value>The XML element names.</value>
  static List<String> get XmlElementNames => _xmlElementNames.Member;
}

/// <summary>
/// Represents an entry of an PhysicalAddressDictionary.
/// </summary>
class PhysicalAddressEntry extends DictionaryEntryProperty<PhysicalAddressKey> {
  SimplePropertyBag<String> _propertyBag;

  /// <summary>
  /// Initializes a new instance of PhysicalAddressEntry
  /// </summary>
  PhysicalAddressEntry() : super() {
    this._propertyBag = new SimplePropertyBag<String>();
    this._propertyBag.addOnChangeEvent((bag) => this._PropertyBagChanged());
  }

  /// <summary>
  /// Gets or sets the street.
  /// </summary>
  String get Street => this._propertyBag[_PhysicalAddressSchema.Street];

  set Street(String value) =>
      this._propertyBag[_PhysicalAddressSchema.Street] = value;

  /// <summary>
  /// Gets or sets the city.
  /// </summary>
  String get City => this._propertyBag[_PhysicalAddressSchema.City];

  set City(String value) =>
      this._propertyBag[_PhysicalAddressSchema.City] = value;

  /// <summary>
  /// Gets or sets the state.
  /// </summary>
  String get State => this._propertyBag[_PhysicalAddressSchema.State];

  set State(String value) =>
      this._propertyBag[_PhysicalAddressSchema.State] = value;

  /// <summary>
  /// Gets or sets the country or region.
  /// </summary>
  String get CountryOrRegion =>
      this._propertyBag[_PhysicalAddressSchema.CountryOrRegion];

  set CountryOrRegion(String value) =>
      this._propertyBag[_PhysicalAddressSchema.CountryOrRegion] = value;

  /// <summary>
  /// Gets or sets the postal code.
  /// </summary>
  String get PostalCode => this._propertyBag[_PhysicalAddressSchema.PostalCode];

  set PostalCode(String value) =>
      this._propertyBag[_PhysicalAddressSchema.PostalCode] = value;

  /// <summary>
  /// Clears the change log.
  /// </summary>
  @override
  void ClearChangeLog() {
    this._propertyBag.ClearChangeLog();
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    if (_PhysicalAddressSchema.XmlElementNames.contains(reader.LocalName)) {
      this._propertyBag[reader.LocalName] = reader.ReadElementValue<String>();

      return true;
    } else {
      return false;
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    for (String xmlElementName in _PhysicalAddressSchema.XmlElementNames) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Types, xmlElementName,
          this._propertyBag[xmlElementName]);
    }
  }

  /// <summary>
  /// Writes the update to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsObject">The ews object.</param>
  /// <param name="ownerDictionaryXmlElementName">Name of the owner dictionary XML element.</param>
  /// <returns>True if update XML was written.</returns>
  @override
  bool WriteSetUpdateToXml(EwsServiceXmlWriter writer, ServiceObject ewsObject,
      String ownerDictionaryXmlElementName) {
    List<String> fieldsToSet = new List<String>();

    for (String xmlElementName in this._propertyBag.AddedItems) {
      fieldsToSet.add(xmlElementName);
    }

    for (String xmlElementName in this._propertyBag.ModifiedItems) {
      fieldsToSet.add(xmlElementName);
    }

    for (String xmlElementName in fieldsToSet) {
      writer.WriteStartElement(
          XmlNamespace.Types, ewsObject.GetSetFieldXmlElementName());

      writer.WriteStartElement(
          XmlNamespace.Types, XmlElementNames.IndexedFieldURI);
      writer.WriteAttributeValue(
          XmlAttributeNames.FieldURI, _GetFieldUri(xmlElementName));
      writer.WriteAttributeValue(
          XmlAttributeNames.FieldIndex, this.Key.toString());
      writer.WriteEndElement(); // IndexedFieldURI

      writer.WriteStartElement(
          XmlNamespace.Types, ewsObject.GetXmlElementName());
      writer.WriteStartElement(
          XmlNamespace.Types, ownerDictionaryXmlElementName);
      writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Entry);
      this.WriteAttributesToXml(writer);
      writer.WriteElementValueWithNamespace(XmlNamespace.Types, xmlElementName,
          this._propertyBag[xmlElementName]);
      writer.WriteEndElement(); // Entry
      writer.WriteEndElement(); // ownerDictionaryXmlElementName
      writer.WriteEndElement(); // ewsObject.GetXmlElementName()

      writer.WriteEndElement(); // ewsObject.GetSetFieldXmlElementName()
    }

    for (String xmlElementName in this._propertyBag.RemovedItems) {
      this._InternalWriteDeleteFieldToXml(writer, ewsObject, xmlElementName);
    }

    return true;
  }

  /// <summary>
  /// Writes the delete update to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsObject">The ews object.</param>
  /// <returns>True if update XML was written.</returns>
  @override
  bool WriteDeleteUpdateToXml(
      EwsServiceXmlWriter writer, ServiceObject ewsObject) {
    for (String xmlElementName in _PhysicalAddressSchema.XmlElementNames) {
      this._InternalWriteDeleteFieldToXml(writer, ewsObject, xmlElementName);
    }

    return true;
  }

  /// <summary>
  /// Gets the field URI.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>Field URI.</returns>
  static String _GetFieldUri(String xmlElementName) {
    return "contacts:PhysicalAddress:" + xmlElementName;
  }

  /// <summary>
  /// Property bag was changed.
  /// </summary>
  void _PropertyBagChanged() {
    this.Changed();
  }

  /// <summary>
  /// Write field deletion to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsObject">The ews object.</param>
  /// <param name="fieldXmlElementName">Name of the field XML element.</param>
  void _InternalWriteDeleteFieldToXml(EwsServiceXmlWriter writer,
      ServiceObject ewsObject, String fieldXmlElementName) {
    writer.WriteStartElement(
        XmlNamespace.Types, ewsObject.GetDeleteFieldXmlElementName());
    writer.WriteStartElement(
        XmlNamespace.Types, XmlElementNames.IndexedFieldURI);
    writer.WriteAttributeValue(
        XmlAttributeNames.FieldURI, _GetFieldUri(fieldXmlElementName));
    writer.WriteAttributeValue(
        XmlAttributeNames.FieldIndex, this.Key.toString());
    writer.WriteEndElement(); // IndexedFieldURI
    writer.WriteEndElement(); // ewsObject.GetDeleteFieldXmlElementName()
  }
}
