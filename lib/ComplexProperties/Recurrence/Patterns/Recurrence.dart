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
import 'package:ews/ComplexProperties/Recurrence/Ranges/EndDateRecurrenceRange.dart';
import 'package:ews/ComplexProperties/Recurrence/Ranges/NoEndRecurrenceRange.dart';
import 'package:ews/ComplexProperties/Recurrence/Ranges/NumberedRecurrenceRange.dart';
import 'package:ews/ComplexProperties/Recurrence/Ranges/RecurrenceRange.dart' as complex;
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:timezone/standalone.dart';

/// <summary>
/// Represents a recurrence pattern, as used by Appointment and Task items.
/// </summary>
class Recurrence extends ComplexProperty {
  /* private */ TZDateTime startDate;

  /* private */
  int numberOfOccurrences;

  /* private */
  TZDateTime endDate;

  /// <summary>
  /// Initializes a new instance of the <see cref="Recurrence"/> class.
  /// </summary>
  Recurrence() : super();

  /// <summary>
  /// Initializes a new instance of the <see cref="Recurrence"/> class.
  /// </summary>
  /// <param name="startDate">The start date.</param>
  Recurrence.withStartDate(this.startDate) : super();

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <value>The name of the XML element.</value>
  String XmlElementName;

  /// <summary>
  /// Gets a value indicating whether this instance is regeneration pattern.
  /// </summary>
  /// <value>
  ///     <c>true</c> if this instance is regeneration pattern; otherwise, <c>false</c>.
  /// </value>
  bool get IsRegenerationPattern => false;

  /// <summary>
  /// Write properties to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void InternalWritePropertiesToXml(EwsServiceXmlWriter writer) {
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Types, this.XmlElementName);
    this.InternalWritePropertiesToXml(writer);
    writer.WriteEndElement();

    complex.RecurrenceRange range;

    if (!this.HasEnd) {
      range = new NoEndRecurrenceRange.withStartDate(this.StartDate);
    }
    else if (this.NumberOfOccurrences != 0) {
      range = new NumberedRecurrenceRange.withStartDate(
          this.StartDate, this.NumberOfOccurrences);
    }
    else {
      range = new EndDateRecurrenceRange.withStartAndEndDates(
          this.StartDate, this.EndDate);
    }

    range.WriteToXml(writer, range.XmlElementName);
  }

  /// <summary>
  /// Gets a property value or throw if null.
  /// </summary>
  /// <typeparam name="T">Value type.</typeparam>
  /// <param name="value">The value.</param>
  /// <param name="name">The property name.</param>
  /// <returns>Property value</returns>
        T GetFieldValueOrThrowIfNull<T>(T value, String name)
        {
            if (value != null)
            {
                return value;
            }
            else
            {
                throw new ServiceValidationException("""
                                string.Format(Strings.PropertyValueMustBeSpecifiedForRecurrencePattern, name)""");
            }
        }

  /// <summary>
  /// Gets or sets the date and time when the recurrence start.
  /// </summary>
  TZDateTime get StartDate =>
      this.GetFieldValueOrThrowIfNull<DateTime>(this.startDate, "StartDate");

  set StartDate(TZDateTime value) => this.startDate = value;

  /// <summary>
  /// Gets a value indicating whether the pattern has a fixed number of occurrences or an end date.
  /// </summary>
  bool get HasEnd => this.numberOfOccurrences != null || this.endDate != null;

  /// <summary>
  /// Sets up this recurrence so that it never ends. Calling NeverEnds is equivalent to setting both NumberOfOccurrences and EndDate to null.
  /// </summary>
  void NeverEnds() {
    this.numberOfOccurrences = null;
    this.endDate = null;
    this.Changed();
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  @override
  void InternalValidate() {
    super.InternalValidate();

    if (this.startDate == null) {
      throw new ServiceValidationException(
          "Strings.RecurrencePatternMustHaveStartDate");
    }
  }

  /// <summary>
  /// Gets or sets the number of occurrences after which the recurrence ends. Setting NumberOfOccurrences resets EndDate.
  /// </summary>
  int get NumberOfOccurrences => this.numberOfOccurrences;

  set NumberOfOccurrences(int value) {
    if (value < 1) {
      throw new ArgumentError.value(value, "NumberOfOccurrences", "Strings.NumberOfOccurrencesMustBeGreaterThanZero");
    }
    if (this.CanSetFieldValue(this.numberOfOccurrences, value)) {
      this.numberOfOccurrences = value;
      this.endDate = null;
      this.Changed();
    }
  }


  /// <summary>
  /// Gets or sets the date after which the recurrence ends. Setting EndDate resets NumberOfOccurrences.
  /// </summary>
  TZDateTime get EndDate => this.endDate;

  set EndDate(TZDateTime value) {
    if (this.CanSetFieldValue(this.endDate, value)) {
      this.endDate = value;
      this.numberOfOccurrences = null;
      this.Changed();
    }
  }

  /// <summary>
  /// Checks if two recurrence objects are identical.
  /// </summary>
  /// <param name="otherRecurrence">The recurrence to compare this one to.</param>
  /// <returns>true if the two recurrences are identical, false otherwise.</returns>
  bool IsSame(Recurrence otherRecurrence) {
    if (otherRecurrence == null) {
      return false;
    }

    return (this.runtimeType == otherRecurrence.runtimeType &&
        this.numberOfOccurrences == otherRecurrence.numberOfOccurrences &&
        this.endDate == otherRecurrence.endDate &&
        this.startDate == otherRecurrence.startDate);
  }
}
