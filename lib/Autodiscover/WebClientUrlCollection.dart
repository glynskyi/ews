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

import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

import 'WebClientUrl.dart';

/// <summary>
/// Represents a user setting that is a collection of Exchange web client URLs.
/// </summary>
class WebClientUrlCollection {
  List<WebClientUrl>? _urls;

  /// <summary>
  /// Initializes a new instance of the <see cref="WebClientUrlCollection"/> class.
  /// </summary>
  WebClientUrlCollection() {
    this._urls = <WebClientUrl>[];
  }

  /// <summary>
  /// Loads instance of WebClientUrlCollection from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  static Future<WebClientUrlCollection> LoadFromXml(EwsXmlReader reader) async {
    WebClientUrlCollection instance = new WebClientUrlCollection();

    do {
      await reader.Read();

      if ((reader.NodeType == XmlNodeType.Element) &&
          (reader.LocalName == XmlElementNames.WebClientUrl)) {
        instance.Urls!.add(await WebClientUrl.LoadFromXml(reader));
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.WebClientUrls));

    return instance;
  }

  /// <summary>
  /// Gets the URLs.
  /// </summary>
  List<WebClientUrl>? get Urls => this._urls;
}
