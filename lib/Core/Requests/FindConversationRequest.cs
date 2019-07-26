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
    /// Represents a request to a Find Conversation operation
    /// </summary>
    class FindConversationRequest extends SimpleServiceRequestBase
    {
        /* private */ ViewBase view;
        /* private */ FolderIdWrapper folderId;
        /* private */ String queryString;
        /* private */ bool returnHighlightTerms;
        /* private */ MailboxSearchLocation? mailboxScope;

        /// <summary>
        /// </summary>
        /// <param name="service"></param>
        FindConversationRequest(ExchangeService service)
            : super(service)
        {
        }

        /// <summary>
        /// Gets or sets the view controlling the number of conversations returned.
        /// </summary>
 ViewBase View
        {
            get
            {
                return this.view;
            }

            set
            {
                this.view = value;
                if (this.view is SeekToConditionItemView)
                {
                    ((SeekToConditionItemView)this.view).SetServiceObjectType(ServiceObjectType.Conversation);
                }
            }
        }

        /// <summary>
        /// Gets or sets folder id
        /// </summary>
        FolderIdWrapper FolderId
        {
            get
            {
                return this.folderId;
            }

            set
            {
                this.folderId = value;
            }
        }

        /// <summary>
        /// Gets or sets the query String for search value.
        /// </summary>
        String QueryString
        {
            get
            {
                return this.queryString;
            }

            set
            {
                this.queryString = value;
            }
        }

        /// <summary>
        /// Gets or sets the query String highlight terms.
        /// </summary>
        bool ReturnHighlightTerms
        {
            get
            {
                return this.returnHighlightTerms;
            }

            set
            {
                this.returnHighlightTerms = value;
            }
        }

        /// <summary>
        /// Gets or sets the mailbox search location to include in the search.
        /// </summary>
        MailboxSearchLocation? MailboxScope
        {
            get
            {
                return this.mailboxScope;
            }

            set
            {
                this.mailboxScope = value;
            }
        }

        /// <summary>
        /// Validate request.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();
            this.view.InternalValidate(this);

            // query String parameter is only valid for Exchange2013 or higher
            //
            if (!StringUtils.IsNullOrEmpty(this.queryString) &&
                this.Service.RequestedServerVersion < ExchangeVersion.Exchange2013)
            {
                throw new ServiceVersionException(
                    string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "queryString",
                        ExchangeVersion.Exchange2013));
            }

            // ReturnHighlightTerms parameter is only valid for Exchange2013 or higher
            //
            if (this.ReturnHighlightTerms &&
                this.Service.RequestedServerVersion < ExchangeVersion.Exchange2013)
            {
                throw new ServiceVersionException(
                    string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "returnHighlightTerms",
                        ExchangeVersion.Exchange2013));
            }

            // SeekToConditionItemView is only valid for Exchange2013 or higher
            //
            if ((this.View is SeekToConditionItemView) &&
                this.Service.RequestedServerVersion < ExchangeVersion.Exchange2013)
            {
                throw new ServiceVersionException(
                    string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "SeekToConditionItemView",
                        ExchangeVersion.Exchange2013));
            }

            // MailboxScope is only valid for Exchange2013 or higher
            //
            if (this.MailboxScope.HasValue &&
                this.Service.RequestedServerVersion < ExchangeVersion.Exchange2013)
            {
                throw new ServiceVersionException(
                    string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "MailboxScope",
                        ExchangeVersion.Exchange2013));
            }
        }

        /// <summary>
        /// Writes XML attributes.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteAttributesToXml(EwsServiceXmlWriter writer)
        {
            this.View.WriteAttributesToXml(writer);
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            // Emit the view element
            //
            this.View.WriteToXml(writer, null);

            // Emit the Sort Order
            //
            this.View.WriteOrderByToXml(writer);

            // Emit the Parent Folder Id
            //
            writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.ParentFolderId);
            this.FolderId.WriteToXml(writer);
            writer.WriteEndElement();

            // Emit the MailboxScope flag
            //
            if (this.MailboxScope.HasValue)
            {
                writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.MailboxScope, this.MailboxScope.Value);
            }

            if (!StringUtils.IsNullOrEmpty(this.queryString))
            {
                // Emit the QueryString
                //
                writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.QueryString);

                if (this.ReturnHighlightTerms)
                {
                    writer.WriteAttributeString(XmlAttributeNames.ReturnHighlightTerms, this.ReturnHighlightTerms.ToString().ToLowerInvariant());
                }

                writer.WriteValue(this.queryString, XmlElementNames.QueryString);
                writer.WriteEndElement();
            }

            if (this.Service.RequestedServerVersion >= ExchangeVersion.Exchange2013)
            {
                if (this.View.PropertySet != null)
                {
                    this.View.PropertySet.WriteToXml(writer, ServiceObjectType.Conversation);
                }
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
            FindConversationResponse response = new FindConversationResponse();
            response.LoadFromXml(reader, XmlElementNames.FindConversationResponse);
            return response;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.FindConversation;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.FindConversationResponse;
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
        /// Executes this request.
        /// </summary>
        /// <returns>Service response.</returns>
        FindConversationResponse Execute()
        {
            FindConversationResponse serviceResponse = (FindConversationResponse)this.InternalExecute();
            serviceResponse.ThrowIfNecessary();
            return serviceResponse;
        }
    }
