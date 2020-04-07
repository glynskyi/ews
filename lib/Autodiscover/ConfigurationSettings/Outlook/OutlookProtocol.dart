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
import 'package:ews/Autodiscover/WebClientUrl.dart';
import 'package:ews/Autodiscover/WebClientUrlCollection.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/OutlookProtocolType.dart';
import 'package:ews/Enumerations/UserSettingName.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/MapiTypeConverterMapEntry.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents a supported Outlook protocol in an Outlook configurations settings account.
/// </summary>
class OutlookProtocol {
  static const String _EXCH = "EXCH";
  static const String _EXPR = "EXPR";
  static const String _WEB = "WEB";

  /// <summary>
  /// Converters to translate common Outlook protocol settings.
  /// Each entry maps to a lambda expression used to get the matching property from the OutlookProtocol instance.
  /// </summary>
  /* private */
  static LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>
      commonProtocolSettings =
      new LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>(() {
    final results = new Map<UserSettingName, Func<OutlookProtocol, Object>>();
    results[UserSettingName.EcpDeliveryReportUrlFragment] = (p) => p.ecpUrlMt;
    results[UserSettingName.EcpEmailSubscriptionsUrlFragment] =
        (p) => p.ecpUrlAggr;
    results[UserSettingName.EcpPublishingUrlFragment] = (p) => p.ecpUrlPublish;
    results[UserSettingName.EcpPhotoUrlFragment] = (p) => p.ecpUrlPhoto;
    results[UserSettingName.EcpRetentionPolicyTagsUrlFragment] =
        (p) => p.ecpUrlRet;
    results[UserSettingName.EcpTextMessagingUrlFragment] = (p) => p.ecpUrlSms;
    results[UserSettingName.EcpVoicemailUrlFragment] = (p) => p.ecpUrlUm;
    results[UserSettingName.EcpConnectUrlFragment] = (p) => p.ecpUrlConnect;
    results[UserSettingName.EcpTeamMailboxUrlFragment] = (p) => p.ecpUrlTm;
    results[UserSettingName.EcpTeamMailboxCreatingUrlFragment] =
        (p) => p.ecpUrlTmCreating;
    results[UserSettingName.EcpTeamMailboxEditingUrlFragment] =
        (p) => p.ecpUrlTmEditing;
    results[UserSettingName.EcpExtensionInstallationUrlFragment] =
        (p) => p.ecpUrlExtInstall;
    results[UserSettingName.SiteMailboxCreationURL] =
        (p) => p.siteMailboxCreationURL;
    return results;
  });

  /// <summary>
  /// Converters to translate (EXCH) Outlook protocol settings.
  /// Each entry maps to a lambda expression used to get the matching property from the OutlookProtocol instance.
  /// </summary>
  /* private */
  static LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>
      internalProtocolSettings =
      new LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>(() {
    var results = new Map<UserSettingName, Func<OutlookProtocol, Object>>();
    results[UserSettingName.ActiveDirectoryServer] =
        (p) => p.activeDirectoryServer;
    results[UserSettingName.CrossOrganizationSharingEnabled] =
        (p) => p.sharingEnabled.toString();
    results[UserSettingName.InternalEcpUrl] = (p) => p.ecpUrl;
    results[UserSettingName.InternalEcpDeliveryReportUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlMt);
    results[UserSettingName.InternalEcpEmailSubscriptionsUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlAggr);
    results[UserSettingName.InternalEcpPublishingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlPublish);
    results[UserSettingName.InternalEcpPhotoUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlPhoto);
    results[UserSettingName.InternalEcpRetentionPolicyTagsUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlRet);
    results[UserSettingName.InternalEcpTextMessagingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlSms);
    results[UserSettingName.InternalEcpVoicemailUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlUm);
    results[UserSettingName.InternalEcpConnectUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlConnect);
    results[UserSettingName.InternalEcpTeamMailboxUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlTm);
    results[UserSettingName.InternalEcpTeamMailboxCreatingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlTmCreating);
    results[UserSettingName.InternalEcpTeamMailboxEditingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlTmEditing);
    results[UserSettingName.InternalEcpTeamMailboxHidingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlTmHiding);
    results[UserSettingName.InternalEcpExtensionInstallationUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlExtInstall);
    results[UserSettingName.InternalEwsUrl] =
        (p) => p.exchangeWebServicesUrl ?? p.availabilityServiceUrl;
    results[UserSettingName.InternalEmwsUrl] =
        (p) => p.exchangeManagementWebServicesUrl;
    results[UserSettingName.InternalMailboxServerDN] = (p) => p.serverDN;
    results[UserSettingName.InternalRpcClientServer] = (p) => p.server;
    results[UserSettingName.InternalOABUrl] = (p) => p.offlineAddressBookUrl;
    results[UserSettingName.InternalUMUrl] = (p) => p.unifiedMessagingUrl;
    results[UserSettingName.MailboxDN] = (p) => p.mailboxDN;
    results[UserSettingName.PublicFolderServer] = (p) => p.publicFolderServer;
    results[UserSettingName.InternalServerExclusiveConnect] =
        (p) => p.serverExclusiveConnect;
    return results;
  });

  /// <summary>
  /// Converters to translate external (EXPR) Outlook protocol settings.
  /// Each entry maps to a lambda expression used to get the matching property from the OutlookProtocol instance.
  /// </summary>
  /* private */
  static LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>
      externalProtocolSettings =
      new LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>(() {
    var results = new Map<UserSettingName, Func<OutlookProtocol, Object>>();
    results[UserSettingName.ExternalEcpDeliveryReportUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlRet);
    results[UserSettingName.ExternalEcpEmailSubscriptionsUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlAggr);
    results[UserSettingName.ExternalEcpPublishingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlPublish);
    results[UserSettingName.ExternalEcpPhotoUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlPhoto);
    results[UserSettingName.ExternalEcpRetentionPolicyTagsUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlRet);
    results[UserSettingName.ExternalEcpTextMessagingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlSms);
    results[UserSettingName.ExternalEcpUrl] = (p) => p.ecpUrl;
    results[UserSettingName.ExternalEcpVoicemailUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlUm);
    results[UserSettingName.ExternalEcpConnectUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlConnect);
    results[UserSettingName.ExternalEcpTeamMailboxUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlTm);
    results[UserSettingName.ExternalEcpTeamMailboxCreatingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlTmCreating);
    results[UserSettingName.ExternalEcpTeamMailboxEditingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlTmEditing);
    results[UserSettingName.ExternalEcpTeamMailboxHidingUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlTmHiding);
    results[UserSettingName.ExternalEcpExtensionInstallationUrl] =
        (p) => p.ConvertEcpFragmentToUrl(p.ecpUrlExtInstall);
    results[UserSettingName.ExternalEwsUrl] =
        (p) => p.exchangeWebServicesUrl ?? p.availabilityServiceUrl;
    results[UserSettingName.ExternalEmwsUrl] =
        (p) => p.exchangeManagementWebServicesUrl;
    results[UserSettingName.ExternalMailboxServer] = (p) => p.server;
    results[UserSettingName.ExternalMailboxServerAuthenticationMethods] =
        (p) => p.authPackage;
    results[UserSettingName.ExternalMailboxServerRequiresSSL] =
        (p) => p.sslEnabled.toString();
    results[UserSettingName.ExternalOABUrl] = (p) => p.offlineAddressBookUrl;
    results[UserSettingName.ExternalUMUrl] = (p) => p.unifiedMessagingUrl;
    results[UserSettingName.ExchangeRpcUrl] = (p) => p.exchangeRpcUrl;
    results[UserSettingName.EwsPartnerUrl] =
        (p) => p.exchangeWebServicesPartnerUrl;
    results[UserSettingName.ExternalServerExclusiveConnect] =
        (p) => p.serverExclusiveConnect.toString();
    results[UserSettingName.CertPrincipalName] = (p) => p.certPrincipalName;
    results[UserSettingName.GroupingInformation] = (p) => p.groupingInformation;
    return results;
  });

  /// <summary>
  /// Merged converter dictionary for translating (EXCH) Outlook protocol settings.
  /// Each entry maps to a lambda expression used to get the matching property from the OutlookProtocol instance.
  /// </summary>
  /* private */
  static LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>
      internalProtocolConverterDictionary =
      new LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>(() {
    var results = new Map<UserSettingName, Func<OutlookProtocol, Object>>();
    commonProtocolSettings.Member.forEach((key, value) => results[key] = value);
    internalProtocolSettings.Member.forEach(
        (key, value) => results[key] = value);
    return results;
  });

  /// <summary>
  /// Merged converter dictionary for translating external (EXPR) Outlook protocol settings.
  /// Each entry maps to a lambda expression used to get the matching property from the OutlookProtocol instance.
  /// </summary>
  /* private */
  static LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>
      externalProtocolConverterDictionary =
      new LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>(() {
    var results = new Map<UserSettingName, Func<OutlookProtocol, Object>>();
    commonProtocolSettings.Member.forEach((key, value) => results[key] = value);
    externalProtocolSettings.Member.forEach(
        (key, value) => results[key] = value);
    return results;
  });

  /// <summary>
  /// Converters to translate Web (WEB) Outlook protocol settings.
  /// Each entry maps to a lambda expression used to get the matching property from the OutlookProtocol instance.
  /// </summary>
  /* private */
  static LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>
      webProtocolConverterDictionary =
      new LazyMember<Map<UserSettingName, Func<OutlookProtocol, Object>>>(() {
    var results = new Map<UserSettingName, Func<OutlookProtocol, Object>>();
    results[UserSettingName.InternalWebClientUrls] =
        (p) => p.internalOutlookWebAccessUrls;
    results[UserSettingName.ExternalWebClientUrls] =
        (p) => p.externalOutlookWebAccessUrls;
    return results;
  });

  /// <summary>
  /// The collection of available user settings for all OutlookProtocol types.
  /// </summary>
  /* private */
  static LazyMember<List<UserSettingName>> availableUserSettings =
      new LazyMember<List<UserSettingName>>(() {
    var results = new List<UserSettingName>();
    results.addAll(commonProtocolSettings.Member.keys);
    results.addAll(internalProtocolSettings.Member.keys);
    results.addAll(externalProtocolSettings.Member.keys);
    results.addAll(webProtocolConverterDictionary.Member.keys);
    return results;
  });

  /// <summary>
  /// Map Outlook protocol name to type.
  /// </summary>
  /* private */
  static LazyMember<Map<String, OutlookProtocolType>> protocolNameToTypeMap =
      new LazyMember<Map<String, OutlookProtocolType>>(() {
    Map<String, OutlookProtocolType> results =
        new Map<String, OutlookProtocolType>();
    results[OutlookProtocol._EXCH] = OutlookProtocolType.Rpc;
    results[OutlookProtocol._EXPR] = OutlookProtocolType.RpcOverHttp;
    results[OutlookProtocol._WEB] = OutlookProtocolType.Web;
    return results;
  });

  /* private */
  String activeDirectoryServer;

  /* private */
  String authPackage;

  /* private */
  String availabilityServiceUrl;

  /* private */
  String ecpUrl;

  /* private */
  String ecpUrlAggr;

  /* private */
  String ecpUrlMt;

  /* private */
  String ecpUrlPublish;

  /* private */
  String ecpUrlPhoto;

  /* private */
  String ecpUrlConnect;

  /* private */
  String ecpUrlRet;

  /* private */
  String ecpUrlSms;

  /* private */
  String ecpUrlUm;

  /* private */
  String ecpUrlTm;

  /* private */
  String ecpUrlTmCreating;

  /* private */
  String ecpUrlTmEditing;

  /* private */
  String ecpUrlTmHiding;

  /* private */
  String siteMailboxCreationURL;

  /* private */
  String ecpUrlExtInstall;

  /* private */
  String exchangeWebServicesUrl;

  /* private */
  String exchangeManagementWebServicesUrl;

  /* private */
  String mailboxDN;

  /* private */
  String offlineAddressBookUrl;

  /* private */
  String exchangeRpcUrl;

  /* private */
  String exchangeWebServicesPartnerUrl;

  /* private */
  String publicFolderServer;

  /* private */
  String server;

  /* private */
  String serverDN;

  /* private */
  String unifiedMessagingUrl;

  /* private */
  bool sharingEnabled;

  /* private */
  bool sslEnabled;

  /* private */
  bool serverExclusiveConnect;

  /* private */
  String certPrincipalName;

  /* private */
  String groupingInformation;

  /* private */
  WebClientUrlCollection externalOutlookWebAccessUrls;

  /* private */
  WebClientUrlCollection internalOutlookWebAccessUrls;

  /// <summary>
  /// Initializes a new instance of the <see cref="OutlookProtocol"/> class.
  /// </summary>
  OutlookProtocol() {
    this.internalOutlookWebAccessUrls = new WebClientUrlCollection();
    this.externalOutlookWebAccessUrls = new WebClientUrlCollection();
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
          case XmlElementNames.Type:
            this.ProtocolType =
                OutlookProtocol.ProtocolNameToType(reader.ReadElementValue<String>());
            break;
          case XmlElementNames.AuthPackage:
            this.authPackage = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.Server:
            this.server = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.ServerDN:
            this.serverDN = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.ServerVersion:
            // just read it out
            reader.ReadElementValue<String>();
            break;
          case XmlElementNames.AD:
            this.activeDirectoryServer = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.MdbDN:
            this.mailboxDN = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EWSUrl:
            this.exchangeWebServicesUrl = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EmwsUrl:
            this.exchangeManagementWebServicesUrl = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.ASUrl:
            this.availabilityServiceUrl = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.OOFUrl:
            // just read it out
            reader.ReadElementValue<String>();
            break;
          case XmlElementNames.UMUrl:
            this.unifiedMessagingUrl = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.OABUrl:
            this.offlineAddressBookUrl = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.PublicFolderServer:
            this.publicFolderServer = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.Internal:
            OutlookProtocol.LoadWebClientUrlsFromXml(
                reader, this.internalOutlookWebAccessUrls, reader.LocalName);
            break;
          case XmlElementNames.External:
            OutlookProtocol.LoadWebClientUrlsFromXml(
                reader, this.externalOutlookWebAccessUrls, reader.LocalName);
            break;
          case XmlElementNames.Ssl:
            String sslStr = reader.ReadElementValue<String>();
            this.sslEnabled = sslStr.toLowerCase() == "on";
            break;
          case XmlElementNames.SharingUrl:
            this.sharingEnabled = reader.ReadElementValue<String>().length > 0;
            break;
          case XmlElementNames.EcpUrl:
            this.ecpUrl = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_um:
            this.ecpUrlUm = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_aggr:
            this.ecpUrlAggr = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_sms:
            this.ecpUrlSms = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_mt:
            this.ecpUrlMt = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_ret:
            this.ecpUrlRet = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_publish:
            this.ecpUrlPublish = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_photo:
            this.ecpUrlPhoto = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.ExchangeRpcUrl:
            this.exchangeRpcUrl = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EwsPartnerUrl:
            this.exchangeWebServicesPartnerUrl = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_connect:
            this.ecpUrlConnect = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_tm:
            this.ecpUrlTm = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_tmCreating:
            this.ecpUrlTmCreating = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_tmEditing:
            this.ecpUrlTmEditing = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_tmHiding:
            this.ecpUrlTmHiding = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.SiteMailboxCreationURL:
            this.siteMailboxCreationURL = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.EcpUrl_extinstall:
            this.ecpUrlExtInstall = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.ServerExclusiveConnect:
            String serverExclusiveConnectStr = reader.ReadElementValue<String>();
            this.serverExclusiveConnect =
                serverExclusiveConnectStr.toLowerCase() == "on";
            break;
          case XmlElementNames.CertPrincipalName:
            this.certPrincipalName = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.GroupingInformation:
            this.groupingInformation = reader.ReadElementValue<String>();
            break;
          default:
            reader.SkipCurrentElement();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.Protocol));
  }

  /// <summary>
  /// Convert protocol name to protocol type.
  /// </summary>
  /// <param name="protocolName">Name of the protocol.</param>
  /// <returns>OutlookProtocolType</returns>
  /* private */
  static OutlookProtocolType ProtocolNameToType(String protocolName) {
    OutlookProtocolType protocolType;
    if (!protocolNameToTypeMap.Member.containsKey(protocolName)) {
      protocolType = OutlookProtocolType.Unknown;
    }
    return protocolType;
  }

  /// <summary>
  /// Loads web client urls from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="webClientUrls">The web client urls.</param>
  /// <param name="elementName">Name of the element.</param>
  /* private */
  static void LoadWebClientUrlsFromXml(EwsXmlReader reader,
      WebClientUrlCollection webClientUrls, String elementName) {
    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.OWAUrl:
            String authMethod = reader.ReadAttributeValue(
                XmlAttributeNames.AuthenticationMethod);
            String owaUrl = reader.ReadElementValue<String>();
            WebClientUrl webClientUrl = new WebClientUrl(authMethod, owaUrl);
            webClientUrls.Urls.add(webClientUrl);
            break;
          default:
            reader.SkipCurrentElement();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.NotSpecified, elementName));
  }

  /// <summary>
  /// Convert ECP fragment to full ECP URL.
  /// </summary>
  /// <param name="fragment">The fragment.</param>
  /// <returns>Full URL String (or null if either portion is empty.</returns>
  /* private */
  String ConvertEcpFragmentToUrl(String fragment) {
    return (StringUtils.IsNullOrEmpty(this.ecpUrl) ||
            StringUtils.IsNullOrEmpty(fragment))
        ? null
        : (this.ecpUrl + fragment);
  }

  /// <summary>
  /// Convert OutlookProtocol to GetUserSettings response.
  /// </summary>
  /// <param name="requestedSettings">The requested settings.</param>
  /// <param name="response">The response.</param>
  void ConvertToUserSettings(List<UserSettingName> requestedSettings,
      GetUserSettingsResponse response) {
    if (this.ConverterDictionary != null) {
      // In English: collect converters that are contained in the requested settings.
      var converterQuery = this
          .ConverterDictionary
          .entries
          .where((converter) => requestedSettings.contains(converter.key));
//                var converterQuery = from converter in this.ConverterDictionary
//                                     where requestedSettings.Contains(converter.Key)
//                                     select converter;

      for (MapEntry<UserSettingName, Func<OutlookProtocol, Object>> kv
          in converterQuery) {
        Object value = kv.value(this);
        if (value != null) {
          response.Settings[kv.key] = value;
        }
      }
    }
  }

  /// <summary>
  /// Gets the type of the protocol.
  /// </summary>
  /// <value>The type of the protocol.</value>
  OutlookProtocolType ProtocolType;

  /// <summary>
  /// Gets the converter dictionary for protocol type.
  /// </summary>
  /// <value>The converter dictionary.</value>
  /* private */
  Map<UserSettingName, Func<OutlookProtocol, Object>> get ConverterDictionary {
    switch (this.ProtocolType) {
      case OutlookProtocolType.Rpc:
        return internalProtocolConverterDictionary.Member;
      case OutlookProtocolType.RpcOverHttp:
        return externalProtocolConverterDictionary.Member;
      case OutlookProtocolType.Web:
        return webProtocolConverterDictionary.Member;
      default:
        return null;
    }
  }

  /// <summary>
  /// Gets the available user settings.
  /// </summary>
  static List<UserSettingName> get AvailableUserSettings =>
      availableUserSettings.Member;
}
