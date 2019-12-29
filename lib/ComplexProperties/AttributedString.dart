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
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents an attributed string, a String with a value and a list of attributions.
/// </summary>
class AttributedString extends ComplexProperty {
  /// <summary>
  /// attribution store
  /// </summary>
  List<String> _attributionList;

  /// <summary>
  /// String value
  /// </summary>
  String Value;

  /// <summary>
  /// Attribution values
  /// </summary>
  List<String> Attributions;

  /// <summary>
  /// Default constructor
  /// </summary>
  AttributedString() : super() {}

  /// <summary>
  /// Constructor
  /// </summary>
  AttributedString.withValue(String value) : super() {}

  /// <summary>
  /// Constructor
  /// </summary>
  /// <param name="value">String value</param>
  /// <param name="attributions">A list of attributions</param>
  AttributedString.withValueAndAttibutions(
      String value, List<String> attributions)
      : super() {
    EwsUtilities.ValidateParam(value, "value");
    this.Value = value;

    if (attributions == null) {
      throw new ArgumentError.notNull("attributions");
    }

    for (String s in attributions) {
      EwsUtilities.ValidateParam(s, "attributions");
    }

    this.Attributions = attributions;
  }

  /// <summary>
  /// Defines an implicit conversion from a regular String to an attributedString.
  /// </summary>
  /// <param name="value">String value of the attributed String being created</param>
  /// <returns>An attributed String initialized with the specified value</returns>
// static implicit operator AttributedString(String value)
//        {
//            return new AttributedString(value);
//        }

  /// <summary>
  /// Tries to read an attributed String blob represented in XML.
  /// </summary>
  /// <param name="reader">XML reader</param>
  /// <returns>Whether reading succeeded</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.Value:
        this.Value = reader.ReadElementValue();
        return true;
      case XmlElementNames.Attributions:
        return this.LoadAttributionsFromXml(reader);
      default:
        return false;
    }
  }

  /// <summary>
  /// Read attribution blobs from XML
  /// </summary>
  /// <param name="reader">XML reader</param>
  /// <returns>Whether reading succeeded</returns>
  bool LoadAttributionsFromXml(EwsServiceXmlReader reader) {
    if (!reader.IsEmptyElement) {
      String localName = reader.LocalName;
      this._attributionList = new List<String>();

      do {
        reader.Read();
        if (reader.NodeType == XmlNodeType.Element &&
            reader.LocalName == XmlElementNames.Attribution) {
          String s = reader.ReadElementValue();
          if (!StringUtils.IsNullOrEmpty(s)) {
            this._attributionList.add(s);
          }
        }
      } while (
          !reader.IsEndElementWithNamespace(XmlNamespace.Types, localName));
      this.Attributions = this._attributionList.toList();
    }

    return true;
  }
}
