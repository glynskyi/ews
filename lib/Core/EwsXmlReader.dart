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

import 'dart:convert';
import 'dart:typed_data';

import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceXmlDeserializationException.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/Xml/XmlReader.dart';
import 'package:ews/misc/OutParam.dart';

/// <summary>
/// XML reader.
/// </summary>
class EwsXmlReader {
  static const int _ReadWriteBufferSize = 4096;

  XmlNodeType _prevNodeType = XmlNodeType.None;
  XmlReader _xmlReader;

  /// <summary>
  /// Initializes a new instance of the <see cref="EwsXmlReader"/> class.
  /// </summary>
  /// <param name="stream">The stream.</param>
  EwsXmlReader(this._xmlReader);

  /// <summary>
  /// Initializes the XML reader.
  /// </summary>
  /// <param name="stream">The stream.</param>
  /// <returns>An XML reader to use.</returns>
  static Future<XmlReader> InitializeXmlReader(Stream stream) async {
    // The ProhibitDtd property is used to indicate whether XmlReader should process DTDs or not. By default,
    // it will do so. EWS doesn't use DTD references so we want to turn this off. Also, the XmlResolver property is
    // set to an instance of XmlUrlResolver by default. We don't want XmlTextReader to try to resolve this DTD reference
    // so we disable the XmlResolver as well.
    // todo("restore xml settings")
//            XmlReaderSettings settings = new XmlReaderSettings()
//            {
//                ConformanceLevel = ConformanceLevel.Auto,
//                ProhibitDtd = true,
//                IgnoreComments = true,
//                IgnoreProcessingInstructions = true,
//                IgnoreWhitespace = true,
//                XmlResolver = null
//            };
//
//            XmlTextReader xmlTextReader = SafeXmlFactory.CreateSafeXmlTextReader(stream);
//            xmlTextReader.Normalization = false;

//            return XmlReader.Create(xmlTextReader, settings);
    return await XmlReader.Create(stream);
  }

  /// <summary>
  /// Formats the name of the element.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localElementName">Name of the local element.</param>
  /// <returns>Element name.</returns>
  /* private */
  static String FormatElementName(String namespacePrefix, String localElementName) {
    return namespacePrefix == null || namespacePrefix.isEmpty
        ? localElementName
        : namespacePrefix + ":" + localElementName;
  }

  /// <summary>
  /// Read XML element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  /// <param name="nodeType">Type of the node.</param>
  /* private */
  void InternalReadElementWithNamespace(
      XmlNamespace xmlNamespace, String localName, XmlNodeType nodeType) {
    if (xmlNamespace == XmlNamespace.NotSpecified) {
      this._InternalReadElement("", localName, nodeType);
    } else {
      this.Read(nodeType: nodeType);

      if ((this.LocalName != localName) ||
          (this.NamespaceUri != EwsUtilities.GetNamespaceUri(xmlNamespace))) {
        throw new ServiceXmlDeserializationException("""string.Format(
                            Strings.UnexpectedElement,
                            ${EwsUtilities.GetNamespacePrefix(xmlNamespace)},
                            $localName,
                            $nodeType,
                            ${this._xmlReader.Name},
                            ${this.NodeType})""");
      }
    }
  }

  /// <summary>
  /// Read XML element.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localName">Name of the local.</param>
  /// <param name="nodeType">Type of the node.</param>
  void _InternalReadElement(String namespacePrefix, String localName, XmlNodeType nodeType) {
    this.Read(nodeType: nodeType);

    if ((this.LocalName != localName) || (this.NamespacePrefix != namespacePrefix)) {
      throw new ServiceXmlDeserializationException("""string.Format(
                                    Strings.UnexpectedElement,
                                    namespacePrefix,
                                    localName,
                                    nodeType,
                                    this.xmlReader.Name,
                                    this.NodeType)""");
    }
  }

  /// <summary>
  /// Reads the next node.
  /// </summary>
  void Read({XmlNodeType nodeType = null}) {
    this._prevNodeType = this._xmlReader.NodeType;

    // XmlReader.Read returns true if the next node was read successfully; false if there
    // are no more nodes to read. The caller to EwsXmlReader.Read expects that there's another node to
    // read. Throw an exception if not true.
    bool nodeRead = this._xmlReader.Read();
    if (!nodeRead) {
      throw new ServiceXmlDeserializationException("Strings.UnexpectedEndOfXmlDocument");
    }
    if (nodeType != null && this.NodeType != nodeType) {
      throw new ServiceXmlDeserializationException("""string.Format(
                        Strings.UnexpectedElementType,
                        nodeType,
                        this.NodeType)""");
    }
  }

  /// <summary>
  /// Reads the attribute value.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="attributeName">Name of the attribute.</param>
  /// <returns>Attribute value.</returns>
  String ReadAttributeValueWithNamespace(XmlNamespace xmlNamespace, String attributeName) {
    if (xmlNamespace == XmlNamespace.NotSpecified) {
      return this.ReadAttributeValue(attributeName);
    } else {
      return this
          ._xmlReader
          .GetAttributeWithNamespace(attributeName, EwsUtilities.GetNamespaceUri(xmlNamespace));
    }
  }

  /// <summary>
  /// Reads the attribute value.
  /// </summary>
  /// <param name="attributeName">Name of the attribute.</param>
  /// <returns>Attribute value.</returns>
  String ReadAttributeStringValue(String attributeName) {
    return this._xmlReader.GetAttribute(attributeName);
  }

  /// <summary>
  /// Reads the attribute value.
  /// </summary>
  /// <typeparam name="T">Type of attribute value.</typeparam>
  /// <param name="attributeName">Name of the attribute.</param>
  /// <returns>Attribute value.</returns>
  T ReadAttributeValue<T>(String attributeName) {
    return EwsUtilities.Parse<T>(this.ReadAttributeStringValue(attributeName));
  }

  /// <summary>
  /// Reads a nullable attribute value.
  /// </summary>
  /// <typeparam name="T">Type of attribute value.</typeparam>
  /// <param name="attributeName">Name of the attribute.</param>
  /// <returns>Attribute value.</returns>
  T ReadNullableAttributeValue<T>(String attributeName) {
    String attributeValue = this.ReadAttributeValue(attributeName);
    if (attributeValue == null) {
      return null;
    } else {
      return EwsUtilities.Parse<T>(attributeValue);
    }
  }

  /// <summary>
  /// Reads the element value.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localName">Name of the local.</param>
  /// <returns>Element value.</returns>
  String ReadElementStringValueWithPrefix(String namespacePrefix, String localName) {
    if (!this.IsStartElementWithPrefix(namespacePrefix, localName)) {
      this.ReadStartElement(namespacePrefix, localName);
    }

    String value = null;

    if (!this.IsEmptyElement) {
      value = this.ReadValue();
    }

    return value;
  }

  /// <summary>
  /// Reads the element value.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  /// <returns>Element value.</returns>
  String ReadElementStringValueWithNamespace(XmlNamespace xmlNamespace, String localName) {
    if (!this.IsStartElementWithNamespace(xmlNamespace, localName)) {
      this.ReadStartElementWithNamespace(xmlNamespace, localName);
    }

    String value = null;

    if (!this.IsEmptyElement) {
      value = this.ReadValue();
    }

    return value;
  }

  /// <summary>
  /// Reads the element value.
  /// </summary>
  /// <returns>Element value.</returns>
  String ReadElementStringValue() {
    this.EnsureCurrentNodeIsStartElement();

    return this.ReadElementStringValueWithPrefix(this.NamespacePrefix, this.LocalName);
  }

  /// <summary>
  /// Reads the element value.
  /// </summary>
  /// <typeparam name="T">Type of element value.</typeparam>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  /// <returns>Element value.</returns>
  T ReadElementValueWithNamespace<T>(XmlNamespace xmlNamespace, String localName) {
    if (!this.IsStartElementWithNamespace(xmlNamespace, localName)) {
      this.ReadStartElementWithNamespace(xmlNamespace, localName);
    }

    T value = null;

    if (!this.IsEmptyElement) {
      value = this.ReadValue<T>();
    }

    return value;
  }

  /// <summary>
  /// Reads the element value.
  /// </summary>
  /// <typeparam name="T">Type of element value.</typeparam>
  /// <returns>Element value.</returns>
  T ReadElementValue<T>() {
    this.EnsureCurrentNodeIsStartElement();

    String namespacePrefix = this.NamespacePrefix;
    String localName = this.LocalName;

    T value = null;

    if (!this.IsEmptyElement) {
      value = this.ReadValue<T>();
    }

    return value;
  }

  /// <summary>
  /// Reads the value.
  /// </summary>
  /// <returns>Value</returns>
  String ReadStringValue() {
    return this._xmlReader.ReadString();
  }

  /// <summary>
  /// Tries to read value.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>True if value was read.</returns>
  bool TryReadValue(OutParam<String> value) {
    if (!this.IsEmptyElement) {
      this.Read();

      if (this.NodeType == XmlNodeType.Text) {
        value.param = this._xmlReader.Value;
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// <summary>
  /// Reads the value.
  /// </summary>
  /// <typeparam name="T">Type of value.</typeparam>
  /// <returns>Value.</returns>
  T ReadValue<T>() {
    return EwsUtilities.Parse<T>(this.ReadStringValue());
  }

  /// <summary>
  /// Reads the base64 element value.
  /// </summary>
  /// <returns>Byte array.</returns>
  Uint8List ReadBase64ElementValue() {
    this.EnsureCurrentNodeIsStartElement();

    final content = this._xmlReader.ReadString();
    return base64.decode(content);

    // todo : check base64 reading

//          // Can use MemoryStream.GetBuffer() if the buffer's capacity and the number of bytes read
//          // are identical. Otherwise need to convert to byte array that's the size of the number of bytes read.
//          return (memoryStream.Length == memoryStream.Capacity) ? memoryStream.GetBuffer() : memoryStream.ToArray();

//          memoryStream.Close();
  }

  /// <summary>
  /// Reads the base64 element value.
  /// </summary>
  /// <param name="outputStream">The output stream.</param>
  void ReadBase64ElementValueWithStream(Stream outputStream) {
    throw UnimplementedError("ReadBase64ElementValueWithStream");
//            this.EnsureCurrentNodeIsStartElement();
//
//            Uint8List buffer = new byte[ReadWriteBufferSize];
//            int bytesRead;
//
//            do
//            {
//                bytesRead = this.xmlReader.ReadElementContentAsBase64(buffer, 0, ReadWriteBufferSize);
//
//                if (bytesRead > 0)
//                {
//                    outputStream.Write(buffer, 0, bytesRead);
//                }
//            }
//            while (bytesRead > 0);
//
//            outputStream.Flush();
  }

  /// <summary>
  /// Reads the start element.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localName">Name of the local.</param>
  void ReadStartElement(String namespacePrefix, String localName) {
    this._InternalReadElement(namespacePrefix, localName, XmlNodeType.Element);
  }

  /// <summary>
  /// Reads the start element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  void ReadStartElementWithNamespace(XmlNamespace xmlNamespace, String localName) {
    this.InternalReadElementWithNamespace(xmlNamespace, localName, XmlNodeType.Element);
  }

  /// <summary>
  /// Reads the end element.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="elementName">Name of the element.</param>
  void ReadEndElementWithPrefix(String namespacePrefix, String elementName) {
    this._InternalReadElement(namespacePrefix, elementName, XmlNodeType.EndElement);
  }

  /// <summary>
  /// Reads the end element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  void ReadEndElementWithNamespace(XmlNamespace xmlNamespace, String localName) {
    this.InternalReadElementWithNamespace(xmlNamespace, localName, XmlNodeType.EndElement);
  }

  /// <summary>
  /// Reads the end element if necessary.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  void ReadEndElementIfNecessary(XmlNamespace xmlNamespace, String localName) {
    if (!(this.IsStartElementWithNamespace(xmlNamespace, localName) && this.IsEmptyElement)) {
      if (!this.IsEndElementWithNamespace(xmlNamespace, localName)) {
        this.ReadEndElementWithNamespace(xmlNamespace, localName);
      }
    }
  }

  /// <summary>
  /// Determines whether current element is a start element.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localName">Name of the local.</param>
  /// <returns>
  ///     <c>true</c> if current element is a start element; otherwise, <c>false</c>.
  /// </returns>
  bool IsStartElementWithPrefix(String namespacePrefix, String localName) {
    String fullyQualifiedName = FormatElementName(namespacePrefix, localName);

    return this.NodeType == XmlNodeType.Element && this._xmlReader.Name == fullyQualifiedName;
  }

  /// <summary>
  /// Determines whether current element is a start element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  /// <returns>
  ///     <c>true</c> if current element is a start element; otherwise, <c>false</c>.
  /// </returns>
  bool IsStartElementWithNamespace(XmlNamespace xmlNamespace, String localName) {
    return (this.LocalName == localName) &&
        this.IsStartElement() &&
        ((this.NamespacePrefix == EwsUtilities.GetNamespacePrefix(xmlNamespace)) ||
            (this.NamespaceUri == EwsUtilities.GetNamespaceUri(xmlNamespace)));
  }

  /// <summary>
  /// Determines whether current element is a start element.
  /// </summary>
  /// <returns>
  ///     <c>true</c> if current element is a start element; otherwise, <c>false</c>.
  /// </returns>
  bool IsStartElement() {
    return this.NodeType == XmlNodeType.Element;
  }

  /// <summary>
  /// Determines whether current element is a end element.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localName">Name of the local.</param>
  /// <returns>
  ///     <c>true</c> if current element is an end element; otherwise, <c>false</c>.
  /// </returns>
  bool IsEndElement(String namespacePrefix, String localName) {
    String fullyQualifiedName = FormatElementName(namespacePrefix, localName);

    return this.NodeType == XmlNodeType.EndElement && this._xmlReader.Name == fullyQualifiedName;
  }

  /// <summary>
  /// Determines whether current element is a end element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  /// <returns>
  ///     <c>true</c> if current element is an end element; otherwise, <c>false</c>.
  /// </returns>
  bool IsEndElementWithNamespace(XmlNamespace xmlNamespace, String localName) {
    return (this.LocalName == localName) &&
        (this.NodeType == XmlNodeType.EndElement) &&
        ((this.NamespacePrefix == EwsUtilities.GetNamespacePrefix(xmlNamespace)) ||
            (this.NamespaceUri == EwsUtilities.GetNamespaceUri(xmlNamespace)));
  }

  /// <summary>
  /// Skips the element.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localName">Name of the local.</param>
  void SkipElement(String namespacePrefix, String localName) {
    if (!this.IsEndElement(namespacePrefix, localName)) {
      if (!this.IsStartElementWithPrefix(namespacePrefix, localName)) {
        this.ReadStartElement(namespacePrefix, localName);
      }

      if (!this.IsEmptyElement) {
        do {
          this.Read();
        } while (!this.IsEndElement(namespacePrefix, localName));
      }
    }
  }

  /// <summary>
  /// Skips the element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  void SkipElementWithNamspace(XmlNamespace xmlNamespace, String localName) {
    if (!this.IsEndElementWithNamespace(xmlNamespace, localName)) {
      if (!this.IsStartElementWithNamespace(xmlNamespace, localName)) {
        this.ReadStartElementWithNamespace(xmlNamespace, localName);
      }

      if (!this.IsEmptyElement) {
        do {
          this.Read();
        } while (!this.IsEndElementWithNamespace(xmlNamespace, localName));
      }
    }
  }

  /// <summary>
  /// Skips the current element.
  /// </summary>
  void SkipCurrentElement() {
    this.SkipElement(this.NamespacePrefix, this.LocalName);
  }

  /// <summary>
  /// Ensures the current node is start element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  void EnsureCurrentNodeIsStartElementWithNamespace(XmlNamespace xmlNamespace, String localName) {
    if (!this.IsStartElementWithNamespace(xmlNamespace, localName)) {
      throw new ServiceXmlDeserializationException("""string.Format(
                        Strings.ElementNotFound,
                        localName,
                        xmlNamespace)""");
    }
  }

  /// <summary>
  /// Ensures the current node is start element.
  /// </summary>
  void EnsureCurrentNodeIsStartElement() {
    if (this.NodeType != XmlNodeType.Element) {
      throw new ServiceXmlDeserializationException("""string.Format(
                        Strings.ExpectedStartElement,
                        this.xmlReader.Name,
                        this.NodeType)""");
    }
  }

  /// <summary>
  /// Ensures the current node is end element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  void EnsureCurrentNodeIsEndElement(XmlNamespace xmlNamespace, String localName) {
    if (!this.IsEndElementWithNamespace(xmlNamespace, localName)) {
      if (!(this.IsStartElementWithNamespace(xmlNamespace, localName) && this.IsEmptyElement)) {
        throw new ServiceXmlDeserializationException("""string.Format(
                            Strings.ElementNotFound,
                            localName,
                            xmlNamespace)""");
      }
    }
  }

  /// <summary>
  /// Reads the Outer XML at the given location.
  /// </summary>
  /// <returns>
  /// Outer XML as string.
  /// </returns>
  String ReadOuterXml() {
    if (!this.IsStartElement()) {
      throw new ServiceXmlDeserializationException("Strings.CurrentPositionNotElementStart");
    }

    return this._xmlReader.ReadOuterXml();
  }

  /// <summary>
  /// Reads the Inner XML at the given location.
  /// </summary>
  /// <returns>
  /// Inner XML as string.
  /// </returns>
  String ReadInnerXml() {
    if (!this.IsStartElement()) {
      throw new ServiceXmlDeserializationException("Strings.CurrentPositionNotElementStart");
    }

    return this._xmlReader.ReadInnerXml();
  }

  /// <summary>
  /// Gets the XML reader for node.
  /// </summary>
  /// <returns></returns>
  XmlReader GetXmlReaderForNode() {
    return this._xmlReader.ReadSubtree();
  }

  /// <summary>
  /// Reads to the next descendant element with the specified local name and namespace.
  /// </summary>
  /// <param name="xmlNamespace">The namespace of the element you with to move to.</param>
  /// <param name="localName">The local name of the element you wish to move to.</param>
  void ReadToDescendant(XmlNamespace xmlNamespace, String localName) {
    this._xmlReader.ReadToDescendant(localName, EwsUtilities.GetNamespaceUri(xmlNamespace));
  }

  /// <summary>
  /// Gets a value indicating whether this instance has attributes.
  /// </summary>
  /// <value>
  ///     <c>true</c> if this instance has attributes; otherwise, <c>false</c>.
  /// </value>
  bool get HasAttributes => this._xmlReader.AttributeCount > 0;

  /// <summary>
  /// Gets a value indicating whether current element is empty.
  /// </summary>
  /// <value>
  ///     <c>true</c> if current element is empty element; otherwise, <c>false</c>.
  /// </value>
  bool get IsEmptyElement => this._xmlReader.IsEmptyElement;

  /// <summary>
  /// Gets the local name of the current element.
  /// </summary>
  /// <value>The local name of the current element.</value>
  String get LocalName => this._xmlReader.LocalName;

  /// <summary>
  /// Gets the namespace prefix.
  /// </summary>
  /// <value>The namespace prefix.</value>
  String get NamespacePrefix => this._xmlReader.Prefix;

  /// <summary>
  /// Gets the namespace URI.
  /// </summary>
  /// <value>The namespace URI.</value>
  String get NamespaceUri => this._xmlReader.NamespaceURI;

  /// <summary>
  /// Gets the type of the node.
  /// </summary>
  /// <value>The type of the node.</value>
  XmlNodeType get NodeType => this._xmlReader.NodeType;

  /// <summary>
  /// Gets the type of the prev node.
  /// </summary>
  /// <value>The type of the prev node.</value>
  XmlNodeType get PrevNodeType => this._prevNodeType;
}
