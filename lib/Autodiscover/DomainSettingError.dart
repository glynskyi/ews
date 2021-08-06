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
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents an error from a GetDomainSettings request.
/// </summary>
class DomainSettingError {
  AutodiscoverErrorCode? _errorCode;

  String? _errorMessage;

  String? _settingName;

  /// <summary>
  /// Initializes a new instance of the <see cref="DomainSettingError"/> class.
  /// </summary>
  DomainSettingError() {}

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  Future<void> LoadFromXml(EwsXmlReader reader) async {
    do {
      await reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.ErrorCode:
            this._errorCode =
                await reader.ReadElementValue<AutodiscoverErrorCode>();
            break;
          case XmlElementNames.ErrorMessage:
            this._errorMessage = await reader.ReadElementValue<String>();
            break;
          case XmlElementNames.SettingName:
            this._settingName = await reader.ReadElementValue<String>();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.DomainSettingError));
  }

  /// <summary>
  /// Gets the error code.
  /// </summary>
  /// <value>The error code.</value>
  AutodiscoverErrorCode? get ErrorCode => this._errorCode;

  /// <summary>
  /// Gets the error message.
  /// </summary>
  /// <value>The error message.</value>
  String? get ErrorMessage => this._errorMessage;

  /// <summary>
  /// Gets the name of the setting.
  /// </summary>
  /// <value>The name of the setting.</value>
  String? get SettingName => this._settingName;
}
