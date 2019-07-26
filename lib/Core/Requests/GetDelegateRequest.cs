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
    /// Represents a GetDelegate request.
    /// </summary>
    class GetDelegateRequest : DelegateManagementRequestBase<GetDelegateResponse>
    {
        /* private */ List<UserId> userIds = new List<UserId>();
        /* private */ bool includePermissions;

        /// <summary>
        /// Initializes a new instance of the <see cref="GetDelegateRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        GetDelegateRequest(ExchangeService service)
            : super(service)
        {
        }

        /// <summary>
        /// Creates the response.
        /// </summary>
        /// <returns>Service response.</returns>
@override
        GetDelegateResponse CreateResponse()
        {
            return new GetDelegateResponse(true);
        }

        /// <summary>
        /// Writes XML attributes.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <remarks>
        /// Subclass will override if it has XML attributes.
        /// </remarks>
@override
        void WriteAttributesToXml(EwsServiceXmlWriter writer)
        {
            base.WriteAttributesToXml(writer);

            writer.WriteAttributeValue(XmlAttributeNames.IncludePermissions, this.IncludePermissions);
        }

        /// <summary>
        /// Writes the elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            base.WriteElementsToXml(writer);

            if (this.UserIds.Count > 0)
            {
                writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.UserIds);

                for (UserId userId in this.UserIds)
                {
                    userId.WriteToXml(writer, XmlElementNames.UserId);
                }

                writer.WriteEndElement(); // UserIds
            }
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.GetDelegateResponse;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.GetDelegate;
        }

        /// <summary>
        /// Gets the request version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this request is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2007_SP1;
        }

        /// <summary>
        /// Gets the user ids.
        /// </summary>
        /// <value>The user ids.</value>
 List<UserId> UserIds
        {
            get { return this.userIds; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether permissions are included.
        /// </summary>
 bool IncludePermissions
        {
            get { return this.includePermissions; }
            set { this.includePermissions = value; }
        }
    }
