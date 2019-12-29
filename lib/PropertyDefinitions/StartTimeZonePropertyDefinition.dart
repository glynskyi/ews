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

import 'package:ews/ComplexProperties/MeetingTimeZone.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertyBag.dart';
import 'package:ews/Core/ServiceObjects/Schemas/AppointmentSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/TimeZonePropertyDefinition.dart';
import 'package:timezone/standalone.dart';

/// <summary>
/// Represents a property definition for properties of type TimeZoneInfo.
/// </summary>
class StartTimeZonePropertyDefinition extends TimeZonePropertyDefinition {
  /// <summary>
  /// Initializes a new instance of the <see cref="StartTimeZonePropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  StartTimeZonePropertyDefinition(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super(xmlElementName, uri, flags, version) {}

  /// <summary>
  /// Registers associated properties.
  /// </summary>
  /// <param name="properties">The list in which to add the associated properties.</param>
  @override
  void RegisterAssociatedInternalProperties(
      List<PropertyDefinition> properties) {
    super.RegisterAssociatedInternalProperties(properties);

    properties.add(AppointmentSchema.MeetingTimeZone);
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
      if (writer.Service.RequestedServerVersion ==
          ExchangeVersion.Exchange2007_SP1) {
        ExchangeService service = writer.Service as ExchangeService;
        if (service != null && service.Exchange2007CompatibilityMode == false) {
          MeetingTimeZone meetingTimeZone =
              new MeetingTimeZone.fromTimeZone(value as TimeZone);
          meetingTimeZone.WriteToXml(writer, XmlElementNames.MeetingTimeZone);
        }
      } else {
        super.WritePropertyValueToXml(writer, propertyBag, isUpdateOperation);
      }
    }
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteToXml(EwsServiceXmlWriter writer) {
    if (writer.Service.RequestedServerVersion ==
        ExchangeVersion.Exchange2007_SP1) {
      AppointmentSchema.MeetingTimeZone.WriteToXml(writer);
    } else {
      super.WriteToXml(writer);
    }
  }

  /// <summary>
  /// Determines whether the specified flag is set.
  /// </summary>
  /// <param name="flag">The flag.</param>
  /// <param name="version">Requested version.</param>
  /// <returns>
  ///     <c>true</c> if the specified flag is set; otherwise, <c>false</c>.
  /// </returns>
  @override
  bool HasFlag(PropertyDefinitionFlags flag, ExchangeVersion version) {
    if (version != null && (version == ExchangeVersion.Exchange2007_SP1)) {
      return AppointmentSchema.MeetingTimeZone.HasFlag(flag, version);
    } else {
      return super.HasFlag(flag, version);
    }
  }
}
