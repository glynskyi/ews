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
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart'
    as complex;
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:timezone/timezone.dart';

/// <summary>
/// Represents recurrence range with start and end dates.
/// </summary>
abstract class RecurrenceRange extends ComplexProperty {
  DateTime? _startDate;

  complex.Recurrence? _recurrence;

  /// <summary>
  /// Initializes a new instance of the <see cref="RecurrenceRange"/> class.
  /// </summary>
  RecurrenceRange() : super();

  /// <summary>
  /// Initializes a new instance of the <see cref="RecurrenceRange"/> class.
  /// </summary>
  /// <param name="startDate">The start date.</param>
  RecurrenceRange.withStartDate(this._startDate) : super();

  /// <summary>
  /// Changes handler.
  /// </summary>
  @override
  void Changed() {
    if (this.Recurrence != null) {
      this.Recurrence!.Changed();
    }
  }

  /// <summary>
  /// Setup the recurrence.
  /// </summary>
  /// <param name="recurrence">The recurrence.</param>
  void SetupRecurrence(complex.Recurrence recurrence) {
    recurrence.StartDate = this.StartDate as TZDateTime?;
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types,
        XmlElementNames.StartDate,
        EwsUtilities.DateTimeToXSDate(this.StartDate!));
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  Future<bool> TryReadElementFromXml(EwsServiceXmlReader reader) async {
    switch (reader.LocalName) {
      case XmlElementNames.StartDate:
        DateTime? startDate = await reader.ReadElementValueAsUnspecifiedDate();
        if (startDate != null) {
          this._startDate = startDate;
          return true;
        }

        return false;

      default:
        return false;
    }
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <value>The name of the XML element.</value>
  String get XmlElementName;

  /// <summary>
  /// Gets or sets the recurrence.
  /// </summary>
  /// <value>The recurrence.</value>
  complex.Recurrence? get Recurrence => this._recurrence;

  set Recurrence(complex.Recurrence? value) => this._recurrence = value;

  /// <summary>
  /// Gets or sets the start date.
  /// </summary>
  /// <value>The start date.</value>
  DateTime? get StartDate => this._startDate;

  set StartDate(DateTime? value) {
    if (this.CanSetFieldValue(this._startDate, value)) {
      this._startDate = value;
      Changed();
    }
  }
}
