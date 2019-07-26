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
    /// Represents voting option information.
    /// </summary>
 class VotingOptionData extends ComplexProperty
    {
        /* private */ String displayName;
        /* private */ SendPrompt sendPrompt;

        /// <summary>
        /// Initializes a new instance of the <see cref="VotingOptionData"/> class.
        /// </summary>
        VotingOptionData()
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
                case XmlElementNames.VotingOptionDisplayName:
                    this.displayName = reader.ReadElementValue<string>();
                    return true;
                case XmlElementNames.SendPrompt:
                    this.sendPrompt = reader.ReadElementValue<SendPrompt>();
                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Gets the display name for the voting option.
        /// </summary>
 String DisplayName
        {
            get { return this.displayName; }
        }

        /// <summary>
        /// Gets the send prompt.
        /// </summary>
 SendPrompt SendPrompt
        {
            get { return this.sendPrompt; }
        }
    }
