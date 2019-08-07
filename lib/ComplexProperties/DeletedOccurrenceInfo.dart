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
import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// Encapsulates information on the deleted occurrence of a recurring appointment.
/// </summary>
class DeletedOccurrenceInfo extends ComplexProperty {
  /// <summary>
  /// The original start date and time of the deleted occurrence.
  /// </summary>
  /// <remarks>
  /// The EWS schema contains a Start property for deleted occurrences but it's
  /// really the original start date and time of the occurrence.
  /// </remarks>
  DateTime _originalStart;

  /// <summary>
  /// Initializes a new instance of the <see cref="DeletedOccurrenceInfo"/> class.
  /// </summary>
  DeletedOccurrenceInfo() {}

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.Start:
        this._originalStart = reader.ReadElementValueAsDateTime();
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Gets the original start date and time of the deleted occurrence.
  /// </summary>
  DateTime get OriginalStart => this._originalStart;
}
