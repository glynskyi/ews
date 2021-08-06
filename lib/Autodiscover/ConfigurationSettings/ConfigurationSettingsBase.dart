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

import 'package:ews/Autodiscover/AutodiscoverError.dart';
import 'package:ews/Autodiscover/Responses/GetUserSettingsResponse.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AutodiscoverResponseType.dart';
import 'package:ews/Enumerations/UserSettingName.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents the base class for configuration settings.
/// </summary>
abstract class ConfigurationSettingsBase {
  AutodiscoverError? _error;

  /// <summary>
  /// Initializes a new instance of the <see cref="ConfigurationSettingsBase"/> class.
  /// </summary>
  ConfigurationSettingsBase() {}

  /// <summary>
  /// Tries to read the current XML element.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True is the current element was read, false otherwise.</returns>
  Future<bool> TryReadCurrentXmlElement(EwsXmlReader reader) async {
    if (reader.LocalName == XmlElementNames.Error) {
      this._error = await AutodiscoverError.Parse(reader);

      return true;
    } else {
      return false;
    }
  }

  /// <summary>
  /// Loads the settings from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  Future<void> LoadFromXml(EwsXmlReader reader) async {
    await reader.ReadStartElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.Autodiscover);
    await reader.ReadStartElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.Response);

    do {
      await reader.Read();

      if (reader.IsStartElement()) {
        if (!await this.TryReadCurrentXmlElement(reader)) {
          await reader.SkipCurrentElement();
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.Response));

    await reader.ReadEndElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.Autodiscover);
  }

  /// <summary>
  /// Gets the namespace that defines the settings.
  /// </summary>
  /// <returns>The namespace that defines the settings</returns>
  String GetNamespace();

  /// <summary>
  /// Makes this instance a redirection response.
  /// </summary>
  /// <param name="redirectUrl">The redirect URL.</param>
  void MakeRedirectionResponse(Uri redirectUrl);

  /// <summary>
  /// Gets the type of the response.
  /// </summary>
  /// <value>The type of the response.</value>
  AutodiscoverResponseType? get ResponseType;

  /// <summary>
  /// Gets the redirect target.
  /// </summary>
  /// <value>The redirect target.</value>
  String? get RedirectTarget;

  /// <summary>
  /// Convert ConfigurationSettings to GetUserSettings response.
  /// </summary>
  /// <param name="smtpAddress">SMTP address.</param>
  /// <param name="requestedSettings">The requested settings.</param>
  /// <returns>GetUserSettingsResponse</returns>
  GetUserSettingsResponse ConvertSettings(
      String smtpAddress, List<UserSettingName> requestedSettings);

  /// <summary>
  /// Gets the error.
  /// </summary>
  /// <value>The error.</value>
  AutodiscoverError? get Error => this._error;
}
