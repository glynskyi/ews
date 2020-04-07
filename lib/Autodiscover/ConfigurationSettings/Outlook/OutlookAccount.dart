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

import 'package:ews/Autodiscover/AlternateMailbox.dart';
import 'package:ews/Autodiscover/AlternateMailboxCollection.dart';
import 'package:ews/Autodiscover/ConfigurationSettings/Outlook/OutlookProtocol.dart';
import 'package:ews/Autodiscover/Responses/GetUserSettingsResponse.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AutodiscoverResponseType.dart';
import 'package:ews/Enumerations/OutlookProtocolType.dart';
import 'package:ews/Enumerations/UserSettingName.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents an Outlook configuration settings account.
/// </summary>
class OutlookAccount {
  static const String _Settings = "settings";
  static const String _RedirectAddr = "redirectAddr";
  static const String _RedirectUrl = "redirectUrl";

  Map<OutlookProtocolType, OutlookProtocol> _protocols;
  AlternateMailboxCollection _alternateMailboxes;

  /// <summary>
  /// Initializes a new instance of the <see cref="OutlookAccount"/> class.
  /// </summary>
  OutlookAccount() {
    this._protocols = new Map<OutlookProtocolType, OutlookProtocol>();
    this._alternateMailboxes = new AlternateMailboxCollection();
  }

  /// <summary>
  /// Load from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXml(EwsXmlReader reader) {
    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.AccountType:
            this.AccountType = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.Action:
            String xmlResponseType = reader.ReadElementValue<String>();

            switch (xmlResponseType) {
              case OutlookAccount._Settings:
                this.ResponseType = AutodiscoverResponseType.Success;
                break;
              case OutlookAccount._RedirectUrl:
                this.ResponseType = AutodiscoverResponseType.RedirectUrl;
                break;
              case OutlookAccount._RedirectAddr:
                this.ResponseType = AutodiscoverResponseType.RedirectAddress;
                break;
              default:
                this.ResponseType = AutodiscoverResponseType.Error;
                break;
            }

            break;
          case XmlElementNames.Protocol:
            OutlookProtocol protocol = new OutlookProtocol();
            protocol.LoadFromXml(reader);
            if (this._protocols.containsKey(protocol.ProtocolType)) {
              // There should be strictly one node per protocol type in the autodiscover response.
              throw new ServiceLocalException(
                  "Strings.InvalidAutodiscoverServiceResponse");
            }
            this._protocols[protocol.ProtocolType] = protocol;
            break;
          case XmlElementNames.RedirectAddr:
          case XmlElementNames.RedirectUrl:
            this.RedirectTarget = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.AlternateMailboxes:
            AlternateMailbox alternateMailbox =
                AlternateMailbox.LoadFromXml(reader);
            this._alternateMailboxes.Entries.add(alternateMailbox);
            break;

          default:
            reader.SkipCurrentElement();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.Account));
  }

  /// <summary>
  /// Convert OutlookAccount to GetUserSettings response.
  /// </summary>
  /// <param name="requestedSettings">The requested settings.</param>
  /// <param name="response">GetUserSettings response.</param>
  void ConvertToUserSettings(List<UserSettingName> requestedSettings,
      GetUserSettingsResponse response) {
    for (OutlookProtocol protocol in this._protocols.values) {
      protocol.ConvertToUserSettings(requestedSettings, response);
    }

    if (requestedSettings.contains(UserSettingName.AlternateMailboxes)) {
      response.Settings[UserSettingName.AlternateMailboxes] =
          this._alternateMailboxes;
    }
  }

  /// <summary>
  /// Gets or sets type of the account.
  /// </summary>
  String AccountType;

  /// <summary>
  /// Gets or sets the type of the response.
  /// </summary>
  AutodiscoverResponseType ResponseType;

  /// <summary>
  /// Gets or sets the redirect target.
  /// </summary>
  String RedirectTarget;
}
