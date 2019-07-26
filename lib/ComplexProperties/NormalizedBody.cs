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
    /// Represents the normalized body of an item - the HTML fragment representation of the body.
    /// </summary>
 class NormalizedBody extends ComplexProperty
    {
        /* private */ BodyType bodyType;
        /* private */ String text;
        /* private */ bool isTruncated;

        /// <summary>
        /// Initializes a new instance of the <see cref="NormalizedBody"/> class.
        /// </summary>
        NormalizedBody()
        {
        }

        /// <summary>
        /// Defines an implicit conversion of NormalizedBody into a string.
        /// </summary>
        /// <param name="messageBody">The NormalizedBody to convert to a string.</param>
        /// <returns>A String containing the text of the UniqueBody.</returns>
 static implicit operator string(NormalizedBody messageBody)
        {
            EwsUtilities.ValidateParam(messageBody, "messageBody");
            return messageBody.Text;
        }

        /// <summary>
        /// Reads attributes from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
@override
        void ReadAttributesFromXml(EwsServiceXmlReader reader)
        {
            this.bodyType = reader.ReadAttributeValue<BodyType>(XmlAttributeNames.BodyType);

            String attributeValue = reader.ReadAttributeValue(XmlAttributeNames.IsTruncated);
            if (!StringUtils.IsNullOrEmpty(attributeValue))
            {
                this.isTruncated = bool.Parse(attributeValue);
            }
        }

        /// <summary>
        /// Reads text value from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
@override
        void ReadTextValueFromXml(EwsServiceXmlReader reader)
        {
            this.text = reader.ReadValue();
        }

        /// <summary>
        /// Writes attributes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteAttributesToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteAttributeValue(XmlAttributeNames.BodyType, this.BodyType);
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            if (!StringUtils.IsNullOrEmpty(this.Text))
            {
                writer.WriteValue(this.Text, XmlElementNames.NormalizedBody);
            }
        }

        /// <summary>
        /// Gets the type of the normalized body's text.
        /// </summary>
 BodyType BodyType
        {
            get
            {
                return this.bodyType;
            }

            set
            {
                this.bodyType = value;
            }
        }

        /// <summary>
        /// Gets the text of the normalized body.
        /// </summary>
 String Text
        {
            get
            {
                return this.text;
            }

            set
            {
                this.text = value;
            }
        }

        /// <summary>
        /// Gets whether the body is truncated.
        /// </summary>
 bool IsTruncated
        {
            get
            {
                return this.isTruncated;
            }

            set
            {
                this.isTruncated = value;
            }
        }

        #region Object method overrides
        /// <summary>
        /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
        /// </summary>
        /// <returns>
        /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
        /// </returns>
@override
 String toString()
        {
            return (this.Text == null) ? "" : this.Text;
        }
        #endregion
    }
