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

import 'package:ews/ComplexProperties/TimeZones/TimeZoneDefinition.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/PropertyBag.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:timezone/standalone.dart';

/// <summary>
/// Represents a property definition for properties of type TimeZoneInfo.
/// </summary>
class TimeZonePropertyDefinition extends PropertyDefinition {
  /// <summary>
  /// Initializes a new instance of the <see cref="TimeZonePropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  TimeZonePropertyDefinition(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUriAndFlags(xmlElementName, uri, flags, version) {}

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyBag">The property bag.</param>
  @override
  Future<void> LoadPropertyValueFromXml(
      EwsServiceXmlReader reader, PropertyBag propertyBag) async {
    TimeZoneDefinition timeZoneDefinition = new TimeZoneDefinition();
    await timeZoneDefinition.LoadFromXml(reader, this.XmlElementName);

    propertyBag[this] = timeZoneDefinition.ToTimeZoneInfo(reader.Service);
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
    TimeZone? value = propertyBag[this] as TimeZone?;

    if (value != null) {
      // We emit time zone properties only if we have not emitted the time zone SOAP header
      // or if this time zone is different from that of the service through which the request
      // is being emitted.
      if (!writer.IsTimeZoneHeaderEmitted || value != writer.Service.TimeZone) {
        TimeZoneDefinition timeZoneDefinition =
            new TimeZoneDefinition.withTimeZone(value);

        timeZoneDefinition.WriteToXml(writer, this.XmlElementName);
      }
    }
  }

  /// <summary>
  /// Gets the property type.
  /// </summary>
  @override
  core.Type get Type => TimeZone;
}
