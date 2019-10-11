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









    import 'dart:io';

import 'package:ews/Autodiscover/AutodiscoverService.dart';
import 'package:ews/Autodiscover/Responses/AutodiscoverResponse.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/ExchangeServerInfo.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AutodiscoverErrorCode.dart';
import 'package:ews/Enumerations/TraceFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceRemoteException.dart';
import 'package:ews/Exceptions/ServiceRequestException.dart';
import 'package:ews/Exceptions/ServiceResponseException.dart';
import 'package:ews/Exceptions/ServiceXmlDeserializationException.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebExceptionStatus.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';
import 'package:ews/Xml/XmlException.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/HttpStatusCode.dart';
import 'package:ews/misc/SoapFaultDetails.dart';
import 'package:ews/misc/StringUtils.dart';
import 'package:ews/misc/UriHelper.dart';

/// <summary>
    /// Represents the base class for all requested made to the Autodiscover service.
    /// </summary>
    abstract class AutodiscoverRequest
    {
        AutodiscoverService _service;
        Uri _url;

        /// <summary>
        /// Initializes a new instance of the <see cref="AutodiscoverRequest"/> class.
        /// </summary>
        /// <param name="service">Autodiscover service associated with this request.</param>
        /// <param name="url">URL of Autodiscover service.</param>
        AutodiscoverRequest(AutodiscoverService service, Uri url)
        {
            this._service = service;
            this._url = url;
        }

        /// <summary>
        /// Determines whether response is a redirection.
        /// </summary>
        /// <param name="httpWebResponse">The HTTP web response.</param>
        /// <returns>True if redirection response.</returns>
        static bool IsRedirectionResponse(IEwsHttpWebResponse httpWebResponse)
        {
            return (httpWebResponse.StatusCode == HttpStatusCode.Redirect) ||
                   (httpWebResponse.StatusCode == HttpStatusCode.Moved) ||
                   (httpWebResponse.StatusCode == HttpStatusCode.RedirectKeepVerb) ||
                   (httpWebResponse.StatusCode == HttpStatusCode.RedirectMethod);
        }

        /// <summary>
        /// Validates the request.
        /// </summary>
        void Validate()
        {
            this.Service.Validate();
        }

        /// <summary>
        /// Executes this instance.
        /// </summary>
        /// <returns></returns>
        Future<AutodiscoverResponse> InternalExecute()
        {
            print("!!!!!!!!");
            throw UnimplementedError("InternalExecute");
//            this.Validate();
//
//            try
//            {
//                IEwsHttpWebRequest request = this.Service.PrepareHttpWebRequestForUrl(this.Url);
//
//                this.Service.TraceHttpRequestHeaders(TraceFlags.AutodiscoverRequestHttpHeaders, request);
//
//                bool needSignature = this.Service.Credentials != null && this.Service.Credentials.NeedSignature;
//                bool needTrace = this.Service.IsTraceEnabledFor(TraceFlags.AutodiscoverRequest);
//
//                using (Stream requestStream = request.GetRequestStream())
//                {
//                    using (MemoryStream memoryStream = new MemoryStream())
//                    {
//                        using (EwsServiceXmlWriter writer = new EwsServiceXmlWriter(this.Service, memoryStream))
//                        {
//                            writer.RequireWSSecurityUtilityNamespace = needSignature;
//                            this.WriteSoapRequest(
//                                this.Url,
//                                writer);
//                        }
//
//                        if (needSignature)
//                        {
//                            this._service.Credentials.Sign(memoryStream);
//                        }
//
//                        if (needTrace)
//                        {
//                            memoryStream.Position = 0;
//                            this.Service.TraceXml(TraceFlags.AutodiscoverRequest, memoryStream);
//                        }
//
//                        EwsUtilities.CopyStream(memoryStream, requestStream);
//                    }
//                }
//
//                using (IEwsHttpWebResponse webResponse = request.GetResponse())
//                {
//                    if (AutodiscoverRequest.IsRedirectionResponse(webResponse))
//                    {
//                        AutodiscoverResponse response = this.CreateRedirectionResponse(webResponse);
//                        if (response != null)
//                        {
//                            return response;
//                        }
//                        else
//                        {
//                            throw new ServiceRemoteException("Strings.InvalidRedirectionResponseReturned");
//                        }
//                    }
//
//                    using (Stream responseStream = AutodiscoverRequest.GetResponseStream(webResponse))
//                    {
//                        using (MemoryStream memoryStream = new MemoryStream())
//                        {
//                            // Copy response stream to in-memory stream and reset to start
//                            EwsUtilities.CopyStream(responseStream, memoryStream);
//                            memoryStream.Position = 0;
//
//                            this.Service.TraceResponse(webResponse, memoryStream);
//
//                            EwsXmlReader ewsXmlReader = new EwsXmlReader(memoryStream);
//
//                            // WCF may not generate an XML declaration.
//                            ewsXmlReader.Read();
//                            if (ewsXmlReader.NodeType == XmlNodeType.XmlDeclaration)
//                            {
//                                ewsXmlReader.ReadStartElementWithNamespace(XmlNamespace.Soap, XmlElementNames.SOAPEnvelopeElementName);
//                            }
//                            else if ((ewsXmlReader.NodeType != XmlNodeType.Element) || (ewsXmlReader.LocalName != XmlElementNames.SOAPEnvelopeElementName) || (ewsXmlReader.NamespaceUri != EwsUtilities.GetNamespaceUri(XmlNamespace.Soap)))
//                            {
//                                throw new ServiceXmlDeserializationException("Strings.InvalidAutodiscoverServiceResponse");
//                            }
//
//                            this.ReadSoapHeaders(ewsXmlReader);
//
//                            AutodiscoverResponse response = this.ReadSoapBody(ewsXmlReader);
//
//                            ewsXmlReader.ReadEndElementWithNamespace(XmlNamespace.Soap, XmlElementNames.SOAPEnvelopeElementName);
//
//                            if (response.ErrorCode == AutodiscoverErrorCode.NoError)
//                            {
//                                return response;
//                            }
//                            else
//                            {
//                                throw new AutodiscoverResponseException(response.ErrorCode, response.ErrorMessage);
//                            }
//                        }
//                    }
//                }
//            }
//            on WebException catch (ex)
//            {
//                if (ex.Status == WebExceptionStatus.ProtocolError && ex.Response != null)
//                {
//                    IEwsHttpWebResponse httpWebResponse = this.Service.HttpWebRequestFactory.CreateExceptionResponse(ex);
//
//                    if (AutodiscoverRequest.IsRedirectionResponse(httpWebResponse))
//                    {
//                        this.Service.ProcessHttpResponseHeaders(
//                            TraceFlags.AutodiscoverResponseHttpHeaders,
//                            httpWebResponse);
//
//                        AutodiscoverResponse response = this.CreateRedirectionResponse(httpWebResponse);
//                        if (response != null)
//                        {
//                            return response;
//                        }
//                    }
//                    else
//                    {
//                        this.ProcessWebException(ex);
//                    }
//                }
//
//                // Wrap exception if the above code block didn't throw
//                throw new ServiceRequestException("string.Format(Strings.ServiceRequestFailed, ex.Message), ex");
//            }
//            on XmlException catch (ex)
//            {
//                this.Service.TraceMessage(
//                    TraceFlags.AutodiscoverConfiguration,
//                    "XML parsing error: $ex", );
//
//                // Wrap exception
//                throw new ServiceRequestException("string.Format(Strings.ServiceRequestFailed, ex.Message), ex");
//            }
//            on IOException catch (ex) {
//                this.Service.TraceMessage(
//                    TraceFlags.AutodiscoverConfiguration,
//                    "I/O error: $ex");
//
//                // Wrap exception
//                throw new ServiceRequestException("string.Format(Strings.ServiceRequestFailed, ex.Message), ex");
//            }
        }

        /// <summary>
        /// Processes the web exception.
        /// </summary>
        /// <param name="webException">The web exception.</param>
        /* private */ void ProcessWebException(WebException webException)
        {
            throw UnimplementedError("ProcessWebException");
//            if (webException.Response != null)
//            {
//                IEwsHttpWebResponse httpWebResponse = this.Service.HttpWebRequestFactory.CreateExceptionResponse(webException);
//                SoapFaultDetails soapFaultDetails;
//
//                if (httpWebResponse.StatusCode == HttpStatusCode.InternalServerError)
//                {
//                    // If tracing is enabled, we read the entire response into a MemoryStream so that we
//                    // can pass it along to the ITraceListener. Then we parse the response from the
//                    // MemoryStream.
//                    if (this.Service.IsTraceEnabledFor(TraceFlags.AutodiscoverRequest))
//                    {
//
//                        {
//
//                            {
//                                // Copy response to in-memory stream and reset position to start.
//                                EwsUtilities.CopyStream(serviceResponseStream, memoryStream);
//                                memoryStream.Position = 0;
//                            }
//
//                            this.Service.TraceResponse(httpWebResponse, memoryStream);
//
//                            EwsXmlReader reader = new EwsXmlReader(memoryStream);
//                            soapFaultDetails = this.ReadSoapFault(reader);
//                        }
//                    }
//                    else
//                    {
//
//                        {
//                            EwsXmlReader reader = new EwsXmlReader(stream);
//                            soapFaultDetails = this.ReadSoapFault(reader);
//                        }
//                    }
//
//                    if (soapFaultDetails != null)
//                    {
//                        throw new ServiceResponseException(new ServiceResponse(soapFaultDetails));
//                    }
//                }
//                else
//                {
//                    this.Service.ProcessHttpErrorResponse(httpWebResponse, webException);
//                }
//            }
        }

        /// <summary>
        /// Create a redirection response.
        /// </summary>
        /// <param name="httpWebResponse">The HTTP web response.</param>
        /* private */ AutodiscoverResponse CreateRedirectionResponse(IEwsHttpWebResponse httpWebResponse)
        {
            String location = httpWebResponse.Headers["Location"];
            if (!StringUtils.IsNullOrEmpty(location))
            {
                try
                {
                    Uri redirectionUri = UriHelper.concat(this.Url, Uri.parse(location));
                    if ((redirectionUri.scheme == "http") || (redirectionUri.scheme == "https"))
                    {
                        AutodiscoverResponse response = this.CreateServiceResponse();
                        response.ErrorCode = AutodiscoverErrorCode.RedirectUrl;
                        response.RedirectionUrl = redirectionUri;
                        return response;
                    }

                    this.Service.TraceMessage(
                        TraceFlags.AutodiscoverConfiguration,
                        "Invalid redirection URL '$redirectionUri' returned by Autodiscover service.");
                }
                catch (UriFormatException)
                {
                    this.Service.TraceMessage(
                        TraceFlags.AutodiscoverConfiguration,
                        "Invalid redirection location '$location' returned by Autodiscover service.");
                }
            }
            else
            {
                this.Service.TraceMessage(
                    TraceFlags.AutodiscoverConfiguration,
                    "Redirection response returned by Autodiscover service without redirection location.");
            }

            return null;
        }

        /// <summary>
        /// Reads the SOAP fault.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>SOAP fault details.</returns>
        /* private */ SoapFaultDetails ReadSoapFault(EwsXmlReader reader)
        {
            SoapFaultDetails soapFaultDetails = null;

            try
            {
                // WCF may not generate an XML declaration.
                reader.Read();
                if (reader.NodeType == XmlNodeType.XmlDeclaration)
                {
                    reader.Read();
                }

                if (!reader.IsStartElement() || (reader.LocalName != XmlElementNames.SOAPEnvelopeElementName))
                {
                    return soapFaultDetails;
                }

                // Get the namespace URI from the envelope element and use it for the rest of the parsing.
                // If it's not 1.1 or 1.2, we can't continue.
                XmlNamespace soapNamespace = EwsUtilities.GetNamespaceFromUri(reader.NamespaceUri);
                if (soapNamespace == XmlNamespace.NotSpecified)
                {
                    return soapFaultDetails;
                }

                reader.Read();

                // Skip SOAP header.
                if (reader.IsStartElementWithNamespace(soapNamespace, XmlElementNames.SOAPHeaderElementName))
                {
                    do
                    {
                        reader.Read();
                    }
                    while (!reader.IsEndElementWithNamespace(soapNamespace, XmlElementNames.SOAPHeaderElementName));

                    // Queue up the next read
                    reader.Read();
                }

                // Parse the fault element contained within the SOAP body.
                if (reader.IsStartElementWithNamespace(soapNamespace, XmlElementNames.SOAPBodyElementName))
                {
                    do
                    {
                        reader.Read();

                        // Parse Fault element
                        if (reader.IsStartElementWithNamespace(soapNamespace, XmlElementNames.SOAPFaultElementName))
                        {
                            soapFaultDetails = SoapFaultDetails.Parse(reader, soapNamespace);
                        }
                    }
                    while (!reader.IsEndElementWithNamespace(soapNamespace, XmlElementNames.SOAPBodyElementName));
                }

                reader.ReadEndElementWithNamespace(soapNamespace, XmlElementNames.SOAPEnvelopeElementName);
            }
            catch (XmlException)
            {
                // If response doesn't contain a valid SOAP fault, just ignore exception and
                // return null for SOAP fault details.
            }

            return soapFaultDetails;
        }

        /// <summary>
        /// Writes the autodiscover SOAP request.
        /// </summary>
        /// <param name="requestUrl">Request URL.</param>
        /// <param name="writer">The writer.</param>
        void WriteSoapRequest(
            Uri requestUrl,
            EwsServiceXmlWriter writer)
        {
            writer.WriteStartElement(XmlNamespace.Soap, XmlElementNames.SOAPEnvelopeElementName);
            writer.WriteAttributeValueWithPrefix("xmlns", EwsUtilities.AutodiscoverSoapNamespacePrefix, EwsUtilities.AutodiscoverSoapNamespace);
            writer.WriteAttributeValueWithPrefix("xmlns", EwsUtilities.WSAddressingNamespacePrefix, EwsUtilities.WSAddressingNamespace);
            writer.WriteAttributeValueWithPrefix("xmlns", EwsUtilities.EwsXmlSchemaInstanceNamespacePrefix, EwsUtilities.EwsXmlSchemaInstanceNamespace);
            if (writer.RequireWSSecurityUtilityNamespace)
            {
                writer.WriteAttributeValueWithPrefix("xmlns", EwsUtilities.WSSecurityUtilityNamespacePrefix, EwsUtilities.WSSecurityUtilityNamespace);
            }

            writer.WriteStartElement(XmlNamespace.Soap, XmlElementNames.SOAPHeaderElementName);

            if (this.Service.Credentials != null)
            {
                this.Service.Credentials.EmitExtraSoapHeaderNamespaceAliases(writer.InternalWriter);
            }

            writer.WriteElementValueWithNamespace(
                XmlNamespace.Autodiscover,
                XmlElementNames.RequestedServerVersion,
                this.Service.RequestedServerVersion.toString());

            writer.WriteElementValueWithNamespace(
                XmlNamespace.WSAddressing,
                XmlElementNames.Action,
               this.GetWsAddressingActionName());

            writer.WriteElementValueWithNamespace(
                XmlNamespace.WSAddressing,
                XmlElementNames.To,
               requestUrl.toString());

            this.WriteExtraCustomSoapHeadersToXml(writer);

            if (this.Service.Credentials != null)
            {
                this.Service.Credentials.SerializeWSSecurityHeaders(writer.InternalWriter);
            }

            this.Service.DoOnSerializeCustomSoapHeaders(writer.InternalWriter);

            writer.WriteEndElement(); // soap:Header

            writer.WriteStartElement(XmlNamespace.Soap, XmlElementNames.SOAPBodyElementName);

            this.WriteBodyToXml(writer);

            writer.WriteEndElement(); // soap:Body
            writer.WriteEndElement(); // soap:Envelope
            writer.Flush();
        }

        /// <summary>
        /// Write extra headers.
        /// </summary>
        /// <param name="writer">The writer</param>
        void WriteExtraCustomSoapHeadersToXml(EwsServiceXmlWriter writer)
        {
            // do nothing here.
            // currently used only by GetUserSettingRequest to emit the BinarySecret header.
        }

        /// <summary>
        /// Writes XML body.
        /// </summary>
        /// <param name="writer">The writer.</param>
        void WriteBodyToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteStartElement(XmlNamespace.Autodiscover, this.GetRequestXmlElementName());
            this.WriteAttributesToXml(writer);
            this.WriteElementsToXml(writer);

            writer.WriteEndElement(); // m:this.GetXmlElementName()
        }

        /// <summary>
        /// Gets the response stream (may be wrapped with GZip/Deflate stream to decompress content)
        /// </summary>
        /// <param name="response">HttpWebResponse.</param>
        /// <returns>ResponseStream</returns>
        static Stream GetResponseStream(IEwsHttpWebResponse response)
        {
            String contentEncoding = response.ContentEncoding;
            Stream responseStream = response.GetResponseStream();

            if (contentEncoding.toLowerCase().contains("gzip"))
            {
                throw UnsupportedError("Unsupported gzip streams");
//                return new GZipStream(responseStream, CompressionMode.Decompress);
            }
            else if (contentEncoding.toLowerCase().contains("deflate"))
            {
                throw UnsupportedError("Unsupported deflate streams");
//                return new DeflateStream(responseStream, CompressionMode.Decompress);
            }
            else
            {
                return responseStream;
            }
        }

        /// <summary>
        /// Read SOAP headers.
        /// </summary>
        /// <param name="reader">EwsXmlReader</param>
        void ReadSoapHeaders(EwsXmlReader reader)
        {
            reader.ReadStartElementWithNamespace(XmlNamespace.Soap, XmlElementNames.SOAPHeaderElementName);
            do
            {
                reader.Read();

                this.ReadSoapHeader(reader);
            }
            while (!reader.IsEndElementWithNamespace(XmlNamespace.Soap, XmlElementNames.SOAPHeaderElementName));
        }

        /// <summary>
        /// Reads a single SOAP header.
        /// </summary>
        /// <param name="reader">EwsXmlReader</param>
        void ReadSoapHeader(EwsXmlReader reader)
        {
            // Is this the ServerVersionInfo?
            if (reader.IsStartElementWithNamespace(XmlNamespace.Autodiscover, XmlElementNames.ServerVersionInfo))
            {
                this._service.ServerInfo = this.ReadServerVersionInfo(reader);
            }
        }

        /// <summary>
        /// Read ServerVersionInfo SOAP header.
        /// </summary>
        /// <param name="reader">EwsXmlReader</param>
        /* private */ ExchangeServerInfo ReadServerVersionInfo(EwsXmlReader reader)
        {
            ExchangeServerInfo serverInfo = new ExchangeServerInfo();
            do
            {
                reader.Read();

                if (reader.IsStartElement())
                {
                    switch (reader.LocalName)
                    {
                        case XmlElementNames.MajorVersion:
                            serverInfo.MajorVersion = reader.ReadElementValue<int>();
                            break;
                        case XmlElementNames.MinorVersion:
                            serverInfo.MinorVersion = reader.ReadElementValue<int>();
                            break;
                        case XmlElementNames.MajorBuildNumber:
                            serverInfo.MajorBuildNumber = reader.ReadElementValue<int>();
                            break;
                        case XmlElementNames.MinorBuildNumber:
                            serverInfo.MinorBuildNumber = reader.ReadElementValue<int>();
                            break;
                        case XmlElementNames.Version:
                            serverInfo.VersionString = reader.ReadElementValue();
                            break;
                        default:
                            break;
                    }
                }
            }
            while (!reader.IsEndElementWithNamespace(XmlNamespace.Autodiscover, XmlElementNames.ServerVersionInfo));

            return serverInfo;
        }

        /// <summary>
        /// Read SOAP body.
        /// </summary>
        /// <param name="reader">EwsXmlReader</param>
        AutodiscoverResponse ReadSoapBody(EwsXmlReader reader)
        {
            reader.ReadStartElementWithNamespace(XmlNamespace.Soap, XmlElementNames.SOAPBodyElementName);
            AutodiscoverResponse responses = this.LoadFromXml(reader);
            reader.ReadEndElementWithNamespace(XmlNamespace.Soap, XmlElementNames.SOAPBodyElementName);
            return responses;
        }

        /// <summary>
        /// Loads responses from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns></returns>
        AutodiscoverResponse LoadFromXml(EwsXmlReader reader)
        {
            String elementName = this.GetResponseXmlElementName();
            reader.ReadStartElementWithNamespace(XmlNamespace.Autodiscover, elementName);
            AutodiscoverResponse response = this.CreateServiceResponse();
            response.LoadFromXml(reader, elementName);
            return response;
        }

        /// <summary>
        /// Gets the name of the request XML element.
        /// </summary>
        /// <returns></returns>
        String GetRequestXmlElementName();

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns></returns>
        String GetResponseXmlElementName();

        /// <summary>
        /// Gets the WS-Addressing action name.
        /// </summary>
        /// <returns></returns>
        String GetWsAddressingActionName();

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <returns>AutodiscoverResponse</returns>
        AutodiscoverResponse CreateServiceResponse();

        /// <summary>
        /// Writes attributes to request XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        void WriteAttributesToXml(EwsServiceXmlWriter writer);

        /// <summary>
        /// Writes elements to request XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        void WriteElementsToXml(EwsServiceXmlWriter writer);

        /// <summary>
        /// Gets the service.
        /// </summary>
        AutodiscoverService get Service => this._service;

        /// <summary>
        /// Gets the URL.
        /// </summary>
        Uri get Url => this._url;
    }
