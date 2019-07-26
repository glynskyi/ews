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
    /// Represents a GetServerTimeZones request.
    /// </summary>
    class GetServerTimeZonesRequest : MultiResponseServiceRequest<GetServerTimeZonesResponse>
    {
        /* private */ Iterable<string> ids;

        /// <summary>
        /// Validate request.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();

            if (this.ids != null)
            {
                EwsUtilities.ValidateParamCollection(this.ids, "Ids");
            }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="GetServerTimeZonesRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        GetServerTimeZonesRequest(ExchangeService service)
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
        GetServerTimeZonesResponse CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new GetServerTimeZonesResponse();
        }

        /// <summary>
        /// Gets the name of the response message XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseMessageXmlElementName()
        {
            return XmlElementNames.GetServerTimeZonesResponseMessage;
        }

        /// <summary>
        /// Gets the expected response message count.
        /// </summary>
        /// <returns>Number of expected response messages.</returns>
@override
        int GetExpectedResponseMessageCount()
        {
            return 1;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.GetServerTimeZones;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.GetServerTimeZonesResponse;
        }

        /// <summary>
        /// Gets the minimum server version required to process this request.
        /// </summary>
        /// <returns>Exchange server version.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2010;
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            if (this.Ids != null)
            {
                writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.Ids);

                for (String id in this.ids)
                {
                    writer.WriteElementValue(
                        XmlNamespace.Types,
                        XmlElementNames.Id,
                        id);
                }

                writer.WriteEndElement(); // Ids
            }
        }

        /// <summary>
        /// Gets or sets the ids of the time zones that should be returned by the server.
        /// </summary>
        Iterable<string> Ids
        {
            get { return this.ids; }
            set { this.ids = value; }
        }
    }
