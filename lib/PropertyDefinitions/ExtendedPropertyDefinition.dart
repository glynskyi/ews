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

import 'dart:core';
import 'dart:core' as core;

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/DefaultExtendedPropertySet.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/MapiPropertyType.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/misc/MapiTypeConverter.dart';
import 'package:ews/misc/Std/EnumToString.dart';
import 'package:ews/misc/StringUtils.dart';
import 'package:ews/misc/Uuid.dart';

/// <summary>
/// Represents the definition of an extended property.
/// </summary>
class ExtendedPropertyDefinition extends PropertyDefinitionBase {
  static const _PropertySetFieldName = "PropertySet";

  static const _PropertySetIdFieldName = "PropertySetId";

  static const _TagFieldName = "Tag";

  static const _NameFieldName = "Name";

  static const _IdFieldName = "Id";

  static const _MapiTypeFieldName = "MapiType";

  DefaultExtendedPropertySet _propertySet;

  Uuid _propertySetId;

  int _tag;

  String _name;

  int _id;

  MapiPropertyType _mapiType;

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition(
      [MapiPropertyType mapiType = MapiPropertyType.String])
      : this._mapiType = mapiType;

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="tag">The tag of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withTag(int tag, this._mapiType) {
    if (tag < 0x00 || tag > 0xFFFF) {
      throw new RangeError.range(
          tag, 0x00, 0xFFFF, "tag", "Strings.TagValueIsOutOfRange");
    }
    this._tag = tag;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="propertySet">The extended property set of the extended property.</param>
  /// <param name="name">The name of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withDefaultPropertySetAndName(
      this._propertySet, this._name, this._mapiType) {
    EwsUtilities.ValidateParam(_name, "name");
  }

  /// <summary>
  /// Initializes a new instance of ExtendedPropertyDefinition.
  /// </summary>
  /// <param name="propertySet">The property set of the extended property.</param>
  /// <param name="id">The Id of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withDefaultPropertySetAndId(
      this._propertySet, this._id, this._mapiType);

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="propertySetId">The property set Id of the extended property.</param>
  /// <param name="name">The name of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withPropertySetIdAndName(
      this._propertySetId, this._name, this._mapiType) {
    EwsUtilities.ValidateParam(_name, "name");

    this._propertySetId = _propertySetId;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="propertySetId">The property set Id of the extended property.</param>
  /// <param name="id">The Id of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withPropertySetIdAndId(
      this._propertySetId, this._id, this._mapiType);

  /// <summary>
  /// Determines whether two specified instances of ExtendedPropertyDefinition are equal.
  /// </summary>
  /// <param name="extPropDef1">First extended property definition.</param>
  /// <param name="extPropDef2">Second extended property definition.</param>
  /// <returns>True if extended property definitions are equal.</returns>
  static bool IsEqualTo(ExtendedPropertyDefinition extPropDef1,
      ExtendedPropertyDefinition extPropDef2) {
    return identical(extPropDef1, extPropDef2) ||
        (extPropDef1 != null &&
            extPropDef2 != null &&
            extPropDef1.Id == extPropDef2.Id &&
            extPropDef1.MapiType == extPropDef2.MapiType &&
            extPropDef1.Tag == extPropDef2.Tag &&
            extPropDef1.Name == extPropDef2.Name &&
            extPropDef1.PropertySet == extPropDef2.PropertySet &&
            extPropDef1._propertySetId == extPropDef2._propertySetId);
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.ExtendedFieldURI;
  }

  /// <summary>
  /// Gets the minimum Exchange version that supports this extended property.
  /// </summary>
  /// <value>The version.</value>
  @override
  ExchangeVersion get Version => ExchangeVersion.Exchange2007_SP1;

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    if (this._propertySet != null) {
      writer.WriteAttributeValue(
          XmlAttributeNames.DistinguishedPropertySetId, this._propertySet);
    }
    if (this._propertySetId != null) {
      writer.WriteAttributeValue(
          XmlAttributeNames.PropertySetId, this._propertySetId.toString());
    }
    if (this._tag != null) {
      writer.WriteAttributeValue(XmlAttributeNames.PropertyTag, this._tag);
    }
    if (!StringUtils.IsNullOrEmpty(this._name)) {
      writer.WriteAttributeValue(XmlAttributeNames.PropertyName, this._name);
    }
    if (this._id != null) {
      writer.WriteAttributeValue(XmlAttributeNames.PropertyId, this._id);
    }
    writer.WriteAttributeValue(XmlAttributeNames.PropertyType, this._mapiType);
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXml(EwsServiceXmlReader reader) {
    String attributeValue;

    attributeValue =
        reader.ReadAttributeValue(XmlAttributeNames.DistinguishedPropertySetId);
    if (!StringUtils.IsNullOrEmpty(attributeValue)) {
      this._propertySet = EnumToString.fromString(
          DefaultExtendedPropertySet.values, attributeValue);
    }

    attributeValue = reader.ReadAttributeValue(XmlAttributeNames.PropertySetId);
    if (!StringUtils.IsNullOrEmpty(attributeValue)) {
      this._propertySetId = Uuid(attributeValue);
    }

    attributeValue = reader.ReadAttributeValue(XmlAttributeNames.PropertyTag);
    if (!StringUtils.IsNullOrEmpty(attributeValue)) {
      this._tag = int.parse(attributeValue);
    }

    this._name = reader.ReadAttributeValue(XmlAttributeNames.PropertyName);

    attributeValue = reader.ReadAttributeValue(XmlAttributeNames.PropertyId);
    if (!StringUtils.IsNullOrEmpty(attributeValue)) {
      this._id = int.parse(attributeValue);
    }

    this._mapiType = reader.ReadAttributeValue<MapiPropertyType>(
        XmlAttributeNames.PropertyType);
  }

  /// <summary>
  /// Determines whether two specified instances of ExtendedPropertyDefinition are equal.
  /// </summary>
  /// <param name="extPropDef1">First extended property definition.</param>
  /// <param name="extPropDef2">Second extended property definition.</param>
  /// <returns>True if extended property definitions are equal.</returns>
  @override
  bool operator ==(Object other) {
    return other is ExtendedPropertyDefinition &&
        ExtendedPropertyDefinition.IsEqualTo(this, other);
  }

  /// <summary>
  /// Serves as a hash function for a particular type.
  /// </summary>
  /// <returns>
  /// A hash code for the current <see cref="T:System.Object"/>.
  /// </returns>

  @override
  int get hashCode {
    return this.GetPrintableName().hashCode;
  }

  /// <summary>
  /// Gets the property definition's printable name.
  /// </summary>
  /// <returns>
  /// The property definition's printable name.
  /// </returns>
  @override
  String GetPrintableName() {
    StringBuffer sb = new StringBuffer();
    sb.write("{");
    sb.write(FormatField<String>(_NameFieldName, this.Name));
    sb.write(FormatField<MapiPropertyType>(_MapiTypeFieldName, this.MapiType));
    sb.write(FormatField<int>(_IdFieldName, this.Id));
    sb.write(FormatField<DefaultExtendedPropertySet>(
        _PropertySetFieldName, this.PropertySet));
    sb.write(FormatField<Uuid>(_PropertySetIdFieldName, this.PropertySetId));
    sb.write(FormatField<int>(_TagFieldName, this.Tag));
    sb.write("}");
    return sb.toString();
  }

  /// <summary>
  /// Formats the field.
  /// </summary>
  /// <typeparam name="T">Type of field value.</typeparam>
  /// <param name="name">The name.</param>
  /// <param name="fieldValue">The field value.</param>
  /// <returns>Formatted value.</returns>
  String FormatField<T>(String name, T fieldValue) {
    return (fieldValue != null) ? "$name: $fieldValue} " : "";
  }

  /// <summary>
  /// Gets the property set of the extended property.
  /// </summary>
  DefaultExtendedPropertySet get PropertySet => this._propertySet;

  /// <summary>
  /// Gets the property set Id or the extended property.
  /// </summary>
  Uuid get PropertySetId => this._propertySetId;

  /// <summary>
  /// Gets the extended property's tag.
  /// </summary>
  int get Tag => this._tag;

  /// <summary>
  /// Gets the name of the extended property.
  /// </summary>
  String get Name => this._name;

  /// <summary>
  /// Gets the Id of the extended property.
  /// </summary>
  int get Id => this._id;

  /// <summary>
  /// Gets the MAPI type of the extended property.
  /// </summary>
  MapiPropertyType get MapiType => this._mapiType;

  /// <summary>
  /// Gets the property type.
  /// </summary>
  @override
  core.Type get Type =>
      MapiTypeConverter.MapiTypeConverterMap.Member[this.MapiType].Type;
}
