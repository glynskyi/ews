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
    /// Represents a collection of Internet message headers.
    /// </summary>
    [EditorBrowsable(EditorBrowsableState.Never)]
 class InternetMessageHeaderCollection extends ComplexPropertyCollection<InternetMessageHeader>
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="InternetMessageHeaderCollection"/> class.
        /// </summary>
        InternetMessageHeaderCollection()
            : super()
        {
        }

        /// <summary>
        /// Creates the complex property.
        /// </summary>
        /// <param name="xmlElementName">Name of the XML element.</param>
        /// <returns>InternetMessageHeader instance.</returns>
@override
        InternetMessageHeader CreateComplexProperty(String xmlElementName)
        {
            return new InternetMessageHeader();
        }

        /// <summary>
        /// Gets the name of the collection item XML element.
        /// </summary>
        /// <param name="complexProperty">The complex property.</param>
        /// <returns>XML element name.</returns>
@override
        String GetCollectionItemXmlElementName(InternetMessageHeader complexProperty)
        {
            return XmlElementNames.InternetMessageHeader;
        }

        /// <summary>
        /// Find a specific header in the collection.
        /// </summary>
        /// <param name="name">The name of the header to locate.</param>
        /// <returns>An InternetMessageHeader representing the header with the specified name; null if no header with the specified name was found.</returns>
 InternetMessageHeader Find(String name)
        {
            for (InternetMessageHeader internetMessageHeader in this)
            {
                if (string.Compare(name, internetMessageHeader.Name, StringComparison.OrdinalIgnoreCase) == 0)
                {
                    return internetMessageHeader;
                }
            }

            return null;
        }
    }
