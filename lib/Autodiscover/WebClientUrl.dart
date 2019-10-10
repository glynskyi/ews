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

/// <summary>
/// Represents the URL of the Exchange web client.
/// </summary>
class WebClientUrl {
  String _authenticationMethods;
  String _url;

  /// <summary>
  /// Initializes a new instance of the <see cref="WebClientUrl"/> class.
  /// </summary>
  WebClientUrl._() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="WebClientUrl"/> class.
  /// </summary>
  /// <param name="authenticationMethods">The authentication methods.</param>
  /// <param name="url">The URL.</param>
  WebClientUrl(String authenticationMethods, String url) {
    this._authenticationMethods = authenticationMethods;
    this._url = url;
  }

  /// <summary>
  /// Loads WebClientUrl instance from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>WebClientUrl.</returns>
  static WebClientUrl LoadFromXml(EwsXmlReader reader) {
    WebClientUrl webClientUrl = new WebClientUrl._();

    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.AuthenticationMethods:
            webClientUrl.AuthenticationMethods =
                reader.ReadElementValue<String>();
            break;
          case XmlElementNames.Url:
            webClientUrl.Url = reader.ReadElementValue<String>();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.WebClientUrl));

    return webClientUrl;
  }

  /// <summary>
  /// Gets the authentication methods.
  /// </summary>
  String get AuthenticationMethods => this._authenticationMethods;

  set AuthenticationMethods(String value) =>
      this._authenticationMethods = value;

  /// <summary>
  /// Gets the URL.
  /// </summary>
  String get Url => this._url;

  set Url(String value) => this._url = value;
}
