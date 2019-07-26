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
    /// Represents an Out of Office response.
    /// </summary>
 sealed class OofReply
    {
        /* private */ String culture = CultureInfo.CurrentCulture.Name;
        /* private */ String message;

        /// <summary>
        /// Writes an empty OofReply to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        static void WriteEmptyReplyToXml(EwsServiceXmlWriter writer, String xmlElementName)
        {
            writer.WriteStartElement(XmlNamespace.Types, xmlElementName);
            writer.WriteEndElement(); // xmlElementName
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="OofReply"/> class.
        /// </summary>
 OofReply()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="OofReply"/> class.
        /// </summary>
        /// <param name="message">The reply message.</param>
 OofReply(String message)
        {
            this.message = message;
        }

        /// <summary>
        /// Defines an implicit conversion between String an OofReply.
        /// </summary>
        /// <param name="message">The message to convert into OofReply.</param>
        /// <returns>An OofReply initialized with the specified message.</returns>
 static implicit operator OofReply(String message)
        {
            return new OofReply(message);
        }

        /// <summary>
        /// Defines an implicit conversion between OofReply and string.
        /// </summary>
        /// <param name="oofReply">The OofReply to convert into a string.</param>
        /// <returns>A String containing the message of the specified OofReply.</returns>
 static implicit operator string(OofReply oofReply)
        {
            EwsUtilities.ValidateParam(oofReply, "oofReply");

            return oofReply.Message;
        }

        /// <summary>
        /// Loads from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        void LoadFromXml(EwsServiceXmlReader reader, String xmlElementName)
        {
            reader.EnsureCurrentNodeIsStartElement(XmlNamespace.Types, xmlElementName);

            if (reader.HasAttributes)
            {
                this.culture = reader.ReadAttributeValue("xml:lang");
            }

            this.message = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.Message);

            reader.ReadEndElement(XmlNamespace.Types, xmlElementName);
        }

        /// <summary>
        /// Writes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        void WriteToXml(EwsServiceXmlWriter writer, String xmlElementName)
        {
            writer.WriteStartElement(XmlNamespace.Types, xmlElementName);

            if (this.Culture != null)
            {
                writer.WriteAttributeValue(
                    "xml",
                    "lang",
                    this.Culture);
            }

            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.Message,
                this.Message);

            writer.WriteEndElement(); // xmlElementName
        }

        /// <summary>
        /// Obtains a String representation of the reply.
        /// </summary>
        /// <returns>A String containing the reply message.</returns>
@override
 String toString()
        {
            return this.Message;
        }

        /// <summary>
        /// Gets or sets the culture of the reply.
        /// </summary>
 String Culture
        {
            get { return this.culture; }
            set { this.culture = value; }
        }

        /// <summary>
        /// Gets or sets the reply message.
        /// </summary>
 String Message
        {
            get { return this.message; }
            set { this.message = value; }
        }
    }
