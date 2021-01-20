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
/// Represents an error from a GetUserSettings request.
/// </summary>
class UserSettingError {
  /// <summary>
  /// Initializes a new instance of the <see cref="UserSettingError"/> class.
  /// </summary>
  UserSettingError() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="UserSettingError"/> class.
  /// </summary>
  /// <param name="errorCode">The error code.</param>
  /// <param name="errorMessage">The error message.</param>
  /// <param name="settingName">Name of the setting.</param>
  UserSettingError.withDetails(AutodiscoverErrorCode errorCode,
      String errorMessage, String settingName) {
    this.ErrorCode = errorCode;
    this.ErrorMessage = errorMessage;
    this.SettingName = settingName;
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXml(EwsXmlReader reader) {
    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.ErrorCode:
            this.ErrorCode = reader.ReadElementValue<AutodiscoverErrorCode>();
            break;
          case XmlElementNames.ErrorMessage:
            this.ErrorMessage = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.SettingName:
            this.SettingName = reader.ReadElementValue<String>();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.UserSettingError));
  }

  /// <summary>
  /// Gets the error code.
  /// </summary>
  /// <value>The error code.</value>
  AutodiscoverErrorCode? ErrorCode;

  /// <summary>
  /// Gets the error message.
  /// </summary>
  /// <value>The error message.</value>
  String? ErrorMessage;

  /// <summary>
  /// Gets the name of the setting.
  /// </summary>
  /// <value>The name of the setting.</value>
  String? SettingName;
}
