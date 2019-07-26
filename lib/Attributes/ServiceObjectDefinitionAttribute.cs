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
    /// ServiceObjectDefinition attribute decorates classes that map to EWS service objects.
    /// </summary>
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
    class ServiceObjectDefinitionAttribute extends Attribute
    {
        /* private */ String xmlElementName;
        /* private */ bool returnedByServer;

        /// <summary>
        /// Initializes a new instance of the <see cref="ServiceObjectDefinitionAttribute"/> class.
        /// </summary>
        /// <param name="xmlElementName">Name of the XML element.</param>
        ServiceObjectDefinitionAttribute(String xmlElementName)
            : super()
        {
            this.xmlElementName = xmlElementName;
            this.returnedByServer = true;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <value>The name of the XML element.</value>
        String XmlElementName
        {
            get { return this.xmlElementName; }
        }

        /// <summary>
        /// True if this ServiceObject can be returned by the server as an object, false otherwise.
        /// </summary>
 bool ReturnedByServer
        {
            get { return this.returnedByServer; }
            set { this.returnedByServer = value; }
        }
    }
