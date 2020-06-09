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

import 'dart:math';
import 'dart:typed_data';

import 'package:ews/ComplexProperties/TimeZones/TimeZoneDefinition.dart';
import 'package:ews/Core/ExchangeServerInfo.dart';
import 'package:ews/Credentials/ExchangeCredentials.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/TraceFlags.dart' as enumerations;
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Http/CookieContainer.dart' as http;
import 'package:ews/Http/EwsHttpWebRequestFactory.dart';
import 'package:ews/Http/HttpRequestHeader.dart';
import 'package:ews/Http/IEwsHttpWebRequestFactory.dart';
import 'package:ews/Http/IWebProxy.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';
import 'package:ews/Interfaces/ITraceListener.dart';
import 'package:ews/Xml/XmlWriter.dart';
import 'package:ews/misc/DelegateTypes.dart';
import 'package:ews/misc/EwsTraceListener.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:ews/misc/Std/MemoryStream.dart';
import 'package:ews/misc/StringUtils.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart' as datetime;

import 'EwsUtilities.dart';

/// <summary>
/// Represents an binding to an Exchange Service.
/// </summary>
abstract class ExchangeServiceBase {
  /* private */
//  static Lock lockObj = new Lock();

  var _requestedServerVersion = ExchangeVersion.Exchange2013_SP1;

  /// <summary>
  /// Special HTTP status code that indicates that the account is locked.
  /// </summary>
//        const HttpStatusCode AccountIsLocked = (HttpStatusCode)456;

  /// <summary>
  /// The binary secret.
  /// </summary>
  static Uint8List _binarySecret;

  /// <summary>
  /// Default UserAgent
  /// </summary>
  static String _defaultUserAgent =
      "ExchangeServicesClient/" + EwsUtilities.BuildVersion;

  /// <summary>
  /// Occurs when the http response headers of a server call is captured.
  /// </summary>
// event ResponseHeadersCapturedHandler OnResponseHeadersCaptured;
  List<ResponseHeadersCapturedHandler> OnResponseHeadersCaptured = [];

  ExchangeCredentials _credentials;
  bool _useDefaultCredentials = false;
  int _timeout = 100000;
  bool _traceEnabled = false;
  bool _sendClientLatencies = true;
  List<enumerations.TraceFlags> _traceFlags = enumerations.TraceFlags.values;
  ITraceListener _traceListener = new EwsTraceListener();
  bool _preAuthenticate = false;
  String _userAgent = _defaultUserAgent;
  bool _acceptGzipEncoding = true;
  bool _keepAlive = true;
  String _connectionGroupName;
  String _clientRequestId;
  bool _returnClientRequestId = false;
  http.CookieContainer _cookieContainer = new http.CookieContainer();
  datetime.TimeZone _timeZone;
  TimeZoneDefinition _timeZoneDefinition;
  ExchangeServerInfo _serverInfo;
  IWebProxy _webProxy;
  Map<String, String> _httpHeaders = new Map<String, String>();
  Map<String, String> _httpResponseHeaders = new Map<String, String>();
  IEwsHttpWebRequestFactory _ewsHttpWebRequestFactory =
      new EwsHttpWebRequestFactory();

  /// <summary>
  /// Calls the custom SOAP header serialization event handlers, if defined.
  /// </summary>
  /// <param name="writer">The XmlWriter to which to write the custom SOAP headers.</param>
  void DoOnSerializeCustomSoapHeaders(XmlWriter writer) {
    EwsUtilities.Assert(writer != null,
        "ExchangeService.DoOnSerializeCustomSoapHeaders", "writer is null");
    this.OnSerializeCustomSoapHeaders.forEach((delegate) => delegate(writer));
  }

  /// <summary>
  /// Creates an HttpWebRequest instance and initializes it with the appropriate parameters,
  /// based on the configuration of this service object.
  /// </summary>
  /// <param name="url">The URL that the HttpWebRequest should target.</param>
  /// <param name="acceptGzipEncoding">If true, ask server for GZip compressed content.</param>
  /// <param name="allowAutoRedirect">If true, redirection responses will be automatically followed.</param>
  /// <returns>A initialized instance of HttpWebRequest.</returns>
  IEwsHttpWebRequest PrepareHttpWebRequestForUrl(
      Uri url, bool acceptGzipEncoding, bool allowAutoRedirect) {
    // Verify that the protocol is something that we can handle
    // todo("add service local exception")
    if ((url.scheme != "http") && (url.scheme != "https")) {
      throw new ServiceLocalException(
          "string.Format(Strings.UnsupportedWebProtocol, url.Scheme)");
    }

    IEwsHttpWebRequest request = this
        .HttpWebRequestFactory
        .CreateRequestWithExchangeServiceAndUrl(this, url);

    request.PreAuthenticate = this.PreAuthenticate;
    request.Timeout = this.Timeout;
    this.SetContentType(request);
    request.Method = "POST";
    request.UserAgent = this.UserAgent;
    request.AllowAutoRedirect = allowAutoRedirect;
    request.CookieContainer = this.CookieContainer;
    request.KeepAlive = this._keepAlive;
    request.ConnectionGroupName = this._connectionGroupName;

    if (acceptGzipEncoding) {
      request.Headers.Add(HttpRequestHeader.AcceptEncoding, "gzip,deflate");
    }

    if (!StringUtils.IsNullOrEmpty(this._clientRequestId)) {
      request.Headers.Add("client-request-id", this._clientRequestId);
      if (this._returnClientRequestId) {
        request.Headers.Add("return-client-request-id", "true");
      }
    }

    if (this._webProxy != null) {
      request.Proxy = this._webProxy;
    }

    if (this.HttpHeaders.length > 0) {
      this
          .HttpHeaders
          .entries
          .forEach((kv) => request.Headers[kv.key] = kv.value);
    }

    request.UseDefaultCredentials = this.UseDefaultCredentials;
    if (!request.UseDefaultCredentials) {
      ExchangeCredentials serviceCredentials = this.Credentials;
      if (serviceCredentials == null) {
        throw new ServiceLocalException("Strings.CredentialsRequired");
      }

      // Make sure that credentials have been authenticated if required
      serviceCredentials.PreAuthenticate();

      // Apply credentials to the request
      serviceCredentials.PrepareWebRequest(request);
    }

    this._httpResponseHeaders.clear();

    return request;
  }

  void SetContentType(IEwsHttpWebRequest request) {
    request.ContentType = "text/xml; charset=utf-8";
    request.Accept = "text/xml";
  }

  /// <summary>
  /// Processes an HTTP error response
  /// </summary>
  /// <param name="httpWebResponse">The HTTP web response.</param>
  /// <param name="webException">The web exception.</param>
  /// <param name="responseHeadersTraceFlag">The trace flag for response headers.</param>
  /// <param name="responseTraceFlag">The trace flag for responses.</param>
  /// <remarks>
  /// This method doesn't handle 500 ISE errors. This is handled by the caller since
  /// 500 ISE typically indicates that a SOAP fault has occurred and the handling of
  /// a SOAP fault is currently service specific.
  /// </remarks>
  void InternalProcessHttpErrorResponse(
      IEwsHttpWebResponse httpWebResponse,
      WebException webException,
      enumerations.TraceFlags responseHeadersTraceFlag,
      enumerations.TraceFlags responseTraceFlag) {
//            EwsUtilities.Assert(
//                httpWebResponse.StatusCode != HttpStatusCode.InternalServerError,
//                "ExchangeServiceBase.InternalProcessHttpErrorResponse",
//                "InternalProcessHttpErrorResponse does not handle 500 ISE errors, the caller is supposed to handle this.");

    this.ProcessHttpResponseHeaders(responseHeadersTraceFlag, httpWebResponse);

    // Deal with new HTTP error code indicating that account is locked.
    // The "unlock" URL is returned as the status description in the response.
    // todo("implement account lock check")
//            if (httpWebResponse.StatusCode == ExchangeServiceBase.AccountIsLocked)
//            {
//                String location = httpWebResponse.StatusDescription;
//
//                Uri accountUnlockUrl = null;
//                if (Uri.IsWellFormedUriString(location, UriKind.Absolute))
//                {
//                    accountUnlockUrl = new Uri(location);
//                }
//
//                this.TraceMessage(responseTraceFlag, string.Format("Account is locked. Unlock URL is {0}", accountUnlockUrl));
//
//                throw new AccountIsLockedException(
//                    string.Format(Strings.AccountIsLocked, accountUnlockUrl),
//                    accountUnlockUrl,
//                    webException);
//            }
  }

  /// <summary>
  /// Processes an HTTP error response.
  /// </summary>
  /// <param name="httpWebResponse">The HTTP web response.</param>
  /// <param name="webException">The web exception.</param>
  void ProcessHttpErrorResponse(
      IEwsHttpWebResponse httpWebResponse, WebException webException);

  /// <summary>
  /// Determines whether tracing is enabled for specified trace flag(s).
  /// </summary>
  /// <param name="enumerations.TraceFlags">The trace flags.</param>
  /// <returns>True if tracing is enabled for specified trace flag(s).
  /// </returns>
  bool IsTraceEnabledFor(enumerations.TraceFlags traceFlag) {
    return this.TraceEnabled && this.TraceFlags.contains(traceFlag);
  }

  /// <summary>
  /// Logs the specified String to the TraceListener if tracing is enabled.
  /// </summary>
  /// <param name="traceType">Kind of trace entry.</param>
  /// <param name="logEntry">The entry to log.</param>
  void TraceMessage(enumerations.TraceFlags traceType, String logEntry) {
    if (this.IsTraceEnabledFor(traceType)) {
      String traceTypeStr = traceType.toString();
      String logMessage = EwsUtilities.FormatLogMessage(traceTypeStr, logEntry);
      this.TraceListener.Trace(traceTypeStr, logMessage);
    }
  }

  /// <summary>
  /// Logs the specified XML to the TraceListener if tracing is enabled.
  /// </summary>
  /// <param name="traceType">Kind of trace entry.</param>
  /// <param name="stream">The stream containing XML.</param>
  void TraceXml(enumerations.TraceFlags traceType, MemoryStream stream) {
    if (this.IsTraceEnabledFor(traceType)) {
      String traceTypeStr = traceType.toString();
      String logMessage =
          EwsUtilities.FormatLogMessageWithXmlContent(traceTypeStr, stream);
      this.TraceListener.Trace(traceTypeStr, logMessage);
    }
  }

  /// <summary>
  /// Traces the HTTP request headers.
  /// </summary>
  /// <param name="traceType">Kind of trace entry.</param>
  /// <param name="request">The request.</param>
  void TraceHttpRequestHeaders(
      enumerations.TraceFlags traceType, IEwsHttpWebRequest request) {
    if (this.IsTraceEnabledFor(traceType)) {
      String traceTypeStr = traceType.toString();
      String headersAsString = EwsUtilities.FormatHttpRequestHeaders(request);
      String logMessage =
          EwsUtilities.FormatLogMessage(traceTypeStr, headersAsString);
      this.TraceListener.Trace(traceTypeStr, logMessage);
    }
  }

  /// <summary>
  /// Traces the HTTP response headers.
  /// </summary>
  /// <param name="traceType">Kind of trace entry.</param>
  /// <param name="response">The response.</param>
  void ProcessHttpResponseHeaders(
      enumerations.TraceFlags traceType, IEwsHttpWebResponse response) {
    this._TraceHttpResponseHeaders(traceType, response);

    this._SaveHttpResponseHeaders(response.Headers);
  }

  /// <summary>
  /// Traces the HTTP response headers.
  /// </summary>
  /// <param name="traceType">Kind of trace entry.</param>
  /// <param name="response">The response.</param>
  void _TraceHttpResponseHeaders(
      enumerations.TraceFlags traceType, IEwsHttpWebResponse response) {
    if (this.IsTraceEnabledFor(traceType)) {
      String traceTypeStr = traceType.toString();
      String headersAsString = EwsUtilities.FormatHttpResponseHeaders(response);
      String logMessage =
          EwsUtilities.FormatLogMessage(traceTypeStr, headersAsString);
      this.TraceListener.Trace(traceTypeStr, logMessage);
    }
  }

  /// <summary>
  /// Save the HTTP response headers.
  /// </summary>
  /// <param name="headers">The response headers</param>
  void _SaveHttpResponseHeaders(WebHeaderCollection headers) {
    this._httpResponseHeaders.clear();

    for (String key in headers.AllKeys) {
      OutParam<String> existingValue = new OutParam();

      if (this._httpResponseHeaders.containsKey(key)) {
        this._httpResponseHeaders[key] =
            existingValue.param + "," + headers[key];
      } else {
        this._httpResponseHeaders[key] = headers[key];
      }
    }

    this.OnResponseHeadersCaptured.forEach((delegate) => delegate(headers));
  }

  /// <summary>
  /// Converts the universal date time String to local date time.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>DateTime</returns>
  DateTime ConvertUniversalDateTimeStringToLocalDateTime(String value) {
//          throw NotImplementedException("ConvertUniversalDateTimeStringToLocalDateTime($value)")
    if (StringUtils.IsNullOrEmpty(value)) {
      return null;
    } else {
      return DateTime.parse(value);
    }
//            if (StringUtils.IsNullOrEmpty(value))
//            {
//                return null;
//            }
//            else
//            {
//                // Assume an unbiased date/time is in UTC. Convert to UTC otherwise.
//                DateTime dateTime = DateTime.Parse(
//                    value,
//                    CultureInfo.InvariantCulture,
//                    DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal);
//
//                if (this.TimeZone == TimeZoneInfo.Utc)
//                {
//                    // This returns a DateTime with Kind.Utc
//                    return dateTime;
//                }
//                else
//                {
//                    DateTime localTime = EwsUtilities.ConvertTime(
//                        dateTime,
//                        TimeZoneInfo.Utc,
//                        this.TimeZone);
//
//                    if (EwsUtilities.IsLocalTimeZone(this.TimeZone))
//                    {
//                        // This returns a DateTime with Kind.Local
//                        return new DateTime(localTime.Ticks, DateTimeKind.Local);
//                    }
//                    else
//                    {
//                        // This returns a DateTime with Kind.Unspecified
//                        return localTime;
//                    }
//                }
//            }
  }

  /// <summary>
  /// Converts xs:dateTime String with either "Z", "-00:00" bias, or "" suffixes to
  /// unspecified StartDate value ignoring the suffix.
  /// </summary>
  /// <param name="value">The String value to parse.</param>
  /// <returns>The parsed DateTime value.</returns>
  DateTime ConvertStartDateToUnspecifiedDateTime(String value) {
    // TODO : check unspecified date
    print(".. uses unsafe ConvertStartDateToUnspecifiedDateTime");
    if (StringUtils.IsNullOrEmpty(value)) {
      return null;
    } else {
      return DateTime.parse(value);
    }
//            if (StringUtils.IsNullOrEmpty(value))
//            {
//                return null;
//            }
//            else
//            {
//                DateTimeOffset dateTimeOffset = DateTimeOffset.Parse(value, CultureInfo.InvariantCulture);
//
//                // Return only the date part with the kind==Unspecified.
//                return dateTimeOffset.Date;
//            }
  }

  /// <summary>
  /// Converts the date time to universal date time string.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>String representation of DateTime.</returns>
  String ConvertDateTimeToUniversalDateTimeString(DateTime value) {
    // todo : repair ConvertDateTimeToUniversalDateTimeString
    final dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'", null);
    final formatted = dateFormat.format(value);
    if (!value.isUtc) {
      print(
          "!! .. unsafe ConvertDateTimeToUniversalDateTimeString($value) => $formatted");
    }
    return formatted;
//            DateTime dateTime;
//
//            switch (value.Kind)
//            {
//                case DateTimeKind.Unspecified:
//                    dateTime = EwsUtilities.ConvertTime(
//                        value,
//                        this.TimeZone,
//                        TimeZoneInfo.Utc);
//
//                    break;
//                case DateTimeKind.Local:
//                    dateTime = EwsUtilities.ConvertTime(
//                        value,
//                        TimeZoneInfo.Local,
//                        TimeZoneInfo.Utc);
//
//                    break;
//                default:
//                    // The date is already in UTC, no need to convert it.
//                    dateTime = value;
//
//                    break;
//            }
//            return dateTime.ToString("yyyy-MM-ddTHH:mm:ss.fffZ", CultureInfo.InvariantCulture);
  }

  /// <summary>
  /// Register the custom auth module to support non-ascii upn authentication if the server supports that
  /// </summary>
//        void RegisterCustomBasicAuthModule()
//        {
//            if (this.RequestedServerVersion.index >= ExchangeVersion.Exchange2013_SP1.index)
//            {
//                BasicAuthModuleForUTF8.InstantiateIfNeeded();
//            }
//        }

  /// <summary>
  /// Sets the user agent to a custom value
  /// </summary>
  /// <param name="userAgent">User agent String to set on the service</param>
  void SetCustomUserAgent(String userAgent) {
    this._userAgent = userAgent;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExchangeServiceBase"/> class.
  /// </summary>
//        ExchangeServiceBase()
//            : this.withTimeZone(TimeZoneInfo.Local);

  /// <summary>
  /// Initializes a new instance of the <see cref="ExchangeServiceBase"/> class.
  /// </summary>
  /// <param name="timeZone">The time zone to which the service is scoped.</param>
//        ExchangeServiceBase.withTimeZone(TimeZoneInfo timeZone)
//        {
//            this.timeZone = timeZone;
//            this.UseDefaultCredentials = true;
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExchangeServiceBase"/> class.
  /// </summary>
  /// <param name="requestedServerVersion">The requested server version.</param>
  ExchangeServiceBase.withVersion(ExchangeVersion requestedServerVersion)
  //: this(requestedServerVersion, TimeZoneInfo.Local)
  {
    this._requestedServerVersion = requestedServerVersion;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExchangeServiceBase"/> class.
  /// </summary>
  /// <param name="requestedServerVersion">The requested server version.</param>
  /// <param name="timeZone">The time zone to which the service is scoped.</param>
//        ExchangeServiceBase(ExchangeVersion requestedServerVersion, TimeZoneInfo timeZone)
//            : this(timeZone)
//        {
//            this.requestedServerVersion = requestedServerVersion;
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExchangeServiceBase"/> class.
  /// </summary>
  /// <param name="service">The other service.</param>
  /// <param name="requestedServerVersion">The requested server version.</param>
  ExchangeServiceBase.withExchangeServiceAndExchangeVersion(
      ExchangeServiceBase service, ExchangeVersion requestedServerVersion)
  //: this(requestedServerVersion, TimeZoneInfo.Local)
  {
    this._requestedServerVersion = requestedServerVersion;
    this._useDefaultCredentials = service._useDefaultCredentials;
    this._credentials = service._credentials;
    this._traceEnabled = service._traceEnabled;
    this._traceListener = service._traceListener;
    this._traceFlags = service._traceFlags;
    this._timeout = service._timeout;
    this._preAuthenticate = service._preAuthenticate;
    this._userAgent = service._userAgent;
    this._acceptGzipEncoding = service._acceptGzipEncoding;
    this._keepAlive = service._keepAlive;
    this._connectionGroupName = service._connectionGroupName;
    this._timeZone = service._timeZone;
    this._httpHeaders = service._httpHeaders;
    this._ewsHttpWebRequestFactory = service._ewsHttpWebRequestFactory;
    this._webProxy = service._webProxy;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ExchangeServiceBase"/> class from existing one.
  /// </summary>
  /// <param name="service">The other service.</param>
//        ExchangeServiceBase(ExchangeServiceBase service)
//            : this(service, service.RequestedServerVersion)
//        {
//        }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  void Validate() {}

  /// <summary>
  /// Gets or sets the cookie container.
  /// </summary>
  /// <value>The cookie container.</value>
  http.CookieContainer get CookieContainer => this._cookieContainer;

  set CookieContainer(http.CookieContainer value) {
    this._cookieContainer = value;
  }

  /// <summary>
  /// Gets the time zone this service is scoped to.
  /// </summary>
  datetime.TimeZone get TimeZone => this._timeZone;

  /// <summary>
  /// Gets a time zone definition generated from the time zone info to which this service is scoped.
  /// </summary>
//        TimeZoneDefinition get TimeZoneDefinition =>
//            {
//                if (this.timeZoneDefinition == null)
//                {
//                    this.timeZoneDefinition = new TimeZoneDefinition(this.TimeZone);
//                }
//
//                return this.timeZoneDefinition;
//            }

  /// <summary>
  /// Gets or sets a value indicating whether client latency info is push to server.
  /// </summary>
  bool get SendClientLatencies => this._sendClientLatencies;

  set SendClientLatencies(bool value) {
    this._sendClientLatencies = value;
  }

  /// <summary>
  /// Gets or sets a value indicating whether tracing is enabled.
  /// </summary>
  bool get TraceEnabled => this._traceEnabled;

  set TraceEnabled(bool value) {
    this._traceEnabled = value;
    if (this._traceEnabled && (this._traceListener == null)) {
      this._traceListener = new EwsTraceListener();
    }
  }

  /// <summary>
  /// Gets or sets the trace flags.
  /// </summary>
  /// <value>The trace flags.</value>
  List<enumerations.TraceFlags> get TraceFlags => this._traceFlags;

  set TraceFlags(List<enumerations.TraceFlags> value) {
    this._traceFlags = value;
  }

  /// <summary>
  /// Gets or sets the trace listener.
  /// </summary>
  /// <value>The trace listener.</value>
  ITraceListener get TraceListener => this._traceListener;

  set TraceListener(ITraceListener value) {
    this._traceListener = value;
    this._traceEnabled = value != null;
  }

  /// <summary>
  /// Gets or sets the credentials used to authenticate with the Exchange Web Services. Setting the Credentials property
  /// automatically sets the UseDefaultCredentials to false.
  /// </summary>
  ExchangeCredentials get Credentials => this._credentials;

  set Credentials(ExchangeCredentials value) {
    this._credentials = value;
    this._useDefaultCredentials = false;
    this._cookieContainer = new http
        .CookieContainer(); // Changing credentials resets the Cookie container
  }

  /// <summary>
  /// Gets or sets a value indicating whether the credentials of the user currently logged into Windows should be used to
  /// authenticate with the Exchange Web Services. Setting UseDefaultCredentials to true automatically sets the Credentials
  /// property to null.
  /// </summary>
  bool get UseDefaultCredentials => this._useDefaultCredentials;

  set UseDefaultCredentials(bool value) {
    this._useDefaultCredentials = value;

    if (value) {
      this._credentials = null;
      this._cookieContainer = new http
          .CookieContainer(); // Changing credentials resets the Cookie container
    }
  }

  /// <summary>
  /// Gets or sets the timeout used when sending HTTP requests and when receiving HTTP responses, in milliseconds.
  /// Defaults to 100000.
  /// </summary>
  int get Timeout => this._timeout;

  set Timeout(int value) {
    if (value < 1) {
      throw new ArgumentError("Strings.TimeoutMustBeGreaterThanZero");
    }

    this._timeout = value;
  }

  /// <summary>
  /// Gets or sets a value that indicates whether HTTP pre-authentication should be performed.
  /// </summary>
  bool get PreAuthenticate => this._preAuthenticate;

  set PreAuthenticate(bool value) {
    this._preAuthenticate = value;
  }

  /// <summary>
  /// Gets or sets a value indicating whether GZip compression encoding should be accepted.
  /// </summary>
  /// <remarks>
  /// This value will tell the server that the client is able to handle GZip compression encoding. The server
  /// will only send Gzip compressed content if it has been configured to do so.
  /// </remarks>
  bool get AcceptGzipEncoding => this._acceptGzipEncoding;

  set AcceptGzipEncoding(bool value) {
    this._acceptGzipEncoding = value;
  }

  /// <summary>
  /// Gets the requested server version.
  /// </summary>
  /// <value>The requested server version.</value>
  ExchangeVersion get RequestedServerVersion => this._requestedServerVersion;

  /// <summary>
  /// Gets or sets the user agent.
  /// </summary>
  /// <value>The user agent.</value>
  String get UserAgent => this._userAgent;

  set UserAgent(String value) {
    this._userAgent = value;
  }

  /// <summary>
  /// Gets information associated with the server that processed the last request.
  /// Will be null if no requests have been processed.
  /// </summary>
  ExchangeServerInfo get ServerInfo => this._serverInfo;

  set ServerInfo(ExchangeServerInfo value) {
    this._serverInfo = value;
  }

  /// <summary>
  /// Gets or sets the web proxy that should be used when sending requests to EWS.
  /// Set this property to null to use the default web proxy.
  /// </summary>
  IWebProxy get WebProxy => this._webProxy;

  set WebProxt(IWebProxy value) {
    this._webProxy = value;
  }

  /// <summary>
  /// Gets or sets if the request to the internet resource should contain a Connection HTTP header with the value Keep-alive
  /// </summary>
  bool get KeepAlive => this._keepAlive;

  set KeepAlive(bool value) {
    this._keepAlive = value;
  }

  /// <summary>
  /// Gets or sets the name of the connection group for the request.
  /// </summary>
  String get ConnectionGroupName => this._connectionGroupName;

  set ConnectionGroupName(String value) {
    this._connectionGroupName = value;
  }

  /// <summary>
  /// Gets or sets the request id for the request.
  /// </summary>
  String get ClientRequestId => this._clientRequestId;

  set ClientRequestId(String value) {
    this._clientRequestId = value;
  }

  /// <summary>
  /// Gets or sets a flag to indicate whether the client requires the server side to return the  request id.
  /// </summary>

// bool ReturnClientRequestId
//        {
//            get { return this.returnClientRequestId; }
//            set { this.returnClientRequestId = value; }
//        }

  /// <summary>
  /// Gets a collection of HTTP headers that will be sent with each request to EWS.
  /// </summary>
  Map<String, String> get HttpHeaders => this._httpHeaders;

  /// <summary>
  /// Gets a collection of HTTP headers from the last response.
  /// </summary>
  Map<String, String> get HttpResponseHeaders => this._httpResponseHeaders;

  /// <summary>
  /// Gets the session key.
  /// </summary>
  static Uint8List get SessionKey {
    // this has to be computed only once.
    if (ExchangeServiceBase._binarySecret == null) {
      Random randomNumberGenerator = Random();
      ExchangeServiceBase._binarySecret = Uint8List(256 ~/ 8);
      for (int i = 0; i < ExchangeServiceBase._binarySecret.length; i++) {
        ExchangeServiceBase._binarySecret[i] =
            randomNumberGenerator.nextInt(256);
      }
    }
    return ExchangeServiceBase._binarySecret;
  }

  /// <summary>
  /// Gets or sets the HTTP web request factory.
  /// </summary>
  IEwsHttpWebRequestFactory get HttpWebRequestFactory =>
      this._ewsHttpWebRequestFactory;

  set HttpWebRequestFactory(IEwsHttpWebRequestFactory value) {
    // If new value is null, reset to default factory.
    this._ewsHttpWebRequestFactory =
        (value == null) ? new EwsHttpWebRequestFactory() : value;
  }

  /// <summary>
  /// For testing: suppresses generation of the SOAP version header.
  /// </summary>
  bool SuppressXmlVersionHeader = false;

  /// <summary>
  /// Provides an event that applications can implement to emit custom SOAP headers in requests that are sent to Exchange.
  /// </summary>
  List<CustomXmlSerializationDelegate> OnSerializeCustomSoapHeaders = [];

// event CustomXmlSerializationDelegate OnSerializeCustomSoapHeaders;
}
