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
import 'package:ews/ComplexProperties/TimeChangeRecurrence.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/Time.dart' as misc;
import 'package:ews/misc/TimeSpan.dart';

/// <summary>
/// Represents a change of time for a time zone.
/// </summary>
class TimeChange extends ComplexProperty {
  String _timeZoneName;
  TimeSpan _offset;
  misc.Time _time;
  DateTime _absoluteDate;
  TimeChangeRecurrence _recurrence;

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeChange"/> class.
  /// </summary>
  TimeChange() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeChange"/> class.
  /// </summary>
  /// <param name="offset">The offset since the beginning of the year when the change occurs.</param>
  TimeChange.withOffset(TimeSpan offset) : super() {
    this._offset = offset;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeChange"/> class.
  /// </summary>
  /// <param name="offset">The offset since the beginning of the year when the change occurs.</param>
  /// <param name="time">The time at which the change occurs.</param>
  TimeChange.withOffsetAndTime(TimeSpan offset, misc.Time time) : super() {
    this._offset = offset;
    this._time = time;
  }

  /// <summary>
  /// Gets or sets the name of the associated time zone.
  /// </summary>
  String get TimeZoneName => this._timeZoneName;

  set TimeZoneName(String value) {
    if (this.CanSetFieldValue(this._timeZoneName, value)) {
      this._timeZoneName = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the offset since the beginning of the year when the change occurs.
  /// </summary>
  TimeSpan get Offset => this._offset;

  set Offset(TimeSpan value) {
    if (this.CanSetFieldValue(this._offset, value)) {
      this._offset = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the time at which the change occurs.
  /// </summary>
  misc.Time get Time => this._time;

  set Time(misc.Time value) {
    if (this.CanSetFieldValue(this._time, value)) {
      this._time = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the absolute date at which the change occurs. AbsoluteDate and Recurrence are mutually exclusive; setting one resets the other.
  /// </summary>
  DateTime get AbsoluteDate => this._absoluteDate;

  set AbsoluteDate(DateTime value) {
    if (this.CanSetFieldValue(this._absoluteDate, value)) {
      this._absoluteDate = value;
      this.Changed();
      if (this._absoluteDate != null) {
        this._recurrence = null;
      }
    }
  }

  /// <summary>
  /// Gets or sets the recurrence pattern defining when the change occurs. Recurrence and AbsoluteDate are mutually exclusive; setting one resets the other.
  /// </summary>
  TimeChangeRecurrence get Recurrence => this._recurrence;

  set Recurrence(TimeChangeRecurrence value) {
    if (this.CanSetFieldValue(this._recurrence, value)) {
      this._recurrence = value;
      this.Changed();
      if (this._recurrence != null) {
        this._absoluteDate = null;
      }
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
      case XmlElementNames.Offset:
        this._offset =
            EwsUtilities.XSDurationToTimeSpan(reader.ReadElementValue());
        return true;
      case XmlElementNames.RelativeYearlyRecurrence:
        throw UnimplementedError("XmlElementNames.RelativeYearlyRecurrence");
//                    this.Recurrence = new TimeChangeRecurrence();
//                    this.Recurrence.LoadFromXml(reader, reader.LocalName);
//        return true;
      case XmlElementNames.AbsoluteDate:
        DateTime dateTime = DateTime.parse(reader.ReadElementValue());

        // TODO: BUG
        this._absoluteDate = dateTime;
//                    this.absoluteDate = new DateTime(dateTime.ToUniversalTime().Ticks, DateTimeKind.Unspecified);
        return true;
      case XmlElementNames.Time:
        this._time = new misc.Time.fromDateTime(
            DateTime.parse(reader.ReadElementValue()));
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Reads the attributes from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadAttributesFromXml(EwsServiceXmlReader reader) {
    this._timeZoneName =
        reader.ReadAttributeValue(XmlAttributeNames.TimeZoneName);
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    writer.WriteAttributeValue(
        XmlAttributeNames.TimeZoneName, this.TimeZoneName);
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    if (this.Offset != null) {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types,
          XmlElementNames.Offset,
          EwsUtilities.TimeSpanToXSDuration(this.Offset));
    }

    if (this.Recurrence != null) {
      this
          .Recurrence
          .WriteToXml(writer, XmlElementNames.RelativeYearlyRecurrence);
    }

    if (this.AbsoluteDate != null) {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types,
          XmlElementNames.AbsoluteDate,
          EwsUtilities.DateTimeToXSDate(this.AbsoluteDate));
      // todo : review absolute date conversation
//                    EwsUtilities.DateTimeToXSDate(new DateTime(this.AbsoluteDate.Value.Ticks, DateTimeKind.Unspecified)));
    }

    if (this.Time != null) {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.Time, this.Time.ToXSTime());
    }
  }
}
