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
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:timezone/standalone.dart';

class NumberedRecurrenceRange extends RecurrenceRange {
  /* private */ int numberOfOccurrences;

  /// <summary>
  /// Initializes a new instance of the <see cref="NumberedRecurrenceRange"/> class.
  /// </summary>
  NumberedRecurrenceRange() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="NumberedRecurrenceRange"/> class.
  /// </summary>
  /// <param name="startDate">The start date.</param>
  /// <param name="numberOfOccurrences">The number of occurrences.</param>
  NumberedRecurrenceRange.withStartDate(
      DateTime startDate, int numberOfOccurrences)
      : super.withStartDate(startDate) {
    this.numberOfOccurrences = numberOfOccurrences;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <value>The name of the XML element.</value>
  @override
  String get XmlElementName => XmlElementNames.NumberedRecurrence;

  /// <summary>
  /// Setups the recurrence.
  /// </summary>
  /// <param name="recurrence">The recurrence.</param>
  @override
  void SetupRecurrence(Recurrence recurrence) {
    super.SetupRecurrence(recurrence);

    recurrence.NumberOfOccurrences = this.NumberOfOccurrences;
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    super.WriteElementsToXml(writer);

    if (this.NumberOfOccurrences != null) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Types,
          XmlElementNames.NumberOfOccurrences, this.NumberOfOccurrences);
    }
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
        case XmlElementNames.NumberOfOccurrences:
          this.numberOfOccurrences = reader.ReadElementValue<int>();
          return true;
        default:
          return false;
      }
    }
  }

  /// <summary>
  /// Gets or sets the number of occurrences.
  /// </summary>
  /// <value>The number of occurrences.</value>
  int get NumberOfOccurrences => this.numberOfOccurrences;

  set NumberOfOccurrences(int value) {
    if (this.CanSetFieldValue(this.numberOfOccurrences, value)) {
      this.numberOfOccurrences = value;
      this.Changed();
    }
  }
}
