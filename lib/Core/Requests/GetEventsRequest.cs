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
    /// GetEvents request
    /// </summary>
    class GetEventsRequest : MultiResponseServiceRequest<GetEventsResponse>
    {
        /* private */ String subscriptionId;
        /* private */ String watermark;

        /// <summary>
        /// Initializes a new instance of the <see cref="GetEventsRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        GetEventsRequest(ExchangeService service)
            : super(service, ServiceErrorHandling.ThrowOnError)
        {
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="responseIndex">Index of the response.</param>
        /// <returns>Service response.</returns>
@override
        GetEventsResponse CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new GetEventsResponse();
        }

        /// <summary>
        /// Gets the expected response message count.
        /// </summary>
        /// <returns>Response count.</returns>
@override
        int GetExpectedResponseMessageCount()
        {
            return 1;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.GetEvents;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.GetEventsResponse;
        }

        /// <summary>
        /// Gets the name of the response message XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseMessageXmlElementName()
        {
            return XmlElementNames.GetEventsResponseMessage;
        }

        /// <summary>
        /// Validates the request.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();
            EwsUtilities.ValidateNonBlankStringParam(this.SubscriptionId, "SubscriptionId");
            EwsUtilities.ValidateNonBlankStringParam(this.Watermark, "Watermark");
        }

        /// <summary>
        /// Writes the elements to XML writer.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteElementValue(
                XmlNamespace.Messages,
                XmlElementNames.SubscriptionId,
                this.SubscriptionId);

            writer.WriteElementValue(
                XmlNamespace.Messages,
                XmlElementNames.Watermark,
                this.Watermark);
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
        /// Gets or sets the subscription id.
        /// </summary>
        /// <value>The subscription id.</value>
 String SubscriptionId
        {
            get { return this.subscriptionId; }
            set { this.subscriptionId = value; }
        }

        /// <summary>
        /// Gets or sets the watermark.
        /// </summary>
        /// <value>The watermark.</value>
 String Watermark
        {
            get { return this.watermark; }
            set { this.watermark = value; }
        }
    }
