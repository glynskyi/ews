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
    /// Represents an alternate mailbox.
    /// </summary>
 sealed class AlternateMailbox
    {
        /* private */ String type;
        /* private */ String displayName;
        /* private */ String legacyDN;
        /* private */ String server;
        /* private */ String smtpAddress;
        /* private */ String ownerSmtpAddress;

        /// <summary>
        /// Initializes a new instance of the <see cref="AlternateMailbox"/> class.
        /// </summary>
        /* private */ AlternateMailbox()
        {
        }

        /// <summary>
        /// Loads AlternateMailbox instance from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>AlternateMailbox.</returns>
        static AlternateMailbox LoadFromXml(EwsXmlReader reader)
        {
            AlternateMailbox altMailbox = new AlternateMailbox();

            do
            {
                reader.Read();

                if (reader.NodeType == XmlNodeType.Element)
                {
                    switch (reader.LocalName)
                    {
                        case XmlElementNames.Type:
                            altMailbox.Type = reader.ReadElementValue<string>();
                            break;
                        case XmlElementNames.DisplayName:
                            altMailbox.DisplayName = reader.ReadElementValue<string>();
                            break;
                        case XmlElementNames.LegacyDN:
                            altMailbox.LegacyDN = reader.ReadElementValue<string>();
                            break;
                        case XmlElementNames.Server:
                            altMailbox.Server = reader.ReadElementValue<string>();
                            break;
                        case XmlElementNames.SmtpAddress:
                            altMailbox.SmtpAddress = reader.ReadElementValue<string>();
                            break;
                        case XmlElementNames.OwnerSmtpAddress:
                            altMailbox.OwnerSmtpAddress = reader.ReadElementValue<string>();
                            break;
                        default:
                            break;
                    }
                }
            }
            while (!reader.IsEndElement(XmlNamespace.Autodiscover, XmlElementNames.AlternateMailbox));

            return altMailbox;
        }

        /// <summary>
        /// Gets the alternate mailbox type.
        /// </summary>
        /// <value>The type.</value>
 String Type
        {
            get { return this.type; }
            set { this.type = value; }
        }

        /// <summary>
        /// Gets the alternate mailbox display name.
        /// </summary>
 String DisplayName
        {
            get { return this.displayName; }
            set { this.displayName = value; }
        }

        /// <summary>
        /// Gets the alternate mailbox legacy DN.
        /// </summary>
 String LegacyDN
        {
            get { return this.legacyDN; }
            set { this.legacyDN = value; }
        }

        /// <summary>
        /// Gets the alernate mailbox server.
        /// </summary>
 String Server
        {
            get { return this.server; }
            set { this.server = value; }
        }

        /// <summary>
        /// Gets the alternate mailbox address.
        /// It has value only when Server and LegacyDN is empty.
        /// </summary>
 String SmtpAddress
        {
            get { return this.smtpAddress; }
            set { this.smtpAddress = value; }
        }

        /// <summary>
        /// Gets the alternate mailbox owner SmtpAddress.
        /// </summary>
 String OwnerSmtpAddress
        {
            get { return this.ownerSmtpAddress; }
            set { this.ownerSmtpAddress = value; }
        }
    }
