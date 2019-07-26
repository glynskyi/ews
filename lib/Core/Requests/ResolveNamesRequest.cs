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
    /// Represents a ResolveNames request.
    /// </summary>
    class ResolveNamesRequest extends MultiResponseServiceRequest<ResolveNamesResponse>
    {
        /* private */ static LazyMember<Map<ResolveNameSearchLocation, string>> searchScopeMap = new LazyMember<Map<ResolveNameSearchLocation, string>>(
            delegate
            {
                Map<ResolveNameSearchLocation, string> map = new Map<ResolveNameSearchLocation, string>();

                map.Add(ResolveNameSearchLocation.DirectoryOnly, "ActiveDirectory");
                map.Add(ResolveNameSearchLocation.DirectoryThenContacts, "ActiveDirectoryContacts");
                map.Add(ResolveNameSearchLocation.ContactsOnly, "Contacts");
                map.Add(ResolveNameSearchLocation.ContactsThenDirectory, "ContactsActiveDirectory");

                return map;
            });

        /* private */ String nameToResolve;
        /* private */ bool returnFullContactData;
        /* private */ ResolveNameSearchLocation searchLocation;
        /* private */ PropertySet contactDataPropertySet;
        /* private */ FolderIdWrapperList parentFolderIds = new FolderIdWrapperList();

        /// <summary>
        /// Asserts the valid.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();
            EwsUtilities.ValidateNonBlankStringParam(this.NameToResolve, "NameToResolve");
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="responseIndex">Index of the response.</param>
        /// <returns>Service response.</returns>
@override
        ResolveNamesResponse CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new ResolveNamesResponse(service);
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.ResolveNames;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.ResolveNamesResponse;
        }

        /// <summary>
        /// Gets the name of the response message XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseMessageXmlElementName()
        {
            return XmlElementNames.ResolveNamesResponseMessage;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ResolveNamesRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        ResolveNamesRequest(ExchangeService service)
            : super(service, ServiceErrorHandling.ThrowOnError)
        {
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
        /// Writes the attributes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteAttributesToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteAttributeValue(
                XmlAttributeNames.ReturnFullContactData,
                this.ReturnFullContactData);

            String searchScope = null;

            searchScopeMap.Member.TryGetValue(this.SearchLocation, out searchScope);

            EwsUtilities.Assert(
                !StringUtils.IsNullOrEmpty(searchScope),
                "ResolveNameRequest.WriteAttributesToXml",
                "The specified search location cannot be mapped to an EWS search scope.");

            String propertySet = null;
            if (this.contactDataPropertySet != null)
            {
                PropertySet.DefaultPropertySetMap.Member.TryGetValue(this.contactDataPropertySet.BasePropertySet, out propertySet);
            }

            if (!this.Service.Exchange2007CompatibilityMode)
            {
                writer.WriteAttributeValue(XmlAttributeNames.SearchScope, searchScope);
            }
            if (!StringUtils.IsNullOrEmpty(propertySet))
            {
                writer.WriteAttributeValue(XmlAttributeNames.ContactDataShape, propertySet);
            }
        }

        /// <summary>
        /// Writes the elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            this.ParentFolderIds.WriteToXml(
                writer,
                XmlNamespace.Messages,
                XmlElementNames.ParentFolderIds);

            writer.WriteElementValue(
                XmlNamespace.Messages,
                XmlElementNames.UnresolvedEntry,
                this.NameToResolve);
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
        /// Gets or sets the name to resolve.
        /// </summary>
        /// <value>The name to resolve.</value>
 String NameToResolve
        {
            get { return this.nameToResolve; }
            set { this.nameToResolve = value; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether to return full contact data or not.
        /// </summary>
        /// <value>
        ///     <c>true</c> if should return full contact data; otherwise, <c>false</c>.
        /// </value>
 bool ReturnFullContactData
        {
            get { return this.returnFullContactData; }
            set { this.returnFullContactData = value; }
        }

        /// <summary>
        /// Gets or sets the search location.
        /// </summary>
        /// <value>The search scope.</value>
 ResolveNameSearchLocation SearchLocation
        {
            get { return this.searchLocation; }
            set { this.searchLocation = value; }
        }

        /// <summary>
        /// Gets or sets the PropertySet for Contact Data
        /// </summary>
        /// <value>The PropertySet</value>
 PropertySet ContactDataPropertySet
        {
            get { return this.contactDataPropertySet; }
            set { this.contactDataPropertySet = value; }
        }

        /// <summary>
        /// Gets the parent folder ids.
        /// </summary>
        /// <value>The parent folder ids.</value>
 FolderIdWrapperList ParentFolderIds
        {
            get { return this.parentFolderIds; }
        }
    }
