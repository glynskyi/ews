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

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/PropertyBag.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ICreateComplexPropertyDelegate.dart';

/// <summary>
/// Represents contained property definition.
/// </summary>
/// <typeparam name="TComplexProperty">The type of the complex property.</typeparam>
class ContainedPropertyDefinition<TComplexProperty extends ComplexProperty>
    extends ComplexPropertyDefinition<TComplexProperty> {
  /* private */ String containedXmlElementName;

  ContainedPropertyDefinition.withFlags(
      String xmlElementName,
      List<PropertyDefinitionFlags> flags,
      ExchangeVersion version,
      ICreateComplexPropertyDelegate<TComplexProperty> propertyCreationDelegate)
      : super.withFlags(
            xmlElementName, flags, version, propertyCreationDelegate) {
    throw NotImplementedException("ContainedPropertyDefinition.withFlags");
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ContainedPropertyDefinition&lt;TComplexProperty&gt;"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="containedXmlElementName">Name of the contained XML element.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  /// <param name="propertyCreationDelegate">Delegate used to create instances of ComplexProperty.</param>
  ContainedPropertyDefinition.withUriAndFlags(
      String xmlElementName,
      String uri,
      String containedXmlElementName,
      List<PropertyDefinitionFlags> flags,
      ExchangeVersion version,
      ICreateComplexPropertyDelegate<TComplexProperty> propertyCreationDelegate)
      : super.withUriAndFlags(
            xmlElementName, uri, flags, version, propertyCreationDelegate) {
    this.containedXmlElementName = containedXmlElementName;
  }

  /// <summary>
  /// Load from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyBag">The property bag.</param>
  @override
  void InternalLoadFromXml(
      EwsServiceXmlReader reader, PropertyBag propertyBag) {
    reader.ReadStartElementWithNamespace(
        XmlNamespace.Types, this.containedXmlElementName);

    super.InternalLoadFromXml(reader, propertyBag);

    reader.ReadEndElementIfNecessary(
        XmlNamespace.Types, this.containedXmlElementName);
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
    ComplexProperty complexProperty = propertyBag[this];

    if (complexProperty != null) {
      writer.WriteStartElement(XmlNamespace.Types, this.XmlElementName);

      complexProperty.WriteToXml(writer, this.containedXmlElementName);

      writer.WriteEndElement(); // this.XmlElementName
    }
  }
}
