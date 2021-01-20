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

import 'dart:core';
import 'dart:core' as core;

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/PropertyDefinitions/ServiceObjectPropertyDefinition.dart';

/// <summary>
/// Represents an indexed property definition.
/// </summary>
class IndexedPropertyDefinition extends ServiceObjectPropertyDefinition {
  /// <summary>
  /// Index attribute of IndexedFieldURI element.
  /// </summary>
  /* private */ String? index;

  /// <summary>
  /// Initializes a new instance of the <see cref="IndexedPropertyDefinition"/> class.
  /// </summary>
  /// <param name="uri">The FieldURI attribute of the IndexedFieldURI element.</param>
  /// <param name="index">The Index attribute of the IndexedFieldURI element.</param>
  IndexedPropertyDefinition(String? uri, String? index) : super.withUri(uri) {
    this.index = index;
  }

  /// <summary>
  /// Determines whether two specified instances of IndexedPropertyDefinition are equal.
  /// </summary>
  /// <param name="idxPropDef1">First indexed property definition.</param>
  /// <param name="idxPropDef2">Second indexed property definition.</param>
  /// <returns>True if indexed property definitions are equal.</returns>
  static bool IsEqualTo(IndexedPropertyDefinition idxPropDef1,
      IndexedPropertyDefinition idxPropDef2) {
    return identical(idxPropDef1, idxPropDef2) ||
        (idxPropDef1 != null &&
            idxPropDef2 != null &&
            idxPropDef1.Uri == idxPropDef2.Uri &&
            idxPropDef1.Index == idxPropDef2.Index);
  }

  /// <summary>
  /// Gets the index of the property.
  /// </summary>
  String? get Index => this.index;

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    writer.WriteAttributeValue(XmlAttributeNames.FieldIndex, this.Index);
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.IndexedFieldURI;
  }

  /// <summary>
  /// Gets the property definition's printable name.
  /// </summary>
  /// <returns>
  /// The property definition's printable name.
  /// </returns>
  @override
  String GetPrintableName() {
    return "${this.Uri}:${this.Index}";
  }

  /// <summary>
  /// Determines whether two specified instances of IndexedPropertyDefinition are equal.
  /// </summary>
  /// <param name="idxPropDef1">First indexed property definition.</param>
  /// <param name="idxPropDef2">Second indexed property definition.</param>
  /// <returns>True if indexed property definitions are equal.</returns>
  bool operator ==(other) {
    return other is IndexedPropertyDefinition && IsEqualTo(this, other);
  }

  @override
  int get hashCode {
    return this.Uri.hashCode ^ this.Index.hashCode;
  }

  /// <summary>
  /// Gets the property type.
  /// </summary>
  @override
  core.Type get Type => String;
}
