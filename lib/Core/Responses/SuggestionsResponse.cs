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
    /// Represents the response to a meeting time suggestion availability request.
    /// </summary>
    class SuggestionsResponse extends ServiceResponse
    {
        /* private */ Collection<Suggestion> daySuggestions = new Collection<Suggestion>();

        /// <summary>
        /// Initializes a new instance of the <see cref="SuggestionsResponse"/> class.
        /// </summary>
        SuggestionsResponse()
            : super()
        {
        }

        /// <summary>
        /// Loads the suggested days from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        void LoadSuggestedDaysFromXml(EwsServiceXmlReader reader)
        {
            reader.ReadStartElement(XmlNamespace.Messages, XmlElementNames.SuggestionDayResultArray);

            do
            {
                await reader.Read();

                if (reader.IsStartElement(XmlNamespace.Types, XmlElementNames.SuggestionDayResult))
                {
                    Suggestion daySuggestion = new Suggestion();

                    daySuggestion.LoadFromXml(reader, reader.LocalName);

                    this.daySuggestions.Add(daySuggestion);
                }
            }
            while (!reader.IsEndElement(XmlNamespace.Messages, XmlElementNames.SuggestionDayResultArray));
        }

        /// <summary>
        /// Gets a list of suggested days.
        /// </summary>
        Collection<Suggestion> Suggestions
        {
            get { return this.daySuggestions; }
        }
    }
