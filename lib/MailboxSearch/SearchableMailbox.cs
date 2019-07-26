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
    /// Represents searchable mailbox object
    /// </summary>
 sealed class SearchableMailbox
    {
        /// <summary>
        /// Constructor
        /// </summary>
 SearchableMailbox()
        {
        }

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="guid">Guid</param>
        /// <param name="smtpAddress">Smtp address</param>
        /// <param name="isExternalMailbox">If true, this is an external mailbox</param>
        /// <param name="externalEmailAddress">External email address</param>
        /// <param name="displayName">Display name</param>
        /// <param name="isMembershipGroup">Is a membership group</param>
        /// <param name="referenceId">Reference id</param>
 SearchableMailbox(
            Guid guid,
            String smtpAddress,
            bool isExternalMailbox,
            String externalEmailAddress,
            String displayName,
            bool isMembershipGroup,
            String referenceId)
        {
            this.Guid = guid;
            this.SmtpAddress = smtpAddress;
            this.IsExternalMailbox = isExternalMailbox;
            this.ExternalEmailAddress = externalEmailAddress;
            this.DisplayName = displayName;
            this.IsMembershipGroup = isMembershipGroup;
            this.ReferenceId = referenceId;
        }

        /// <summary>
        /// Load from xml
        /// </summary>
        /// <param name="reader">The reader</param>
        /// <returns>Searchable mailbox object</returns>
        static SearchableMailbox LoadFromXml(EwsServiceXmlReader reader)
        {
            reader.EnsureCurrentNodeIsStartElement(XmlNamespace.Types, XmlElementNames.SearchableMailbox);

            SearchableMailbox searchableMailbox = new SearchableMailbox();
            searchableMailbox.Guid = new Guid(reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.Guid));
            searchableMailbox.SmtpAddress = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.PrimarySmtpAddress);
            bool isExternalMailbox = false;
            bool.TryParse(reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.IsExternalMailbox), out isExternalMailbox);
            searchableMailbox.IsExternalMailbox = isExternalMailbox;
            searchableMailbox.ExternalEmailAddress = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.ExternalEmailAddress);
            searchableMailbox.DisplayName = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.DisplayName);
            bool isMembershipGroup = false;
            bool.TryParse(reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.IsMembershipGroup), out isMembershipGroup);
            searchableMailbox.IsMembershipGroup = isMembershipGroup;
            searchableMailbox.ReferenceId = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.ReferenceId);

            return searchableMailbox;
        }

        /// <summary>
        /// Guid
        /// </summary>
 Guid Guid { get; set; }

        /// <summary>
        /// Smtp address
        /// </summary>
 String SmtpAddress { get; set; }

        /// <summary>
        /// If true, this is an external mailbox
        /// </summary>
 bool IsExternalMailbox { get; set; }

        /// <summary>
        /// External email address for the mailbox
        /// </summary>
 String ExternalEmailAddress { get; set; }

        /// <summary>
        /// Display name
        /// </summary>
 String DisplayName { get; set; }

        /// <summary>
        /// Is a membership group
        /// </summary>
 bool IsMembershipGroup { get; set; }

        /// <summary>
        /// Reference id
        /// </summary>
 String ReferenceId { get; set; }
    }
