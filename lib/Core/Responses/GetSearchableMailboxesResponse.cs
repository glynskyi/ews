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
    /// Represents the GetSearchableMailboxes response.
    /// </summary>
 class GetSearchableMailboxesResponse extends ServiceResponse
    {
        List<SearchableMailbox> searchableMailboxes = new List<SearchableMailbox>();

        /// <summary>
        /// Initializes a new instance of the <see cref="GetSearchableMailboxesResponse"/> class.
        /// </summary>
        GetSearchableMailboxesResponse()
            : super()
        {
        }

        /// <summary>
        /// Reads response elements from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
@override
        void ReadElementsFromXml(EwsServiceXmlReader reader)
        {
            this.searchableMailboxes.Clear();

            base.ReadElementsFromXml(reader);

            reader.ReadStartElement(XmlNamespace.Messages, XmlElementNames.SearchableMailboxes);
            if (!reader.IsEmptyElement)
            {
                do
                {
                    await reader.Read();
                    if (reader.IsStartElement(XmlNamespace.Types, XmlElementNames.SearchableMailbox))
                    {
                        this.searchableMailboxes.Add(SearchableMailbox.LoadFromXml(reader));
                    }
                }
                while (!reader.IsEndElement(XmlNamespace.Messages, XmlElementNames.SearchableMailboxes));
            }

            await reader.Read();
            if (reader.IsStartElement(XmlNamespace.Messages, XmlElementNames.FailedMailboxes))
            {
                this.FailedMailboxes = FailedSearchMailbox.LoadFailedMailboxesXml(XmlNamespace.Messages, reader);
            }
        }

        /// <summary>
        /// Searchable mailboxes result
        /// </summary>
 SearchableMailbox[] SearchableMailboxes
        {
            get { return this.searchableMailboxes.ToArray(); }
        }

        /// <summary>
        /// Failed mailboxes
        /// </summary>
 FailedSearchMailbox[] FailedMailboxes { get; set; }
    }
