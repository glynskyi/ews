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
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:uuid_enhanced/uuid.dart';

/// <summary>
/// Represents the retention tag of an item.
/// </summary>
class RetentionTagBase extends ComplexProperty {
  /// <summary>
  /// Xml element name.
  /// </summary>
  final String _xmlElementName;

  /// <summary>
  /// Is explicit.
  /// </summary>
  bool _isExplicit;

  /// <summary>
  /// Retention id.
  /// </summary>
  Uuid _retentionId;

  /// <summary>
  /// Initializes a new instance of the <see cref="RetentionTagBase"/> class.
  /// </summary>
  /// <param name="xmlElementName">Xml element name.</param>
  RetentionTagBase(this._xmlElementName);

  /// <summary>
  /// Gets or sets if the tag is explicit.
  /// </summary>
  bool get IsExplicit => this._isExplicit;

  set IsExplicit(bool value) {
    if (this.CanSetFieldValue(this._isExplicit, value)) {
      this._isExplicit = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the retention id.
  /// </summary>
  Uuid get RetentionId => this._retentionId;

  set RetentionId(Uuid value) {
    if (this.CanSetFieldValue(this._retentionId, value)) {
      this._retentionId = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Reads attributes from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadAttributesFromXml(EwsServiceXmlReader reader) {
    this._isExplicit =
        reader.ReadAttributeValue<bool>(XmlAttributeNames.IsExplicit);
  }

  /// <summary>
  /// Reads text value from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadTextValueFromXml(EwsServiceXmlReader reader) {
    this._retentionId = new Uuid.fromString(reader.ReadValue());
  }

  /// <summary>
  /// Writes attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    writer.WriteAttributeValue(XmlAttributeNames.IsExplicit, this._isExplicit);
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    if (this._retentionId.isNotEmpty) {
      writer.WriteValue(this._retentionId.toString(), this._xmlElementName);
    }
  }

  /// <summary>
  /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  String toString() {
    if (this._retentionId.isEmpty) {
      return "";
    } else {
      return this._retentionId.toString();
    }
  }
}
