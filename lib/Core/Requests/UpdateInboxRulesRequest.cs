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
    /// Represents a UpdateInboxRulesRequest request.
    /// </summary>
    class UpdateInboxRulesRequest extends SimpleServiceRequestBase
    {
        /// <summary>
        /// The smtp address of the mailbox from which to get the inbox rules.
        /// </summary>
        /* private */ String mailboxSmtpAddress;

        /// <summary>
        /// Remove OutlookRuleBlob or not.
        /// </summary>
        /* private */ bool removeOutlookRuleBlob;

        /// <summary>
        /// InboxRule operation collection.
        /// </summary>
        /* private */ Iterable<RuleOperation> inboxRuleOperations;

        /// <summary>
        /// Initializes a new instance of the <see cref="UpdateInboxRulesRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        UpdateInboxRulesRequest(ExchangeService service)
            : super(service)
        {
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.UpdateInboxRules;
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            if (!StringUtils.IsNullOrEmpty(this.mailboxSmtpAddress))
            {
                writer.WriteElementValue(
                    XmlNamespace.Messages,
                    XmlElementNames.MailboxSmtpAddress,
                    this.mailboxSmtpAddress);
            }

            writer.WriteElementValue(
                XmlNamespace.Messages,
                XmlElementNames.RemoveOutlookRuleBlob,
                this.RemoveOutlookRuleBlob);
            writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.Operations);
            for (RuleOperation operation in this.inboxRuleOperations)
            {
                operation.WriteToXml(writer, operation.XmlElementName);
            }
            writer.WriteEndElement();
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.UpdateInboxRulesResponse;
        }

        /// <summary>
        /// Parses the response.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>Response object.</returns>
@override
        object ParseResponse(EwsServiceXmlReader reader)
        {
            UpdateInboxRulesResponse response = new UpdateInboxRulesResponse();
            response.LoadFromXml(reader, XmlElementNames.UpdateInboxRulesResponse);
            return response;
        }

        /// <summary>
        /// Gets the request version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this request is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2010_SP1;
        }

        /// <summary>
        /// Validate request.
        /// </summary>
@override
        void Validate()
        {
            if (this.inboxRuleOperations == null)
            {
                throw new ArgumentError("RuleOperations cannot be null.", "Operations");
            }

            int operationCount = 0;
            for (RuleOperation operation in this.inboxRuleOperations)
            {
                EwsUtilities.ValidateParam(operation, "RuleOperation");
                operationCount++;
            }

            if (operationCount == 0)
            {
                throw new ArgumentError("RuleOperations cannot be empty.", "Operations");
            }

            this.Service.Validate();
        }

        /// <summary>
        /// Executes this request.
        /// </summary>
        /// <returns>Service response.</returns>
        UpdateInboxRulesResponse Execute()
        {
            UpdateInboxRulesResponse serviceResponse = (UpdateInboxRulesResponse)this.InternalExecute();
            if (serviceResponse.Result == ServiceResult.Error)
            {
                throw new UpdateInboxRulesException(serviceResponse, this.inboxRuleOperations.GetEnumerator());
            }
            return serviceResponse;
        }

        /// <summary>
        /// Gets or sets the address of the mailbox in which to update the inbox rules.
        /// </summary>
        String MailboxSmtpAddress
        {
            get { return this.mailboxSmtpAddress; }
            set { this.mailboxSmtpAddress = value; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether or not to remove OutlookRuleBlob from
        /// the rule collection.
        /// </summary>
        bool RemoveOutlookRuleBlob
        {
            get { return this.removeOutlookRuleBlob; }
            set { this.removeOutlookRuleBlob = value; }
        }

        /// <summary>
        /// Gets or sets the RuleOperation collection.
        /// </summary>
        Iterable<RuleOperation> InboxRuleOperations
        {
            get { return this.inboxRuleOperations; }
            set { this.inboxRuleOperations = value; }
        }
    }
