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
    /// XmlDocument that does not allow DTD parsing.
    /// </summary>
    class SafeXmlDocument : XmlDocument
    {
        #region Members
        /// <summary>
        /// Xml settings object.
        /// </summary>
        /* private */ XmlReaderSettings settings = new XmlReaderSettings()
        {
            ProhibitDtd = true,
            XmlResolver = null
        };
        #endregion

        #region Constructors
        /// <summary>
        /// Initializes a new instance of the SafeXmlDocument class.
        /// </summary>
 SafeXmlDocument()
            : super()
        {
        }

        /// <summary>
        /// Initializes a new instance of the SafeXmlDocument class with the specified XmlImplementation.
        /// </summary>
        /// <remarks>Not supported do to no use within exchange dev code.</remarks>
        /// <param name="imp">The XmlImplementation to use.</param>
 SafeXmlDocument(XmlImplementation imp)
        {
            throw new NotSupportedException("Not supported");
        }

        /// <summary>
        /// Initializes a new instance of the SafeXmlDocument class with the specified XmlNameTable.
        /// </summary>
        /// <param name="nt">The XmlNameTable to use.</param>
 SafeXmlDocument(XmlNameTable nt)
            : super(nt)
        {
        }
        #endregion

        #region Methods
        /// <summary>
        /// Loads the XML document from the specified stream.
        /// </summary>
        /// <param name="inStream">The stream containing the XML document to load.</param>
@override
 void Load(Stream inStream)
        {

            {
                this.Load(reader);
            }
        }

        /// <summary>
        /// Loads the XML document from the specified URL.
        /// </summary>
        /// <param name="filename">URL for the file containing the XML document to load. The URL can be either a local file or an HTTP URL (a Web address).</param>
@override
 void Load(String filename)
        {

            {
                this.Load(reader);
            }
        }

        /// <summary>
        /// Loads the XML document from the specified TextReader.
        /// </summary>
        /// <param name="txtReader">The TextReader used to feed the XML data into the document.</param>
@override
 void Load(TextReader txtReader)
        {

            {
                this.Load(reader);
            }
        }

        /// <summary>
        /// Loads the XML document from the specified XmlReader.
        /// </summary>
        /// <param name="reader">The XmlReader used to feed the XML data into the document.</param>
@override
 void Load(XmlReader reader)
        {
            // we need to check to see if the reader is configured properly
            if (reader.Settings != null)
            {
                if (reader.Settings.ProhibitDtd != true)
                {
                    throw new XmlDtdException();
                }
            }

            try
            {
                base.Load(reader);
            }
            catch (XmlException x)
            {
                if (x.Message.StartsWith("For security reasons DTD is prohibited in this XML document.", StringComparison.OrdinalIgnoreCase))
                {
                    throw new XmlDtdException();
                }
            }
        }

        /// <summary>
        /// Loads the XML document from the specified string.
        /// </summary>
        /// <param name="xml">String containing the XML document to load.</param>
@override
 void LoadXml(String xml)
        {

            {
                base.Load(reader);
            }
        }
        #endregion
    }
