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
    /// Represents a SetHoldOnMailboxesRequest request.
    /// </summary>
    class SetHoldOnMailboxesRequest extends SimpleServiceRequestBase
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="SetHoldOnMailboxesRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        SetHoldOnMailboxesRequest(ExchangeService service)
            : super(service)
        {
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.SetHoldOnMailboxesResponse;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.SetHoldOnMailboxes;
        }

        /// <summary>
        /// Validate request.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();

            if (StringUtils.IsNullOrEmpty(this.HoldId))
            {
                throw new ServiceValidationException(Strings.HoldIdParameterIsNotSpecified);
            }

            if (StringUtils.IsNullOrEmpty(this.InPlaceHoldIdentity) && (this.Mailboxes == null || this.Mailboxes.Length == 0))
            {
                throw new ServiceValidationException(Strings.HoldMailboxesParameterIsNotSpecified);
            }
        }

        /// <summary>
        /// Parses the response.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>Response object.</returns>
@override
        object ParseResponse(EwsServiceXmlReader reader)
        {
            SetHoldOnMailboxesResponse response = new SetHoldOnMailboxesResponse();
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
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.ActionType, this.ActionType.ToString());
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.HoldId, this.HoldId);
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.Query, this.Query ?? "");
            if (this.Mailboxes != null && this.Mailboxes.Length > 0)
            {
                writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.Mailboxes);
                for (String mailbox in this.Mailboxes)
                {
                    writer.WriteElementValue(XmlNamespace.Types, XmlElementNames.String, mailbox);
                }

                writer.WriteEndElement();   // Mailboxes
            }

            // Language
            if (!StringUtils.IsNullOrEmpty(this.Language))
            {
                writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.Language, this.Language);
            }

            if (!StringUtils.IsNullOrEmpty(this.InPlaceHoldIdentity))
            {
                writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.InPlaceHoldIdentity, this.InPlaceHoldIdentity);
            }

            if (!StringUtils.IsNullOrEmpty(this.ItemHoldPeriod))
            {
                writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.ItemHoldPeriod, this.ItemHoldPeriod);
            }
        }

        /// <summary>
        /// Executes this request.
        /// </summary>
        /// <returns>Service response.</returns>
        SetHoldOnMailboxesResponse Execute()
        {
            SetHoldOnMailboxesResponse serviceResponse = (SetHoldOnMailboxesResponse)this.InternalExecute();
            return serviceResponse;
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
        /// Action type
        /// </summary>
 HoldAction ActionType { get; set; }

        /// <summary>
        /// Hold id
        /// </summary>
 String HoldId { get; set; }

        /// <summary>
        /// Query
        /// </summary>
 String Query { get; set; }

        /// <summary>
        /// Collection of mailboxes to be held/unheld
        /// </summary>
 string[] Mailboxes { get; set; }

        /// <summary>
        /// Query language
        /// </summary>
 String Language { get; set; }

        /// <summary>
        /// InPlaceHold Identity
        /// </summary>
 String InPlaceHoldIdentity { get; set; }

        /// <summary>
        /// Item hold period
        /// </summary>
 String ItemHoldPeriod { get; set; }
    }
