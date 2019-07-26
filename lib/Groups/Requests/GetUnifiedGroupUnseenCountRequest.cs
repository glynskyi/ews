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
    /// Represents a request to the GetUnifiedGroupUnseenCount operation.
    /// </summary>
    class GetUnifiedGroupUnseenCountRequest extends SimpleServiceRequestBase
    {
        /// <summary>
        /// The last visited time utc for the group
        /// </summary>
        /* private */ readonly DateTime lastVisitedTimeUtc;

        /// <summary>
        /// The identify type associated with the group
        /// </summary>
        /* private */ readonly UnifiedGroupIdentityType identityType;

        /// <summary>
        /// The value of identity associated with the group
        /// </summary>
        /* private */ readonly String identityValue;

        /// <summary>
        /// Initializes a new instance of the <see cref="GetUnifiedGroupUnseenCountRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="lastVisitedTimeUtc">The last visited time utc for the group</param>
        /// <param name="identityType">The identity type for the group</param>
        /// <param name="value">The value associated with the identify type for the group</param>
        GetUnifiedGroupUnseenCountRequest(
            ExchangeService service,
            DateTime lastVisitedTimeUtc,
            UnifiedGroupIdentityType identityType,
            String value) : super(service)
        {
            this.lastVisitedTimeUtc = lastVisitedTimeUtc;
            this.identityType = identityType;
            this.identityValue = value;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.GetUnifiedGroupUnseenCountResponseMessage;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.GetUnifiedGroupUnseenCount;
        }

        /// <summary>
        /// Parses the response.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>Response object.</returns>
@override
        object ParseResponse(EwsServiceXmlReader reader)
        {
            GetUnifiedGroupUnseenCountResponse response = new GetUnifiedGroupUnseenCountResponse();
            response.LoadFromXml(reader, GetResponseXmlElementName());
            return response;
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            UnifiedGroupIdentity groupIdentity = new UnifiedGroupIdentity(this.identityType, this.identityValue);

            groupIdentity.WriteToXml(writer, XmlElementNames.GroupIdentity);
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.LastVisitedTimeUtc, this.lastVisitedTimeUtc.ToString("yyyy-MM-ddTHH:mm:ss.fffffffZ"));
        }

        /// <summary>
        /// Gets the request version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this request is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2015;
        }

        /// <summary>
        /// Executes this request.
        /// </summary>
        /// <returns>Service response.</returns>
        GetUnifiedGroupUnseenCountResponse Execute()
        {
            return (GetUnifiedGroupUnseenCountResponse)this.InternalExecute();
        }
    }
