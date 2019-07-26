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
    /// Represents an MarkAllItemsAsRead request.
    /// </summary>
    class MarkAllItemsAsReadRequest extends MultiResponseServiceRequest<ServiceResponse>
    {
        /* private */ FolderIdWrapperList folderIds = new FolderIdWrapperList();

        /// <summary>
        /// Initializes a new instance of the <see cref="MarkAllItemsAsReadRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
        MarkAllItemsAsReadRequest(ExchangeService service, ServiceErrorHandling errorHandlingMode)
            : super(service, errorHandlingMode)
        {
        }

        /// <summary>
        /// Validates request.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();
            EwsUtilities.ValidateParam(this.FolderIds, "FolderIds");
            this.FolderIds.Validate(this.Service.RequestedServerVersion);
        }

        /// <summary>
        /// Gets the expected response message count.
        /// </summary>
        /// <returns>Number of expected response messages.</returns>
@override
        int GetExpectedResponseMessageCount()
        {
            return this.FolderIds.Count;
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="responseIndex">Index of the response.</param>
        /// <returns>Service object.</returns>
@override
        ServiceResponse CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new ServiceResponse();
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.MarkAllItemsAsRead;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.MarkAllItemsAsReadResponse;
        }

        /// <summary>
        /// Gets the name of the response message XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseMessageXmlElementName()
        {
            return XmlElementNames.MarkAllItemsAsReadResponseMessage;
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.ReadFlag, this.ReadFlag);
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.SuppressReadReceipts, this.SuppressReadReceipts);

            this.FolderIds.WriteToXml(
                writer,
                XmlNamespace.Messages,
                XmlElementNames.FolderIds);
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
        /// Gets the folder ids.
        /// </summary>
        FolderIdWrapperList FolderIds
        {
            get { return this.folderIds; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether items should be marked as read/unread.
        /// </summary>
        bool ReadFlag
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets a value indicating whether read receipts should be suppressed for items.
        /// </summary>
        bool SuppressReadReceipts
        {
            get;
            set;
        }
    }
