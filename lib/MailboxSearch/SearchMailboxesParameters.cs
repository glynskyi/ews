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
    /// Represents search mailbox parameters.
    /// </summary>
 sealed class SearchMailboxesParameters
    {
        /// <summary>
        /// Search queries
        /// </summary>
 MailboxQuery[] SearchQueries { get; set; }

        /// <summary>
        /// Result type
        /// </summary>
 SearchResultType ResultType { get; set; }

        /// <summary>
        /// Sort by property
        /// </summary>
 String SortBy { get; set; }

        /// <summary>
        /// Sort direction
        /// </summary>
 SortDirection SortOrder { get; set; }

        /// <summary>
        /// Perform deduplication
        /// </summary>
 bool PerformDeduplication { get; set; }

        /// <summary>
        /// Page size
        /// </summary>
 int PageSize { get; set; }

        /// <summary>
        /// Search page direction
        /// </summary>
 SearchPageDirection PageDirection { get; set; }

        /// <summary>
        /// Page item reference
        /// </summary>
 String PageItemReference { get; set; }

        /// <summary>
        /// Preview item response shape
        /// </summary>
 PreviewItemResponseShape PreviewItemResponseShape { get; set; }

        /// <summary>
        /// Query language
        /// </summary>
 String Language { get; set; }
    }
