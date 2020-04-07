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
    /// Represents the CompanyInsightValue.
    /// </summary>
 class CompanyInsightValue extends InsightValue
    {
        /* private */ String name;
        /* private */ String satoriId;
        /* private */ String description;
        /* private */ String descriptionAttribution;
        /* private */ String imageUrl;
        /* private */ String imageUrlAttribution;
        /* private */ String yearFound;
        /* private */ String financeSymbol;
        /* private */ String websiteUrl;

        /// <summary>
        /// Gets the Name
        /// </summary>
 String Name
        {
            get
            {
                return this.name;
            }

            set
            {
                this.SetFieldValue<string>(ref this.name, value);
            }
        }

        /// <summary>
        /// Gets the SatoriId
        /// </summary>
 String SatoriId
        {
            get
            {
                return this.satoriId;
            }

            set
            {
                this.SetFieldValue<string>(ref this.satoriId, value);
            }
        }

        /// <summary>
        /// Gets the Description
        /// </summary>
 String Description
        {
            get
            {
                return this.description;
            }

            set
            {
                this.SetFieldValue<string>(ref this.description, value);
            }
        }

        /// <summary>
        /// Gets the DescriptionAttribution
        /// </summary>
 String DescriptionAttribution
        {
            get
            {
                return this.descriptionAttribution;
            }

            set
            {
                this.SetFieldValue<string>(ref this.descriptionAttribution, value);
            }
        }

        /// <summary>
        /// Gets the ImageUrl
        /// </summary>
 String ImageUrl
        {
            get
            {
                return this.imageUrl;
            }

            set
            {
                this.SetFieldValue<string>(ref this.imageUrl, value);
            }
        }

        /// <summary>
        /// Gets the ImageUrlAttribution
        /// </summary>
 String ImageUrlAttribution
        {
            get
            {
                return this.imageUrlAttribution;
            }

            set
            {
                this.SetFieldValue<string>(ref this.imageUrlAttribution, value);
            }
        }

        /// <summary>
        /// Gets the YearFound
        /// </summary>
 String YearFound
        {
            get
            {
                return this.yearFound;
            }

            set
            {
                this.SetFieldValue<string>(ref this.yearFound, value);
            }
        }

        /// <summary>
        /// Gets the FinanceSymbol
        /// </summary>
 String FinanceSymbol
        {
            get
            {
                return this.financeSymbol;
            }

            set
            {
                this.SetFieldValue<string>(ref this.financeSymbol, value);
            }
        }

        /// <summary>
        /// Gets the WebsiteUrl
        /// </summary>
 String WebsiteUrl
        {
            get
            {
                return this.websiteUrl;
            }

            set
            {
                this.SetFieldValue<string>(ref this.websiteUrl, value);
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
                case XmlElementNames.Name:
                    this.Name = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.SatoriId:
                    this.SatoriId = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.Description:
                    this.Description = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.DescriptionAttribution:
                    this.DescriptionAttribution = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.ImageUrl:
                    this.ImageUrl = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.ImageUrlAttribution:
                    this.ImageUrlAttribution = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.YearFound:
                    this.YearFound = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.FinanceSymbol:
                    this.FinanceSymbol = reader.ReadElementValue<String>();
                    break;
                case XmlElementNames.WebsiteUrl:
                    this.WebsiteUrl = reader.ReadElementValue<String>();
                    break;
                default:
                    return false;
            }

            return true;
        }
    }
