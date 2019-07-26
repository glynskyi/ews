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
    /// Represents a request to a Apply Conversation Action operation
    /// </summary>
    class ApplyConversationActionRequest extends MultiResponseServiceRequest<ServiceResponse>
    {
        /* private */ List<ConversationAction> conversationActions = new List<ConversationAction>();
 List<ConversationAction> ConversationActions
        {
            get { return this.conversationActions; }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ApplyConversationActionRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="errorHandlingMode">Indicates how errors should be handled.</param>
        ApplyConversationActionRequest(ExchangeService service, ServiceErrorHandling errorHandlingMode)
            : super(service, errorHandlingMode)
        {
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="responseIndex">Index of the response.</param>
        /// <returns>Service response.</returns>
@override
        ServiceResponse CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new ServiceResponse();
        }

        /// <summary>
        /// Gets the expected response message count.
        /// </summary>
        /// <returns>Number of expected response messages.</returns>
@override
        int GetExpectedResponseMessageCount()
        {
            return this.conversationActions.Count;
        }

        /// <summary>
        /// Validate request.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();
            EwsUtilities.ValidateParamCollection(this.conversationActions, "conversationActions");
            for (int iAction = 0; iAction < this.ConversationActions.Count; iAction++)
            {
                this.ConversationActions[iAction].Validate();
            }
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteStartElement(
                XmlNamespace.Messages,
                XmlElementNames.ConversationActions);
            for (int iAction = 0; iAction < this.ConversationActions.Count; iAction++)
            {
                this.ConversationActions[iAction].WriteElementsToXml(writer);
            }
            writer.WriteEndElement();
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.ApplyConversationAction;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.ApplyConversationActionResponse;
        }

        /// <summary>
        /// Gets the name of the response message XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseMessageXmlElementName()
        {
            return XmlElementNames.ApplyConversationActionResponseMessage;
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
    }
