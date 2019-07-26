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
    /// Represents property definition for type represented by xs:list of values in schema.
    /// </summary>
    /// <typeparam name="TPropertyValue">Property value type. Constrained to be a value type.</typeparam>
    class ListValuePropertyDefinition<TPropertyValue> : GenericPropertyDefinition<TPropertyValue> where TPropertyValue : struct
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ListValuePropertyDefinition&lt;TPropertyValue&gt;"/> class.
        /// </summary>
        /// <param name="xmlElementName">Name of the XML element.</param>
        /// <param name="uri">The URI.</param>
        /// <param name="flags">The flags.</param>
        /// <param name="version">The version.</param>
        ListValuePropertyDefinition(
            String xmlElementName,
            String uri,
            PropertyDefinitionFlags flags,
            ExchangeVersion version)
            : super(
                xmlElementName,
                uri,
                flags,
                version)
        {
        }

        /// <summary>
        /// Parses the specified value.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns>Value of string.</returns>
@override
        object Parse(String value)
        {
            // xs:list values are sent as a space-separated list; convert to comma-separated for EwsUtilities.Parse.
            String commaSeparatedValue = StringUtils.IsNullOrEmpty(value) ? value : value.Replace(' ', ',');
            return EwsUtilities.Parse<TPropertyValue>(commaSeparatedValue);
        }
    }
