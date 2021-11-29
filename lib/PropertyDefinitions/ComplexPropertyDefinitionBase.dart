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
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/OutParam.dart';

import 'PropertyDefinition.dart';

/// <summary>
/// Represents abstract complex property definition.
/// </summary>
abstract class ComplexPropertyDefinitionBase extends PropertyDefinition {
  /// <summary>
  /// Initializes a new instance of the <see cref="ComplexPropertyDefinitionBase"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  ComplexPropertyDefinitionBase.withFlags(String xmlElementName,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withFlags(xmlElementName, flags, version);

  /// <summary>
  /// Initializes a new instance of the <see cref="ComplexPropertyDefinitionBase"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="version">The version.</param>
  ComplexPropertyDefinitionBase.withUri(
      String xmlElementName, String uri, ExchangeVersion version)
      : super.withUri(xmlElementName, uri, version);

  /// <summary>
  /// Initializes a new instance of the <see cref="ComplexPropertyDefinitionBase"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  ComplexPropertyDefinitionBase.withUriAndFlags(String xmlElementName,
      String uri, List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUriAndFlags(xmlElementName, uri, flags, version) {}

  /// <summary>
  /// Creates the property instance.
  /// </summary>
  /// <param name="owner">The owner.</param>
  /// <returns>ComplexProperty.</returns>
  ComplexProperty CreatePropertyInstance(ServiceObject? owner);

  /// <summary>
  /// Internals the load from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyBag">The property bag.</param>
  Future<void> InternalLoadFromXml(
      EwsServiceXmlReader reader, PropertyBag propertyBag) async {
    OutParam<Object> complexPropertyOutParam = new OutParam<Object>();

    bool justCreated =
        _GetPropertyInstance(propertyBag, complexPropertyOutParam);

    if (!justCreated &&
        this.HasFlag(PropertyDefinitionFlags.UpdateCollectionItems,
            propertyBag.Owner!.Service.RequestedServerVersion)) {
      await (complexPropertyOutParam.param as ComplexProperty)
          .UpdateFromXml(reader, reader.LocalName);
    } else {
      await (complexPropertyOutParam.param as ComplexProperty)
          .LoadFromXml(reader, reader.LocalName);
    }

    propertyBag[this] = complexPropertyOutParam.param;
  }

  /// <summary>
  /// Gets the property instance.
  /// </summary>
  /// <param name="propertyBag">The property bag.</param>
  /// <param name="complexProperty">The property instance.</param>
  /// <returns>True if the instance is newly created.</returns>
  bool _GetPropertyInstance(
      PropertyBag propertyBag, OutParam<Object> complexPropertyOutParam) {
    if (!propertyBag.TryGetValue(this, complexPropertyOutParam) ||
        !this.HasFlag(PropertyDefinitionFlags.ReuseInstance,
            propertyBag.Owner!.Service.RequestedServerVersion)) {
      complexPropertyOutParam.param =
          this.CreatePropertyInstance(propertyBag.Owner);
      return true;
    }

    return false;
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyBag">The property bag.</param>
  @override
  Future<void> LoadPropertyValueFromXml(
      EwsServiceXmlReader reader, PropertyBag propertyBag) async {
    reader.EnsureCurrentNodeIsStartElementWithNamespace(
        XmlNamespace.Types, this.XmlElementName);

    if (!reader.IsEmptyElement || reader.HasAttributes) {
      await this.InternalLoadFromXml(reader, propertyBag);
    }

    await reader.ReadEndElementIfNecessary(
        XmlNamespace.Types, this.XmlElementName);
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
    ComplexProperty? complexProperty = propertyBag[this] as ComplexProperty?;

    if (complexProperty != null) {
      complexProperty.WriteToXml(writer, this.XmlElementName);
    }
  }
}
