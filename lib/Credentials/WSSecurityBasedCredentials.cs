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





    /// <summary>

    /// </summary>
 abstract class WSSecurityBasedCredentials : ExchangeCredentials
    {
        // The WS-Addressing headers format String to use for adding the WS-Addressing headers.
        // Fill-Ins: {0} = Web method name; {1} = EWS URL
        const String WsAddressingHeadersFormat =
            "<wsa:Action soap:mustUnderstand='1'>http://schemas.microsoft.com/exchange/services/2006/messages/{0}</wsa:Action>" +
            "<wsa:ReplyTo><wsa:Address>http://www.w3.org/2005/08/addressing/anonymous</wsa:Address></wsa:ReplyTo>" +
            "<wsa:To soap:mustUnderstand='1'>{1}</wsa:To>";

        // The WS-Security header format String to use for adding the WS-Security header.
        // Fill-Ins:
        //     {0} = EncryptedData block (the token)
        const String WsSecurityHeaderFormat =
            "<wsse:Security soap:mustUnderstand='1'>" +
            "  {0}" +   // EncryptedData (token)
            "</wsse:Security>";

        const String WsuTimeStampFormat =
            "<wsu:Timestamp>" +
            "<wsu:Created>{0:yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'}</wsu:Created>" +
            "<wsu:Expires>{1:yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'}</wsu:Expires>" +
            "</wsu:Timestamp>";

        /// <summary>
        /// Path suffix for WS-Security endpoint.
        /// </summary>
        const String WsSecurityPathSuffix = "/wssecurity";

        /* private */ readonly bool addTimestamp;
        /* private */ static XmlNamespaceManager namespaceManager;
        /* private */ String securityToken;
        /* private */ Uri ewsUrl;

        /// <summary>
        /// Initializes a new instance of the <see cref="WSSecurityBasedCredentials"/> class.
        /// </summary>
        WSSecurityBasedCredentials()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="WSSecurityBasedCredentials"/> class.
        /// </summary>
        /// <param name="securityToken">The security token.</param>
        WSSecurityBasedCredentials(String securityToken)
        {
            this.securityToken = securityToken;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="WSSecurityBasedCredentials"/> class.
        /// </summary>
        /// <param name="securityToken">The security token.</param>
        /// <param name="addTimestamp">Timestamp should be added.</param>
        WSSecurityBasedCredentials(String securityToken, bool addTimestamp)
        {
            this.securityToken = securityToken;
            this.addTimestamp = addTimestamp;
        }

        /// <summary>
        /// This method is called to pre-authenticate credentials before a service request is made.
        /// </summary>
@override
        void PreAuthenticate()
        {
            // Nothing special to do here.
        }

        /// <summary>
        /// Emit the extra namespace aliases used for WS-Security and WS-Addressing.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void EmitExtraSoapHeaderNamespaceAliases(XmlWriter writer)
        {
            writer.WriteAttributeString(
                "xmlns",
                EwsUtilities.WSSecuritySecExtNamespacePrefix,
                null,
                EwsUtilities.WSSecuritySecExtNamespace);
            writer.WriteAttributeString(
                "xmlns",
                EwsUtilities.WSAddressingNamespacePrefix,
                null,
                EwsUtilities.WSAddressingNamespace);
        }

        /// <summary>
        /// Serialize the WS-Security and WS-Addressing SOAP headers.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="webMethodName">The Web method being called.</param>
@override
        void SerializeExtraSoapHeaders(XmlWriter writer, String webMethodName)
        {
            this.SerializeWSAddressingHeaders(writer, webMethodName);
            this.SerializeWSSecurityHeaders(writer);
        }

        /// <summary>
        /// Creates the WS-Addressing headers necessary to send with an outgoing request.
        /// </summary>
        /// <param name="xmlWriter">The XML writer to serialize the headers to.</param>
        /// <param name="webMethodName">Web method being called</param>
        /* private */ void SerializeWSAddressingHeaders(XmlWriter xmlWriter, String webMethodName)
        {
            EwsUtilities.Assert(
                webMethodName != null,
                "WSSecurityBasedCredentials.SerializeWSAddressingHeaders",
                "Web method name cannot be null!");

            EwsUtilities.Assert(
                this.ewsUrl != null,
                "WSSecurityBasedCredentials.SerializeWSAddressingHeaders",
                "EWS Url cannot be null!");

            // Format the WS-Addressing headers.
            String wsAddressingHeaders = String.Format(
                WSSecurityBasedCredentials.WsAddressingHeadersFormat,
                webMethodName,
                this.ewsUrl);

            // And write them out...
            xmlWriter.WriteRaw(wsAddressingHeaders);
        }

        /// <summary>
        /// Creates the WS-Security header necessary to send with an outgoing request.
        /// </summary>
        /// <param name="xmlWriter">The XML writer to serialize the header to.</param>
@override
        void SerializeWSSecurityHeaders(XmlWriter xmlWriter)
        {
            EwsUtilities.Assert(
                this.securityToken != null,
                "WSSecurityBasedCredentials.SerializeWSSecurityHeaders",
                "Security token cannot be null!");

            // <wsu:Timestamp wsu:Id="_timestamp">
            //   <wsu:Created>2007-09-20T01:13:10.468Z</wsu:Created>
            //   <wsu:Expires>2007-09-20T01:18:10.468Z</wsu:Expires>
            // </wsu:Timestamp>
            //
            String timestamp = null;
            if (this.addTimestamp)
            {
                DateTime utcNow = DateTime.UtcNow;
                timestamp = string.Format(
                    WSSecurityBasedCredentials.WsuTimeStampFormat,
                    utcNow,
                    utcNow.AddMinutes(5));
            }

            // Format the WS-Security header based on all the information we have.
            String wsSecurityHeader = String.Format(
                WSSecurityBasedCredentials.WsSecurityHeaderFormat,
                timestamp + this.securityToken);

            // And write the header out...
            xmlWriter.WriteRaw(wsSecurityHeader);
        }

        /// <summary>
        /// Adjusts the URL based on the credentials.
        /// </summary>
        /// <param name="url">The URL.</param>
        /// <returns>Adjust URL.</returns>
@override
        Uri AdjustUrl(Uri url)
        {
            return new Uri(GetUriWithoutSuffix(url) + WSSecurityBasedCredentials.WsSecurityPathSuffix);
        }

        /// <summary>
        /// Gets or sets the security token.
        /// </summary>
        String SecurityToken
        {
            get { return this.securityToken; }
            set { this.securityToken = value; }
        }

        /// <summary>
        /// Gets or sets the EWS URL.
        /// </summary>
        Uri EwsUrl
        {
            get { return this.ewsUrl; }
            set { this.ewsUrl = value; }
        }

        /// <summary>
        /// Gets the XmlNamespaceManager which is used to select node during signing the message.
        /// </summary>
        static XmlNamespaceManager NamespaceManager
        {
            get
            {
                if (namespaceManager == null)
                {
                    namespaceManager = new XmlNamespaceManager(new NameTable());
                    namespaceManager.AddNamespace(EwsUtilities.WSSecurityUtilityNamespacePrefix, EwsUtilities.WSSecurityUtilityNamespace);
                    namespaceManager.AddNamespace(EwsUtilities.WSAddressingNamespacePrefix, EwsUtilities.WSAddressingNamespace);
                    namespaceManager.AddNamespace(EwsUtilities.EwsSoapNamespacePrefix, EwsUtilities.EwsSoapNamespace);
                    namespaceManager.AddNamespace(EwsUtilities.EwsTypesNamespacePrefix, EwsUtilities.EwsTypesNamespace);
                    namespaceManager.AddNamespace(EwsUtilities.WSSecuritySecExtNamespacePrefix, EwsUtilities.WSSecuritySecExtNamespace);
                }

                return namespaceManager;
            }
        }
    }
