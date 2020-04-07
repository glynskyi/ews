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
import 'package:ews/Enumerations/AutodiscoverErrorCode.dart';

/// <summary>
/// Represents the base class for all responses returned by the Autodiscover service.
/// </summary>
abstract class AutodiscoverResponse {
  AutodiscoverErrorCode _errorCode;
  String _errorMessage;
  Uri _redirectionUrl;

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverResponse"/> class.
  /// </summary>
  AutodiscoverResponse() {
    this._errorCode = AutodiscoverErrorCode.NoError;
    this._errorMessage = "Strings.NoError";
  }

  /// <summary>
  /// Loads response from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="endElementName">End element name.</param>
  void LoadFromXml(EwsXmlReader reader, String endElementName) {
    switch (reader.LocalName) {
      case XmlElementNames.ErrorCode:
        this.ErrorCode = reader.ReadElementValue<AutodiscoverErrorCode>();
        break;
      case XmlElementNames.ErrorMessage:
        this.ErrorMessage = reader.ReadElementValue<String>();
        break;
      default:
        break;
    }
  }

  /// <summary>
  /// Gets the error code that was returned by the service.
  /// </summary>
  AutodiscoverErrorCode get ErrorCode => this._errorCode;

  set ErrorCode(AutodiscoverErrorCode value) => this._errorCode = value;

  /// <summary>
  /// Gets the error message that was returned by the service.
  /// </summary>
  /// <value>The error message.</value>
  String get ErrorMessage => this._errorMessage;

  set ErrorMessage(String value) => this._errorMessage = value;

  /// <summary>
  /// Gets or sets the redirection URL.
  /// </summary>
  /// <value>The redirection URL.</value>
  Uri get RedirectionUrl => this._redirectionUrl;

  set RedirectionUrl(Uri value) => this._redirectionUrl = value;
}
