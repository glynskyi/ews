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

import 'package:ews/Autodiscover/ConfigurationSettings/ConfigurationSettingsBase.dart';
import 'package:ews/Autodiscover/ConfigurationSettings/Outlook/OutlookAccount.dart';
import 'package:ews/Autodiscover/ConfigurationSettings/Outlook/OutlookProtocol.dart';
import 'package:ews/Autodiscover/ConfigurationSettings/Outlook/OutlookUser.dart';
import 'package:ews/Autodiscover/Responses/GetUserSettingsResponse.dart';
import 'package:ews/Autodiscover/UserSettingError.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AutodiscoverErrorCode.dart';
import 'package:ews/Enumerations/AutodiscoverResponseType.dart';
import 'package:ews/Enumerations/UserSettingName.dart';

/// <summary>
/// Represents Outlook configuration settings.
/// </summary>
class OutlookConfigurationSettings extends ConfigurationSettingsBase {
  /// <summary>
  /// All user settings that are available from the Outlook provider.
  /// </summary>
  static LazyMember<List<UserSettingName>> _allOutlookProviderSettings =
      new LazyMember<List<UserSettingName>>(() {
    List<UserSettingName> results = <UserSettingName>[];
    results.addAll(OutlookUser.AvailableUserSettings);
    results.addAll(OutlookProtocol.AvailableUserSettings!);
    results.add(UserSettingName.AlternateMailboxes);
    return results;
  });

  late OutlookUser _user;
  OutlookAccount? _account;

  /// <summary>
  /// Initializes a new instance of the <see cref="OutlookConfigurationSettings"/> class.
  /// </summary>
  OutlookConfigurationSettings() {
    this._user = new OutlookUser();
    this._account = new OutlookAccount();
  }

  /// <summary>
  /// Determines whether user setting is available in the OutlookConfiguration or not.
  /// </summary>
  /// <param name="setting">The setting.</param>
  /// <returns>True if user setting is available, otherwise, false.
  /// </returns>
  static bool IsAvailableUserSetting(UserSettingName setting) {
    return _allOutlookProviderSettings.Member!.contains(setting);
  }

  /// <summary>
  /// Gets the namespace that defines the settings.
  /// </summary>
  /// <returns>The namespace that defines the settings.</returns>
  @override
  String GetNamespace() {
    return "http://schemas.microsoft.com/exchange/autodiscover/outlook/responseschema/2006a";
  }

  /// <summary>
  /// Makes this instance a redirection response.
  /// </summary>
  /// <param name="redirectUrl">The redirect URL.</param>
  @override
  void MakeRedirectionResponse(Uri redirectUrl) {
    this._account = new OutlookAccount()
      ..RedirectTarget = redirectUrl.toString()
      ..ResponseType = AutodiscoverResponseType.RedirectUrl;
  }

  /// <summary>
  /// Tries to read the current XML element.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True is the current element was read, false otherwise.</returns>
  @override
  Future<bool> TryReadCurrentXmlElement(EwsXmlReader reader) async {
    if (!await super.TryReadCurrentXmlElement(reader)) {
      switch (reader.LocalName) {
        case XmlElementNames.User:
          await this._user.LoadFromXml(reader);
          return true;
        case XmlElementNames.Account:
          await this._account!.LoadFromXml(reader);
          return true;
        default:
          await reader.SkipCurrentElement();
          return false;
      }
    } else {
      return true;
    }
  }

  /// <summary>
  /// Convert OutlookConfigurationSettings to GetUserSettings response.
  /// </summary>
  /// <param name="smtpAddress">SMTP address requested.</param>
  /// <param name="requestedSettings">The requested settings.</param>
  /// <returns>GetUserSettingsResponse</returns>
  @override
  GetUserSettingsResponse ConvertSettings(
      String smtpAddress, List<UserSettingName> requestedSettings) {
    GetUserSettingsResponse response = new GetUserSettingsResponse();
    response.SmtpAddress = smtpAddress;

    if (this.Error != null) {
      response.ErrorCode = AutodiscoverErrorCode.InternalServerError;
      response.ErrorMessage = this.Error!.Message;
    } else {
      switch (this.ResponseType) {
        case AutodiscoverResponseType.Success:
          response.ErrorCode = AutodiscoverErrorCode.NoError;
          response.ErrorMessage = "";
          this._user.ConvertToUserSettings(requestedSettings, response);
          this._account!.ConvertToUserSettings(requestedSettings, response);
          this._ReportUnsupportedSettings(requestedSettings, response);
          break;
        case AutodiscoverResponseType.Error:
          response.ErrorCode = AutodiscoverErrorCode.InternalServerError;
          response.ErrorMessage = "Strings.InvalidAutodiscoverServiceResponse";
          break;
        case AutodiscoverResponseType.RedirectAddress:
          response.ErrorCode = AutodiscoverErrorCode.RedirectAddress;
          response.ErrorMessage = "";
          response.RedirectTarget = this.RedirectTarget;
          break;
        case AutodiscoverResponseType.RedirectUrl:
          response.ErrorCode = AutodiscoverErrorCode.RedirectUrl;
          response.ErrorMessage = "";
          response.RedirectTarget = this.RedirectTarget;
          break;
        default:
          EwsUtilities.Assert(
              false,
              "OutlookConfigurationSettings.ConvertSettings",
              "An unexpected error has occured. This code path should never be reached.");
          break;
      }
    }
    return response;
  }

  /// <summary>
  /// Reports any requested user settings that aren't supported by the Outlook provider.
  /// </summary>
  /// <param name="requestedSettings">The requested settings.</param>
  /// <param name="response">The response.</param>
  void _ReportUnsupportedSettings(List<UserSettingName> requestedSettings,
      GetUserSettingsResponse response) {
    // In English: find settings listed in requestedSettings that are not supported by the Legacy provider.
    Iterable<UserSettingName> invalidSettingQuery = requestedSettings.where(
        (setting) =>
            !OutlookConfigurationSettings.IsAvailableUserSetting(setting));
//          Iterable<UserSettingName> invalidSettingQuery = from setting in requestedSettings
//                                                               where
//                                                               select setting;

    // Add any unsupported settings to the UserSettingsError collection.
    for (UserSettingName invalidSetting in invalidSettingQuery) {
      UserSettingError settingError = new UserSettingError()
        ..ErrorCode = AutodiscoverErrorCode.InvalidSetting
        ..SettingName = invalidSetting.toString()
        ..ErrorMessage =
            "Strings.AutodiscoverInvalidSettingForOutlookProvider, invalidSetting.toString())";
      response.UserSettingErrors.add(settingError);
    }
  }

  /// <summary>
  /// Gets the type of the response.
  /// </summary>
  /// <value>The type of the response.</value>
  @override
  AutodiscoverResponseType? get ResponseType {
    if (this._account != null) {
      return this._account!.ResponseType;
    } else {
      return AutodiscoverResponseType.Error;
    }
  }

  /// <summary>
  /// Gets the redirect target.
  /// </summary>
  @override
  String? get RedirectTarget => this._account!.RedirectTarget;
}
