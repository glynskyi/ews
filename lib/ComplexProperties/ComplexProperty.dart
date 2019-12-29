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

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Interfaces/ISelfValidate.dart';
import 'package:ews/Xml/XmlNodeType.dart';

import 'IComplexPropertyChangedDelegate.dart';

typedef bool ReadAction(EwsServiceXmlReader reader);

/// <summary>
/// Represents a property that can be sent to or retrieved from EWS.
/// </summary>
abstract class ComplexProperty implements ISelfValidate {
  XmlNamespace _xmlNamespace = XmlNamespace.Types;

  /// <summary>
  /// Initializes a new instance of the <see cref="ComplexProperty"/> class.
  /// </summary>
  ComplexProperty() {}

  /// <summary>
  /// Gets or sets the namespace.
  /// </summary>
  /// <value>The namespace.</value>
  XmlNamespace get Namespace => this._xmlNamespace;

  set Namespace(XmlNamespace value) => this._xmlNamespace = value;

  /// <summary>
  /// Sets value of field.
  /// </summary>
  /// <typeparam name="T">Field type.</typeparam>
  /// <param name="field">The field.</param>
  /// <param name="value">The value.</param>
  bool CanSetFieldValue<T>(T field, T value) {
    bool applyChange;
    if (field == null) {
      applyChange = value != null;
    } else {
      if (field is Comparable<T>) {
        Comparable<T> c = field;
        applyChange = value != null && c.compareTo(value) != 0;
      } else {
        applyChange = true;
      }
    }
    return applyChange;
  }

  /// <summary>
  /// Clears the change log.
  /// </summary>
  void ClearChangeLog() {}

  /// <summary>
  /// Reads the attributes from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void ReadAttributesFromXml(EwsServiceXmlReader reader) {}

  /// <summary>
  /// Reads the text value from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void ReadTextValueFromXml(EwsServiceXmlReader reader) {}

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    return false;
  }

  /// <summary>
  /// Tries to read element from XML to patch this property.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  bool TryReadElementFromXmlToPatch(EwsServiceXmlReader reader) {
    return false;
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {}

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteElementsToXml(EwsServiceXmlWriter writer) {}

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void LoadFromXmlWithNamespace(EwsServiceXmlReader reader,
      XmlNamespace xmlNamespace, String xmlElementName) {
    this._InternalLoadFromXml(
        reader, xmlNamespace, xmlElementName, this.TryReadElementFromXml);
  }

  /// <summary>
  /// Loads from XML to update itself.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void UpdateFromXmlWithNamespace(EwsServiceXmlReader reader,
      XmlNamespace xmlNamespace, String xmlElementName) {
    this._InternalLoadFromXml(reader, xmlNamespace, xmlElementName,
        this.TryReadElementFromXmlToPatch);
  }

  /// <summary>
  /// Loads from XML
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="readAction"></param>
  void _InternalLoadFromXml(EwsServiceXmlReader reader,
      XmlNamespace xmlNamespace, String xmlElementName, ReadAction readAction) {
    reader.EnsureCurrentNodeIsStartElementWithNamespace(
        xmlNamespace, xmlElementName);

    this.ReadAttributesFromXml(reader);

    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        switch (reader.NodeType) {
          case XmlNodeType.Element:
            if (!readAction(reader)) {
              reader.SkipCurrentElement();
            }
            break;
          case XmlNodeType.Text:
            this.ReadTextValueFromXml(reader);
            break;
          // todo("check other branches")
          case XmlNodeType.None:
          case XmlNodeType.XmlDeclaration:
          case XmlNodeType.EndElement:
            break;
        }
      } while (!reader.IsEndElementWithNamespace(xmlNamespace, xmlElementName));
    }
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void LoadFromXml(EwsServiceXmlReader reader, String xmlElementName) {
    this.LoadFromXmlWithNamespace(reader, this.Namespace, xmlElementName);
  }

  /// <summary>
  /// Loads from XML to update this property.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void UpdateFromXml(EwsServiceXmlReader reader, String xmlElementName) {
    this.UpdateFromXmlWithNamespace(reader, this.Namespace, xmlElementName);
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void WriteToXmlWithNamespace(EwsServiceXmlWriter writer,
      XmlNamespace xmlNamespace, String xmlElementName) {
    writer.WriteStartElement(xmlNamespace, xmlElementName);
    this.WriteAttributesToXml(writer);
    this.WriteElementsToXml(writer);
    writer.WriteEndElement();
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void WriteToXml(EwsServiceXmlWriter writer, String xmlElementName) {
    this.WriteToXmlWithNamespace(writer, this.Namespace, xmlElementName);
  }

  /// <summary>
  /// Occurs when property changed.
  /// </summary>
//        event ComplexPropertyChangedDelegate OnChange;
  List<IComplexPropertyChangedDelegate> OnChangeList = [];

  void addOnChangeEvent(IComplexPropertyChangedDelegate change) {
    OnChangeList.add(change);
  }

  void removeChangeEvent(IComplexPropertyChangedDelegate change) {
    OnChangeList.remove(change);
  }

  /// <summary>
  /// Instance was changed.
  /// </summary>
  Changed() {
    if (OnChangeList.isNotEmpty) {
      for (IComplexPropertyChangedDelegate change in OnChangeList) {
        change(this);
      }
    }
  }

  /// <summary>
  /// Implements ISelfValidate.Validate. Validates this instance.
  /// </summary>
  void Validate() {
    this.InternalValidate();
  }

  /// <summary>
  ///  Validates this instance.
  /// </summary>
  void InternalValidate() {}
}
