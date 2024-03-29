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
    /// Represents an object that can be used to store user-defined configuration settings.
    /// </summary>
 class UserConfiguration
    {
        /* private */ const ExchangeVersion ObjectVersion = ExchangeVersion.Exchange2010;

        // For consistency with ServiceObject behavior, access to ItemId is permitted for a new object.
        /* private */ const UserConfigurationProperties PropertiesAvailableForNewObject =
            UserConfigurationProperties.BinaryData |
            UserConfigurationProperties.Dictionary |
            UserConfigurationProperties.XmlData;

        /* private */ const UserConfigurationProperties NoProperties = (UserConfigurationProperties)0;


        /* private */ ExchangeService service;
        /* private */ String name;
        /* private */ FolderId parentFolderId = null;
        /* private */ ItemId itemId = null;
        /* private */ UserConfigurationDictionary dictionary = null;
        /* private */ Uint8List xmlData = null;
        /* private */ Uint8List binaryData = null;
        /* private */ UserConfigurationProperties propertiesAvailableForAccess;
        /* private */ UserConfigurationProperties updatedProperties;

        /// <summary>
        /// Indicates whether changes trigger an update or create operation.
        /// </summary>
        /* private */ bool isNew = false;

        /// <summary>
        /// Initializes a new instance of <see cref="UserConfiguration"/> class.
        /// </summary>
        /// <param name="service">The service to which the user configuration is bound.</param>
 UserConfiguration(ExchangeService service)
            : this(service, PropertiesAvailableForNewObject)
        {
        }

        /// <summary>
        /// Writes a byte array to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="byteArray">Byte array to write.</param>
        /// <param name="xmlElementName">Name of the Xml element.</param>
        /* private */ static void WriteByteArrayToXml(
            EwsServiceXmlWriter writer,
            Uint8List byteArray,
            String xmlElementName)
        {
            EwsUtilities.Assert(
                writer != null,
                "UserConfiguration.WriteByteArrayToXml",
                "writer is null");
            EwsUtilities.Assert(
                xmlElementName != null,
                "UserConfiguration.WriteByteArrayToXml",
                "xmlElementName is null");

            writer.WriteStartElement(XmlNamespace.Types, xmlElementName);

            if (byteArray != null && byteArray.Length > 0)
            {
                writer.WriteValue(Convert.ToBase64String(byteArray), xmlElementName);
            }

            writer.WriteEndElement();
        }

        /// <summary>
        /// Writes to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlNamespace">The XML namespace.</param>
        /// <param name="name">The user configuration name.</param>
        /// <param name="parentFolderId">The Id of the folder containing the user configuration.</param>
        static void WriteUserConfigurationNameToXml(
            EwsServiceXmlWriter writer,
            XmlNamespace xmlNamespace,
            String name,
            FolderId parentFolderId)
        {
            EwsUtilities.Assert(
                writer != null,
                "UserConfiguration.WriteUserConfigurationNameToXml",
                "writer is null");
            EwsUtilities.Assert(
                name != null,
                "UserConfiguration.WriteUserConfigurationNameToXml",
                "name is null");
            EwsUtilities.Assert(
                parentFolderId != null,
                "UserConfiguration.WriteUserConfigurationNameToXml",
                "parentFolderId is null");

            writer.WriteStartElement(xmlNamespace, XmlElementNames.UserConfigurationName);

            writer.WriteAttributeValue(XmlAttributeNames.Name, name);

            parentFolderId.WriteToXml(writer);

            writer.WriteEndElement();
        }

        /// <summary>
        /// Initializes a new instance of <see cref="UserConfiguration"/> class.
        /// </summary>
        /// <param name="service">The service to which the user configuration is bound.</param>
        /// <param name="requestedProperties">The properties requested for this user configuration.</param>
        UserConfiguration(ExchangeService service, UserConfigurationProperties requestedProperties)
        {
            EwsUtilities.ValidateParam(service, "service");

            if (service.RequestedServerVersion < UserConfiguration.ObjectVersion)
            {
                throw new ServiceVersionException(
                    string.Format(
                        Strings.ObjectTypeIncompatibleWithRequestVersion,
                        this.GetType().Name,
                        UserConfiguration.ObjectVersion));
            }

            this.service = service;
            this.isNew = true;

            this.InitializeProperties(requestedProperties);
        }

        /// <summary>
        /// Gets the name of the user configuration.
        /// </summary>
 String Name
        {
            get { return this.name; }
            set { this.name = value; }
        }

        /// <summary>
        /// Gets the Id of the folder containing the user configuration.
        /// </summary>
 FolderId ParentFolderId
        {
            get { return this.parentFolderId; }
            set { this.parentFolderId = value; }
        }

        /// <summary>
        /// Gets the Id of the user configuration.
        /// </summary>
 ItemId ItemId
        {
            get
            {
                return this.itemId;
            }
        }

        /// <summary>
        /// Gets the dictionary of the user configuration.
        /// </summary>
 UserConfigurationDictionary Dictionary
        {
            get
            {
                return this.dictionary;
            }
        }

        /// <summary>
        /// Gets or sets the xml data of the user configuration.
        /// </summary>
 Uint8List XmlData
        {
            get
            {
                this.ValidatePropertyAccess(UserConfigurationProperties.XmlData);

                return this.xmlData;
            }

            set
            {
                this.xmlData = value;

                this.MarkPropertyForUpdate(UserConfigurationProperties.XmlData);
            }
        }

        /// <summary>
        /// Gets or sets the binary data of the user configuration.
        /// </summary>
 Uint8List BinaryData
        {
            get
            {
                this.ValidatePropertyAccess(UserConfigurationProperties.BinaryData);

                return this.binaryData;
            }

            set
            {
                this.binaryData = value;
                this.MarkPropertyForUpdate(UserConfigurationProperties.BinaryData);
            }
        }

        /// <summary>
        /// Gets a value indicating whether this user configuration has been modified.
        /// </summary>
 bool IsDirty
        {
            get
            {
                return (this.updatedProperties != NoProperties) || this.dictionary.IsDirty;
            }
        }

        /// <summary>
        /// Binds to an existing user configuration and loads the specified properties.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="service">The service to which the user configuration is bound.</param>
        /// <param name="name">The name of the user configuration.</param>
        /// <param name="parentFolderId">The Id of the folder containing the user configuration.</param>
        /// <param name="properties">The properties to load.</param>
        /// <returns>A user configuration instance.</returns>
 static UserConfiguration Bind(
            ExchangeService service,
            String name,
            FolderId parentFolderId,
            UserConfigurationProperties properties)
        {
            UserConfiguration result = service.GetUserConfiguration(
                name,
                parentFolderId,
                properties);

            result.isNew = false;

            return result;
        }

        /// <summary>
        /// Binds to an existing user configuration and loads the specified properties.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="service">The service to which the user configuration is bound.</param>
        /// <param name="name">The name of the user configuration.</param>
        /// <param name="parentFolderName">The name of the folder containing the user configuration.</param>
        /// <param name="properties">The properties to load.</param>
        /// <returns>A user configuration instance.</returns>
 static UserConfiguration Bind(
            ExchangeService service,
            String name,
            WellKnownFolderName parentFolderName,
            UserConfigurationProperties properties)
        {
            return UserConfiguration.Bind(
                service,
                name,
                new FolderId(parentFolderName),
                properties);
        }

        /// <summary>
        /// Saves the user configuration. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="name">The name of the user configuration.</param>
        /// <param name="parentFolderId">The Id of the folder in which to save the user configuration.</param>
 void Save(String name, FolderId parentFolderId)
        {
            EwsUtilities.ValidateParam(name, "name");
            EwsUtilities.ValidateParam(parentFolderId, "parentFolderId");

            parentFolderId.Validate(this.service.RequestedServerVersion);

            if (!this.isNew)
            {
                throw new InvalidOperationException(Strings.CannotSaveNotNewUserConfiguration);
            }

            this.parentFolderId = parentFolderId;
            this.name = name;

            this.service.CreateUserConfiguration(this);

            this.isNew = false;

            this.ResetIsDirty();
        }

        /// <summary>
        /// Saves the user configuration. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="name">The name of the user configuration.</param>
        /// <param name="parentFolderName">The name of the folder in which to save the user configuration.</param>
 void Save(String name, WellKnownFolderName parentFolderName)
        {
            this.Save(name, new FolderId(parentFolderName));
        }

        /// <summary>
        /// Updates the user configuration by applying local changes to the Exchange server.
        /// Calling this method results in a call to EWS.
        /// </summary>
 void Update()
        {
            if (this.isNew)
            {
                throw new InvalidOperationException(Strings.CannotUpdateNewUserConfiguration);
            }

            if (this.IsPropertyUpdated(UserConfigurationProperties.BinaryData) ||
                this.IsPropertyUpdated(UserConfigurationProperties.Dictionary) ||
                this.IsPropertyUpdated(UserConfigurationProperties.XmlData))
            {
                this.service.UpdateUserConfiguration(this);
            }

            this.ResetIsDirty();
        }

        /// <summary>
        /// Deletes the user configuration. Calling this method results in a call to EWS.
        /// </summary>
 void Delete()
        {
            if (this.isNew)
            {
                throw new InvalidOperationException(Strings.DeleteInvalidForUnsavedUserConfiguration);
            }
            else
            {
                this.service.DeleteUserConfiguration(this.name, this.parentFolderId);
            }
        }

        /// <summary>
        /// Loads the specified properties on the user configuration. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="properties">The properties to load.</param>
 void Load(UserConfigurationProperties properties)
        {
            this.InitializeProperties(properties);

            this.service.LoadPropertiesForUserConfiguration(this, properties);
        }

        /// <summary>
        /// Writes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlNamespace">The XML namespace.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        void WriteToXml(
            EwsServiceXmlWriter writer,
            XmlNamespace xmlNamespace,
            String xmlElementName)
        {
            EwsUtilities.Assert(
                writer != null,
                "UserConfiguration.WriteToXml",
                "writer is null");
            EwsUtilities.Assert(
                xmlElementName != null,
                "UserConfiguration.WriteToXml",
                "xmlElementName is null");

            writer.WriteStartElement(xmlNamespace, xmlElementName);

            // Write the UserConfigurationName element
            WriteUserConfigurationNameToXml(
                writer,
                XmlNamespace.Types,
                this.name,
                this.parentFolderId);

            // Write the Dictionary element
            if (this.IsPropertyUpdated(UserConfigurationProperties.Dictionary))
            {
                this.dictionary.WriteToXml(writer, XmlElementNames.Dictionary);
            }

            // Write the XmlData element
            if (this.IsPropertyUpdated(UserConfigurationProperties.XmlData))
            {
                this.WriteXmlDataToXml(writer);
            }

            // Write the BinaryData element
            if (this.IsPropertyUpdated(UserConfigurationProperties.BinaryData))
            {
                this.WriteBinaryDataToXml(writer);
            }

            writer.WriteEndElement();
        }

        /// <summary>
        /// Gets the base64 property value.
        /// </summary>
        /// <param name="bytes">The bytes.</param>
        /// <returns></returns>
        /* private */ String GetBase64PropertyValue(Uint8List bytes)
        {
            if (bytes == null ||
                bytes.Length == 0)
            {
                return String.Empty;
            }
            else
            {
                return Convert.ToBase64String(bytes);
            }
        }

        /// <summary>
        /// Determines whether the specified property was updated.
        /// </summary>
        /// <param name="property">property to evaluate.</param>
        /// <returns>Boolean indicating whether to send the property Xml.</returns>
        /* private */ bool IsPropertyUpdated(UserConfigurationProperties property)
        {
            bool isPropertyDirty = false;
            bool isPropertyEmpty = false;

            switch (property)
            {
                case UserConfigurationProperties.Dictionary:
                    isPropertyDirty = this.Dictionary.IsDirty;
                    isPropertyEmpty = this.Dictionary.Count == 0;
                    break;
                case UserConfigurationProperties.XmlData:
                    isPropertyDirty = (property & this.updatedProperties) == property;
                    isPropertyEmpty = (this.xmlData == null) || (this.xmlData.Length == 0);
                    break;
                case UserConfigurationProperties.BinaryData:
                    isPropertyDirty = (property & this.updatedProperties) == property;
                    isPropertyEmpty = (this.binaryData == null) || (this.binaryData.Length == 0);
                    break;
                default:
                    EwsUtilities.Assert(
                        false,
                        "UserConfiguration.IsPropertyUpdated",
                        "property not supported: " + property.ToString());
                    break;
            }

            // Consider the property updated, if it's been modified, and either
            //    . there's a value or
            //    . there's no value but the operation is update.
            return isPropertyDirty && ((!isPropertyEmpty) || (!this.isNew));
        }

        /// <summary>
        /// Writes the XmlData property to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /* private */ void WriteXmlDataToXml(EwsServiceXmlWriter writer)
        {
            EwsUtilities.Assert(
                writer != null,
                "UserConfiguration.WriteXmlDataToXml",
                "writer is null");

            WriteByteArrayToXml(
                writer,
                this.xmlData,
                XmlElementNames.XmlData);
        }

        /// <summary>
        /// Writes the BinaryData property to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /* private */ void WriteBinaryDataToXml(EwsServiceXmlWriter writer)
        {
            EwsUtilities.Assert(
                writer != null,
                "UserConfiguration.WriteBinaryDataToXml",
                "writer is null");

            WriteByteArrayToXml(
                writer,
                this.binaryData,
                XmlElementNames.BinaryData);
        }

        /// <summary>
        /// Loads from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        void LoadFromXml(EwsServiceXmlReader reader)
        {
            EwsUtilities.Assert(
                reader != null,
                "UserConfiguration.LoadFromXml",
                "reader is null");

            reader.ReadStartElement(XmlNamespace.Messages, XmlElementNames.UserConfiguration);
            await reader.Read(); // Position at first property element

            do
            {
                if (reader.NodeType == XmlNodeType.Element)
                {
                    switch (reader.LocalName)
                    {
                        case XmlElementNames.UserConfigurationName:
                            String responseName = reader.ReadAttributeValue(XmlAttributeNames.Name);

                            EwsUtilities.Assert(
                                string.Compare(this.name, responseName, StringComparison.Ordinal) == 0,
                                "UserConfiguration.LoadFromXml",
                                "UserConfigurationName does not match: Expected: " + this.name + " Name in response: " + responseName);

                            reader.SkipCurrentElement();
                            break;

                        case XmlElementNames.ItemId:
                            this.itemId = new ItemId();
                            this.itemId.LoadFromXml(reader, XmlElementNames.ItemId);
                            break;

                        case XmlElementNames.Dictionary:
                            this.dictionary.LoadFromXml(reader, XmlElementNames.Dictionary);
                            break;

                        case XmlElementNames.XmlData:
                            this.xmlData = Convert.FromBase64String(reader.ReadElementValue<String>());
                            break;

                        case XmlElementNames.BinaryData:
                            this.binaryData = Convert.FromBase64String(reader.ReadElementValue<String>());
                            break;

                        default:
                            EwsUtilities.Assert(
                                false,
                                "UserConfiguration.LoadFromXml",
                                "Xml element not supported: " + reader.LocalName);
                            break;
                    }
                }

                // If XmlData was loaded, read is skipped because GetXmlData positions the reader at the next property.
                await reader.Read();
            }
            while (!reader.IsEndElement(XmlNamespace.Messages, XmlElementNames.UserConfiguration));
        }

        /// <summary>
        /// Initializes properties.
        /// </summary>
        /// <param name="requestedProperties">The properties requested for this UserConfiguration.</param>
        /// <remarks>
        /// InitializeProperties is called in 3 cases:
        /// .  Create new object:  From the UserConfiguration constructor.
        /// .  Bind to existing object:  Again from the constructor.  The constructor is called eventually by the GetUserConfiguration request.
        /// .  Refresh properties:  From the Load method.
        /// </remarks>
        /* private */ void InitializeProperties(UserConfigurationProperties requestedProperties)
        {
            this.itemId = null;
            this.dictionary = new UserConfigurationDictionary();
            this.xmlData = null;
            this.binaryData = null;
            this.propertiesAvailableForAccess = requestedProperties;

            this.ResetIsDirty();
        }

        /// <summary>
        /// Resets flags to indicate that properties haven't been modified.
        /// </summary>
        /* private */ void ResetIsDirty()
        {
            this.updatedProperties = NoProperties;
            this.dictionary.IsDirty = false;
        }

        /// <summary>
        /// Determines whether the specified property may be accessed.
        /// </summary>
        /// <param name="property">Property to access.</param>
        /* private */ void ValidatePropertyAccess(UserConfigurationProperties property)
        {
            if ((property & this.propertiesAvailableForAccess) != property)
            {
                throw new PropertyException(Strings.MustLoadOrAssignPropertyBeforeAccess, property.ToString());
            }
        }

        /// <summary>
        /// Adds the passed property to updatedProperties.
        /// </summary>
        /// <param name="property">Property to update.</param>
        /* private */ void MarkPropertyForUpdate(UserConfigurationProperties property)
        {
            this.updatedProperties |= property;
            this.propertiesAvailableForAccess |= property;
        }
    }
