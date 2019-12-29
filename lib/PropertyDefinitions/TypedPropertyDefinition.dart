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

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/PropertyBag.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents typed property definition.
/// </summary>
abstract class TypedPropertyDefinition extends PropertyDefinition {
  /* private */
  bool isNullable = false;

  /// <summary>
  /// Initializes a new instance of the <see cref="TypedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="version">The version.</param>
  TypedPropertyDefinition.withUri(
      String xmlElementName, String uri, ExchangeVersion version)
      : super.withUri(xmlElementName, uri, version) {
    this.isNullable = false;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="TypedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  TypedPropertyDefinition.withUriAndFlags(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUriAndFlags(xmlElementName, uri, flags, version);

  /// <summary>
  /// Initializes a new instance of the <see cref="TypedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  /// <param name="isNullable">Indicates that this property definition is for a nullable property.</param>
  TypedPropertyDefinition.withUriAndFlagsAndNullable(
      String xmlElementName,
      String uri,
      List<PropertyDefinitionFlags> flags,
      ExchangeVersion version,
      bool isNullable)
      : super.withUriAndFlags(xmlElementName, uri, flags, version) {
    this.isNullable = isNullable;
  }

  /// <summary>
  /// Parses the specified value.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>Typed value.</returns>
  Object Parse(String value);

  /// <summary>
  /// Gets a value indicating whether this property definition is for a nullable type (ref, int?, bool?...).
  /// </summary>
  @override
  bool get IsNullable => this.isNullable;

  /// <summary>
  /// Convert instance to string.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>String representation of property value.</returns>
  String toStringWithObject(Object value) {
    return value.toString();
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyBag">The property bag.</param>
  @override
  void LoadPropertyValueFromXml(
      EwsServiceXmlReader reader, PropertyBag propertyBag) {
    String value = reader.ReadElementValueWithNamespace(
        XmlNamespace.Types, this.XmlElementName);

    if (!StringUtils.IsNullOrEmpty(value)) {
      propertyBag[this] = this.Parse(value);
    }
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="propertyBag">The property bag.</param>
  /// <param name="isUpdateOperation">Indicates whether the context is an update operation.</param>
  @override
  void WritePropertyValueToXml(EwsServiceXmlWriter writer,
      PropertyBag propertyBag, bool isUpdateOperation) {
    Object value = propertyBag[this];

    if (value != null) {
      writer.WriteElementValue(
          XmlNamespace.Types, this.XmlElementName, this.Name, value);
    }
  }
}
