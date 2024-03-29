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
import 'package:ews/Core/ExchangeServiceBase.dart';
import 'package:ews/Core/PropertyBag.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';

/// <summary>
/// Represents DateTime property definition.
/// </summary>
class DateTimePropertyDefinition extends PropertyDefinition {
  bool _isNullable = false;

  /// <summary>
  /// Initializes a new instance of the <see cref="DateTimePropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="version">The version.</param>
  DateTimePropertyDefinition(
      String xmlElementName, String uri, ExchangeVersion version)
      : super.withUri(xmlElementName, uri, version);

  /// <summary>
  /// Initializes a new instance of the <see cref="DateTimePropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  DateTimePropertyDefinition.withUriAndFlags(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUriAndFlags(xmlElementName, uri, flags, version);

  /// <summary>
  /// Initializes a new instance of the <see cref="DateTimePropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  /// <param name="isNullable">Indicates that this property definition is for a nullable property.</param>
  DateTimePropertyDefinition.withUriAndFlagsANdNullable(
      String xmlElementName,
      String uri,
      List<PropertyDefinitionFlags> flags,
      ExchangeVersion version,
      bool isNullable)
      : super.withUriAndFlags(xmlElementName, uri, flags, version) {
    this._isNullable = isNullable;
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyBag">The property bag.</param>
  @override
  Future<void> LoadPropertyValueFromXml(
      EwsServiceXmlReader reader, PropertyBag propertyBag) async {
    String? value = await reader.ReadElementValueWithNamespace(
        XmlNamespace.Types, this.XmlElementName);

    propertyBag[this] =
        reader.Service.ConvertUniversalDateTimeStringToLocalDateTime(value);
  }

  /// <summary>
  /// Scopes the date time property to the appropriate time zone, if necessary.
  /// </summary>
  /// <param name="service">The service emitting the request.</param>
  /// <param name="dateTime">The date time.</param>
  /// <param name="propertyBag">The property bag.</param>
  /// <param name="isUpdateOperation">Indicates whether the scoping is to be performed in the context of an update operation.</param>
  /// <returns>The converted DateTime.</returns>
  DateTime ScopeToTimeZone(ExchangeServiceBase service, DateTime dateTime,
      PropertyBag propertyBag, bool isUpdateOperation) {
    // todo : unsafe ScopeToTimeZone
    print("!!! using unsafe ScopeToTimeZone");
    return dateTime;
//            try
//            {
//                DateTime convertedDateTime = EwsUtilities.ConvertTime(
//                    dateTime,
//                    service.TimeZone,
//                    TimeZoneInfo.Utc);
//
//                return new DateTime(convertedDateTime.Ticks, DateTimeKind.Utc);
//            }
//            catch (TimeZoneConversionException e)
//            {
//                throw new PropertyException(
//                    string.Format(Strings.InvalidDateTime, dateTime),
//                    this.Name,
//                    e);
//            }
  }

  /// <summary>
  /// Writes the property value to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="propertyBag">The property bag.</param>
  /// <param name="isUpdateOperation">Indicates whether the context is an update operation.</param>
  @override
  void WritePropertyValueToXml(EwsServiceXmlWriter writer,
      PropertyBag propertyBag, bool isUpdateOperation) {
    Object? value = propertyBag[this];

    if (value != null) {
      writer.WriteStartElement(XmlNamespace.Types, this.XmlElementName);

      DateTime convertedDateTime = _GetConvertedDateTime(
          writer.Service, propertyBag, isUpdateOperation, value);

      writer.WriteValue(
          EwsUtilities.DateTimeToXSDateTime(convertedDateTime), this.Name);

      writer.WriteEndElement();
    }
  }

  /// <summary>
  /// Gets the converted date time.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="propertyBag">The property bag.</param>
  /// <param name="isUpdateOperation">if set to <c>true</c> [is update operation].</param>
  /// <param name="value">The value.</param>
  /// <returns></returns>
  DateTime _GetConvertedDateTime(ExchangeServiceBase? service,
      PropertyBag propertyBag, bool isUpdateOperation, Object value) {
    // TODO : fix GetConvertedDateTime
    print(".. used incorect GetConvertedDateTime");
    DateTime dateTime = value as core.DateTime;

    return dateTime;
//            DateTime convertedDateTime;
//
//            // If the date/time is unspecified, we may need to scope it to time zone.
//            if (dateTime.Kind == DateTimeKind.Unspecified)
//            {
//                convertedDateTime = this.ScopeToTimeZone(
//                    service,
//                    (DateTime)value,
//                    propertyBag,
//                    isUpdateOperation);
//            }
//            else
//            {
//                convertedDateTime = dateTime;
//            }
//            return convertedDateTime;
  }

  /// <summary>
  /// Gets a value indicating whether this property definition is for a nullable type (ref, int?, bool?...).
  /// </summary>
  @override
  bool get IsNullable => this._isNullable;

  /// <summary>
  /// Gets the property type.
  /// </summary>
  @override
  core.Type get Type => DateTime;
}
