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
    /// Represents the user Outlook configuration settings apply to.
    /// </summary>
    [EditorBrowsable(EditorBrowsableState.Never)]
    sealed class OutlookUser
    {
        /// <summary>
        /// Converters to translate Outlook user settings.
        /// Each entry maps to a lambda expression used to get the matching property from the OutlookUser instance.
        /// </summary>
        /* private */ static LazyMember<ConverterDictionary> converterDictionary = new LazyMember<ConverterDictionary>(
            delegate()
            {
                var results = new ConverterDictionary();
                results.Add(UserSettingName.UserDisplayName,            u => u.displayName);
                results.Add(UserSettingName.UserDN,                     u => u.legacyDN);
                results.Add(UserSettingName.UserDeploymentId,           u => u.deploymentId);
                results.Add(UserSettingName.AutoDiscoverSMTPAddress,    u => u.autodiscoverAMTPAddress);
                return results;
            });

        #region /* private */ fields
        /* private */ String displayName;
        /* private */ String legacyDN;
        /* private */ String deploymentId;
        /* private */ String autodiscoverAMTPAddress;
        #endregion

        /// <summary>
        /// Initializes a new instance of the <see cref="OutlookUser"/> class.
        /// </summary>
        OutlookUser()
        {
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
                        case XmlElementNames.DisplayName:
                            this.displayName = reader.ReadElementValue();
                            break;
                        case XmlElementNames.LegacyDN:
                            this.legacyDN = reader.ReadElementValue();
                            break;
                        case XmlElementNames.DeploymentId:
                            this.deploymentId = reader.ReadElementValue();
                            break;
                        case XmlElementNames.AutoDiscoverSMTPAddress:
                            this.autodiscoverAMTPAddress = reader.ReadElementValue();
                            break;
                        default:
                            reader.SkipCurrentElement();
                            break;
                    }
                }
            }
            while (!reader.IsEndElement(XmlNamespace.NotSpecified, XmlElementNames.User));
        }

        /// <summary>
        /// Convert OutlookUser to GetUserSettings response.
        /// </summary>
        /// <param name="requestedSettings">The requested settings.</param>
        /// <param name="response">The response.</param>
        void ConvertToUserSettings(
            List<UserSettingName> requestedSettings,
            GetUserSettingsResponse response)
        {
            // In English: collect converters that are contained in the requested settings.
            var converterQuery = from converter in converterDictionary.Member
                                 where requestedSettings.Contains(converter.Key)
                                 select converter;

            for (ConverterPair kv in converterQuery)
            {
                String value = kv.Value(this);
                if (!StringUtils.IsNullOrEmpty(value))
                {
                    response.Settings[kv.Key] = value;
                }
            }
        }

        /// <summary>
        /// Gets the available user settings.
        /// </summary>
        /// <value>The available user settings.</value>
        static Iterable<UserSettingName> AvailableUserSettings
        {
            get { return converterDictionary.Member.Keys; }
        }
    }
