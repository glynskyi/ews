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
    /// Represents a "push" Subscribe request.
    /// </summary>
    class SubscribeToPushNotificationsRequest : SubscribeRequest<PushSubscription>
    {
        /* private */ int frequency = 30;
        /* private */ Uri url;
        /* private */ String callerData;

        /// <summary>
        /// Initializes a new instance of the <see cref="SubscribeToPushNotificationsRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        SubscribeToPushNotificationsRequest(ExchangeService service)
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
            EwsUtilities.ValidateParam(this.Url, "Url");
            if ((this.Frequency < 1) || (this.Frequency > 1440))
            {
                throw new ArgumentError(string.Format(Strings.InvalidFrequencyValue, this.Frequency));
            }
        }

        /// <summary>
        /// Gets the name of the subscription XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetSubscriptionXmlElementName()
        {
            return XmlElementNames.PushSubscriptionRequest;
        }

        /// <summary>
        /// Internals the write elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void InternalWriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.StatusFrequency,
                this.Frequency);

            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.URL,
                this.Url.ToString());

            if (this.Service.RequestedServerVersion >= ExchangeVersion.Exchange2013
                && !StringUtils.IsNullOrEmpty(this.callerData))
            {
                writer.WriteElementValue(
                    XmlNamespace.Types,
                    XmlElementNames.CallerData,
                    this.CallerData);
            }
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="responseIndex">Index of the response.</param>
        /// <returns>Service response.</returns>
@override
        SubscribeResponse<PushSubscription> CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new SubscribeResponse<PushSubscription>(new PushSubscription(service));
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
        /// Gets or sets the frequency.
        /// </summary>
        /// <value>The frequency.</value>
 int Frequency
        {
            get { return this.frequency; }
            set { this.frequency = value; }
        }

        /// <summary>
        /// Gets or sets the URL.
        /// </summary>
        /// <value>The URL.</value>
 Uri Url
        {
            get { return this.url; }
            set { this.url = value; }
        }

        /// <summary>
        /// Gets or sets the URL.
        /// </summary>
        /// <value>The URL.</value>
 String CallerData
        {
            get { return this.callerData; }
            set { this.callerData = value; }
        }
    }
