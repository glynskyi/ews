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

import 'package:ews/ComplexProperties/Attendee.dart';
import 'package:ews/ComplexProperties/ComplexPropertyCollection.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// Represents a collection of attendees.
/// </summary>
class AttendeeCollection extends ComplexPropertyCollection<Attendee> {
  /// <summary>
  /// Initializes a new instance of the <see cref="AttendeeCollection"/> class.
  /// </summary>
  AttendeeCollection() : super() {}

  /// <summary>
  /// Adds an attendee to the collection.
  /// </summary>
  /// <param name="attendee">The attendee to add.</param>
  void Add(Attendee attendee) {
    this.InternalAdd(attendee);
  }

  /// <summary>
  /// Adds a attendee to the collection.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address of the attendee.</param>
  /// <returns>An Attendee instance initialized with the provided SMTP address.</returns>
  Attendee AddWithSmtpAddress(String smtpAddress) {
    Attendee result = new Attendee(smtpAddress: smtpAddress);

    this.InternalAdd(result);

    return result;
  }

  /// <summary>
  /// Adds a attendee to the collection.
  /// </summary>
  /// <param name="name">The name of the attendee.</param>
  /// <param name="smtpAddress">The SMTP address of the attendee.</param>
  /// <returns>An Attendee instance initialized with the provided name and SMTP address.</returns>
  Attendee AddWithNameAndSmtpAddress(String name, String smtpAddress) {
    Attendee result = new Attendee(name: name, smtpAddress: smtpAddress);

    this.InternalAdd(result);

    return result;
  }

  /// <summary>
  /// Clears the collection.
  /// </summary>
  void Clear() {
    this.InternalClear();
  }

  /// <summary>
  /// Removes an attendee from the collection.
  /// </summary>
  /// <param name="index">The index of the attendee to remove.</param>
  void RemoveAt(int index) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.range(
          index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
    }

    this.InternalRemoveAt(index);
  }

  /// <summary>
  /// Removes an attendee from the collection.
  /// </summary>
  /// <param name="attendee">The attendee to remove.</param>
  /// <returns>True if the attendee was successfully removed from the collection, false otherwise.</returns>
  bool Remove(Attendee attendee) {
    EwsUtilities.ValidateParam(attendee, "attendee");

    return this.InternalRemove(attendee);
  }

  /// <summary>
  /// Creates an Attendee object from an XML element name.
  /// </summary>
  /// <param name="xmlElementName">The XML element name from which to create the attendee.</param>
  /// <returns>An Attendee object.</returns>
  @override
  Attendee CreateComplexProperty(String xmlElementName) {
    if (xmlElementName == XmlElementNames.Attendee) {
      return new Attendee();
    } else {
      return null;
    }
  }

  /// <summary>
  /// Retrieves the XML element name corresponding to the provided Attendee object.
  /// </summary>
  /// <param name="attendee">The Attendee object from which to determine the XML element name.</param>
  /// <returns>The XML element name corresponding to the provided Attendee object.</returns>
  @override
  String GetCollectionItemXmlElementName(Attendee attendee) {
    return XmlElementNames.Attendee;
  }
}
