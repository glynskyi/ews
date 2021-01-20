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

import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart';
import 'package:ews/ComplexProperties/Recurrence/Ranges/EndDateRecurrenceRange.dart';
import 'package:ews/ComplexProperties/Recurrence/Ranges/NoEndRecurrenceRange.dart';
import 'package:ews/ComplexProperties/Recurrence/Ranges/NumberedRecurrenceRange.dart';
import 'package:ews/ComplexProperties/Recurrence/Ranges/RecurrenceRange.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/PropertyBag.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceXmlDeserializationException.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represenrs recurrence property definition.
/// </summary>
class RecurrencePropertyDefinition extends PropertyDefinition {
  /// <summary>
  /// Initializes a new instance of the <see cref="RecurrencePropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  RecurrencePropertyDefinition(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUriAndFlags(xmlElementName, uri, flags, version) {}

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertyBag">The property bag.</param>
  @override
  void LoadPropertyValueFromXml(
      EwsServiceXmlReader reader, PropertyBag propertyBag) {
    reader.EnsureCurrentNodeIsStartElementWithNamespace(
        XmlNamespace.Types, XmlElementNames.Recurrence);

    Recurrence? recurrence = null;

    reader.Read(nodeType: XmlNodeType.Element); // This is the pattern element

    recurrence = GetRecurrenceFromString(reader.LocalName);

    recurrence.LoadFromXml(reader, reader.LocalName);

    reader.Read(nodeType: XmlNodeType.Element); // This is the range element

    RecurrenceRange range = GetRecurrenceRange(reader.LocalName);

    range.LoadFromXml(reader, reader.LocalName);
    range.SetupRecurrence(recurrence);

    reader.ReadEndElementIfNecessary(
        XmlNamespace.Types, XmlElementNames.Recurrence);

    propertyBag[this] = recurrence;
  }

  /// <summary>
  /// Gets the recurrence range.
  /// </summary>
  /// <param name="recurrenceRangeString">The recurrence range string.</param>
  /// <returns></returns>
  /* private */
  static RecurrenceRange GetRecurrenceRange(String recurrenceRangeString) {
    RecurrenceRange range;

    switch (recurrenceRangeString) {
      case XmlElementNames.NoEndRecurrence:
        range = new NoEndRecurrenceRange();
        break;
      case XmlElementNames.EndDateRecurrence:
        range = new EndDateRecurrenceRange();
        break;
      case XmlElementNames.NumberedRecurrence:
        range = new NumberedRecurrenceRange();
        break;
      default:
        throw new ServiceXmlDeserializationException(
            "InvalidRecurrenceRange($recurrenceRangeString)");
    }
    return range;
  }

  /// <summary>
  /// Gets the recurrence from string.
  /// </summary>
  /// <param name="recurranceString">The recurrance string.</param>
  /// <returns></returns>
  /* private */
  Recurrence GetRecurrenceFromString(String recurranceString) {
    throw UnimplementedError("GetRecurrenceFromString");
//            Recurrence recurrence = null;
//
//            switch (recurranceString)
//            {
//                case XmlElementNames.RelativeYearlyRecurrence:
//                    recurrence = new Recurrence.RelativeYearlyPattern();
//                    break;
//                case XmlElementNames.AbsoluteYearlyRecurrence:
//                    recurrence = new Recurrence.YearlyPattern();
//                    break;
//                case XmlElementNames.RelativeMonthlyRecurrence:
//                    recurrence = new Recurrence.RelativeMonthlyPattern();
//                    break;
//                case XmlElementNames.AbsoluteMonthlyRecurrence:
//                    recurrence = new Recurrence.MonthlyPattern();
//                    break;
//                case XmlElementNames.DailyRecurrence:
//                    recurrence = new Recurrence.DailyPattern();
//                    break;
//                case XmlElementNames.DailyRegeneration:
//                    recurrence = new Recurrence.DailyRegenerationPattern();
//                    break;
//                case XmlElementNames.WeeklyRecurrence:
//                    recurrence = new Recurrence.WeeklyPattern();
//                    break;
//                case XmlElementNames.WeeklyRegeneration:
//                    recurrence = new Recurrence.WeeklyRegenerationPattern();
//                    break;
//                case XmlElementNames.MonthlyRegeneration:
//                    recurrence = new Recurrence.MonthlyRegenerationPattern();
//                    break;
//                case XmlElementNames.YearlyRegeneration:
//                    recurrence = new Recurrence.YearlyRegenerationPattern();
//                    break;
//                default:
//                    throw new ServiceXmlDeserializationException(string.Format(Strings.InvalidRecurrencePattern, recurranceString));
//            }
//            return recurrence;
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
    Recurrence? value = propertyBag[this] as Recurrence?;

    if (value != null) {
      value.WriteToXml(writer, XmlElementNames.Recurrence);
    }
  }

  /// <summary>
  /// Gets the property type.
  /// </summary>
  @override
  core.Type get Type => Recurrence;
}
