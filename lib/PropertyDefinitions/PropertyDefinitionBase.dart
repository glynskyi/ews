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
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/PropertyDefinitions/ExtendedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IndexedPropertyDefinition.dart';
import 'package:ews/misc/OutParam.dart';

/// <summary>
/// Represents the base class for all property definitions.
/// </summary>
/* [Serializable] */
abstract class PropertyDefinitionBase {
  /// <summary>
  /// Initializes a new instance of the <see cref="PropertyDefinitionBase"/> class.
  /// </summary>
  PropertyDefinitionBase() {}

  /// <summary>
  /// Tries to load from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <returns>True if property was loaded.</returns>
  static bool TryLoadFromXml(EwsServiceXmlReader reader,
      OutParam<PropertyDefinitionBase> propertyDefinitionOutParam) {
    switch (reader.LocalName) {
      case XmlElementNames.FieldURI:
        propertyDefinitionOutParam.param =
            ServiceObjectSchema.FindPropertyDefinition(
                reader.ReadAttributeValue(XmlAttributeNames.FieldURI));
        reader.SkipCurrentElement();
        return true;
      case XmlElementNames.IndexedFieldURI:
        propertyDefinitionOutParam.param = new IndexedPropertyDefinition(
            reader.ReadAttributeValue(XmlAttributeNames.FieldURI),
            reader.ReadAttributeValue(XmlAttributeNames.FieldIndex));
        reader.SkipCurrentElement();
        return true;
      case XmlElementNames.ExtendedFieldURI:
        propertyDefinitionOutParam.param = new ExtendedPropertyDefinition();
        (propertyDefinitionOutParam.param as ExtendedPropertyDefinition)
            .LoadFromXml(reader);
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  String GetXmlElementName();

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteAttributesToXml(EwsServiceXmlWriter writer);

  /// <summary>
  /// Gets the minimum Exchange version that supports this property.
  /// </summary>
  /// <value>The version.</value>
  ExchangeVersion get Version;

  /// <summary>
  /// Gets the property definition's printable name.
  /// </summary>
  /// <returns>The property definition's printable name.</returns>
  String GetPrintableName();

  /// <summary>
  /// Gets the type of the property.
  /// </summary>
  core.Type get Type;

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Types, this.GetXmlElementName());
    this.WriteAttributesToXml(writer);
    writer.WriteEndElement();
  }

  /// <summary>
  /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </returns>
  String toString() {
    return this.GetPrintableName();
  }
}
