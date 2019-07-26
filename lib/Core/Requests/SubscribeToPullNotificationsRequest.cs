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
    /// Represents a "pull" Subscribe request.
    /// </summary>
    class SubscribeToPullNotificationsRequest : SubscribeRequest<PullSubscription>
    {
        /* private */ int timeout = 30;

        /// <summary>
        /// Initializes a new instance of the <see cref="SubscribeToPullNotificationsRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        SubscribeToPullNotificationsRequest(ExchangeService service)
            : super(service)
        {
        }

        /// <summary>
        /// Validate request.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();
            if ((this.Timeout < 1) || (this.Timeout > 1440))
            {
                throw new ArgumentError(string.Format(Strings.InvalidTimeoutValue, this.Timeout));
            }
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="responseIndex">Index of the response.</param>
        /// <returns>Service response.</returns>
@override
        SubscribeResponse<PullSubscription> CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new SubscribeResponse<PullSubscription>(new PullSubscription(service));
        }

        /// <summary>
        /// Gets the name of the subscription XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetSubscriptionXmlElementName()
        {
            return XmlElementNames.PullSubscriptionRequest;
        }

        /// <summary>
        /// method to write XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void InternalWriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.Timeout,
                this.Timeout);
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
        /// Gets or sets the timeout.
        /// </summary>
        /// <value>The timeout.</value>
 int Timeout
        {
            get { return this.timeout; }
            set { this.timeout = value; }
        }
    }
