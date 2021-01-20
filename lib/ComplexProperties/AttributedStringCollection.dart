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

import 'package:ews/ComplexProperties/AttributedString.dart';
import 'package:ews/ComplexProperties/ComplexPropertyCollection.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// Represents a collection of attributed strings
/// </summary>
class AttributedStringCollection
    extends ComplexPropertyCollection<AttributedString> {
  /// <summary>
  /// Collection parent XML element name
  /// </summary>
  String? _collectionItemXmlElementName;

  /// <summary>
  /// Creates a new instance of the <see cref="AttributedStringCollection"/> class.
  /// </summary>
  AttributedStringCollection()
      : this.withElementName(XmlElementNames.StringAttributedValue);

  /// <summary>
  /// Creates a new instance of the <see cref="AttributedStringCollection"/> class.
  /// </summary>
  /// <param name="collectionItemXmlElementName">Name of the collection item XML element.</param>
  AttributedStringCollection.withElementName(
      String collectionItemXmlElementName)
      : super() {
    EwsUtilities.ValidateParam(
        collectionItemXmlElementName, "collectionItemXmlElementName");
    this._collectionItemXmlElementName = collectionItemXmlElementName;
  }

  /// <summary>
  /// Adds an attributed String to the collection.
  /// </summary>
  /// <param name="attributedString">Attributed String to be added</param>
  void Add(AttributedString attributedString) {
    this.InternalAdd(attributedString);
  }

  /// <summary>
  /// Adds multiple attributed strings to the collection.
  /// </summary>
  /// <param name="attributedStrings">Attributed strings to be added</param>
  void AddRange(Iterable<AttributedString> attributedStrings) {
    if (attributedStrings != null) {
      for (AttributedString attributedString in attributedStrings) {
        this.Add(attributedString);
      }
    }
  }

  /// <summary>
  /// Adds an attributed String to the collection.
  /// </summary>
  /// <param name="stringValue">The SMTP address used to initialize the e-mail address.</param>
  /// <returns>An AttributedString object initialized with the provided SMTP address.</returns>
  AttributedString AddValue(String stringValue) {
    AttributedString attributedString =
        new AttributedString.withValue(stringValue);

    this.Add(attributedString);

    return attributedString;
  }

  /// <summary>
  /// Adds a String value and list of attributions
  /// </summary>
  /// <param name="stringValue">String value of the attributed String being added</param>
  /// <param name="attributions">Attributions of the attributed String being added</param>
  /// <returns>The added attributedString object</returns>
  AttributedString AddValueWithAttributions(
      String stringValue, List<String> attributions) {
    AttributedString attributedString =
        new AttributedString.withValueAndAttibutions(stringValue, attributions);

    this.Add(attributedString);

    return attributedString;
  }

  /// <summary>
  /// Clears the collection.
  /// </summary>
  void Clear() {
    this.InternalClear();
  }

  /// <summary>
  /// Removes an attributed String from the collection.
  /// </summary>
  /// <param name="attributedString">Attributed String to be removed</param>
  /// <returns>Whether succeeded</returns>
  bool Remove(AttributedString attributedString) {
    EwsUtilities.ValidateParam(attributedString, "attributedString");

    return this.InternalRemove(attributedString);
  }

  /// <summary>
  /// Creates an AttributedString object from an XML element name.
  /// </summary>
  /// <param name="xmlElementName">The XML element name from which to create the attributed String object</param>
  /// <returns>An AttributedString object</returns>
  @override
  AttributedString? CreateComplexProperty(String xmlElementName) {
    EwsUtilities.ValidateParam(xmlElementName, "xmlElementName");
    if (xmlElementName == this._collectionItemXmlElementName) {
      return new AttributedString();
    } else {
      return null;
    }
  }

  /// <summary>
  /// Retrieves the XML element name corresponding to the provided AttributedString object.
  /// </summary>
  /// <param name="attributedString">The AttributedString object from which to determine the XML element name.</param>
  /// <returns>The XML element name corresponding to the provided AttributedString object.</returns>
  @override
  String? GetCollectionItemXmlElementName(AttributedString attributedString) {
    return this._collectionItemXmlElementName;
  }

  /// <summary>
  /// Determine whether we should write collection to XML or not.
  /// </summary>
  /// <returns>Always true, even if the collection is empty.</returns>
  @override
  bool ShouldWriteToRequest() {
    return true;
  }
}
