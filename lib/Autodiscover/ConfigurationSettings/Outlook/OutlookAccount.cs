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
    /// Represents an Outlook configuration settings account.
    /// </summary>
    [EditorBrowsable(EditorBrowsableState.Never)]
    sealed class OutlookAccount
    {
        #region /* private */ constants
        /* private */ const String Settings = "settings";
        /* private */ const String RedirectAddr = "redirectAddr";
        /* private */ const String RedirectUrl = "redirectUrl";
        #endregion

        #region /* private */ fields
        /* private */ Map<OutlookProtocolType, OutlookProtocol> protocols;
        /* private */ AlternateMailboxCollection alternateMailboxes;
        #endregion

        /// <summary>
        /// Initializes a new instance of the <see cref="OutlookAccount"/> class.
        /// </summary>
        OutlookAccount()
        {
            this.protocols = new Map<OutlookProtocolType, OutlookProtocol>();
            this.alternateMailboxes = new AlternateMailboxCollection();
        }

        /// <summary>
        /// Load from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        void LoadFromXml(EwsXmlReader reader)
        {
            do
            {
                reader.Read();

                if (reader.NodeType == XmlNodeType.Element)
                {
                    switch (reader.LocalName)
                    {
                        case XmlElementNames.AccountType:
                            this.AccountType = reader.ReadElementValue();
                            break;
                        case XmlElementNames.Action:
                            String xmlResponseType = reader.ReadElementValue();

                            switch (xmlResponseType)
                            {
                                case OutlookAccount.Settings:
                                    this.ResponseType = AutodiscoverResponseType.Success;
                                    break;
                                case OutlookAccount.RedirectUrl:
                                    this.ResponseType = AutodiscoverResponseType.RedirectUrl;
                                    break;
                                case OutlookAccount.RedirectAddr:
                                    this.ResponseType = AutodiscoverResponseType.RedirectAddress;
                                    break;
                                default:
                                    this.ResponseType = AutodiscoverResponseType.Error;
                                    break;
                            }

                            break;
                        case XmlElementNames.Protocol:
                            OutlookProtocol protocol = new OutlookProtocol();
                            protocol.LoadFromXml(reader);
                            if (this.protocols.ContainsKey(protocol.ProtocolType))
                            {
                                // There should be strictly one node per protocol type in the autodiscover response.
                                throw new ServiceLocalException(Strings.InvalidAutodiscoverServiceResponse);
                            }
                            this.protocols.Add(protocol.ProtocolType, protocol);
                            break;
                        case XmlElementNames.RedirectAddr:
                        case XmlElementNames.RedirectUrl:
                            this.RedirectTarget = reader.ReadElementValue();
                            break;
                        case XmlElementNames.AlternateMailboxes:
                            AlternateMailbox alternateMailbox = AlternateMailbox.LoadFromXml(reader);
                            this.alternateMailboxes.Entries.Add(alternateMailbox);
                            break;

                        default:
                            reader.SkipCurrentElement();
                            break;
                    }
                }
            }
            while (!reader.IsEndElement(XmlNamespace.NotSpecified, XmlElementNames.Account));
        }

        /// <summary>
        /// Convert OutlookAccount to GetUserSettings response.
        /// </summary>
        /// <param name="requestedSettings">The requested settings.</param>
        /// <param name="response">GetUserSettings response.</param>
        void ConvertToUserSettings(List<UserSettingName> requestedSettings, GetUserSettingsResponse response)
        {
            for (OutlookProtocol protocol in this.protocols.Values)
            {
                protocol.ConvertToUserSettings(requestedSettings, response);
            }

            if (requestedSettings.Contains(UserSettingName.AlternateMailboxes))
            {
                response.Settings[UserSettingName.AlternateMailboxes] = this.alternateMailboxes;
            }
        }

        /// <summary>
        /// Gets or sets type of the account.
        /// </summary>
        String AccountType
        {
            get; set;
        }

        /// <summary>
        /// Gets or sets the type of the response.
        /// </summary>
        AutodiscoverResponseType ResponseType
        {
            get; set;
        }

        /// <summary>
        /// Gets or sets the redirect target.
        /// </summary>
        String RedirectTarget
        {
            get; set;
        }
    }
