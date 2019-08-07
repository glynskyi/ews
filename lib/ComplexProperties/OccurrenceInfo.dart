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
import 'package:ews/ComplexProperties/ItemId.dart' as complex;
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// Encapsulates information on the occurrence of a recurring appointment.
/// </summary>
class OccurrenceInfo extends ComplexProperty {
  complex.ItemId _itemId;

  DateTime _start;

  DateTime _end;

  DateTime _originalStart;

  /// <summary>
  /// Initializes a new instance of the <see cref="OccurrenceInfo"/> class.
  /// </summary>
  OccurrenceInfo() {}

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.ItemId:
        this._itemId = new complex.ItemId();
        this._itemId.LoadFromXml(reader, reader.LocalName);
        return true;
      case XmlElementNames.Start:
        this._start = reader.ReadElementValueAsDateTime();
        return true;
      case XmlElementNames.End:
        this._end = reader.ReadElementValueAsDateTime();
        return true;
      case XmlElementNames.OriginalStart:
        this._originalStart = reader.ReadElementValueAsDateTime();
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Gets the Id of the occurrence.
  /// </summary>
  complex.ItemId get ItemId => this._itemId;

  /// <summary>
  /// Gets the start date and time of the occurrence.
  /// </summary>
  DateTime get Start => this._start;

  /// <summary>
  /// Gets the end date and time of the occurrence.
  /// </summary>
  DateTime get End => this._end;

  /// <summary>
  /// Gets the original start date and time of the occurrence.
  /// </summary>
  DateTime get OriginalStart => this._originalStart;
}
