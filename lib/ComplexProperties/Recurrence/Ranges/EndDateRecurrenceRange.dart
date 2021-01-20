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

import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart';
import 'package:ews/ComplexProperties/Recurrence/Ranges/RecurrenceRange.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:timezone/timezone.dart';

/// <summary>
/// Represents recurrent range with an end date.
/// </summary>
class EndDateRecurrenceRange extends RecurrenceRange {
  /* private */ DateTime? endDate;

  /// <summary>
  /// Initializes a new instance of the <see cref="EndDateRecurrenceRange"/> class.
  /// </summary>
  EndDateRecurrenceRange() : super();

  /// <summary>
  /// Initializes a new instance of the <see cref="EndDateRecurrenceRange"/> class.
  /// </summary>
  /// <param name="startDate">The start date.</param>
  /// <param name="endDate">The end date.</param>
  EndDateRecurrenceRange.withStartAndEndDates(
      DateTime? startDate, DateTime? endDate)
      : super.withStartDate(startDate) {
    this.endDate = endDate;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <value>The name of the XML element.</value>
  @override
  String get XmlElementName => XmlElementNames.EndDateRecurrence;

  /// <summary>
  /// Setups the recurrence.
  /// </summary>
  /// <param name="recurrence">The recurrence.</param>
  @override
  void SetupRecurrence(Recurrence recurrence) {
    super.SetupRecurrence(recurrence);

    recurrence.EndDate = this.EndDate as TZDateTime?;
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    super.WriteElementsToXml(writer);

    writer.WriteElementValueWithNamespace(XmlNamespace.Types,
        XmlElementNames.EndDate, EwsUtilities.DateTimeToXSDate(this.EndDate!));
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    if (super.TryReadElementFromXml(reader)) {
      return true;
    } else {
      switch (reader.LocalName) {
        case XmlElementNames.EndDate:
          this.endDate = reader.ReadElementValueAsDateTime();
          return true;
        default:
          return false;
      }
    }
  }

  /// <summary>
  /// Gets or sets the end date.
  /// </summary>
  /// <value>The end date.</value>
  DateTime? get EndDate => this.endDate;

  set EndDate(DateTime? value) {
    if (this.CanSetFieldValue(this.endDate, value)) {
      this.endDate = value;
      Changed();
    }
  }
}
