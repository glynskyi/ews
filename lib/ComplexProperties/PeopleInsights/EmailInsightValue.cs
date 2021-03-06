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
    /// Represents the EmailInsightValue.
    /// </summary>
 class EmailInsightValue extends InsightValue
    {
        /// <summary>
        /// Gets the Id
        /// </summary>
 String Id
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the ThreadId
        /// </summary>
 String ThreadId
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the Subject
        /// </summary>
 String Subject
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the LastEmailDateUtcTicks
        /// </summary>
 long LastEmailDateUtcTicks
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the Body
        /// </summary>
 String Body
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the LastEmailSender
        /// </summary>
 ProfileInsightValue LastEmailSender
        {
            get;
            set;
        }

        /// <summary>
        /// Gets the EmailsCount
        /// </summary>
 int EmailsCount
        {
            get;
            set;
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">XML reader</param>
        /// <returns>Whether the element was read</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.InsightSource:
                    this.InsightSource = reader.ReadElementValue<string>();
                    break;
                case XmlElementNames.UpdatedUtcTicks:
                    this.UpdatedUtcTicks = reader.ReadElementValue<long>();
                    break;
                case XmlElementNames.Id:
                    this.Id = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.ThreadId:
                    this.ThreadId = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Subject:
                    this.Subject = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.LastEmailDateUtcTicks:
                    this.LastEmailDateUtcTicks = reader.ReadElementValue<long>();
                    break;
                case XmlElementNames.Body:
                    this.Body = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.LastEmailSender:
                    this.LastEmailSender = new ProfileInsightValue();
                    this.LastEmailSender.LoadFromXml(reader, reader.LocalName);
                    break;
                case XmlElementNames.EmailsCount:
                    this.EmailsCount = reader.ReadElementValue<int>();
                    break;
                default:
                    return false;
            }

            return true;
        }
    }
