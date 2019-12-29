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
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/ServiceObjectPropertyDefinition.dart';

/// <summary>
/// Represents the definition of a folder or item property.
/// </summary>
abstract class PropertyDefinition extends ServiceObjectPropertyDefinition {
  String _xmlElementName;

  List<PropertyDefinitionFlags> _flags;

  String _name;

  ExchangeVersion _version;

  /// <summary>
  /// Initializes a new instance of the <see cref="PropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="version">The version.</param>
  PropertyDefinition.withUri(
      String xmlElementName, String uri, ExchangeVersion version)
      : super.withUri(uri) {
    this._xmlElementName = xmlElementName;
    this._flags = [PropertyDefinitionFlags.None];
    this._version = version;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="PropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  PropertyDefinition.withFlags(String xmlElementName,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super() {
    this._xmlElementName = xmlElementName;
    this._flags = flags;
    this._version = version;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="PropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  PropertyDefinition.withUriAndFlags(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUri(uri) {
    this._xmlElementName = xmlElementName;
    this._flags = flags;
    this._version = version;
  }

  /// <summary>
  /// Determines whether the specified flag is set.
  /// </summary>
  /// <param name="flag">The flag.</param>
  /// <param name="version">Requested version.</param>
  /// <returns>
  ///     <c>true</c> if the specified flag is set; otherwise, <c>false</c>.
  /// </returns>
  bool HasFlag(PropertyDefinitionFlags flag, ExchangeVersion version) {
    return this._flags.contains(flag);
  }

  /// <summary>
  /// Determines whether the specified flag is set.
  /// </summary>
  /// <param name="flag">The flag.</param>
  /// <returns>
  ///     <c>true</c> if the specified flag is set; otherwise, <c>false</c>.
  /// </returns>
  bool HasFlagWithoutExchangeVersion(PropertyDefinitionFlags flag) {
    return this._flags.contains(flag);
  }

  /// <summary>
  /// Registers associated properties.
  /// </summary>
  /// <param name="properties">The list in which to add the associated properties.</param>
  void RegisterAssociatedInternalProperties(
      List<PropertyDefinition> properties) {}

  /// <summary>
  /// Gets a list of associated properties.
  /// </summary>
  /// <returns>A list of PropertyDefinition objects.</returns>
  /// <remarks>
  /// This is a hack. It is here (currently) solely to help the API
  /// register the MeetingTimeZone property definition that is internal.
  /// </remarks>
  List<PropertyDefinition> GetAssociatedInternalProperties() {
    List<PropertyDefinition> properties = new List<PropertyDefinition>();

    this.RegisterAssociatedInternalProperties(properties);

    return properties;
  }

  /// <summary>
  /// Gets the minimum Exchange version that supports this property.
  /// </summary>
  /// <value>The version.</value>
  @override
  ExchangeVersion get Version => this._version;

  /// <summary>
  /// Gets a value indicating whether this property definition is for a nullable type (ref, int?, bool?...).
  /// </summary>
  bool get IsNullable => true;

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyBag">The property bag.</param>
  void LoadPropertyValueFromXml(
      EwsServiceXmlReader reader, PropertyBag propertyBag);

  /// <summary>
  /// Writes the property value to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="propertyBag">The property bag.</param>
  /// <param name="isUpdateOperation">Indicates whether the context is an update operation.</param>
  void WritePropertyValueToXml(EwsServiceXmlWriter writer,
      PropertyBag propertyBag, bool isUpdateOperation);

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <value>The name of the XML element.</value>
  String get XmlElementName => this._xmlElementName;

  /// <summary>
  /// Gets the name of the property.
  /// </summary>
  String get Name {
    if (this._name == null || this._name.isEmpty) {
      ServiceObjectSchema.InitializeSchemaPropertyNames();
    }

    return this._name;
  }

  void set Name(String value) {
    this._name = value;
  }

  /// <summary>
  /// Gets the property definition's printable name.
  /// </summary>
  /// <returns>
  /// The property definition's printable name.
  /// </returns>
  @override
  String GetPrintableName() {
    return this.Name;
  }
}
