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

import 'dart:core';
import 'dart:io';

import 'package:ews/Autodiscover/ConfigurationSettings/ConfigurationSettingsBase.dart';
import 'package:ews/Autodiscover/ConfigurationSettings/Outlook/OutlookConfigurationSettings.dart';
import 'package:ews/Autodiscover/Requests/AutodiscoverRequest.dart';
import 'package:ews/Autodiscover/Requests/GetDomainSettingsRequest.dart';
import 'package:ews/Autodiscover/Requests/GetUserSettingsRequest.dart';
import 'package:ews/Autodiscover/Responses/GetDomainSettingsResponseCollection.dart';
import 'package:ews/Autodiscover/Responses/GetUserSettingsResponse.dart';
import 'package:ews/Autodiscover/Responses/GetUserSettingsResponseCollection.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeServiceBase.dart';
import 'package:ews/Enumerations/AutodiscoverEndpoints.dart';
import 'package:ews/Enumerations/AutodiscoverErrorCode.dart';
import 'package:ews/Enumerations/AutodiscoverResponseType.dart';
import 'package:ews/Enumerations/DomainSettingName.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/TraceFlags.dart' as enumerations;
import 'package:ews/Enumerations/UserSettingName.dart';
import 'package:ews/Exceptions/AutodiscoverLocalException.dart';
import 'package:ews/Exceptions/AutodiscoverRemoteException.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';
import 'package:ews/Xml/XmlException.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:ews/misc/Std/MemoryStream.dart';
import 'package:ews/misc/StringUtils.dart';
import 'package:ews/misc/UriHelper.dart';

/// <summary>
/// Defines a delegate that is used by the AutodiscoverService to ask whether a redirectionUrl can be used.
/// </summary>
/// <param name="redirectionUrl">Redirection URL that Autodiscover wants to use.</param>
/// <returns>Delegate returns true if Autodiscover is allowed to use this URL.</returns>
typedef AutodiscoverRedirectionUrlValidationCallback = bool Function(String redirectionUrl);

typedef GetDomainCallback = String Function();

/* private */
typedef GetSettingsMethod<TGetSettingsResponseCollection, TSettingName>
    = Future<TGetSettingsResponseCollection> Function(
        List<String> smtpAddresses,
        List<TSettingName> settings,
        ExchangeVersion requestedVersion,
        OutParam<Uri> autodiscoverUrl);

/// <summary>
/// Represents a binding to the Exchange Autodiscover Service.
/// </summary>
class AutodiscoverService extends ExchangeServiceBase {
  /// <summary>
  /// Autodiscover legacy path
  /// </summary>
  static const String _AutodiscoverLegacyPath = "/autodiscover/autodiscover.xml";

  /// <summary>
  /// Autodiscover legacy Url with protocol fill-in
  /// </summary>
//  static const String _AutodiscoverLegacyUrl = "{0}://{1}" + _AutodiscoverLegacyPath;

  /// <summary>
  /// Autodiscover legacy HTTPS Url
  /// </summary>
  static const String _AutodiscoverLegacyHttpsUrl = "https://{0}" + _AutodiscoverLegacyPath;

  /// <summary>
  /// Autodiscover legacy HTTP Url
  /// </summary>
  static const String _AutodiscoverLegacyHttpUrl = "http://{0}" + _AutodiscoverLegacyPath;

  /// <summary>
  /// Autodiscover SOAP HTTPS Url
  /// </summary>
  static const String _AutodiscoverSoapHttpsUrl = "https://{0}/autodiscover/autodiscover.svc";

  /// <summary>
  /// Autodiscover SOAP WS-Security HTTPS Url
  /// </summary>
//  static const String _AutodiscoverSoapWsSecurityHttpsUrl =
//      _AutodiscoverSoapHttpsUrl + "/wssecurity";

  /// <summary>
  /// Autodiscover SOAP WS-Security symmetrickey HTTPS Url
  /// </summary>
//  static const String _AutodiscoverSoapWsSecuritySymmetricKeyHttpsUrl =
//      _AutodiscoverSoapHttpsUrl + "/wssecurity/symmetrickey";

  /// <summary>
  /// Autodiscover SOAP WS-Security x509cert HTTPS Url
  /// </summary>
//  static const String _AutodiscoverSoapWsSecurityX509CertHttpsUrl =
//      _AutodiscoverSoapHttpsUrl + "/wssecurity/x509cert";

  /// <summary>
  /// Autodiscover request namespace
  /// </summary>
//  static const String _AutodiscoverRequestNamespace =
//      "http://schemas.microsoft.com/exchange/autodiscover/outlook/requestschema/2006";

  /// <summary>
  /// Legacy path regular expression.
  /// </summary>
  static RegExp _LegacyPathRegex =
      new RegExp("/autodiscover/([^/]+/)*autodiscover.xml", caseSensitive: false);

  /// <summary>
  /// Maximum number of Url (or address) redirections that will be followed by an Autodiscover call
  /// </summary>
  static const int AutodiscoverMaxRedirections = 10;

  /// <summary>
  /// HTTP header indicating that SOAP Autodiscover service is enabled.
  /// </summary>
  static const String _AutodiscoverSoapEnabledHeaderName = "X-SOAP-Enabled";

  /// <summary>
  /// HTTP header indicating that WS-Security Autodiscover service is enabled.
  /// </summary>
  static const String _AutodiscoverWsSecurityEnabledHeaderName = "X-WSSecurity-Enabled";

  /// <summary>
  /// HTTP header indicating that WS-Security/SymmetricKey Autodiscover service is enabled.
  /// </summary>
  static const String _AutodiscoverWsSecuritySymmetricKeyEnabledHeaderName =
      "X-WSSecurity-SymmetricKey-Enabled";

  /// <summary>
  /// HTTP header indicating that WS-Security/X509Cert Autodiscover service is enabled.
  /// </summary>
  static const String _AutodiscoverWsSecurityX509CertEnabledHeaderName =
      "X-WSSecurity-X509Cert-Enabled";

  /// <summary>
  /// HTTP header indicating that OAuth Autodiscover service is enabled.
  /// </summary>
  static const String _AutodiscoverOAuthEnabledHeaderName = "X-OAuth-Enabled";

  /// <summary>
  /// Minimum request version for Autodiscover SOAP service.
  /// </summary>
  static const ExchangeVersion _MinimumRequestVersionForAutoDiscoverSoapService =
      ExchangeVersion.Exchange2010;

  String _domain;
  bool _isExternal = true;
  Uri _url;
  AutodiscoverRedirectionUrlValidationCallback _redirectionUrlValidationCallback;

  // TODO: return AutodiscoverDnsClient
//        /* private */ AutodiscoverDnsClient dnsClient;
//        /* private */ IPAddress dnsServerAddress;
  bool _enableScpLookup = true;

  /// <summary>
  /// Default implementation of AutodiscoverRedirectionUrlValidationCallback.
  /// Always returns true indicating that the URL can be used.
  /// </summary>
  /// <param name="redirectionUrl">The redirection URL.</param>
  /// <returns>Returns true.</returns>
  /* private */
  bool DefaultAutodiscoverRedirectionUrlValidationCallback(String redirectionUrl) {
    throw new AutodiscoverLocalException(
        "string.Format(Strings.AutodiscoverRedirectBlocked, $redirectionUrl)");
  }

  /// <summary>
  /// Calls the Autodiscover service to get configuration settings at the specified URL.
  /// </summary>
  /// <typeparam name="TSettings">The type of the settings to retrieve.</typeparam>
  /// <param name="emailAddress">The email address to retrieve configuration settings for.</param>
  /// <param name="url">The URL of the Autodiscover service.</param>
  /// <returns>The requested configuration settings.</returns>
  TSettings _GetLegacyUserSettingsAtUrl<TSettings extends ConfigurationSettingsBase>(
      TSettings settings, String emailAddress, Uri url) {
    throw UnimplementedError("GetLegacyUserSettingsAtUrl");
//            this.TraceMessage(
//                enumerations.TraceFlags.AutodiscoverConfiguration,
//                "Trying to call Autodiscover for $emailAddress on $url.");
//
////            TSettings settings = new TSettings();
//
//            IEwsHttpWebRequest request = this.PrepareHttpWebRequestForUrl(url, false, false);
//
//            this.TraceHttpRequestHeaders(enumerations.TraceFlags.AutodiscoverRequestHttpHeaders, request);
//
//            using (Stream requestStream = request.GetRequestStream())
//            {
//                Stream writerStream = requestStream;
//
//                // If tracing is enabled, we generate the request in-memory so that we
//                // can pass it along to the ITraceListener. Then we copy the stream to
//                // the request stream.
//                if (this.IsTraceEnabledFor(enumerations.TraceFlags.AutodiscoverRequest))
//                {
//                    using (MemoryStream memoryStream = new MemoryStream())
//                    {
//                        using (StreamWriter writer = new StreamWriter(memoryStream))
//                        {
//                            this._WriteLegacyAutodiscoverRequest(emailAddress, settings, writer);
//                            writer.Flush();
//
//                            this.TraceXml(enumerations.TraceFlags.AutodiscoverRequest, memoryStream);
//
//                            EwsUtilities.CopyStream(memoryStream, requestStream);
//                        }
//                    }
//                }
//                else
//                {
//
//                    {
//                        this._WriteLegacyAutodiscoverRequest(emailAddress, settings, writer);
//                    }
//                }
//            }
//
//            using (IEwsHttpWebResponse webResponse = request.GetResponse())
//            {
//                OutParam<Uri> redirectUrlOutParam = OutParam();
//                if (this._TryGetRedirectionResponse(webResponse, redirectUrlOutParam))
//                {
//                    settings.MakeRedirectionResponse(redirectUrlOutParam.param);
//                    return settings;
//                }
//
//                using (Stream responseStream = webResponse.GetResponseStream())
//                {
//                    // If tracing is enabled, we read the entire response into a MemoryStream so that we
//                    // can pass it along to the ITraceListener. Then we parse the response from the
//                    // MemoryStream.
//                    if (this.IsTraceEnabledFor(enumerations.TraceFlags.AutodiscoverResponse))
//                    {
//                        using (MemoryStream memoryStream = new MemoryStream())
//                        {
//                            // Copy response stream to in-memory stream and reset to start
//                            EwsUtilities.CopyStream(responseStream, memoryStream);
//                            memoryStream.Position = 0;
//
//                            this.TraceResponse(webResponse, memoryStream);
//
//                            EwsXmlReader reader = new EwsXmlReader(memoryStream);
//                            reader.Read(XmlNodeType.XmlDeclaration);
//                            settings.LoadFromXml(reader);
//                        }
//                    }
//                    else
//                    {
//                        EwsXmlReader reader = new EwsXmlReader(responseStream);
//                        reader.Read(XmlNodeType.XmlDeclaration);
//                        settings.LoadFromXml(reader);
//                    }
//                }
//
//                return settings;
//            }
  }

  /// <summary>
  /// Writes the autodiscover request.
  /// </summary>
  /// <param name="emailAddress">The email address.</param>
  /// <param name="settings">The settings.</param>
  /// <param name="writer">The writer.</param>
//        void _WriteLegacyAutodiscoverRequest(
//            String emailAddress,
//            ConfigurationSettingsBase settings,
//            StreamWriter writer)
//        {
//            writer.Write("<Autodiscover xmlns=\"$AutodiscoverRequestNamespace\">");
//            writer.Write("<Request>");
//            writer.Write("<EMailAddress>$emailAddress</EMailAddress>");
//            writer.Write("<AcceptableResponseSchema>${settings.GetNamespace()}</AcceptableResponseSchema>");
//            writer.Write("</Request>");
//            writer.Write("</Autodiscover>");
//        }

  /// <summary>
  /// Gets a redirection URL to an SSL-enabled Autodiscover service from the standard non-SSL Autodiscover URL.
  /// </summary>
  /// <param name="domainName">The name of the domain to call Autodiscover on.</param>
  /// <returns>A valid SSL-enabled redirection URL. (May be null).</returns>
  Future<Uri> _GetRedirectUrl(String domainName) async {
    String url = _AutodiscoverLegacyHttpUrl.replaceAll("{0}", "autodiscover." + domainName);

    this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
        "Trying to get Autodiscover redirection URL from $url.");

    IEwsHttpWebRequest request = this.HttpWebRequestFactory.CreateRequestWithUrl(Uri.parse(url));

    request.Method = "GET";
    request.AllowAutoRedirect = false;
    request.PreAuthenticate = false;

    IEwsHttpWebResponse response = null;

    try {
      response = await request.GetResponse();
    } on WebException catch (ex) {
      this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration, "Request error: $ex");

      // The exception response factory requires a valid HttpWebResponse,
      // but there will be no web response if the web request couldn't be
      // actually be issued (e.g. due to DNS error).
      if (ex.Response != null) {
        response = this.HttpWebRequestFactory.CreateExceptionResponse(ex);
      }
    } on IOException catch (ex) {
      this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration, "I/O error: $ex");
    }

    if (response != null) {
      {
        OutParam<Uri> redirectUrl = OutParam();
        if (this._TryGetRedirectionResponse(response, redirectUrl)) {
          return redirectUrl.param;
        }
      }
    }

    this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
        "No Autodiscover redirection URL was returned.");

    return null;
  }

  /// <summary>
  /// Tries the get redirection response.
  /// </summary>
  /// <param name="response">The response.</param>
  /// <param name="redirectUrl">The redirect URL.</param>
  /// <returns>True if a valid redirection URL was found.</returns>
  bool _TryGetRedirectionResponse(IEwsHttpWebResponse response, OutParam<Uri> redirectUrlOutParam) {
    redirectUrlOutParam.param = null;
    if (AutodiscoverRequest.IsRedirectionResponse(response)) {
      // Get the redirect location and verify that it's valid.
      String location = response.Headers["Location"];

      if (!StringUtils.IsNullOrEmpty(location)) {
        try {
          redirectUrlOutParam.param = UriHelper.concat(response.ResponseUri, location);

          // Check if URL is SSL and that the path matches.
          // TODO check absolute path of the redirectUrl
          bool hasMatches = _LegacyPathRegex.hasMatch(redirectUrlOutParam.param.path);
          if ((redirectUrlOutParam.param.scheme == "https") && hasMatches) {
            this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
                "Redirection URL found: '${redirectUrlOutParam.param}'");

            return true;
          }
        } catch (UriFormatException) {
          this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
              "Invalid redirection URL was returned: '$location'");
          return false;
        }
      }
    }

    return false;
  }

  /// <summary>
  /// Calls the legacy Autodiscover service to retrieve configuration settings.
  /// </summary>
  /// <typeparam name="TSettings">The type of the settings to retrieve.</typeparam>
  /// <param name="emailAddress">The email address to retrieve configuration settings for.</param>
  /// <returns>The requested configuration settings.</returns>
  Future<TSettings> GetLegacyUserSettings<TSettings extends ConfigurationSettingsBase>(
      TSettings newSettings, String emailAddress) async {
    // If Url is specified, call service directly.
    if (this.Url != null) {
      bool hasMatch = _LegacyPathRegex.hasMatch(this.Url.path);
      if (hasMatch) {
        return this._GetLegacyUserSettingsAtUrl<TSettings>(newSettings, emailAddress, this.Url);
      }

      // this.Uri is intended for Autodiscover SOAP service, convert to Legacy endpoint URL.
      Uri autodiscoverUrl = UriHelper.concat(this.Url, _AutodiscoverLegacyPath);
      return this
          ._GetLegacyUserSettingsAtUrl<TSettings>(newSettings, emailAddress, autodiscoverUrl);
    }

    // If Domain is specified, figure out the endpoint Url and call service.
    else if (!StringUtils.IsNullOrEmpty(this.Domain)) {
      Uri autodiscoverUrl = Uri.parse(_AutodiscoverLegacyHttpsUrl.replaceAll("{0}", this.Domain));
      return this
          ._GetLegacyUserSettingsAtUrl<TSettings>(newSettings, emailAddress, autodiscoverUrl);
    } else {
      // No Url or Domain specified, need to figure out which endpoint to use.
      OutParam<int> currentHopOutParam = OutParam()..param = 1;
      List<String> redirectionEmailAddresses = new List<String>();
      return await this.InternalGetLegacyUserSettings<TSettings>(
          newSettings, emailAddress, redirectionEmailAddresses, currentHopOutParam);
    }
  }

  /// <summary>
  /// Calls the legacy Autodiscover service to retrieve configuration settings.
  /// </summary>
  /// <typeparam name="TSettings">The type of the settings to retrieve.</typeparam>
  /// <param name="emailAddress">The email address to retrieve configuration settings for.</param>
  /// <param name="redirectionEmailAddresses">List of previous email addresses.</param>
  /// <param name="currentHop">Current number of redirection urls/addresses attempted so far.</param>
  /// <returns>The requested configuration settings.</returns>
  /* private */
  Future<TSettings> InternalGetLegacyUserSettings<TSettings extends ConfigurationSettingsBase>(
      TSettings newSettings,
      String emailAddress,
      List<String> redirectionEmailAddresses,
      OutParam<int> currentHopOutParam) async {
    String domainName = EwsUtilities.DomainFromEmailAddress(emailAddress);

    OutParam<int> scpUrlCountOutParam = OutParam();
    scpUrlCountOutParam.param = 0;
    List<Uri> urls = this.GetAutodiscoverServiceUrls(domainName, scpUrlCountOutParam);

    if (urls.length == 0) {
      throw new ServiceValidationException("Strings.AutodiscoverServiceRequestRequiresDomainOrUrl");
    }

    // Assume caller is not inside the Intranet, regardless of whether SCP Urls
    // were returned or not. SCP Urls are only relevant if one of them returns
    // valid Autodiscover settings.
    this._isExternal = true;

    int currentUrlIndex = 0;

    // Used to save exception for later reporting.
    Exception delayedException = null;
    OutParam<TSettings> settingsOutParam = OutParam();

    do {
      Uri autodiscoverUrl = urls[currentUrlIndex];
      bool isScpUrl = currentUrlIndex < scpUrlCountOutParam.param;

      try {
        settingsOutParam.param =
            this._GetLegacyUserSettingsAtUrl<TSettings>(newSettings, emailAddress, autodiscoverUrl);

        switch (settingsOutParam.param.ResponseType) {
          case AutodiscoverResponseType.Success:
            // Not external if Autodiscover endpoint found via SCP returned the settings.
            if (isScpUrl) {
              this.IsExternal = false;
            }
            this.Url = autodiscoverUrl;
            return settingsOutParam.param;
          case AutodiscoverResponseType.RedirectUrl:
            if (currentHopOutParam.param < AutodiscoverMaxRedirections) {
              currentHopOutParam.param++;
              this.TraceMessage(enumerations.TraceFlags.AutodiscoverResponse,
                  "Autodiscover service returned redirection URL '${settingsOutParam.param.RedirectTarget}'.");

              urls[currentUrlIndex] = Uri.parse(settingsOutParam.param.RedirectTarget);
            } else {
              throw new AutodiscoverLocalException("Strings.MaximumRedirectionHopsExceeded");
            }
            break;
          case AutodiscoverResponseType.RedirectAddress:
            if (currentHopOutParam.param < AutodiscoverMaxRedirections) {
              currentHopOutParam.param++;
              this.TraceMessage(enumerations.TraceFlags.AutodiscoverResponse,
                  "Autodiscover service returned redirection email address '${settingsOutParam.param.RedirectTarget}'.");

              // If this email address was already tried, we may have a loop
              // in SCP lookups. Disable consideration of SCP records.
              this._DisableScpLookupIfDuplicateRedirection(
                  settingsOutParam.param.RedirectTarget, redirectionEmailAddresses);

              return this.InternalGetLegacyUserSettings<TSettings>(
                  newSettings,
                  settingsOutParam.param.RedirectTarget,
                  redirectionEmailAddresses,
                  currentHopOutParam);
            } else {
              throw new AutodiscoverLocalException("Strings.MaximumRedirectionHopsExceeded");
            }
            break;
          case AutodiscoverResponseType.Error:
            // Don't treat errors from an SCP-based Autodiscover service to be conclusive.
            // We'll try the next one and record the error for later.
            if (isScpUrl) {
              this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
                  "Error returned by Autodiscover service found via SCP, treating as inconclusive.");

              delayedException = new AutodiscoverRemoteException(
                  "Strings.AutodiscoverError", settingsOutParam.param.Error);
              currentUrlIndex++;
            } else {
              throw new AutodiscoverRemoteException(
                  "Strings.AutodiscoverError", settingsOutParam.param.Error);
            }
            break;
          default:
            EwsUtilities.Assert(false, "Autodiscover.GetConfigurationSettings",
                "An unexpected error has occurred. This code path should never be reached.");
            break;
        }
      } on WebException catch (ex) {
        if (ex.Response != null) {
          IEwsHttpWebResponse response = this.HttpWebRequestFactory.CreateExceptionResponse(ex);
          OutParam<Uri> redirectUrlOutParam = OutParam();
          if (this._TryGetRedirectionResponse(response, redirectUrlOutParam)) {
            this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
                "Host returned a redirection to url ${redirectUrlOutParam.param}");

            currentHopOutParam.param++;
            urls[currentUrlIndex] = redirectUrlOutParam.param;
          } else {
            this.ProcessHttpErrorResponse(response, ex);

            this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
                "$_url failed: ${ex.runtimeType} (${ex.message})");

            // The url did not work, let's try the next.
            currentUrlIndex++;
          }
        } else {
          this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
              "$_url failed: ${ex.runtimeType} (${ex.message})");

          // The url did not work, let's try the next.
          currentUrlIndex++;
        }
      } on XmlException catch (ex) {
        this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
            "$_url failed: XML parsing error: $ex");

        // The content at the URL wasn't a valid response, let's try the next.
        currentUrlIndex++;
      } on IOException catch (ex) {
        this.TraceMessage(
            enumerations.TraceFlags.AutodiscoverConfiguration, "$_url failed: I/O error: $ex");

        // The content at the URL wasn't a valid response, let's try the next.
        currentUrlIndex++;
      }
    } while (currentUrlIndex < urls.length);

    // If we got this far it's because none of the URLs we tried have worked. As a next-to-last chance, use GetRedirectUrl to

    // redirection URL to get the configuration settings for this email address. (This will be a common scenario for
    // DataCenter deployments).
    Uri redirectionUrl = await this._GetRedirectUrl(domainName);
    if ((redirectionUrl != null) &&
        await this.TryLastChanceHostRedirection<TSettings>(
            newSettings, emailAddress, redirectionUrl, settingsOutParam)) {
      return settingsOutParam.param;
    } else {
      // Getting a redirection URL from an HTTP GET failed too. As a last chance, try to get an appropriate SRV Record

      throw UnimplementedError("GetRedirectionUrlFromDnsSrvRecord");
//                redirectionUrl = this.GetRedirectionUrlFromDnsSrvRecord(domainName);
      if ((redirectionUrl != null) &&
          await this.TryLastChanceHostRedirection<TSettings>(
              newSettings, emailAddress, redirectionUrl, settingsOutParam)) {
        return settingsOutParam.param;
      }

      // If there was an earlier exception, throw it.
      else if (delayedException != null) {
        throw delayedException;
      } else {
        throw new AutodiscoverLocalException("Strings.AutodiscoverCouldNotBeLocated");
      }
    }
  }

  /// <summary>
  /// Get an autodiscover SRV record in DNS and construct autodiscover URL.
  /// </summary>
  /// <param name="domainName">Name of the domain.</param>
  /// <returns>Autodiscover URL (may be null if lookup failed)</returns>
//        Uri GetRedirectionUrlFromDnsSrvRecord(String domainName)
//        {
//            this.TraceMessage(
//                TraceFlags.AutodiscoverConfiguration,
//                string.Format("Trying to get Autodiscover host from DNS SRV record for {0}.", domainName));
//
//            String hostname = this.dnsClient.FindAutodiscoverHostFromSrv(domainName);
//            if (!StringUtils.IsNullOrEmpty(hostname))
//            {
//                this.TraceMessage(
//                    TraceFlags.AutodiscoverConfiguration,
//                    string.Format("Autodiscover host {0} was returned.", hostname));
//
//                return new Uri(string.Format(AutodiscoverLegacyHttpsUrl, hostname));
//            }
//            else
//            {
//                this.TraceMessage(
//                    TraceFlags.AutodiscoverConfiguration,
//                    "No matching Autodiscover DNS SRV records were found.");
//
//                return null;
//            }
//        }

  /// <summary>

  /// </summary>
  /// <typeparam name="TSettings">The type of the settings.</typeparam>
  /// <param name="emailAddress">The email address.</param>
  /// <param name="redirectionUrl">Redirection Url.</param>
  /// <param name="settings">The settings.</param>
  /* private */
  Future<bool> TryLastChanceHostRedirection<TSettings extends ConfigurationSettingsBase>(
      TSettings newSettings,
      String emailAddress,
      Uri redirectionUrl,
      OutParam<TSettings> settings) async {
    settings.param = null;

    List<String> redirectionEmailAddresses = new List<String>();

    // Bug 60274: Performing a non-SSL HTTP GET to retrieve a redirection URL is potentially unsafe. We allow the caller
    // to specify delegate to be called to determine whether we are allowed to use the redirection URL.
    if (this.CallRedirectionUrlValidationCallback(redirectionUrl.toString())) {
      for (int currentHop = 0;
          currentHop < AutodiscoverService.AutodiscoverMaxRedirections;
          currentHop++) {
        try {
          settings.param = this
              ._GetLegacyUserSettingsAtUrl<TSettings>(newSettings, emailAddress, redirectionUrl);

          switch (settings.param.ResponseType) {
            case AutodiscoverResponseType.Success:
              return true;
            case AutodiscoverResponseType.Error:
              throw new AutodiscoverRemoteException(
                  "Strings.AutodiscoverError", settings.param.Error);
            case AutodiscoverResponseType.RedirectAddress:
              // If this email address was already tried, we may have a loop
              // in SCP lookups. Disable consideration of SCP records.
              this._DisableScpLookupIfDuplicateRedirection(
                  settings.param.RedirectTarget, redirectionEmailAddresses);

              settings.param = await this.InternalGetLegacyUserSettings<TSettings>(
                  newSettings,
                  settings.param.RedirectTarget,
                  redirectionEmailAddresses,
                  OutParam()..param = currentHop);
              return true;
            case AutodiscoverResponseType.RedirectUrl:
              try {
                redirectionUrl = Uri.parse(settings.param.RedirectTarget);
              } catch (UriFormatException) {
                this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
                    "Service returned invalid redirection URL ${settings.param.RedirectTarget}");
                return false;
              }
              break;
            default:
              String failureMessage =
                  "Autodiscover call at $redirectionUrl failed with error ${settings.param.ResponseType}, target ${settings.param.RedirectTarget}";
              this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration, failureMessage);
              return false;
          }
        } on WebException catch (ex) {
          if (ex.Response != null) {
            IEwsHttpWebResponse response = this.HttpWebRequestFactory.CreateExceptionResponse(ex);
            if (this._TryGetRedirectionResponse(response, OutParam()..param = redirectionUrl)) {
              this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
                  "Host returned a redirection to url ${redirectionUrl}");
              continue;
            } else {
              this.ProcessHttpErrorResponse(response, ex);
            }
          }

          this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
              "$_url failed: ${ex.runtimeType} (${ex.message})");

          return false;
        } on XmlException catch (ex) {
          // If the response is malformed, it wasn't a valid Autodiscover endpoint.
          this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
              "$redirectionUrl failed: XML parsing error: $ex");
          return false;
        } on IOException catch (ex) {
          this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
              "$redirectionUrl failed: I/O error: $ex");
          return false;
        }
      }
    }

    return false;
  }

  /// <summary>
  /// Disables SCP lookup if duplicate email address redirection.
  /// </summary>
  /// <param name="emailAddress">The email address to use.</param>
  /// <param name="redirectionEmailAddresses">The list of prior redirection email addresses.</param>
  void _DisableScpLookupIfDuplicateRedirection(
      String emailAddress, List<String> redirectionEmailAddresses) {
    // SMTP addresses are case-insensitive so entries are converted to lower-case.
    emailAddress = emailAddress.toLowerCase();

    if (redirectionEmailAddresses.contains(emailAddress)) {
      this.EnableScpLookup = false;
    } else {
      redirectionEmailAddresses.add(emailAddress);
    }
  }

  /// <summary>
  /// Gets user settings from Autodiscover legacy endpoint.
  /// </summary>
  /// <param name="emailAddress">The email address.</param>
  /// <param name="requestedSettings">The requested settings.</param>
  /// <returns>GetUserSettingsResponse</returns>
  Future<GetUserSettingsResponse> InternalGetLegacyUserSettingsSimple(
      String emailAddress, List<UserSettingName> requestedSettings) async {
    // Cannot call legacy Autodiscover service with WindowsLive and other WSSecurity-based credentials
    // TODO implement WSSecurityBasedCredentials
//            if ((this.Credentials != null) && (this.Credentials is WSSecurityBasedCredentials))
//            {
//                throw new AutodiscoverLocalException("Strings.WLIDCredentialsCannotBeUsedWithLegacyAutodiscover");
//            }

    OutlookConfigurationSettings settings = await this
        .GetLegacyUserSettings<OutlookConfigurationSettings>(
            OutlookConfigurationSettings(), emailAddress);

    return settings.ConvertSettings(emailAddress, requestedSettings);
  }

  /// <summary>
  /// Calls the SOAP Autodiscover service for user settings for a single SMTP address.
  /// </summary>
  /// <param name="smtpAddress">SMTP address.</param>
  /// <param name="requestedSettings">The requested settings.</param>
  /// <returns></returns>
  Future<GetUserSettingsResponse> InternalGetSoapUserSettings(
      String smtpAddress, List<UserSettingName> requestedSettings) async {
    List<String> smtpAddresses = new List<String>();
    smtpAddresses.add(smtpAddress);

    List<String> redirectionEmailAddresses = new List<String>();
    redirectionEmailAddresses.add(smtpAddress.toLowerCase());

    for (int currentHop = 0;
        currentHop < AutodiscoverService.AutodiscoverMaxRedirections;
        currentHop++) {
      GetUserSettingsResponse response =
          (await this.GetUserSettingsWithSmptAddresses(smtpAddresses, requestedSettings))[0];

      switch (response.ErrorCode) {
        case AutodiscoverErrorCode.RedirectAddress:
          this.TraceMessage(enumerations.TraceFlags.AutodiscoverResponse,
              "Autodiscover service returned redirection email address '${response.RedirectTarget}'.");

          smtpAddresses.clear();
          smtpAddresses.add(response.RedirectTarget.toLowerCase());
          this.Url = null;
          this.Domain = null;

          // If this email address was already tried, we may have a loop
          // in SCP lookups. Disable consideration of SCP records.
          this._DisableScpLookupIfDuplicateRedirection(
              response.RedirectTarget, redirectionEmailAddresses);
          break;

        case AutodiscoverErrorCode.RedirectUrl:
          this.TraceMessage(enumerations.TraceFlags.AutodiscoverResponse,
              "Autodiscover service returned redirection URL '${response.RedirectTarget}'");

          this.Url = this.Credentials.AdjustUrl(Uri.parse(response.RedirectTarget));
          break;

        case AutodiscoverErrorCode.NoError:
        default:
          return response;
      }
    }

    throw new AutodiscoverLocalException("Strings.AutodiscoverCouldNotBeLocated");
  }

  /// <summary>

  /// </summary>
  /// <param name="smtpAddresses">The SMTP addresses of the users.</param>
  /// <param name="settings">The settings.</param>
  /// <returns></returns>
  Future<GetUserSettingsResponseCollection> GetUserSettingsWithSmptAddresses(
      List<String> smtpAddresses, List<UserSettingName> settings) {
    EwsUtilities.ValidateParam(smtpAddresses, "smtpAddresses");
    EwsUtilities.ValidateParam(settings, "settings");

    return this.GetSettings<GetUserSettingsResponseCollection, UserSettingName>(
        smtpAddresses, settings, null, this._InternalGetUserSettings, () {
      return EwsUtilities.DomainFromEmailAddress(smtpAddresses[0]);
    });
  }

  /// <summary>

  /// </summary>
  /// <typeparam name="TGetSettingsResponseCollection">Type of response collection to return.</typeparam>
  /// <typeparam name="TSettingName">Type of setting name.</typeparam>
  /// <param name="identities">Either the domains or the SMTP addresses of the users.</param>
  /// <param name="settings">The settings.</param>
  /// <param name="requestedVersion">Requested version of the Exchange service.</param>
  /// <param name="getSettingsMethod">The method to use.</param>
  /// <param name="getDomainMethod">The method to calculate the domain value.</param>
  /// <returns></returns>
  /* private */
  Future<TGetSettingsResponseCollection> GetSettings<TGetSettingsResponseCollection, TSettingName>(
      List<String> identities,
      List<TSettingName> settings,
      ExchangeVersion requestedVersion,
      GetSettingsMethod<TGetSettingsResponseCollection, TSettingName> getSettingsMethod,
      GetDomainCallback getDomainMethod) async {
    TGetSettingsResponseCollection response;

    // Autodiscover service only exists in E14 or later.
    if (this.RequestedServerVersion.index <
        _MinimumRequestVersionForAutoDiscoverSoapService.index) {
      throw new ServiceVersionException("""string.Format(
                        Strings.AutodiscoverServiceIncompatibleWithRequestVersion,
                        MinimumRequestVersionForAutoDiscoverSoapService)""");
    }

    // If Url is specified, call service directly.
    if (this.Url != null) {
      OutParam<Uri> autodiscoverUrl = OutParam();
      autodiscoverUrl.param = this.Url;

      response = await getSettingsMethod(identities, settings, requestedVersion, autodiscoverUrl);

      this.Url = autodiscoverUrl.param;
      return response;
    }

    // If Domain is specified, determine endpoint Url and call service.
    else if (!StringUtils.IsNullOrEmpty(this.Domain)) {
      OutParam<String> hostOutParam = OutParam()..param = this.Domain;
      OutParam<Uri> autodiscoverUrl = OutParam();
      autodiscoverUrl.param = await this._GetAutodiscoverEndpointUrl(hostOutParam);
      this.Domain = hostOutParam.param;
      response = await getSettingsMethod(identities, settings, requestedVersion, autodiscoverUrl);

      // If we got this far, response was successful, set Url.
      this.Url = autodiscoverUrl.param;
      return response;
    }

    // No Url or Domain specified, need to figure out which endpoint(s) to try.
    else {
      // Assume caller is not inside the Intranet, regardless of whether SCP Urls
      // were returned or not. SCP Urls are only relevent if one of them returns
      // valid Autodiscover settings.
      this.IsExternal = true;

      OutParam<Uri> autodiscoverUrlOutParam = OutParam();

      String domainName = getDomainMethod();
      OutParam<int> scpHostCountOutParam = OutParam();
      List<String> hosts = await this.GetAutodiscoverServiceHosts(domainName, scpHostCountOutParam);

      if (hosts.length == 0) {
        throw new ServiceValidationException(
            "Strings.AutodiscoverServiceRequestRequiresDomainOrUrl");
      }

      for (int currentHostIndex = 0; currentHostIndex < hosts.length; currentHostIndex++) {
        OutParam<String> hostOutParam = OutParam()..param = hosts[currentHostIndex];
        bool isScpHost = currentHostIndex < scpHostCountOutParam.param;

        if (await this._TryGetAutodiscoverEndpointUrl(hostOutParam, autodiscoverUrlOutParam)) {
          try {
            response = await getSettingsMethod(
                identities, settings, requestedVersion, autodiscoverUrlOutParam);

            // If we got this far, the response was successful, set Url.
            this.Url = autodiscoverUrlOutParam.param;

            // Not external if Autodiscover endpoint found via SCP returned the settings.
            if (isScpHost) {
              this.IsExternal = false;
            }

            return response;
          } catch (AutodiscoverResponseException) {
            // skip
          } catch (ServiceRequestException) {
            // skip
          }
        }
      }

      // Next-to-last chance: try unauthenticated GET over HTTP to be redirected to appropriate service endpoint.
      autodiscoverUrlOutParam.param = await this._GetRedirectUrl(domainName);
      if ((autodiscoverUrlOutParam.param != null) &&
          this.CallRedirectionUrlValidationCallback(autodiscoverUrlOutParam.param.toString()) &&
          await this._TryGetAutodiscoverEndpointUrl(
              OutParam()..param = autodiscoverUrlOutParam.param.host, autodiscoverUrlOutParam)) {
        response = await getSettingsMethod(
            identities, settings, requestedVersion, autodiscoverUrlOutParam);

        // If we got this far, the response was successful, set Url.
        this.Url = autodiscoverUrlOutParam.param;

        return response;
      }

      // Last Chance: try to read autodiscover SRV Record from DNS. If we find one, use
      // the hostname returned to construct an Autodiscover endpoint URL.
      // TODO: Implement SVR Record from DNS
//                autodiscoverUrl = this.GetRedirectionUrlFromDnsSrvRecord(domainName);
//                if ((autodiscoverUrl != null) &&
//                    this.CallRedirectionUrlValidationCallback(autodiscoverUrl.ToString()) &&
//                        this.TryGetAutodiscoverEndpointUrl(autodiscoverUrl.Host, out autodiscoverUrl))
//                {
//                    response = getSettingsMethod(
//                                    identities,
//                                    settings,
//                                    requestedVersion,
//                                    ref autodiscoverUrl);
//
//                    // If we got this far, the response was successful, set Url.
//                    this.Url = autodiscoverUrl;
//
//                    return response;
//                }
//                else
//                {
      throw new AutodiscoverLocalException("Strings.AutodiscoverCouldNotBeLocated");
//                }
    }
  }

  /// <summary>
  /// Gets settings for one or more users.
  /// </summary>
  /// <param name="smtpAddresses">The SMTP addresses of the users.</param>
  /// <param name="settings">The settings.</param>
  /// <param name="requestedVersion">Requested version of the Exchange service.</param>
  /// <param name="autodiscoverUrl">The autodiscover URL.</param>
  /// <returns>GetUserSettingsResponse collection.</returns>
  Future<GetUserSettingsResponseCollection> _InternalGetUserSettings(
      List<String> smtpAddresses,
      List<UserSettingName> settings,
      ExchangeVersion requestedVersion,
      OutParam<Uri> autodiscoverUrlOutParam) async {
    // The response to GetUserSettings can be a redirection. Execute GetUserSettings until we get back
    // a valid response or we've followed too many redirections.
    for (int currentHop = 0;
        currentHop < AutodiscoverService.AutodiscoverMaxRedirections;
        currentHop++) {
      GetUserSettingsRequest request =
          new GetUserSettingsRequest(this, autodiscoverUrlOutParam.param);
      request.SmtpAddresses = smtpAddresses;
      request.Settings = settings;
      GetUserSettingsResponseCollection response = await request.Execute();

      // Did we get redirected?
      if (response.ErrorCode == AutodiscoverErrorCode.RedirectUrl &&
          response.RedirectionUrl != null) {
        this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
            "Request to ${autodiscoverUrlOutParam.param} returned redirection to ${response.RedirectionUrl}");

        // this url need be brought back to the caller.
        //
        autodiscoverUrlOutParam.param = response.RedirectionUrl;
      } else {
        return response;
      }
    }

    this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
        "Maximum number of redirection hops $AutodiscoverMaxRedirections exceeded");

    throw new AutodiscoverLocalException("Strings.MaximumRedirectionHopsExceeded");
  }

  /// <summary>

  /// </summary>
  /// <param name="domains">The domains.</param>
  /// <param name="settings">The settings.</param>
  /// <param name="requestedVersion">Requested version of the Exchange service.</param>
  /// <returns>GetDomainSettingsResponse collection.</returns>
//        GetDomainSettingsResponseCollection GetDomainSettings(
//            List<String> domains,
//            List<DomainSettingName> settings,
//            ExchangeVersion? requestedVersion)
//        {
//            EwsUtilities.ValidateParam(domains, "domains");
//            EwsUtilities.ValidateParam(settings, "settings");
//
//            return this.GetSettings<GetDomainSettingsResponseCollection, DomainSettingName>(
//                domains,
//                settings,
//                requestedVersion,
//                this.InternalGetDomainSettings,
//                delegate() { return domains[0]; });
//        }

  /// <summary>
  /// Gets settings for one or more domains.
  /// </summary>
  /// <param name="domains">The domains.</param>
  /// <param name="settings">The settings.</param>
  /// <param name="requestedVersion">Requested version of the Exchange service.</param>
  /// <param name="autodiscoverUrl">The autodiscover URL.</param>
  /// <returns>GetDomainSettingsResponse collection.</returns>
  Future<GetDomainSettingsResponseCollection> _InternalGetDomainSettings(
      List<String> domains,
      List<DomainSettingName> settings,
      ExchangeVersion requestedVersion,
      OutParam<Uri> autodiscoverUrlOutParam) async {
    // The response to GetDomainSettings can be a redirection. Execute GetDomainSettings until we get back
    // a valid response or we've followed too many redirections.
    for (int currentHop = 0;
        currentHop < AutodiscoverService.AutodiscoverMaxRedirections;
        currentHop++) {
      GetDomainSettingsRequest request =
          new GetDomainSettingsRequest(this, autodiscoverUrlOutParam.param);
      request.Domains = domains;
      request.Settings = settings;
      request.RequestedVersion = requestedVersion;
      GetDomainSettingsResponseCollection response = await request.Execute();

      // Did we get redirected?
      if (response.ErrorCode == AutodiscoverErrorCode.RedirectUrl &&
          response.RedirectionUrl != null) {
        autodiscoverUrlOutParam.param = response.RedirectionUrl;
      } else {
        return response;
      }
    }

    this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
        "Maximum number of redirection hops $AutodiscoverMaxRedirections exceeded");

    throw new AutodiscoverLocalException("Strings.MaximumRedirectionHopsExceeded");
  }

  /// <summary>
  /// Gets the autodiscover endpoint URL.
  /// </summary>
  /// <param name="host">The host.</param>
  /// <returns></returns>
  Future<Uri> _GetAutodiscoverEndpointUrl(OutParam<String> host) async {
    OutParam<Uri> autodiscoverUrlOutParam = OutParam();

    if (await this._TryGetAutodiscoverEndpointUrl(host, autodiscoverUrlOutParam)) {
      return autodiscoverUrlOutParam.param;
    } else {
      throw new AutodiscoverLocalException("Strings.NoSoapOrWsSecurityEndpointAvailable");
    }
  }

  /// <summary>
  /// Tries the get Autodiscover Service endpoint URL.
  /// </summary>
  /// <param name="host">The host.</param>
  /// <param name="url">The URL.</param>
  /// <returns></returns>
  Future<bool> _TryGetAutodiscoverEndpointUrl(
      OutParam<String> hostOutParam, OutParam<Uri> urlOutParam) async {
    urlOutParam.param = null;

    OutParam<Set<AutodiscoverEndpoints>> endpointsOutParam = OutParam();
    if (await this._TryGetEnabledEndpointsForHost(hostOutParam, endpointsOutParam)) {
      urlOutParam.param =
          Uri.parse(_AutodiscoverSoapHttpsUrl.replaceAll("{0}", hostOutParam.param));

      // Make sure that at least one of the non-legacy endpoints is available.
      if (!endpointsOutParam.param.contains(AutodiscoverEndpoints.Soap) &&
          !endpointsOutParam.param.contains(AutodiscoverEndpoints.WsSecurity) &&
          !endpointsOutParam.param.contains(AutodiscoverEndpoints.WSSecuritySymmetricKey) &&
          !endpointsOutParam.param.contains(AutodiscoverEndpoints.WSSecurityX509Cert) &&
          !endpointsOutParam.param.contains(AutodiscoverEndpoints.OAuth)) {
        this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
            "No Autodiscover endpoints are available  for host ${hostOutParam.param}");

        return false;
      }

      // If we have WLID credentials, make sure that we have a WS-Security endpoint
//                if (this.Credentials is WindowsLiveCredentials)
//                {
//                    if (endpoints.contains(utodiscoverEndpoints.WsSecurity)
//                    {
//                        this.TraceMessage(
//                            TraceFlags.AutodiscoverConfiguration,
//                            string.Format("No Autodiscover WS-Security endpoint is available for host {0}", host));
//
//                        return false;
//                    }
//                    else
//                    {
//                        url = new Uri(string.Format(AutodiscoverSoapWsSecurityHttpsUrl, host));
//                    }
//                }
//                else if (this.Credentials is PartnerTokenCredentials)
//                {
//                    if (endpoints.contains(utodiscoverEndpoints.WSSecuritySymmetricKey)
//                    {
//                        this.TraceMessage(
//                            enumerations.TraceFlags.AutodiscoverConfiguration,
//                            "No Autodiscover WS-Security/SymmetricKey endpoint is available for host $host");
//
//                        return false;
//                    }
//                    else
//                    {
//                        url = new Uri(string.Format(AutodiscoverSoapWsSecuritySymmetricKeyHttpsUrl, host));
//                    }
//                }
//                else if (this.Credentials is X509CertificateCredentials)
//                {
//                    if (endpoints.contains(utodiscoverEndpoints.WSSecurityX509Cert)
//                    {
//                        this.TraceMessage(
//                            enumerations.TraceFlags.AutodiscoverConfiguration,
//                            "No Autodiscover WS-Security/X509Cert endpoint is available for host $host");
//
//                        return false;
//                    }
//                    else
//                    {
//                        url = new Uri(string.Format(AutodiscoverSoapWsSecurityX509CertHttpsUrl, host));
//                    }
//                }
//                else if (this.Credentials is OAuthCredentials)
//                {
//                    // If the credential is OAuthCredentials, no matter whether we have
//                    // the corresponding x-header, we will go with OAuth.
//                    url = new Uri(string.Format(AutodiscoverSoapHttpsUrl, host));
//                }

      return true;
    } else {
      this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
          "No Autodiscover endpoints are available for host ${hostOutParam.param}");

      return false;
    }
  }

  /// <summary>
  /// Defaults the get autodiscover service urls for domain.
  /// </summary>
  /// <param name="domainName">Name of the domain.</param>
  /// <returns></returns>
//        /* private */ List<String> DefaultGetScpUrlsForDomain(String domainName)
//        {
//            DirectoryHelper helper = new DirectoryHelper(this);
//            return helper.GetAutodiscoverScpUrlsForDomain(domainName);
//        }

  /// <summary>
  /// Gets the list of autodiscover service URLs.
  /// </summary>
  /// <param name="domainName">Domain name.</param>
  /// <param name="scpHostCount">Count of hosts found via SCP lookup.</param>
  /// <returns>List of Autodiscover URLs.</returns>
  List<Uri> GetAutodiscoverServiceUrls(String domainName, OutParam<int> scpHostCountOutParam) {
    List<Uri> urls = new List<Uri>();

    if (this._enableScpLookup) {
      // Get SCP URLs
      throw UnimplementedError("Unimplemented ScpLookup");
//                Func<string, ICollection<String>> callback = this.GetScpUrlsForDomainCallback ?? this.DefaultGetScpUrlsForDomain;
//                List<String> scpUrls = callback(domainName);
//                for (String str in scpUrls)
//                {
//                    urls.add(Uri.parse(str));
//                }
    }

    scpHostCountOutParam.param = urls.length;

    // As a fallback, add autodiscover URLs base on the domain name.
    urls.add(Uri.parse(_AutodiscoverLegacyHttpsUrl.replaceAll("{0}", domainName)));
    urls.add(
        Uri.parse(_AutodiscoverLegacyHttpsUrl.replaceAll("{0}", "autodiscover." + domainName)));

    return urls;
  }

  /// <summary>
  /// Gets the list of autodiscover service hosts.
  /// </summary>
  /// <param name="domainName">Name of the domain.</param>
  /// <param name="scpHostCount">Count of SCP hosts that were found.</param>
  /// <returns>List of host names.</returns>
  List<String> GetAutodiscoverServiceHosts(String domainName, OutParam<int> scpHostCountOutParam) {
    List<String> serviceHosts = new List<String>();
    for (Uri url in this.GetAutodiscoverServiceUrls(domainName, scpHostCountOutParam)) {
      serviceHosts.add(url.host);
    }

    return serviceHosts;
  }

  /// <summary>
  /// Gets the enabled autodiscover endpoints on a specific host.
  /// </summary>
  /// <param name="host">The host.</param>
  /// <param name="endpoints">Endpoints found for host.</param>
  /// <returns>Flags indicating which endpoints are enabled.</returns>
  Future<bool> _TryGetEnabledEndpointsForHost(
      OutParam<String> hostOutParam, OutParam<Set<AutodiscoverEndpoints>> endpointsOutParam) async {
    this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
        "Determining which endpoints are enabled for host ${hostOutParam.param}");

    // We may get redirected to another host. And therefore need to limit the number
    // of redirections we'll tolerate.
    for (int currentHop = 0; currentHop < AutodiscoverMaxRedirections; currentHop++) {
      Uri autoDiscoverUrl =
          Uri.parse(_AutodiscoverLegacyHttpsUrl.replaceAll("{0}", hostOutParam.param));

      endpointsOutParam.param = Set.of([AutodiscoverEndpoints.None]);

      IEwsHttpWebRequest request = this.HttpWebRequestFactory.CreateRequestWithUrl(autoDiscoverUrl);

      request.Method = "GET";
      request.AllowAutoRedirect = false;
      request.PreAuthenticate = false;
      request.UseDefaultCredentials = false;

      IEwsHttpWebResponse response = null;

      try {
        response = await request.GetResponse();
      } on WebException catch (ex) {
        this.TraceMessage(
            enumerations.TraceFlags.AutodiscoverConfiguration, "Request error: ${ex.message}");

        // The exception response factory requires a valid HttpWebResponse,
        // but there will be no web response if the web request couldn't be
        // actually be issued (e.g. due to DNS error).
        if (ex.Response != null) {
          response = this.HttpWebRequestFactory.CreateExceptionResponse(ex);
        }
      } on IOException catch (ex) {
        this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration, "I/O error: $ex");
      }

      if (response != null) {
        {
          OutParam<Uri> redirectUrlOutParam = OutParam();
          if (this._TryGetRedirectionResponse(response, redirectUrlOutParam)) {
            this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
                "Host returned redirection to host '${redirectUrlOutParam.param.host}'");

            hostOutParam.param = redirectUrlOutParam.param.host;
          } else {
            endpointsOutParam.param = await this._GetEndpointsFromHttpWebResponse(response);

            this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
                "Host returned enabled endpoint flags: ${endpointsOutParam.param}");

            return true;
          }
        }
      } else {
        return false;
      }
    }

    this.TraceMessage(enumerations.TraceFlags.AutodiscoverConfiguration,
        "Maximum number of redirection hops $AutodiscoverMaxRedirections exceeded");

    throw new AutodiscoverLocalException("Strings.MaximumRedirectionHopsExceeded");
  }

  /// <summary>
  /// Gets the endpoints from HTTP web response.
  /// </summary>
  /// <param name="response">The response.</param>
  /// <returns>Endpoints enabled.</returns>
  Set<AutodiscoverEndpoints> _GetEndpointsFromHttpWebResponse(IEwsHttpWebResponse response) {
    Set<AutodiscoverEndpoints> endpoints = Set.of([AutodiscoverEndpoints.Legacy]);
    if (!StringUtils.IsNullOrEmpty(response.Headers[_AutodiscoverSoapEnabledHeaderName])) {
      endpoints.add(AutodiscoverEndpoints.Soap);
    }
    if (!StringUtils.IsNullOrEmpty(response.Headers[_AutodiscoverWsSecurityEnabledHeaderName])) {
      endpoints.add(AutodiscoverEndpoints.WsSecurity);
    }
    if (!StringUtils.IsNullOrEmpty(
        response.Headers[_AutodiscoverWsSecuritySymmetricKeyEnabledHeaderName])) {
      endpoints.add(AutodiscoverEndpoints.WSSecuritySymmetricKey);
    }
    if (!StringUtils.IsNullOrEmpty(
        response.Headers[_AutodiscoverWsSecurityX509CertEnabledHeaderName])) {
      endpoints.add(AutodiscoverEndpoints.WSSecurityX509Cert);
    }
    if (!StringUtils.IsNullOrEmpty(response.Headers[_AutodiscoverOAuthEnabledHeaderName])) {
      endpoints.add(AutodiscoverEndpoints.OAuth);
    }
    return endpoints;
  }

  /// <summary>
  /// Traces the response.
  /// </summary>
  /// <param name="response">The response.</param>
  /// <param name="memoryStream">The response content in a MemoryStream.</param>
  void TraceResponse(IEwsHttpWebResponse response, MemoryStream memoryStream) {
    this.ProcessHttpResponseHeaders(
        enumerations.TraceFlags.AutodiscoverResponseHttpHeaders, response);

    if (this.TraceEnabled) {
      if (!StringUtils.IsNullOrEmpty(response.ContentType) &&
          (response.ContentType.toLowerCase().startsWith("text/") ||
              response.ContentType.toLowerCase().startsWith("application/soap"))) {
        this.TraceXml(enumerations.TraceFlags.AutodiscoverResponse, memoryStream);
      } else {
        this.TraceMessage(enumerations.TraceFlags.AutodiscoverResponse, "Non-textual response");
      }
    }
  }

  /// <summary>
  /// Creates an HttpWebRequest instance and initializes it with the appropriate parameters,
  /// based on the configuration of this service object.
  /// </summary>
  /// <param name="url">The URL that the HttpWebRequest should target.</param>
//           IEwsHttpWebRequest PrepareHttpWebRequestForUrl(Uri url)
//        {
//            return this.PrepareHttpWebRequestForUrl(
//                            url,
//                            false,      // acceptGzipEncoding
//                            false);     // allowAutoRedirect
//        }

  /// <summary>
  /// Calls the redirection URL validation callback.
  /// </summary>
  /// <param name="redirectionUrl">The redirection URL.</param>
  /// <remarks>
  /// If the redirection URL validation callback is null, use the default callback which
  /// does not allow following any redirections.
  /// </remarks>
  /// <returns>True if redirection should be followed.</returns>
  /* private */
  bool CallRedirectionUrlValidationCallback(String redirectionUrl) {
    AutodiscoverRedirectionUrlValidationCallback callback =
        (this.RedirectionUrlValidationCallback == null)
            ? DefaultAutodiscoverRedirectionUrlValidationCallback
            : this.RedirectionUrlValidationCallback;
    return callback(redirectionUrl);
  }

  /// <summary>
  /// Processes an HTTP error response.
  /// </summary>
  /// <param name="httpWebResponse">The HTTP web response.</param>
  /// <param name="webException">The web exception.</param>
  @override
  void ProcessHttpErrorResponse(IEwsHttpWebResponse httpWebResponse, WebException webException) {
    this.InternalProcessHttpErrorResponse(
        httpWebResponse,
        webException,
        enumerations.TraceFlags.AutodiscoverResponseHttpHeaders,
        enumerations.TraceFlags.AutodiscoverResponse);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
// AutodiscoverService()
//            : this(ExchangeVersion.Exchange2010)
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="requestedServerVersion">The requested server version.</param>
// AutodiscoverService.withExchangeVersion(ExchangeVersion requestedServerVersion)
//            : this(null, null, requestedServerVersion)
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="domain">The domain that will be used to determine the URL of the service.</param>
// AutodiscoverService.withDomain(String domain)
//            : this(null, domain)
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="domain">The domain that will be used to determine the URL of the service.</param>
  /// <param name="requestedServerVersion">The requested server version.</param>
// AutodiscoverService.withDomainAndExchangeVersion(String domain, ExchangeVersion requestedServerVersion)
//            : this(null, domain, requestedServerVersion)
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="url">The URL of the service.</param>
// AutodiscoverService.withUrl(Uri url)
//            : this(url, url.Host)
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="url">The URL of the service.</param>
  /// <param name="requestedServerVersion">The requested server version.</param>
// AutodiscoverService.withUrlAndExchangeVersion(Uri url, ExchangeVersion requestedServerVersion)
//            : this(url, url.Host, requestedServerVersion)
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="url">The URL of the service.</param>
  /// <param name="domain">The domain that will be used to determine the URL of the service.</param>
//        AutodiscoverService.withUrlAndDomain(Uri url, String domain)
//            : super()
//        {
//            EwsUtilities.ValidateDomainNameAllowNull(domain, "domain");
//
//            this.url = url;
//            this.domain = domain;
//            this.dnsClient = new AutodiscoverDnsClient(this);
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="url">The URL of the service.</param>
  /// <param name="domain">The domain that will be used to determine the URL of the service.</param>
  /// <param name="requestedServerVersion">The requested server version.</param>
//        AutodiscoverService.withUrlAndDomainAndExchangeVersion(
//            Uri url,
//            String domain,
//            ExchangeVersion requestedServerVersion)
//            : super(requestedServerVersion)
//        {
//            EwsUtilities.ValidateDomainNameAllowNull(domain, "domain");
//
//            this.url = url;
//            this.domain = domain;
//            this.dnsClient = new AutodiscoverDnsClient(this);
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="service">The other service.</param>
  /// <param name="requestedServerVersion">The requested server version.</param>
  AutodiscoverService.withExchangeServiceAndExchangeVersion(
      ExchangeServiceBase service, ExchangeVersion requestedServerVersion)
      : super.withExchangeServiceAndExchangeVersion(service, requestedServerVersion);

  // TODO fix dns client
//        {
//            this.dnsClient = new AutodiscoverDnsClient(this);
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverService"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
//        AutodiscoverService.withExchangeService(ExchangeServiceBase service)
//            : this(service, service.RequestedServerVersion)
//        {
//        }

  /// <summary>
  /// Retrieves the specified settings for single SMTP address.
  /// </summary>
  /// <param name="userSmtpAddress">The SMTP addresses of the user.</param>
  /// <param name="userSettingNames">The user setting names.</param>
  /// <returns>A UserResponse object containing the requested settings for the specified user.</returns>
  /// <remarks>
  /// This method handles will run the entire Autodiscover "discovery" algorithm and will follow address and URL redirections.
  /// </remarks>
  Future<GetUserSettingsResponse> GetUserSettingsWithSmtpAddress(
      String userSmtpAddress, List<UserSettingName> userSettingNames) async {
    List<UserSettingName> requestedSettings = new List<UserSettingName>.of(userSettingNames);

    if (StringUtils.IsNullOrEmpty(userSmtpAddress)) {
      throw new ServiceValidationException("Strings.InvalidAutodiscoverSmtpAddress");
    }

    if (requestedSettings.length == 0) {
      throw new ServiceValidationException("Strings.InvalidAutodiscoverSettingsCount");
    }

    if (this.RequestedServerVersion.index <
        _MinimumRequestVersionForAutoDiscoverSoapService.index) {
      // TODO implement autodiscovery for Exchange 2007
      throw UnsupportedError("Doesn't support autodiscovery for Exchange2007");
//                return await this.InternalGetLegacyUserSettings(userSmtpAddress, requestedSettings);
    } else {
      return await this.InternalGetSoapUserSettings(userSmtpAddress, requestedSettings);
    }
  }

  /// <summary>
  /// Retrieves the specified settings for a set of users.
  /// </summary>
  /// <param name="userSmtpAddresses">The SMTP addresses of the users.</param>
  /// <param name="userSettingNames">The user setting names.</param>
  /// <returns>A GetUserSettingsResponseCollection object containing the responses for each individual user.</returns>
// GetUserSettingsResponseCollection GetUsersSettings(
//            Iterable<String> userSmtpAddresses,
//            params UserSettingName[] userSettingNames)
//        {
//            if (this.RequestedServerVersion < MinimumRequestVersionForAutoDiscoverSoapService)
//            {
//                throw new ServiceVersionException(
//                    string.Format(Strings.AutodiscoverServiceIncompatibleWithRequestVersion, MinimumRequestVersionForAutoDiscoverSoapService));
//            }
//
//            List<String> smtpAddresses = new List<String>(userSmtpAddresses);
//            List<UserSettingName> settings = new List<UserSettingName>(userSettingNames);
//
//            return this.GetUserSettings(smtpAddresses, settings);
//        }

  /// <summary>
  /// Retrieves the specified settings for a domain.
  /// </summary>
  /// <param name="domain">The domain.</param>
  /// <param name="requestedVersion">Requested version of the Exchange service.</param>
  /// <param name="domainSettingNames">The domain setting names.</param>
  /// <returns>A DomainResponse object containing the requested settings for the specified domain.</returns>
// GetDomainSettingsResponse GetDomainSettings(
//            String domain,
//            ExchangeVersion requestedVersion,
//            params DomainSettingName[] domainSettingNames)
//        {
//            List<String> domains = new List<String>(1);
//            domains.Add(domain);
//            List<DomainSettingName> settings = new List<DomainSettingName>(domainSettingNames);
//            return this.GetDomainSettings(domains, settings, requestedVersion)[0];
//        }

  /// <summary>
  /// Retrieves the specified settings for a set of domains.
  /// </summary>
  /// <param name="domains">The SMTP addresses of the domains.</param>
  /// <param name="requestedVersion">Requested version of the Exchange service.</param>
  /// <param name="domainSettingNames">The domain setting names.</param>
  /// <returns>A GetDomainSettingsResponseCollection object containing the responses for each individual domain.</returns>
// GetDomainSettingsResponseCollection GetDomainSettings(
//            Iterable<String> domains,
//            ExchangeVersion requestedVersion,
//            List<DomainSettingName> domainSettingNames)
//        {
//            List<DomainSettingName> settings = new List<DomainSettingName>.of(domainSettingNames);
//
//            return this.GetDomainSettings(domains.toList(), settings, requestedVersion);
//        }

  /// <summary>
  /// Try to get the partner access information for the given target tenant.
  /// </summary>
  /// <param name="targetTenantDomain">The target domain or user email address.</param>
  /// <param name="partnerAccessCredentials">The partner access credentials.</param>
  /// <param name="targetTenantAutodiscoverUrl">The autodiscover url for the given tenant.</param>
  /// <returns>True if the partner access information was retrieved, false otherwise.</returns>
// bool TryGetPartnerAccess(
//            String targetTenantDomain,
//            out ExchangeCredentials partnerAccessCredentials,
//            out Uri targetTenantAutodiscoverUrl)
//        {
//            EwsUtilities.ValidateNonBlankStringParam(targetTenantDomain, "targetTenantDomain");
//
//            // the user should set the url to its own tenant's autodiscover url.
//            //
//            if (this.Url == null)
//            {
//                throw new ServiceValidationException(Strings.PartnerTokenRequestRequiresUrl);
//            }
//
//            if (this.RequestedServerVersion < ExchangeVersion.Exchange2010_SP1)
//            {
//                throw new ServiceVersionException(
//                    string.Format(
//                        Strings.PartnerTokenIncompatibleWithRequestVersion,
//                        ExchangeVersion.Exchange2010_SP1));
//            }
//
//            partnerAccessCredentials = null;
//            targetTenantAutodiscoverUrl = null;
//
//            String smtpAddress = targetTenantDomain;
//            if (!smtpAddress.Contains("@"))
//            {
//                smtpAddress = "SystemMailbox{e0dc1c29-89c3-4034-b678-e6c29d823ed9}@" + targetTenantDomain;
//            }
//
//            GetUserSettingsRequest request = new GetUserSettingsRequest(this, this.Url, true /* expectPartnerToken */);
//            request.SmtpAddresses = new List<String>(new[] { smtpAddress });
//            request.Settings = new List<UserSettingName>(new[] { UserSettingName.ExternalEwsUrl });
//
//            GetUserSettingsResponseCollection response = null;
//            try
//            {
//                response = request.Execute();
//            }
//            catch (ServiceRequestException)
//            {
//                return false;
//            }
//            catch (ServiceRemoteException)
//            {
//                return false;
//            }
//
//            if (StringUtils.IsNullOrEmpty(request.PartnerToken)
//                || StringUtils.IsNullOrEmpty(request.PartnerTokenReference))
//            {
//                return false;
//            }
//
//            if (response.ErrorCode == AutodiscoverErrorCode.NoError)
//            {
//                GetUserSettingsResponse firstResponse = response.Responses[0];
//                if (firstResponse.ErrorCode == AutodiscoverErrorCode.NoError)
//                {
//                    targetTenantAutodiscoverUrl = this.Url;
//                }
//                else if (firstResponse.ErrorCode == AutodiscoverErrorCode.RedirectUrl)
//                {
//                    targetTenantAutodiscoverUrl = new Uri(firstResponse.RedirectTarget);
//                }
//                else
//                {
//                    return false;
//                }
//            }
//            else
//            {
//                return false;
//            }
//
//            partnerAccessCredentials = new PartnerTokenCredentials(
//                request.PartnerToken,
//                request.PartnerTokenReference);
//
//            targetTenantAutodiscoverUrl = partnerAccessCredentials.AdjustUrl(
//                targetTenantAutodiscoverUrl);
//
//            return true;
//        }

  /// <summary>
  /// Gets or sets the domain this service is bound to. When this property is set, the domain
  /// name is used to automatically determine the Autodiscover service URL.
  /// </summary>
  String get Domain => this._domain;

  set Domain(String value) {
    EwsUtilities.ValidateDomainNameAllowNull(value, "Domain");

    // If Domain property is set to non-null value, Url property is nulled.
    if (value != null) {
      this._url = null;
    }
    this._domain = value;
  }

  /// <summary>
  /// Gets or sets the URL this service is bound to.
  /// </summary>
  Uri get Url => this._url;

  set Url(Uri value) {
    // If Url property is set to non-null value, Domain property is set to host portion of Url.
    if (value != null) {
      this._domain = value.host;
    }
    this._url = value;
  }

  /// <summary>
  /// Gets a value indicating whether the Autodiscover service that URL points to is (inside the corporate network)
  /// or external (outside the corporate network).
  /// </summary>
  /// <remarks>
  /// IsExternal is null in the following cases:
  /// - This instance has been created with a domain name and no method has been called,
  /// - This instance has been created with a URL.
  /// </remarks>
  bool get IsExternal => this._isExternal;

  set IsExternal(bool value) => this._isExternal = value;

  /// <summary>
  /// Gets or sets the redirection URL validation callback.
  /// </summary>
  /// <value>The redirection URL validation callback.</value>
  AutodiscoverRedirectionUrlValidationCallback get RedirectionUrlValidationCallback =>
      this._redirectionUrlValidationCallback;

  set RedirectionUrlValidationCallback(AutodiscoverRedirectionUrlValidationCallback value) =>
      this._redirectionUrlValidationCallback = value;

  /// <summary>
  /// Gets or sets the DNS server address.
  /// </summary>
  /// <value>The DNS server address.</value>
//        IPAddress DnsServerAddress
//        {
//            get { return this.dnsServerAddress; }
//            set { this.dnsServerAddress = value; }
//        }

  /// <summary>
  /// Gets or sets a value indicating whether the AutodiscoverService should perform SCP (ServiceConnectionPoint) record lookup when determining
  /// the Autodiscover service URL.
  /// </summary>
  bool get EnableScpLookup => this._enableScpLookup;

  set EnableScpLookup(bool value) => this._enableScpLookup = value;

  /// <summary>
  /// Gets or sets the delegate used to resolve Autodiscover SCP urls for a specified domain.
  /// </summary>
// Func<string, ICollection<String>> GetScpUrlsForDomainCallback
//        {
//            get;
//            set;
//        }
}
