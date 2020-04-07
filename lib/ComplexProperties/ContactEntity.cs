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
    /// Represents an ContactEntity object.
    /// </summary>
 class ContactEntity extends ExtractedEntity
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ContactEntity"/> class.
        /// </summary>
        ContactEntity()
            : super()
        {
        }

        /// <summary>
        /// Gets the contact entity PersonName.
        /// </summary>
 String PersonName { get; set; }

        /// <summary>
        /// Gets the contact entity BusinessName.
        /// </summary>
 String BusinessName { get; set; }

        /// <summary>
        /// Gets the contact entity PhoneNumbers.
        /// </summary>
 ContactPhoneEntityCollection PhoneNumbers { get; set; }

        /// <summary>
        /// Gets the contact entity Urls.
        /// </summary>
 StringList Urls { get; set; }

        /// <summary>
        /// Gets the contact entity EmailAddresses.
        /// </summary>
 StringList EmailAddresses { get; set; }

        /// <summary>
        /// Gets the contact entity Addresses.
        /// </summary>
 StringList Addresses { get; set; }

        /// <summary>
        /// Gets the contact entity ContactString.
        /// </summary>
 String ContactString { get; set; }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.NlgPersonName:
                    this.PersonName = reader.ReadElementValue<String>();
                    return true;

                case XmlElementNames.NlgBusinessName:
                    this.BusinessName = reader.ReadElementValue<String>();
                    return true;

                case XmlElementNames.NlgPhoneNumbers:
                    this.PhoneNumbers = new ContactPhoneEntityCollection();
                    this.PhoneNumbers.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.NlgPhoneNumbers);
                    return true;

                case XmlElementNames.NlgUrls:
                    this.Urls = new StringList(XmlElementNames.NlgUrl);
                    this.Urls.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.NlgUrls);
                    return true;

                case XmlElementNames.NlgEmailAddresses:
                    this.EmailAddresses = new StringList(XmlElementNames.NlgEmailAddress);
                    this.EmailAddresses.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.NlgEmailAddresses);
                    return true;

                case XmlElementNames.NlgAddresses:
                    this.Addresses = new StringList(XmlElementNames.NlgAddress);
                    this.Addresses.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.NlgAddresses);
                    return true;

                case XmlElementNames.NlgContactString:
                    this.ContactString = reader.ReadElementValue<String>();
                    return true;

                default:
                    return base.TryReadElementFromXml(reader);
            }
        }
    }
