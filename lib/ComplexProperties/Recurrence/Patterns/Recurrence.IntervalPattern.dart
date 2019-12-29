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
//    /// Contains nested type Recurrence.IntervalPattern.
//    /// </content>
// abstract partial class Recurrence
//    {
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:timezone/standalone.dart';

/// <summary>
/// Represents a recurrence pattern where each occurrence happens at a specific interval after the previous one.
/// </summary>
abstract class IntervalPattern extends Recurrence {
  int _interval = 1;

  /// <summary>
  /// Initializes a new instance of the <see cref="IntervalPattern"/> class.
  /// </summary>
  IntervalPattern() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="IntervalPattern"/> class.
  /// </summary>
  /// <param name="startDate">The start date.</param>
  /// <param name="interval">The interval.</param>
  IntervalPattern.withStartDateAndInterval(TZDateTime startDate, int interval)
      : super.withStartDate(startDate) {
    if (interval < 1) {
      throw new RangeError(
          "interval is Strings.IntervalMustBeGreaterOrEqualToOne");
    }

    this.Interval = interval;
  }

  /// <summary>
  /// Write properties to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void InternalWritePropertiesToXml(EwsServiceXmlWriter writer) {
    super.InternalWritePropertiesToXml(writer);

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Interval, this.Interval);
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
        case XmlElementNames.Interval:
          this._interval = reader.ReadElementValue<int>();
          return true;
        default:
          return false;
      }
    }
  }

  /// <summary>
  /// Gets or sets the interval between occurrences.
  /// </summary>
  int get Interval => this._interval;

  set Interval(int value) {
    if (value < 1) {
      throw new ArgumentError("Strings.IntervalMustBeGreaterOrEqualToOne");
    }
    if (this.CanSetFieldValue(this._interval, value)) {
      this._interval = value;
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
        this._interval == (otherRecurrence as IntervalPattern)._interval;
  }
}
//    }
