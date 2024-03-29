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
    /// Represents a UnifiedGroup class.
    /// </summary>
 class UnifiedGroup : ComplexProperty
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="UnifiedGroup"/> class.
        /// </summary>
        UnifiedGroup() :
            base()
        {
        }

        /// <summary>
        /// Gets or sets whether this groups is a favorite group
        /// </summary>
 bool IsFavorite { get; set; }

        /// <summary>
        /// Gets or sets the ExternalDirectoryObjectId for this group
        /// </summary>
 String ExternalDirectoryObjectId { get; set; }

        /// <summary>
        /// Gets or sets the LastVisitedTimeUtc for this group and user
        /// </summary>
 String LastVisitedTimeUtc { get; set; }

        /// <summary>
        /// Gets or sets the SmtpAddress associated with this group
        /// </summary>
 String SmtpAddress { get; set; }

        /// <summary>
        /// Gets or sets the LegacyDN associated with this group
        /// </summary>
 String LegacyDN { get; set; }

        /// <summary>
        /// Gets or sets the MailboxGuid associated with this group
        /// </summary>
 String MailboxGuid { get; set; }

        /// <summary>
        /// Gets or sets the DisplayName associated with this group
        /// </summary>
 String DisplayName { get; set; }

        /// <summary>
        /// Gets or sets the AccessType associated with this group
        /// </summary>
 UnifiedGroupAccessType AccessType { get; set; }

        /// <summary>
        /// Read Conversations from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <param name="xmlElementName">The xml element to read.</param>
@override
        Future<void> LoadFromXml(EwsServiceXmlReader reader, String xmlElementName) async
        {
            reader.EnsureCurrentNodeIsStartElement(XmlNamespace.Types, XmlElementNames.UnifiedGroup);
            do
            {
                await reader.Read();
                switch (reader.LocalName)
                {
                    case XmlElementNames.SmtpAddress:
                        this.SmtpAddress = reader.ReadElementValue<String>();
                        break;
                    case XmlElementNames.LegacyDN:
                        this.LegacyDN = reader.ReadElementValue<String>();
                        break;
                    case XmlElementNames.MailboxGuid:
                        this.MailboxGuid = reader.ReadElementValue<String>();
                        break;
                    case XmlElementNames.DisplayName:
                        this.DisplayName = reader.ReadElementValue<String>();
                        break;
                    case XmlElementNames.IsFavorite:
                        this.IsFavorite = reader.ReadElementValue<bool>();
                        break;
                    case XmlElementNames.LastVisitedTimeUtc:
                        this.LastVisitedTimeUtc = reader.ReadElementValue<String>();
                        break;
                    case XmlElementNames.AccessType:
                        this.AccessType = (UnifiedGroupAccessType)Enum.Parse(typeof(UnifiedGroupAccessType), reader.ReadElementValue<String>(), false);
                        break;
                    case XmlElementNames.ExternalDirectoryObjectId:
                        this.ExternalDirectoryObjectId = reader.ReadElementValue<String>();
                        break;
                    default:
                        break;
                }
            }
            while (!reader.IsEndElement(XmlNamespace.Types, XmlElementNames.UnifiedGroup));

            // Skip end element
            reader.EnsureCurrentNodeIsEndElement(XmlNamespace.NotSpecified, XmlElementNames.UnifiedGroup);
            await reader.Read();
        }
    }
