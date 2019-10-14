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

import 'package:ews/Autodiscover/Responses/GetUserSettingsResponse.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/UserSettingName.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/MapiTypeConverterMapEntry.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents the user Outlook configuration settings apply to.
/// </summary>
class OutlookUser {
  /// <summary>
  /// Converters to translate Outlook user settings.
  /// Each entry maps to a lambda expression used to get the matching property from the OutlookUser instance.
  /// </summary>
  static LazyMember<Map<UserSettingName, Func<OutlookUser, String>>>
      _converterDictionary =
      new LazyMember<Map<UserSettingName, Func<OutlookUser, String>>>(() {
    var results = new Map<UserSettingName, Func<OutlookUser, String>>();
    results[UserSettingName.UserDisplayName] = (u) => u._displayName;
    results[UserSettingName.UserDN] = (u) => u._legacyDN;
    results[UserSettingName.UserDeploymentId] = (u) => u._deploymentId;
    results[UserSettingName.AutoDiscoverSMTPAddress] =
        (u) => u._autodiscoverAMTPAddress;
    return results;
  });

  String _displayName;
  String _legacyDN;
  String _deploymentId;
  String _autodiscoverAMTPAddress;

  /// <summary>
  /// Initializes a new instance of the <see cref="OutlookUser"/> class.
  /// </summary>
  OutlookUser() {}

  /// <summary>
  /// Load from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXml(EwsXmlReader reader) {
    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.DisplayName:
            this._displayName = reader.ReadElementValue();
            break;
          case XmlElementNames.LegacyDN:
            this._legacyDN = reader.ReadElementValue();
            break;
          case XmlElementNames.DeploymentId:
            this._deploymentId = reader.ReadElementValue();
            break;
          case XmlElementNames.AutoDiscoverSMTPAddress:
            this._autodiscoverAMTPAddress = reader.ReadElementValue();
            break;
          default:
            reader.SkipCurrentElement();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.User));
  }

  /// <summary>
  /// Convert OutlookUser to GetUserSettings response.
  /// </summary>
  /// <param name="requestedSettings">The requested settings.</param>
  /// <param name="response">The response.</param>
  void ConvertToUserSettings(List<UserSettingName> requestedSettings,
      GetUserSettingsResponse response) {
    // In English: collect converters that are contained in the requested settings.

    var converterQuery = _converterDictionary.Member.entries
        .where((converter) => requestedSettings.contains(converter.key));
//            var converterQuery = from converter in _converterDictionary.Member
//                                 where requestedSettings.Contains(converter.Key)
//                                 select converter;

    for (MapEntry<UserSettingName, Func<OutlookUser, String>> kv
        in converterQuery) {
      String value = kv.value(this);
      if (!StringUtils.IsNullOrEmpty(value)) {
        response.Settings[kv.key] = value;
      }
    }
  }

  /// <summary>
  /// Gets the available user settings.
  /// </summary>
  /// <value>The available user settings.</value>
  static Iterable<UserSettingName> get AvailableUserSettings =>
      _converterDictionary.Member.keys;
}
