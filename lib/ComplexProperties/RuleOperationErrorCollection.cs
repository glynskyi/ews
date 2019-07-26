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
    /// Represents a collection of rule operation errors.
    /// </summary>
 class RuleOperationErrorCollection extends ComplexPropertyCollection<RuleOperationError>
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="RuleOperationErrorCollection"/> class.
        /// </summary>
        RuleOperationErrorCollection()
            : super()
        {
        }

        /// <summary>
        /// Creates an RuleOperationError object from an XML element name.
        /// </summary>
        /// <param name="xmlElementName">The XML element name from which to create the RuleOperationError object.</param>
        /// <returns>A RuleOperationError object.</returns>
@override
        RuleOperationError CreateComplexProperty(String xmlElementName)
        {
            if (xmlElementName == XmlElementNames.RuleOperationError)
            {
                return new RuleOperationError();
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// Retrieves the XML element name corresponding to the provided RuleOperationError object.
        /// </summary>
        /// <param name="operationError">The RuleOperationError object from which to determine the XML element name.</param>
        /// <returns>The XML element name corresponding to the provided RuleOperationError object.</returns>
@override
        String GetCollectionItemXmlElementName(RuleOperationError operationError)
        {
            return XmlElementNames.RuleOperationError;
        }
    }
