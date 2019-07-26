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
    /// Represents an entry of an PhysicalAddressDictionary.
    /// </summary>
 class PhysicalAddressEntry extends DictionaryEntryProperty<PhysicalAddressKey>
    {
        #region Fields

        /* private */ SimplePropertyBag<string> propertyBag;

        #endregion

        #region Constructors

        /// <summary>
        /// Initializes a new instance of PhysicalAddressEntry
        /// </summary>
 PhysicalAddressEntry()
            : super()
        {
            this.propertyBag = new SimplePropertyBag<string>();
            this.propertyBag.OnChange += this.PropertyBagChanged;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets or sets the street.
        /// </summary>
        String get Street => this.PropertyBag[PhysicalAddressSchema.Street];
        set Street(String value) => this.PropertyBag[PhysicalAddressSchema.Street] = value;

        /// <summary>
        /// Gets or sets the city.
        /// </summary>
        String get City => this.PropertyBag[PhysicalAddressSchema.City];
        set City(String value) => this.PropertyBag[PhysicalAddressSchema.City] = value;

        /// <summary>
        /// Gets or sets the state.
        /// </summary>
        String get State => this.PropertyBag[PhysicalAddressSchema.State];
        set State(String value) => this.PropertyBag[PhysicalAddressSchema.State] = value;

        /// <summary>
        /// Gets or sets the country or region.
        /// </summary>
        String get CountryOrRegion => this.PropertyBag[PhysicalAddressSchema.CountryOrRegion];
        set CountryOrRegion(String value) => this.PropertyBag[PhysicalAddressSchema.CountryOrRegion] = value;

        /// <summary>
        /// Gets or sets the postal code.
        /// </summary>
        String get PostalCode => this.PropertyBag[PhysicalAddressSchema.PostalCode];
        set PostalCode(String value) => this.PropertyBag[PhysicalAddressSchema.PostalCode] = value;

        #endregion

        #region methods

        /// <summary>
        /// Clears the change log.
        /// </summary>
@override
        void ClearChangeLog()
        {
            this.propertyBag.ClearChangeLog();
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            if (PhysicalAddressSchema.XmlElementNames.Contains(reader.LocalName))
            {
                this.propertyBag[reader.LocalName] = reader.ReadElementValue();

                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            for (String xmlElementName in PhysicalAddressSchema.XmlElementNames)
            {
                writer.WriteElementValue(
                    XmlNamespace.Types,
                    xmlElementName,
                    this.propertyBag[xmlElementName]);
            }
        }

        /// <summary>
        /// Writes the update to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="ewsObject">The ews object.</param>
        /// <param name="ownerDictionaryXmlElementName">Name of the owner dictionary XML element.</param>
        /// <returns>True if update XML was written.</returns>
@override
        bool WriteSetUpdateToXml(
            EwsServiceXmlWriter writer,
            ServiceObject ewsObject,
            String ownerDictionaryXmlElementName)
        {
            List<string> fieldsToSet = new List<string>();

            for (String xmlElementName in this.propertyBag.AddedItems)
            {
                fieldsToSet.Add(xmlElementName);
            }

            for (String xmlElementName in this.propertyBag.ModifiedItems)
            {
                fieldsToSet.Add(xmlElementName);
            }

            for (String xmlElementName in fieldsToSet)
            {
                writer.WriteStartElement(XmlNamespace.Types, ewsObject.GetSetFieldXmlElementName());

                writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.IndexedFieldURI);
                writer.WriteAttributeValue(XmlAttributeNames.FieldURI, GetFieldUri(xmlElementName));
                writer.WriteAttributeValue(XmlAttributeNames.FieldIndex, this.Key.ToString());
                writer.WriteEndElement(); // IndexedFieldURI

                writer.WriteStartElement(XmlNamespace.Types, ewsObject.GetXmlElementName());
                writer.WriteStartElement(XmlNamespace.Types, ownerDictionaryXmlElementName);
                writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Entry);
                this.WriteAttributesToXml(writer);
                writer.WriteElementValue(
                    XmlNamespace.Types,
                    xmlElementName,
                    this.propertyBag[xmlElementName]);
                writer.WriteEndElement(); // Entry
                writer.WriteEndElement(); // ownerDictionaryXmlElementName
                writer.WriteEndElement(); // ewsObject.GetXmlElementName()

                writer.WriteEndElement(); // ewsObject.GetSetFieldXmlElementName()
            }

            for (String xmlElementName in this.propertyBag.RemovedItems)
            {
                this.InternalWriteDeleteFieldToXml(
                    writer,
                    ewsObject,
                    xmlElementName);
            }

            return true;
        }

        /// <summary>
        /// Writes the delete update to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="ewsObject">The ews object.</param>
        /// <returns>True if update XML was written.</returns>
@override
        bool WriteDeleteUpdateToXml(EwsServiceXmlWriter writer, ServiceObject ewsObject)
        {
            for (String xmlElementName in PhysicalAddressSchema.XmlElementNames)
            {
                this.InternalWriteDeleteFieldToXml(
                    writer,
                    ewsObject,
                    xmlElementName);
            }

            return true;
        }

        #endregion

        #region /* private */ methods

        /// <summary>
        /// Gets the field URI.
        /// </summary>
        /// <param name="xmlElementName">Name of the XML element.</param>
        /// <returns>Field URI.</returns>
        /* private */ static String GetFieldUri(String xmlElementName)
        {
            return "contacts:PhysicalAddress:" + xmlElementName;
        }

        /// <summary>
        /// Property bag was changed.
        /// </summary>
        /* private */ void PropertyBagChanged()
        {
            this.Changed();
        }

        /// <summary>
        /// Write field deletion to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="ewsObject">The ews object.</param>
        /// <param name="fieldXmlElementName">Name of the field XML element.</param>
        /* private */ void InternalWriteDeleteFieldToXml(
            EwsServiceXmlWriter writer,
            ServiceObject ewsObject,
            String fieldXmlElementName)
        {
            writer.WriteStartElement(XmlNamespace.Types, ewsObject.GetDeleteFieldXmlElementName());
            writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.IndexedFieldURI);
            writer.WriteAttributeValue(XmlAttributeNames.FieldURI, GetFieldUri(fieldXmlElementName));
            writer.WriteAttributeValue(XmlAttributeNames.FieldIndex, this.Key.ToString());
            writer.WriteEndElement(); // IndexedFieldURI
            writer.WriteEndElement(); // ewsObject.GetDeleteFieldXmlElementName()
        }

        #endregion

        #region Classes

        /// <summary>
        /// Schema definition for PhysicalAddress
        /// </summary>
        /* private */ static class PhysicalAddressSchema
        {
 const String Street = "Street";
 const String City = "City";
 const String State = "State";
 const String CountryOrRegion = "CountryOrRegion";
 const String PostalCode = "PostalCode";

            /// <summary>
            /// List of XML element names.
            /// </summary>
            /* private */ static LazyMember<List<string>> xmlElementNames = new LazyMember<List<string>>(
                delegate()
                {
                    List<string> result = new List<string>();
                    result.Add(Street);
                    result.Add(City);
                    result.Add(State);
                    result.Add(CountryOrRegion);
                    result.Add(PostalCode);
                    return result;
                });

            /// <summary>
            /// Gets the XML element names.
            /// </summary>
            /// <value>The XML element names.</value>
 static List<string> XmlElementNames
            {
                get { return xmlElementNames.Member; }
            }
        }

        #endregion
    }
