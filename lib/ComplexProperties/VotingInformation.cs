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
    /// Represents voting information.
    /// </summary>
 class VotingInformation extends ComplexProperty
    {
        /* private */ Collection<VotingOptionData> userOptions = new Collection<VotingOptionData>();
        /* private */ String votingResponse;

        /// <summary>
        /// Initializes a new instance of the <see cref="VotingInformation"/> class.
        /// </summary>
        VotingInformation()
        {
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.UserOptions:
                    if (!reader.IsEmptyElement)
                    {
                        do
                        {
                            reader.Read();

                            if (reader.IsStartElement(XmlNamespace.Types, XmlElementNames.VotingOptionData))
                            {
                                VotingOptionData option = new VotingOptionData();
                                option.LoadFromXml(reader, reader.LocalName);
                                this.userOptions.Add(option);
                            }
                        }
                        while (!reader.IsEndElement(XmlNamespace.Types, XmlElementNames.UserOptions));
                    }
                    return true;
                case XmlElementNames.VotingResponse:
                    this.votingResponse = reader.ReadElementValue<string>();
                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Gets the list of user options.
        /// </summary>
 Collection<VotingOptionData> UserOptions
        {
            get { return this.userOptions; }
        }

        /// <summary>
        /// Gets the voting response.
        /// </summary>
 String VotingResponse
        {
            get { return this.votingResponse; }
        }
    }
