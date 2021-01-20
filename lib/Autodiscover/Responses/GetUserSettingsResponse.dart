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

import 'package:ews/Autodiscover/AlternateMailboxCollection.dart';
import 'package:ews/Autodiscover/DocumentSharingLocationCollection.dart';
import 'package:ews/Autodiscover/ProtocolConnectionCollection.dart';
import 'package:ews/Autodiscover/Responses/AutodiscoverResponse.dart';
import 'package:ews/Autodiscover/UserSettingError.dart';
import 'package:ews/Autodiscover/WebClientUrlCollection.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/UserSettingName.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/OutParam.dart';

/// <summary>
/// Represents the response to a GetUsersSettings call for an individual user.
/// </summary>
class GetUserSettingsResponse extends AutodiscoverResponse {
  /// <summary>
  /// Initializes a new instance of the <see cref="GetUserSettingsResponse"/> class.
  /// </summary>
  GetUserSettingsResponse() : super() {
    this.SmtpAddress = "";
    this.Settings = new Map<UserSettingName?, Object?>();
    this.UserSettingErrors = <UserSettingError>[];
  }

  /// <summary>
  /// Tries the get the user setting value.
  /// </summary>
  /// <typeparam name="T">Type of user setting.</typeparam>
  /// <param name="setting">The setting.</param>
  /// <param name="value">The setting value.</param>
  /// <returns>True if setting was available.</returns>
  bool TryGetSettingValue<T>(
      UserSettingName setting, OutParam<T>? valueOutParam) {
    if (this.Settings.containsKey(setting)) {
      valueOutParam!.param = this.Settings[setting] as T?;
      return true;
    } else {
      valueOutParam = null;
      return false;
    }
  }

  /// <summary>
  /// Gets the SMTP address this response applies to.
  /// </summary>
  String? SmtpAddress;

  /// <summary>
  /// Gets the redirectionTarget (URL or email address)
  /// </summary>
  String? RedirectTarget;

  /// <summary>
  /// Gets the requested settings for the user.
  /// </summary>
  late Map<UserSettingName?, Object?> Settings;

  /// <summary>
  /// Gets error information for settings that could not be returned.
  /// </summary>
  late List<UserSettingError> UserSettingErrors;

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
        switch (reader.LocalName) {
          case XmlElementNames.RedirectTarget:
            this.RedirectTarget = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.UserSettingErrors:
            this._LoadUserSettingErrorsFromXml(reader);
            break;
          case XmlElementNames.UserSettings:
            this.LoadUserSettingsFromXml(reader);
            break;
          default:
            super.LoadFromXml(reader, endElementName);
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, endElementName));
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadUserSettingsFromXml(EwsXmlReader reader) {
    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if ((reader.NodeType == XmlNodeType.Element) &&
            (reader.LocalName == XmlElementNames.UserSetting)) {
          String? settingClass = reader.ReadAttributeValueWithNamespace(
              XmlNamespace.XmlSchemaInstance, XmlAttributeNames.Type);

          switch (settingClass) {
            case XmlElementNames.StringSetting:
            case XmlElementNames.WebClientUrlCollectionSetting:
            case XmlElementNames.AlternateMailboxCollectionSetting:
            case XmlElementNames.ProtocolConnectionCollectionSetting:
            case XmlElementNames.DocumentSharingLocationCollectionSetting:
              this._ReadSettingFromXml(reader);
              break;

            default:
              EwsUtilities.Assert(
                  false,
                  "GetUserSettingsResponse.LoadUserSettingsFromXml",
                  "Invalid setting class '$settingClass' returned");
              break;
          }
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Autodiscover, XmlElementNames.UserSettings));
    }
  }

  /// <summary>
  /// Reads user setting from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void _ReadSettingFromXml(EwsXmlReader reader) {
    String? name = null;
    Object? value = null;

    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.Name:
            name = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.Value:
            value = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.WebClientUrls:
            value = WebClientUrlCollection.LoadFromXml(reader);
            break;
          case XmlElementNames.ProtocolConnections:
            value = ProtocolConnectionCollection.LoadFromXml(reader);
            break;
          case XmlElementNames.AlternateMailboxes:
            value = AlternateMailboxCollection.LoadFromXml(reader);
            break;
          case XmlElementNames.DocumentSharingLocations:
            value = DocumentSharingLocationCollection.LoadFromXml(reader);
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.UserSetting));

    // EWS Managed API is broken with AutoDSvc endpoint in RedirectUrl scenario
    try {
      UserSettingName? userSettingName =
          EwsUtilities.Parse<UserSettingName>(name);
      this.Settings[userSettingName] = value;
    } catch (ArgumentException) {
      // ignore unexpected UserSettingName in the response (due to the server-side bugs).
      // it'd be better if this is hooked into ITraceListener, but that is unavailable here.
      //
      // in case "name" is null, EwsUtilities.Parse throws ArgumentNullException
      // (which derives from ArgumentException).
      //
      EwsUtilities.Assert(false, "GetUserSettingsResponse.ReadSettingFromXml",
          "Unexpected or empty name element in user setting");
    }
  }

  /// <summary>
  /// Loads the user setting errors.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void _LoadUserSettingErrorsFromXml(EwsXmlReader reader) {
    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if ((reader.NodeType == XmlNodeType.Element) &&
            (reader.LocalName == XmlElementNames.UserSettingError)) {
          UserSettingError error = new UserSettingError();
          error.LoadFromXml(reader);
          this.UserSettingErrors.add(error);
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Autodiscover, XmlElementNames.UserSettingErrors));
    }
  }
}
