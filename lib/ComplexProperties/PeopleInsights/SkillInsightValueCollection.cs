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
    /// Represents the collection of person insights.
    /// </summary>
 class SkillInsightValueCollection extends ComplexPropertyCollection<SkillInsightValue>
    {
        /// <summary>
        /// XML element name
        /// </summary>
        /* private */ readonly String collectionItemXmlElementName;

        /// <summary>
        /// Creates a new instance of the <see cref="SkillInsightValueCollection"/> class.
        /// </summary>
        SkillInsightValueCollection()
            : this(XmlElementNames.SkillInsightValue)
        {
        }

        /// <summary>
        /// Creates a new instance of the <see cref="SkillInsightValueCollection"/> class.
        /// </summary>
        /// <param name="collectionItemXmlElementName">Name of the collection item XML element.</param>
        SkillInsightValueCollection(String collectionItemXmlElementName)
            : super()
        {
            this.collectionItemXmlElementName = collectionItemXmlElementName;
        }

        /// <summary>
        /// Creates a SkillInsightValue object from an XML element name.
        /// </summary>
        /// <param name="xmlElementName">The XML element name from which to create the SkillInsightValue.</param>
        /// <returns>A SkillInsightValue object.</returns>
@override
        SkillInsightValue CreateComplexProperty(String xmlElementName)
        {
            if (xmlElementName == this.collectionItemXmlElementName)
            {
                return new SkillInsightValue();
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// Retrieves the XML element name corresponding to the provided PersonInsight object.
        /// </summary>
        /// <param name="insight">The SkillInsightValue object from which to determine the XML element name.</param>
        /// <returns>The XML element name corresponding to the provided SkillInsightValue object.</returns>
@override
        String GetCollectionItemXmlElementName(SkillInsightValue insight)
        {
            return this.collectionItemXmlElementName;
        }

        /// <summary>
        /// Determine whether we should write collection to XML or not.
        /// </summary>
        /// <returns>Always true, even if the collection is empty.</returns>
@override
        bool ShouldWriteToRequest()
        {
            return true;
        }
    }
