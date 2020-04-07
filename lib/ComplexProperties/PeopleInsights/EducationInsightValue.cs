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
    /// Represents the EducationInsightValue.
    /// </summary>
 class EducationInsightValue extends InsightValue
    {
        /* private */ String institute;
        /* private */ String degree;
        /* private */ long startUtcTicks;
        /* private */ long endUtcTicks;

        /// <summary>
        /// Gets the Institute
        /// </summary>
 String Institute
        {
            get
            {
                return this.institute;
            }

            set
            {
                this.SetFieldValue<string>(ref this.institute, value);
            }
        }

        /// <summary>
        /// Gets the Degree
        /// </summary>
 String Degree
        {
            get
            {
                return this.degree;
            }

            set
            {
                this.SetFieldValue<string>(ref this.degree, value);
            }
        }

        /// <summary>
        /// Gets the StartUtcTicks
        /// </summary>
 long StartUtcTicks
        {
            get
            {
                return this.startUtcTicks;
            }

            set
            {
                this.SetFieldValue<long>(ref this.startUtcTicks, value);
            }
        }

        /// <summary>
        /// Gets the EndUtcTicks
        /// </summary>
 long EndUtcTicks
        {
            get
            {
                return this.endUtcTicks;
            }

            set
            {
                this.SetFieldValue<long>(ref this.endUtcTicks, value);
            }
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
                case XmlElementNames.Institute:
                    this.Institute = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Degree:
                    this.Degree = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.StartUtcTicks:
                    this.StartUtcTicks = reader.ReadElementValue<long>();
                    break;
                case XmlElementNames.EndUtcTicks:
                    this.EndUtcTicks = reader.ReadElementValue<long>();
                    break;
                default:
                    return false;
            }

            return true;
        }
    }
