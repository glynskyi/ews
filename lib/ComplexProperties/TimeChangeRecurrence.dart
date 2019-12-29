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
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/DayOfTheWeek.dart' as enumerations;
import 'package:ews/Enumerations/DayOfTheWeekIndex.dart' as enumerations;
import 'package:ews/Enumerations/Month.dart' as enumerations;
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents a recurrence pattern for a time change in a time zone.
/// </summary>
class TimeChangeRecurrence extends ComplexProperty {
  enumerations.DayOfTheWeek _dayOfTheWeek;

  enumerations.DayOfTheWeekIndex _dayOfTheWeekIndex;

  enumerations.Month _month;

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeChangeRecurrence"/> class.
  /// </summary>
  TimeChangeRecurrence() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeChangeRecurrence"/> class.
  /// </summary>
  /// <param name="dayOfTheWeekIndex">The index of the day in the month at which the time change occurs.</param>
  /// <param name="dayOfTheWeek">The day of the week the time change occurs.</param>
  /// <param name="month">The month the time change occurs.</param>
  TimeChangeRecurrence.withDayOfTheWeek(
      enumerations.DayOfTheWeekIndex dayOfTheWeekIndex,
      enumerations.DayOfTheWeek dayOfTheWeek,
      enumerations.Month month)
      : super() {
    this._dayOfTheWeekIndex = dayOfTheWeekIndex;
    this._dayOfTheWeek = dayOfTheWeek;
    this._month = month;
  }

  /// <summary>
  /// Gets or sets the index of the day in the month at which the time change occurs.
  /// </summary>
  enumerations.DayOfTheWeekIndex get DayOfTheWeekIndex =>
      this._dayOfTheWeekIndex;

  set DayOfTheWeekIndex(enumerations.DayOfTheWeekIndex value) {
    if (this.CanSetFieldValue(this._dayOfTheWeekIndex, value)) {
      this._dayOfTheWeekIndex = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the day of the week the time change occurs.
  /// </summary>
  enumerations.DayOfTheWeek get DayOfTheWeek => this._dayOfTheWeek;

  set DayOfTheWeek(enumerations.DayOfTheWeek value) {
    if (this.CanSetFieldValue(this._dayOfTheWeek, value)) {
      this._dayOfTheWeek = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the month the time change occurs.
  /// </summary>
  enumerations.Month get Month => this._month;

  set Month(enumerations.Month value) {
    if (this.CanSetFieldValue(this._month, value)) {
      this._month = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    if (this.DayOfTheWeek != null) {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.DaysOfWeek, this.DayOfTheWeek);
    }

    if (this._dayOfTheWeekIndex != null) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Types,
          XmlElementNames.DayOfWeekIndex, this.DayOfTheWeekIndex);
    }

    if (this.Month != null) {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.Month, this.Month);
    }
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.DaysOfWeek:
        this._dayOfTheWeek =
            reader.ReadElementValue<enumerations.DayOfTheWeek>();
        return true;
      case XmlElementNames.DayOfWeekIndex:
        this._dayOfTheWeekIndex =
            reader.ReadElementValue<enumerations.DayOfTheWeekIndex>();
        return true;
      case XmlElementNames.Month:
        this._month = reader.ReadElementValue<enumerations.Month>();
        return true;
      default:
        return false;
    }
  }
}
