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
    /// Represents a SetTeamMailbox request.
    /// </summary>
    class SetTeamMailboxRequest extends SimpleServiceRequestBase
    {
        /// <summary>
        /// TeamMailbox email address
        /// </summary>
        /* private */ EmailAddress emailAddress;

        /// <summary>
        /// SharePoint site URL
        /// </summary>
        /* private */ Uri sharePointSiteUrl;

        /// <summary>
        /// TeamMailbox lifecycle state
        /// </summary>
        /* private */ TeamMailboxLifecycleState state;

        /// <summary>
        /// Initializes a new instance of the <see cref="SetTeamMailboxRequest"/> class.
        /// </summary>
        /// <param name="service">The service</param>
        /// <param name="emailAddress">TeamMailbox email address</param>
        /// <param name="sharePointSiteUrl">SharePoint site URL</param>
        /// <param name="state">TeamMailbox state</param>
        SetTeamMailboxRequest(ExchangeService service, EmailAddress emailAddress, Uri sharePointSiteUrl, TeamMailboxLifecycleState state)
            : super(service)
        {
            if (emailAddress == null)
            {
                throw new ArgumentNullException("emailAddress");
            }

            if (sharePointSiteUrl == null)
            {
                throw new ArgumentNullException("sharePointSiteUrl");
            }

            this.emailAddress = emailAddress;
            this.sharePointSiteUrl = sharePointSiteUrl;
            this.state = state;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.SetTeamMailbox;
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            this.emailAddress.WriteToXml(writer, XmlNamespace.Messages, XmlElementNames.EmailAddress);
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.SharePointSiteUrl, this.sharePointSiteUrl.ToString());
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.State, this.state.ToString());
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.SetTeamMailboxResponse;
        }

        /// <summary>
        /// Parses the response.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>Response object.</returns>
@override
        object ParseResponse(EwsServiceXmlReader reader)
        {
            ServiceResponse response = new ServiceResponse();
            response.LoadFromXml(reader, GetResponseXmlElementName());
            return response;
        }

        /// <summary>
        /// Gets the request version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this request is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2013;
        }

        /// <summary>
        /// Executes this request.
        /// </summary>
        /// <returns>Service response.</returns>
        ServiceResponse Execute()
        {
            ServiceResponse serviceResponse = (ServiceResponse)this.InternalExecute();
            serviceResponse.ThrowIfNecessary();
            return serviceResponse;
        }
    }
