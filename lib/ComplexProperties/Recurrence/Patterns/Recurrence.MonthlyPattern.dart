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

//    /// <content>
//    /// Contains nested type Recurrence.MonthlyPattern.
//    /// </content>
// abstract partial class Recurrence
//    {
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.IntervalPattern.dart';
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:timezone/standalone.dart';

/// <summary>
/// Represents a recurrence pattern where each occurrence happens on a specific day a specific number of
/// months after the previous one.
/// </summary>
class MonthlyPattern extends IntervalPattern {
  int _dayOfMonth;

  /// <summary>
  /// Initializes a new instance of the <see cref="MonthlyPattern"/> class.
  /// </summary>
  MonthlyPattern() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="MonthlyPattern"/> class.
  /// </summary>
  /// <param name="startDate">The date and time when the recurrence starts.</param>
  /// <param name="interval">The number of months between each occurrence.</param>
  /// <param name="dayOfMonth">The day of the month when each occurrence happens.</param>
  MonthlyPattern.withStartDateAndIntervalAndDayOfMonth(
      TZDateTime startDate, int interval, int dayOfMonth)
      : super.withStartDateAndInterval(startDate, interval) {
    this.DayOfMonth = dayOfMonth;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <value>The name of the XML element.</value>
  @override
  String get XmlElementName => XmlElementNames.AbsoluteMonthlyRecurrence;

  /// <summary>
  /// Write properties to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void InternalWritePropertiesToXml(EwsServiceXmlWriter writer) {
    super.InternalWritePropertiesToXml(writer);

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.DayOfMonth, this.DayOfMonth);
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if appropriate element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    if (super.TryReadElementFromXml(reader)) {
      return true;
    } else {
      switch (reader.LocalName) {
        case XmlElementNames.DayOfMonth:
          this._dayOfMonth = reader.ReadElementValue<int>();
          return true;
        default:
          return false;
      }
    }
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  @override
  void InternalValidate() {
    super.InternalValidate();

    if (this._dayOfMonth == null) {
      throw new ServiceValidationException("Strings.DayOfMonthMustBeBetween1And31");
    }
  }

  /// <summary>
  /// Gets or sets the day of the month when each occurrence happens. DayOfMonth must be between 1 and 31.
  /// </summary>
  int get DayOfMonth => this.GetFieldValueOrThrowIfNull<int>(this._dayOfMonth, "DayOfMonth");

  set DayOfMonth(int value) {
    if (value < 1 || value > 31) {
      throw new RangeError("DayOfMonth Strings.DayOfMonthMustBeBetween1And31");
    }
    if (this.CanSetFieldValue(this._dayOfMonth, value)) {
      this._dayOfMonth = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Checks if two recurrence objects are identical.
  /// </summary>
  /// <param name="otherRecurrence">The recurrence to compare this one to.</param>
  /// <returns>true if the two recurrences are identical, false otherwise.</returns>
  @override
  bool IsSame(Recurrence otherRecurrence) {
    return super.IsSame(otherRecurrence) &&
        this._dayOfMonth == (otherRecurrence as MonthlyPattern)._dayOfMonth;
  }
}
//    }
