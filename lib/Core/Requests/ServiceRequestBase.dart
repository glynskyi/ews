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

import 'dart:async';
import 'dart:io';

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeServerInfo.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceError.dart';
import 'package:ews/Enumerations/TraceFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Exceptions/ServerBusyException.dart';
import 'package:ews/Exceptions/ServiceRequestException.dart';
import 'package:ews/Exceptions/ServiceResponseException.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/Exceptions/ServiceXmlDeserializationException.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebExceptionStatus.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';
import 'package:ews/Xml/XmlException.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/HttpStatusCode.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:ews/misc/SoapFaultDetails.dart';
import 'package:ews/misc/Std/EnumToString.dart';
import 'package:ews/misc/Std/MemoryStream.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents an service request.
/// </summary>
abstract class ServiceRequestBase {
  /// <summary>
  /// The two contants below are used to set the AnchorMailbox and ExplicitLogonUser values
  /// in the request header.
  /// </summary>
  /// <remarks>
  /// Note: Setting this values will route the request directly to the backend hosting the
  /// AnchorMailbox. These headers should be used primarily for UnifiedGroup scenario where
  /// a request needs to be routed directly to the group mailbox versus the user mailbox.
  /// </remarks>
  static const String _AnchorMailboxHeaderName = "X-AnchorMailbox";
  static const String _ExplicitLogonUserHeaderName = "X-OWA-ExplicitLogonUser";

//  static const List<String> _RequestIdResponseHeaders = ["RequestId", "request-id"];
//  static const String _XMLSchemaNamespace = "http://www.w3.org/2001/XMLSchema";
//  static const String _XMLSchemaInstanceNamespace = "http://www.w3.org/2001/XMLSchema-instance";
//  static const String _ClientStatisticsRequestHeader = "X-ClientStatistics";

  /// <summary>
  /// Gets or sets the anchor mailbox associated with the request
  /// </summary>
  /// <remarks>
  /// Setting this value will add special headers to the request which in turn
  /// will route the request directly to the mailbox server against which the request
  /// is to be executed.
  /// </remarks>
  String? AnchorMailbox;

  /// <summary>
  /// Maintains the collection of client side statistics for requests already completed
  /// </summary>
  static List<String> _clientStatisticsCache = <String>[];

  ExchangeService _service;

  /// <summary>
  /// Gets the response stream (may be wrapped with GZip/Deflate stream to decompress content)
  /// </summary>
  /// <param name="response">HttpWebResponse.</param>
  /// <returns>ResponseStream</returns>
  static Stream<List<int>> GetResponseStream(IEwsHttpWebResponse response) {
    String contentEncoding = response.ContentEncoding;
    Stream<List<int>> responseStream = response.GetResponseStream();

    return _WrapStream(responseStream, response.ContentEncoding);
  }

  /// <summary>
  /// Gets the response stream (may be wrapped with GZip/Deflate stream to decompress content)
  /// </summary>
  /// <param name="response">HttpWebResponse.</param>
  /// <param name="readTimeout">read timeout in milliseconds</param>
  /// <returns>ResponseStream</returns>
  static Stream<List<int>> GetResponseStreamWithTimeout(
      IEwsHttpWebResponse response, int readTimeout) {
    Stream responseStream = response.GetResponseStream();

//            responseStream.ReadTimeout = readTimeout;
    return _WrapStream(
        responseStream as Stream<List<int>>, response.ContentEncoding);
  }

  static Stream<List<int>> _WrapStream(
      Stream<List<int>> responseStream, String contentEncoding) {
    if (contentEncoding.toLowerCase().contains("gzip")) {
      return GZipCodec().decoder.bind(responseStream);
      // return new GZipStream(responseStream, CompressionMode.Decompress);
    } else if (contentEncoding.toLowerCase().contains("deflate")) {
      // return new DeflateStream(responseStream, CompressionMode.Decompress);
      return ZLibDecoder().bind(responseStream);
    } else {
      return responseStream;
    }
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  String GetXmlElementName();

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  String GetResponseXmlElementName();

  /// <summary>
  /// Gets the minimum server version required to process this request.
  /// </summary>
  /// <returns>Exchange server version.</returns>
  ExchangeVersion GetMinimumRequiredServerVersion();

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteElementsToXml(EwsServiceXmlWriter writer);

  /// <summary>
  /// Parses the response.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>Response object.</returns>
  Future<Object> ParseResponse(EwsServiceXmlReader reader) async {
    throw new NotImplementedException(
        "you must override either this or the 2-parameter version");
  }

  /// <summary>
  /// Parses the response.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="responseHeaders">Response headers</param>
  /// <returns>Response object.</returns>
  /// <remarks>If this is overriden instead of the 1-parameter version, you can read response headers</remarks>
  Future<Object> ParseResponseWithHeaders(
      EwsServiceXmlReader reader, WebHeaderCollection responseHeaders) async {
    return this.ParseResponse(reader);
  }

  /// <summary>
  /// Gets a value indicating whether the TimeZoneContext SOAP header should be eimitted.
  /// </summary>
  /// <value><c>true</c> if the time zone should be emitted; otherwise, <c>false</c>.</value>
  bool get EmitTimeZoneHeader => false;

  /// <summary>
  /// Validate request.
  /// </summary>
  void Validate() {
    this.Service.Validate();
  }

  /// <summary>
  /// Writes XML body.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteBodyToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Messages, this.GetXmlElementName());

    this.WriteAttributesToXml(writer);
    this.WriteElementsToXml(writer);

    writer.WriteEndElement(); // m:this.GetXmlElementName()
  }

  /// <summary>
  /// Writes XML attributes.
  /// </summary>
  /// <remarks>
  /// Subclass will override if it has XML attributes.
  /// </remarks>
  /// <param name="writer">The writer.</param>
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {}

  /// <summary>
  /// Allows the subclasses to add their own header information
  /// </summary>
  /// <param name="webHeaderCollection">The HTTP request headers</param>
  void AddHeaders(WebHeaderCollection? webHeaderCollection) {
    if (!StringUtils.IsNullOrEmpty(this.AnchorMailbox)) {
      webHeaderCollection!.Set(_AnchorMailboxHeaderName, this.AnchorMailbox);
      webHeaderCollection.Set(_ExplicitLogonUserHeaderName, this.AnchorMailbox);
    }
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceRequestBase"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  ServiceRequestBase(this._service) {
    this.ThrowIfNotSupportedByRequestedServerVersion();
  }

  /// <summary>
  /// Gets the service.
  /// </summary>
  /// <value>The service.</value>
  ExchangeService get Service => this._service;

  /// <summary>
  /// Throw exception if request is not supported in requested server version.
  /// </summary>
  /// <exception cref="ServiceVersionException">Raised if request requires a later version of Exchange.</exception>
  void ThrowIfNotSupportedByRequestedServerVersion() {
    if (this.Service.RequestedServerVersion.index <
        this.GetMinimumRequiredServerVersion().index) {
      throw new ServiceVersionException("""string.Format(
                        Strings.RequestIncompatibleWithRequestVersion,
                        this.GetXmlElementName(),
                        this.GetMinimumRequiredServerVersion())""");
    }
  }

  /// <summary>
  /// Writes XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(
        XmlNamespace.Soap, XmlElementNames.SOAPEnvelopeElementName);
    writer.WriteAttributeValueWithPrefix(
        "xmlns",
        EwsUtilities.EwsXmlSchemaInstanceNamespacePrefix,
        EwsUtilities.EwsXmlSchemaInstanceNamespace);
    writer.WriteAttributeValueWithPrefix(
        "xmlns",
        EwsUtilities.EwsMessagesNamespacePrefix,
        EwsUtilities.EwsMessagesNamespace);
    writer.WriteAttributeValueWithPrefix("xmlns",
        EwsUtilities.EwsTypesNamespacePrefix, EwsUtilities.EwsTypesNamespace);
    if (writer.RequireWSSecurityUtilityNamespace) {
      writer.WriteAttributeValueWithPrefix(
          "xmlns",
          EwsUtilities.WSSecurityUtilityNamespacePrefix,
          EwsUtilities.WSSecurityUtilityNamespace);
    }

    writer.WriteStartElement(
        XmlNamespace.Soap, XmlElementNames.SOAPHeaderElementName);

    if (this.Service.Credentials != null) {
      this
          .Service
          .Credentials!
          .EmitExtraSoapHeaderNamespaceAliases(writer.InternalWriter);
    }

    // Emit the RequestServerVersion header
    if (!this.Service.SuppressXmlVersionHeader) {
      writer.WriteStartElement(
          XmlNamespace.Types, XmlElementNames.RequestServerVersion);
      writer.WriteAttributeValue(
          XmlAttributeNames.Version, this._GetRequestedServiceVersionString());
      writer.WriteEndElement(); // RequestServerVersion
    }

    // Against Exchange 2007 SP1, we always emit the simplified time zone header. It adds very little to
    // the request, so bandwidth consumption is not an issue. Against Exchange 2010 and above, we emit
    // the full time zone header but only when the request actually needs it.
    //
    // The exception to this is if we are in Exchange2007 Compat Mode, in which case we should never emit
    // the header.  (Note: Exchange2007 Compat Mode is enabled for testability purposes only.)
    //
    if ((this.Service.RequestedServerVersion ==
                ExchangeVersion.Exchange2007_SP1 ||
            this.EmitTimeZoneHeader) &&
        (!this.Service.Exchange2007CompatibilityMode)) {
//                writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.TimeZoneContext);

      // todo("implement time zone definitions")
//                this.Service.TimeZoneDefinition.WriteToXml(writer);

//                writer.WriteEndElement(); // TimeZoneContext

      writer.IsTimeZoneHeaderEmitted = true;
    }

    // Emit the MailboxCulture header
    // todo("restore this features")
//            if (this.Service.PreferredCulture != null)
//            {
//                writer.WriteElementValueWithNamespace(
//                    XmlNamespace.Types,
//                    XmlElementNames.MailboxCulture,
//                    this.Service.PreferredCulture.Name);
//            }

    // Emit the DateTimePrecision header
    // todo("restore this features")
//            if (this.Service.DateTimePrecision != DateTimePrecision.Default)
//            {
//                writer.WriteElementValueWithNamespace(
//                    XmlNamespace.Types,
//                    XmlElementNames.DateTimePrecision,
//                    this.Service.DateTimePrecision.ToString());
//            }

    // Emit the ExchangeImpersonation header
    // todo("restore this features")
//            if (this.Service.ImpersonatedUserId != null)
//            {
//                this.Service.ImpersonatedUserId.WriteToXml(writer);
//            }
//            else if (this.Service.PrivilegedUserId != null)
//            {
//                this.Service.PrivilegedUserId.WriteToXml(writer, this.Service.RequestedServerVersion);
//            }
//            else if (this.Service.ManagementRoles != null)
//            {
//                this.Service.ManagementRoles.WriteToXml(writer);
//            }

    if (this.Service.Credentials != null) {
      this.Service.Credentials!.SerializeExtraSoapHeaders(
          writer.InternalWriter, this.GetXmlElementName());
    }

    this.Service.DoOnSerializeCustomSoapHeaders(writer.InternalWriter);

    writer.WriteEndElement(); // soap:Header

    writer.WriteStartElement(
        XmlNamespace.Soap, XmlElementNames.SOAPBodyElementName);

    this.WriteBodyToXml(writer);

    writer.WriteEndElement(); // soap:Body
    writer.WriteEndElement(); // soap:Envelope
  }

  /// <summary>
  /// Gets String representation of requested server version.
  /// </summary>
  /// <remarks>
  /// In order to support E12 RTM servers, ExchangeService has another flag indicating that
  /// we should use "Exchange2007" as the server version String rather than Exchange2007_SP1.
  /// </remarks>
  /// <returns>String representation of requested server version.</returns>
  String? _GetRequestedServiceVersionString() {
    if (this.Service.Exchange2007CompatibilityMode &&
        this.Service.RequestedServerVersion ==
            ExchangeVersion.Exchange2007_SP1) {
      return "Exchange2007";
    } else {
      return EnumToString.parse(this.Service.RequestedServerVersion);
    }
  }

  /// <summary>
  /// Emits the request.
  /// </summary>
  /// <param name="request">The request.</param>
  Future<void> _EmitRequest(IEwsHttpWebRequest request) async {
    StreamConsumer<List<int>>? requestStream =
        await this._GetWebRequestStream(request);
    EwsServiceXmlWriter writer =
        new EwsServiceXmlWriter(this.Service, requestStream);
    this.WriteToXml(writer);
    await writer.Flush();
    await writer.Dispose();
  }

  /// <summary>
  /// Traces the and emits the request.
  /// </summary>
  /// <param name="request">The request.</param>
  /// <param name="needSignature"></param>
  /// <param name="needTrace"></param>
  Future<void> _TraceAndEmitRequest(
      IEwsHttpWebRequest request, bool needSignature, bool needTrace) async {
    MemoryStream memoryStream = new MemoryStream();

    EwsServiceXmlWriter writer =
        new EwsServiceXmlWriter(this.Service, memoryStream);

    writer.RequireWSSecurityUtilityNamespace = needSignature;
    this.WriteToXml(writer);

    await writer.Flush();
    await writer.Dispose();

    if (needSignature) {
      this._service.Credentials!.Sign(memoryStream);
    }

    if (needTrace) {
      this.TraceXmlRequest(memoryStream);
    }

    StreamConsumer<List<int>> serviceRequestStream = await (this
        ._GetWebRequestStream(request) as FutureOr<StreamConsumer<List<int>>>);

    await EwsUtilities.CopyStream(memoryStream, serviceRequestStream);
    await serviceRequestStream.close();

    await memoryStream.close();
  }

  /// <summary>
  /// Get the request stream
  /// </summary>
  /// <param name="request">The request</param>
  /// <returns>The Request stream</returns>
  Future<StreamConsumer<List<int>>> _GetWebRequestStream(
      IEwsHttpWebRequest request) {
    // In the async case, although we can use async callback to make the entire worflow completely async,
    // there is little perf gain with this approach because of EWS's message nature.
    // The overall latency of BeginGetRequestStream() is same as GetRequestStream() in this case.
    // The overhead to implement a two-step async operation includes wait handle synchronization, exception handling and wrapping.
    // Therefore, we only leverage BeginGetResponse() and EndGetResponse() to provide the async functionality.
    // Reference: http://www.wintellect.com/CS/blogs/jeffreyr/archive/2009/02/08/httpwebrequest-its-request-stream-and-sending-data-in-chunks.aspx
//            return request.EndGetRequestStream(request.BeginGetRequestStream(null, null));
    return request.GetRequestStream();
  }

  /// <summary>
  /// Reads the response.
  /// </summary>
  /// <param name="ewsXmlReader">The XML reader.</param>
  /// <param name="responseHeaders">HTTP response headers</param>
  /// <returns>Service response.</returns>
  Future<Object> ReadResponseWithHeaders(EwsServiceXmlReader ewsXmlReader,
      WebHeaderCollection? responseHeaders) async {
    Object serviceResponse;

    await this.ReadPreamble(ewsXmlReader);
    await ewsXmlReader.ReadStartElementWithNamespace(
        XmlNamespace.Soap, XmlElementNames.SOAPEnvelopeElementName);
    await this._ReadSoapHeader(ewsXmlReader);
    await ewsXmlReader.ReadStartElementWithNamespace(
        XmlNamespace.Soap, XmlElementNames.SOAPBodyElementName);

    await ewsXmlReader.ReadStartElementWithNamespace(
        XmlNamespace.Messages, this.GetResponseXmlElementName());

    if (responseHeaders != null) {
      serviceResponse =
          await this.ParseResponseWithHeaders(ewsXmlReader, responseHeaders);
    } else {
      serviceResponse = await this.ParseResponse(ewsXmlReader);
    }

    await ewsXmlReader.ReadEndElementIfNecessary(
        XmlNamespace.Messages, this.GetResponseXmlElementName());

    await ewsXmlReader.ReadEndElementWithNamespace(
        XmlNamespace.Soap, XmlElementNames.SOAPBodyElementName);
    await ewsXmlReader.ReadEndElementWithNamespace(
        XmlNamespace.Soap, XmlElementNames.SOAPEnvelopeElementName);
    return serviceResponse;
  }

  /// <summary>
  /// Reads any preamble data not part of the core response.
  /// </summary>
  /// <param name="ewsXmlReader">The EwsServiceXmlReader.</param>
  Future<void> ReadPreamble(EwsServiceXmlReader ewsXmlReader) async {
    await this._ReadXmlDeclaration(ewsXmlReader);
  }

  /// <summary>
  /// Read SOAP header and extract server version
  /// </summary>
  /// <param name="reader">EwsServiceXmlReader</param>
  Future<void> _ReadSoapHeader(EwsServiceXmlReader reader) async {
    await reader.ReadStartElementWithNamespace(
        XmlNamespace.Soap, XmlElementNames.SOAPHeaderElementName);
    do {
      await reader.Read();

      // Is this the ServerVersionInfo?
      if (reader.IsStartElementWithNamespace(
          XmlNamespace.Types, XmlElementNames.ServerVersionInfo)) {
        this.Service.ServerInfo = ExchangeServerInfo.Parse(reader);
      }

      // Ignore anything else inside the SOAP header
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Soap, XmlElementNames.SOAPHeaderElementName));
  }

  /// <summary>
  /// Reads the SOAP fault.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>SOAP fault details.</returns>
  Future<SoapFaultDetails?> ReadSoapFault(EwsServiceXmlReader reader) async {
    SoapFaultDetails? soapFaultDetails = null;

    try {
      await this._ReadXmlDeclaration(reader);

      await reader.Read();
      if (!reader.IsStartElement() ||
          (reader.LocalName != XmlElementNames.SOAPEnvelopeElementName)) {
        return soapFaultDetails;
      }

      // namespace URI from the envelope element and use it for the rest of the parsing.
      // If it's not 1.1 or 1.2, we can't continue.
      XmlNamespace soapNamespace =
          EwsUtilities.GetNamespaceFromUri(reader.NamespaceUri);
      if (soapNamespace == XmlNamespace.NotSpecified) {
        return soapFaultDetails;
      }

      await reader.Read();

      // EWS doesn't always return a SOAP header. If this response contains a header element,
      // read the server version information contained in the header.
      if (reader.IsStartElementWithNamespace(
          soapNamespace, XmlElementNames.SOAPHeaderElementName)) {
        do {
          await reader.Read();

          if (reader.IsStartElementWithNamespace(
              XmlNamespace.Types, XmlElementNames.ServerVersionInfo)) {
            this.Service.ServerInfo = ExchangeServerInfo.Parse(reader);
          }
        } while (!reader.IsEndElementWithNamespace(
            soapNamespace, XmlElementNames.SOAPHeaderElementName));

        // Queue up the next read
        await reader.Read();
      }

      // Parse the fault element contained within the SOAP body.
      if (reader.IsStartElementWithNamespace(
          soapNamespace, XmlElementNames.SOAPBodyElementName)) {
        do {
          await reader.Read();

          // Parse Fault element
          if (reader.IsStartElementWithNamespace(
              soapNamespace, XmlElementNames.SOAPFaultElementName)) {
            soapFaultDetails =
                await SoapFaultDetails.Parse(reader, soapNamespace);
          }
        } while (!reader.IsEndElementWithNamespace(
            soapNamespace, XmlElementNames.SOAPBodyElementName));
      }

      await reader.ReadEndElementWithNamespace(
          soapNamespace, XmlElementNames.SOAPEnvelopeElementName);
    } on XmlException catch (e) {
      // If response doesn't contain a valid SOAP fault, just ignore exception and
      // return null for SOAP fault details.
    }

    return soapFaultDetails;
  }

  /// <summary>
  /// Validates request parameters, and emits the request to the server.
  /// </summary>
  /// <param name="request">The request.</param>
  /// <returns>The response returned by the server.</returns>
  Future<IEwsHttpWebResponse> ValidateAndEmitRequest(
      OutParam<IEwsHttpWebRequest> requestOut) async {
    this.Validate();

    // todo("implement validation")
    IEwsHttpWebRequest request = await this.BuildEwsHttpWebRequest();
    requestOut.param = request;
//
//            if (this.service.SendClientLatencies)
//            {
//                String clientStatisticsToAdd = null;
//
//                lock (clientStatisticsCache)
//                {
//                    if (clientStatisticsCache.Count > 0)
//                    {
//                        clientStatisticsToAdd = clientStatisticsCache[0];
//                        clientStatisticsCache.RemoveAt(0);
//                    }
//                }
//
//                if (!StringUtils.IsNullOrEmpty(clientStatisticsToAdd))
//                {
//                    if (request.Headers[ClientStatisticsRequestHeader] != null)
//                    {
//                        request.Headers[ClientStatisticsRequestHeader] =
//                            request.Headers[ClientStatisticsRequestHeader]
//                            + clientStatisticsToAdd;
//                    }
//                    else
//                    {
//                        request.Headers.Add(
//                            ClientStatisticsRequestHeader,
//                            clientStatisticsToAdd);
//                    }
//                }
//            }
//
//            DateTime startTime = DateTime.UtcNow;
    IEwsHttpWebResponse? response = null;
//
//            try
//            {
    response = await this.GetEwsHttpWebResponse(request);
//            }
//            finally
//            {
//                if (this.service.SendClientLatencies)
//                {
//                    int clientSideLatency = (int)(DateTime.UtcNow - startTime).TotalMilliseconds;
//                    String requestId = "";
//                    String soapAction = this.GetType().Name.Replace("Request", "");
//
//                    if (response != null && response.Headers != null)
//                    {
//                        for (String requestIdHeader in ServiceRequestBase.RequestIdResponseHeaders)
//                        {
//                            String requestIdValue = response.Headers.Get(requestIdHeader);
//                            if (!StringUtils.IsNullOrEmpty(requestIdValue))
//                            {
//                                requestId = requestIdValue;
//                                break;
//                            }
//                        }
//                    }
//
//                    StringBuffer sb = new StringBuffer();
//                    sb.write("MessageId=");
//                    sb.write(requestId);
//                    sb.write(",ResponseTime=");
//                    sb.write(clientSideLatency);
//                    sb.write(",SoapAction=");
//                    sb.write(soapAction);
//                    sb.write(";");
//
//                    lock (clientStatisticsCache)
//                    {
//                        clientStatisticsCache.Add(sb.toString());
//                    }
//                }
//            }

    return response;
  }

  /// <summary>
  /// Builds the IEwsHttpWebRequest object for current service request with exception handling.
  /// </summary>
  /// <returns>An IEwsHttpWebRequest instance</returns>
  Future<IEwsHttpWebRequest> BuildEwsHttpWebRequest() async {
    IEwsHttpWebRequest? request = null;
    try {
      request =
          await this.Service.PrepareHttpWebRequest(this.GetXmlElementName());

      this
          .Service
          .TraceHttpRequestHeaders(TraceFlags.EwsRequestHttpHeaders, request);

      bool needSignature = this.Service.Credentials != null &&
          this.Service.Credentials!.NeedSignature;
      bool needTrace = this.Service.IsTraceEnabledFor(TraceFlags.EwsRequest);

      // The request might need to add additional headers
      this.AddHeaders(request.Headers);

      // If tracing is enabled, we generate the request in-memory so that we
      // can pass it along to the ITraceListener. Then we copy the stream to
      // the request stream.
      if (needSignature || needTrace) {
        await this._TraceAndEmitRequest(request, needSignature, needTrace);
      } else {
        await this._EmitRequest(request);
      }

      return request;
    } on WebException catch (ex, stacktrace) {
      if (ex.Status == WebExceptionStatus.ProtocolError &&
          ex.Response != null) {
        await this._ProcessWebException(ex);
      }

      // Wrap exception if the above code block didn't throw
      throw new ServiceRequestException(
          "ServiceRequestFailed(${ex.message})", ex, stacktrace);
    } on IOException catch (ex, stacktrace) {
      if (request != null) {
        request.Abort();
      }
      // Wrap exception.
      throw new ServiceRequestException(
          "ServiceRequestFailed($ex)", ex, stacktrace);
    }
  }

  /// <summary>
  ///  Gets the IEwsHttpWebRequest object from the specified IEwsHttpWebRequest object with exception handling
  /// </summary>
  /// <param name="request">The specified IEwsHttpWebRequest</param>
  /// <returns>An IEwsHttpWebResponse instance</returns>
  Future<IEwsHttpWebResponse> GetEwsHttpWebResponse(
      IEwsHttpWebRequest request) async {
    try {
      IEwsHttpWebResponse response = await request.GetResponse();
      return response;
    } on WebException catch (ex, stacktrace) {
      if (ex.Status == WebExceptionStatus.ProtocolError &&
          ex.Response != null) {
        await this._ProcessWebException(ex);
      }

      // Wrap exception if the above code block didn't throw
      throw new ServiceRequestException(
          "Strings.ServiceRequestFailed($ex)", ex, stacktrace);
    } on IOException catch (ex, stacktrace) {
      // Wrap exception.
      throw new ServiceRequestException(
          "ServiceRequestFailed($ex)", ex, stacktrace);
    }
  }

  /// <summary>
  /// Ends getting the specified async IEwsHttpWebRequest object from the specified IEwsHttpWebRequest object with exception handling.
  /// </summary>
  /// <param name="request">The specified IEwsHttpWebRequest</param>
  /// <param name="asyncResult">An IAsyncResult that references the asynchronous request.</param>
  /// <returns>An IEwsHttpWebResponse instance</returns>
//        IEwsHttpWebResponse EndGetEwsHttpWebResponse(IEwsHttpWebRequest request, IAsyncResult asyncResult)
//        {
//            try
//            {
//                // Note that this call may throw ArgumentException if the HttpWebRequest instance is not the original one,
//                // and we just let it out
//                return request.EndGetResponse(asyncResult);
//            }
//            on WebException catch(ex)
//            {
//                if (ex.Status == WebExceptionStatus.ProtocolError && ex.Response != null)
//                {
//                    this.ProcessWebException(ex);
//                }
//
//                // Wrap exception if the above code block didn't throw
//                throw new ServiceRequestException("string.Format(Strings.ServiceRequestFailed, ex.Message)", ex);
//            }
//            on IOException catch (e)
//            {
//                // Wrap exception.
//                throw new ServiceRequestException("string.Format(Strings.ServiceRequestFailed, e.Message)"", e);
//            }
//        }

  /// <summary>
  /// Processes the web exception.
  /// </summary>
  /// <param name="webException">The web exception.</param>
  Future<void> _ProcessWebException(WebException webException) async {
    if (webException.Response != null) {
      IEwsHttpWebResponse httpWebResponse = this
          .Service
          .HttpWebRequestFactory
          .CreateExceptionResponse(webException);
      SoapFaultDetails? soapFaultDetails = null;

      if (httpWebResponse.StatusCode == HttpStatusCode.InternalServerError) {
        this.Service.ProcessHttpResponseHeaders(
            TraceFlags.EwsResponseHttpHeaders, httpWebResponse);

        // If tracing is enabled, we read the entire response into a MemoryStream so that we
        // can pass it along to the ITraceListener. Then we parse the response from the
        // MemoryStream.
        if (this.Service.IsTraceEnabledFor(TraceFlags.EwsResponse)) {
          MemoryStream memoryStream = new MemoryStream();
          Stream serviceResponseStream =
              ServiceRequestBase.GetResponseStream(httpWebResponse);

          // Copy response to in-memory stream and reset position to start.
          await EwsUtilities.CopyStream(
              serviceResponseStream as Stream<List<int>>, memoryStream);
          memoryStream.Position = 0;

//                            await serviceResponseStream.close();

          this.TraceResponseXml(httpWebResponse, memoryStream);

          EwsServiceXmlReader reader =
              await EwsServiceXmlReader.Create(memoryStream, this.Service);
          soapFaultDetails = await this.ReadSoapFault(reader);
          await memoryStream.close();
        } else {
          Stream stream = ServiceRequestBase.GetResponseStream(httpWebResponse);

          EwsServiceXmlReader reader = await EwsServiceXmlReader.Create(
              stream as Stream<List<int>>, this.Service);
          soapFaultDetails = await this.ReadSoapFault(reader);
//                        await stream.close();
        }

        if (soapFaultDetails != null) {
          switch (soapFaultDetails.ResponseCode) {
            case ServiceError.ErrorInvalidServerVersion:
              throw new ServiceVersionException(
                  "Strings.ServerVersionNotSupported");

            case ServiceError.ErrorSchemaValidation:
              // If we're talking to an E12 server (8.00.xxxx.xxx), a schema validation error is the same as a version mismatch error.
              // (Which only will happen if we send a request that's not valid for E12).
              if ((this.Service.ServerInfo != null) &&
                  (this.Service.ServerInfo!.MajorVersion == 8) &&
                  (this.Service.ServerInfo!.MinorVersion == 0)) {
                throw new ServiceVersionException(
                    "Strings.ServerVersionNotSupported");
              }

              break;

            case ServiceError.ErrorIncorrectSchemaVersion:
              // This shouldn't happen. It indicates that a request wasn't valid for the version that was specified.
//                                EwsUtilities.Assert(
//                                    false,
//                                    "ServiceRequestBase.ProcessWebException",
//                                    "Exchange server supports requested version but request was invalid for that version");
              break;

            case ServiceError.ErrorServerBusy:
              throw new ServerBusyException(
                  new ServiceResponse.withSoapFault(soapFaultDetails));

            default:
              // Other error codes will be reported as remote error
              break;
          }

          // General fall-through case: throw a ServiceResponseException
          throw new ServiceResponseException(
              new ServiceResponse.withSoapFault(soapFaultDetails));
        }
      } else {
        this.Service.ProcessHttpErrorResponse(httpWebResponse, webException);
      }
    }
  }

  /// <summary>
  /// Traces an XML request.  This should only be used for synchronous requests, or synchronous situations
  /// (such as a WebException on an asynchrounous request).
  /// </summary>
  /// <param name="memoryStream">The request content in a MemoryStream.</param>
  void TraceXmlRequest(MemoryStream memoryStream) {
    this.Service.TraceXml(TraceFlags.EwsRequest, memoryStream);
  }

  /// <summary>
  /// Traces the response.  This should only be used for synchronous requests, or synchronous situations
  /// (such as a WebException on an asynchrounous request).
  /// </summary>
  /// <param name="response">The response.</param>
  /// <param name="memoryStream">The response content in a MemoryStream.</param>
  void TraceResponseXml(
      IEwsHttpWebResponse response, MemoryStream memoryStream) {
    // todo("check OrdinalIgnoreCase argument");
    if (!StringUtils.IsNullOrEmpty(response.ContentType) &&
        (response.ContentType.startsWith(
                "text/" /*, StringComparison.OrdinalIgnoreCase*/) ||
            response.ContentType.startsWith(
                "application/soap" /*, StringComparison.OrdinalIgnoreCase)*/))) {
      this.Service.TraceXml(TraceFlags.EwsResponse, memoryStream);
    } else {
      this.Service.TraceMessage(TraceFlags.EwsResponse, "Non-textual response");
    }
  }

  /// <summary>
  /// Try to read the XML declaration. If it's not there, the server didn't return XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  Future<void> _ReadXmlDeclaration(EwsServiceXmlReader reader) async {
    try {
      await reader.Read(nodeType: XmlNodeType.XmlDeclaration);
    } on XmlException catch (ex, stacktrace) {
      throw new ServiceRequestException(
          "ServiceResponseDoesNotContainXml", ex, stacktrace);
    } on ServiceXmlDeserializationException catch (ex, stacktrace) {
      throw new ServiceRequestException(
          "ServiceResponseDoesNotContainXml", ex, stacktrace);
    }
  }
}
