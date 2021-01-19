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

import 'dart:collection';

import 'package:ews/Autodiscover/Responses/AutodiscoverResponse.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents a collection of responses to a call to the Autodiscover service.
/// </summary>
/// <typeparam name="TResponse">The type of the responses in the collection.</typeparam>
abstract class AutodiscoverResponseCollection<
        TResponse extends AutodiscoverResponse> extends AutodiscoverResponse
    with IterableMixin<TResponse> {
  List<TResponse> _responses;

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverResponseCollection&lt;TResponse&gt;"/> class.
  /// </summary>
  AutodiscoverResponseCollection() {
    this._responses = <TResponse>[];
  }

  /// <summary>
  /// Gets the number of responses in the collection.
  /// </summary>
  int get Count => this._responses.length;

  /// <summary>
  /// Gets the response at the specified index.
  /// </summary>
  /// <param name="index">Index.</param>
  TResponse operator [](int index) {
    return this._responses[index];
  }

  /// <summary>
  /// Gets the responses list.
  /// </summary>
  List<TResponse> get Responses => this._responses;

  /// <summary>
  /// Loads response from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="endElementName">End element name.</param>
  @override
  void LoadFromXml(EwsXmlReader reader, String endElementName) {
    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        if (reader.LocalName == this.GetResponseCollectionXmlElementName()) {
          this.LoadResponseCollectionFromXml(reader);
        } else {
          super.LoadFromXml(reader, endElementName);
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, endElementName));
  }

  /// <summary>
  /// Loads the response collection from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /* private */
  void LoadResponseCollectionFromXml(EwsXmlReader reader) {
    if (!reader.IsEmptyElement) {
      do {
        reader.Read();
        if ((reader.NodeType == XmlNodeType.Element) &&
            (reader.LocalName == this.GetResponseInstanceXmlElementName())) {
          TResponse response = this.CreateResponseInstance();
          response.LoadFromXml(
              reader, this.GetResponseInstanceXmlElementName());
          this.Responses.add(response);
        }
      } while (!reader.IsEndElementWithNamespace(XmlNamespace.Autodiscover,
          this.GetResponseCollectionXmlElementName()));
    }
  }

  /// <summary>
  /// Gets the name of the response collection XML element.
  /// </summary>
  /// <returns>Response collection XMl element name.</returns>
  String GetResponseCollectionXmlElementName();

  /// <summary>
  /// Gets the name of the response instance XML element.
  /// </summary>
  /// <returns>Response instance XMl element name.</returns>
  String GetResponseInstanceXmlElementName();

  /// <summary>
  /// Create a response instance.
  /// </summary>
  /// <returns>TResponse.</returns>
  TResponse CreateResponseInstance();

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
  @override
  Iterator<TResponse> get iterator => this._responses.iterator;
}
