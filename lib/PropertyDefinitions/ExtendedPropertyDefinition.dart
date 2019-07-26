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
import 'package:uuid_enhanced/uuid.dart';

/// <summary>
/// Represents the definition of an extended property.
/// </summary>
class ExtendedPropertyDefinition extends PropertyDefinitionBase {
  /* private */
  static const PropertySetFieldName = "PropertySet";

  /* private */
  static const PropertySetIdFieldName = "PropertySetId";

  /* private */
  static const TagFieldName = "Tag";

  /* private */
  static const NameFieldName = "Name";

  /* private */
  static const IdFieldName = "Id";

  /* private */
  static const MapiTypeFieldName = "MapiType";

  /* private */
  DefaultExtendedPropertySet propertySet;

  /* private */
  Uuid propertySetId;

  /* private */
  int tag;

  /* private */
  String name;

  /* private */
  int id;

  /* private */
  MapiPropertyType mapiType;

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition([MapiPropertyType mapiType = MapiPropertyType.String]) : this.mapiType = mapiType;

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="tag">The tag of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withTag(int tag, this.mapiType) {
    if (tag < 0x00 || tag > 0xFF) {
      throw new RangeError.range(tag, 0x00, 0xFF, "tag", "Strings.TagValueIsOutOfRange");
    }
    this.tag = tag;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="propertySet">The extended property set of the extended property.</param>
  /// <param name="name">The name of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withDefaultPropertySetAndName(this.propertySet, this.name, this.mapiType) {
    EwsUtilities.ValidateParam(name, "name");
  }

  /// <summary>
  /// Initializes a new instance of ExtendedPropertyDefinition.
  /// </summary>
  /// <param name="propertySet">The property set of the extended property.</param>
  /// <param name="id">The Id of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withDefaultPropertySetAndId(this.propertySet, this.id, this.mapiType);

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="propertySetId">The property set Id of the extended property.</param>
  /// <param name="name">The name of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withPropertySetIdAndName(this.propertySetId, this.name, this.mapiType) {
    EwsUtilities.ValidateParam(name, "name");

    this.propertySetId = propertySetId;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="propertySetId">The property set Id of the extended property.</param>
  /// <param name="id">The Id of the extended property.</param>
  /// <param name="mapiType">The MAPI type of the extended property.</param>
  ExtendedPropertyDefinition.withPropertySetIdAndId(this.propertySetId, this.id, this.mapiType);

  /// <summary>
  /// Determines whether two specified instances of ExtendedPropertyDefinition are equal.
  /// </summary>
  /// <param name="extPropDef1">First extended property definition.</param>
  /// <param name="extPropDef2">Second extended property definition.</param>
  /// <returns>True if extended property definitions are equal.</returns>
  static bool IsEqualTo(ExtendedPropertyDefinition extPropDef1, ExtendedPropertyDefinition extPropDef2) {
    return identical(extPropDef1, extPropDef2) ||
        (extPropDef1 != null &&
            extPropDef2 != null &&
            extPropDef1.Id == extPropDef2.Id &&
            extPropDef1.MapiType == extPropDef2.MapiType &&
            extPropDef1.Tag == extPropDef2.Tag &&
            extPropDef1.Name == extPropDef2.Name &&
            extPropDef1.PropertySet == extPropDef2.PropertySet &&
            extPropDef1.propertySetId == extPropDef2.propertySetId);
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
    if (this.propertySet != null) {
      writer.WriteAttributeValue(XmlAttributeNames.DistinguishedPropertySetId, this.propertySet);
    }
    if (this.propertySetId != null) {
      writer.WriteAttributeValue(XmlAttributeNames.PropertySetId, this.propertySetId.toString());
    }
    if (this.tag != null) {
      writer.WriteAttributeValue(XmlAttributeNames.PropertyTag, this.tag);
    }
    if (!StringUtils.IsNullOrEmpty(this.name)) {
      writer.WriteAttributeValue(XmlAttributeNames.PropertyName, this.name);
    }
    if (this.id != null) {
      writer.WriteAttributeValue(XmlAttributeNames.PropertyId, this.id);
    }
    writer.WriteAttributeValue(XmlAttributeNames.PropertyType, this.mapiType);
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXml(EwsServiceXmlReader reader) {
    String attributeValue;

    attributeValue = reader.ReadAttributeValue(XmlAttributeNames.DistinguishedPropertySetId);
    if (!StringUtils.IsNullOrEmpty(attributeValue)) {
      this.propertySet = EnumToString.fromString(DefaultExtendedPropertySet.values, attributeValue);
    }

    attributeValue = reader.ReadAttributeValue(XmlAttributeNames.PropertySetId);
    if (!StringUtils.IsNullOrEmpty(attributeValue)) {
      this.propertySetId = Uuid.fromString(attributeValue);
    }

    attributeValue = reader.ReadAttributeValue(XmlAttributeNames.PropertyTag);
    if (!StringUtils.IsNullOrEmpty(attributeValue)) {
      this.tag = int.parse(attributeValue, radix: 16);
    }

    this.name = reader.ReadAttributeValue(XmlAttributeNames.PropertyName);

    attributeValue = reader.ReadAttributeValue(XmlAttributeNames.PropertyId);
    if (!StringUtils.IsNullOrEmpty(attributeValue)) {
      this.id = int.parse(attributeValue);
    }

    this.mapiType = reader.ReadAttributeValue<MapiPropertyType>(XmlAttributeNames.PropertyType);
  }

  /// <summary>
  /// Determines whether two specified instances of ExtendedPropertyDefinition are equal.
  /// </summary>
  /// <param name="extPropDef1">First extended property definition.</param>
  /// <param name="extPropDef2">Second extended property definition.</param>
  /// <returns>True if extended property definitions are equal.</returns>
// static bool operator ==(ExtendedPropertyDefinition extPropDef1, ExtendedPropertyDefinition extPropDef2)
//        {
//            return ExtendedPropertyDefinition.IsEqualTo(extPropDef1, extPropDef2);
//        }

  /// <summary>
  /// Determines whether two specified instances of ExtendedPropertyDefinition are not equal.
  /// </summary>
  /// <param name="extPropDef1">First extended property definition.</param>
  /// <param name="extPropDef2">Second extended property definition.</param>
  /// <returns>True if extended property definitions are equal.</returns>
// static bool operator !=(ExtendedPropertyDefinition extPropDef1, ExtendedPropertyDefinition extPropDef2)
//        {
//            return !ExtendedPropertyDefinition.IsEqualTo(extPropDef1, extPropDef2);
//        }

  /// <summary>
  /// Determines whether a given extended property definition is equal to this extended property definition.
  /// </summary>
  /// <param name="obj">The object to check for equality.</param>
  /// <returns>True if the properties definitions define the same extended property.</returns>
  @override
  bool Equals(Object obj) {
    ExtendedPropertyDefinition propertyDefinition = obj as ExtendedPropertyDefinition;
    return ExtendedPropertyDefinition.IsEqualTo(propertyDefinition, this);
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
    sb.write(FormatField<String>(NameFieldName, this.Name));
    sb.write(FormatField<MapiPropertyType>(MapiTypeFieldName, this.MapiType));
    sb.write(FormatField<int>(IdFieldName, this.Id));
    sb.write(FormatField<DefaultExtendedPropertySet>(PropertySetFieldName, this.PropertySet));
    sb.write(FormatField<Uuid>(PropertySetIdFieldName, this.PropertySetId));
    sb.write(FormatField<int>(TagFieldName, this.Tag));
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
  DefaultExtendedPropertySet get PropertySet => this.propertySet;

  /// <summary>
  /// Gets the property set Id or the extended property.
  /// </summary>
  Uuid get PropertySetId => this.propertySetId;

  /// <summary>
  /// Gets the extended property's tag.
  /// </summary>
  int get Tag => this.tag;

  /// <summary>
  /// Gets the name of the extended property.
  /// </summary>
  String get Name => this.name;

  /// <summary>
  /// Gets the Id of the extended property.
  /// </summary>
  int get Id => this.id;

  /// <summary>
  /// Gets the MAPI type of the extended property.
  /// </summary>
  MapiPropertyType get MapiType => this.mapiType;

  /// <summary>
  /// Gets the property type.
  /// </summary>
  @override
  core.Type get Type => MapiTypeConverter.MapiTypeConverterMap.Member[this.MapiType].Type;
}
