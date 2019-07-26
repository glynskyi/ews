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
    /// Represents a PlayOnPhone request.
    /// </summary>
    class PlayOnPhoneRequest extends SimpleServiceRequestBase
    {
        /* private */ ItemId itemId;
        /* private */ String dialString;

        /// <summary>
        /// Initializes a new instance of the <see cref="PlayOnPhoneRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        PlayOnPhoneRequest(ExchangeService service)
            : super(service)
        {
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.PlayOnPhone;
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            this.itemId.WriteToXml(writer, XmlNamespace.Messages, XmlElementNames.ItemId);
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.DialString, dialString);
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.PlayOnPhoneResponse;
        }

        /// <summary>
        /// Parses the response.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>Response object.</returns>
@override
        object ParseResponse(EwsServiceXmlReader reader)
        {
            PlayOnPhoneResponse serviceResponse = new PlayOnPhoneResponse(this.Service);
            serviceResponse.LoadFromXml(reader, XmlElementNames.PlayOnPhoneResponse);
            return serviceResponse;
        }

        /// <summary>
        /// Gets the request version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this request is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2010;
        }

        /// <summary>
        /// Executes this request.
        /// </summary>
        /// <returns>Service response.</returns>
        PlayOnPhoneResponse Execute()
        {
            PlayOnPhoneResponse serviceResponse = (PlayOnPhoneResponse)this.InternalExecute();
            serviceResponse.ThrowIfNecessary();
            return serviceResponse;
        }

        /// <summary>
        /// Gets or sets the item id of the message to play.
        /// </summary>
        ItemId ItemId
        {
            get
            {
                return this.itemId;
            }

            set
            {
                this.itemId = value;
            }
        }

        /// <summary>
        /// Gets or sets the dial string.
        /// </summary>
        String DialString
        {
            get
            {
                return this.dialString;
            }

            set
            {
                this.dialString = value;
            }
        }
    }
