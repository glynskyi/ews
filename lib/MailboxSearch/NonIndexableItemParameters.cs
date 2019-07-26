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
    /// Represents non indexable item parameters base class
    /// </summary>
 abstract class NonIndexableItemParameters
    {
        /// <summary>
        /// List of mailboxes (in legacy DN format)
        /// </summary>
 string[] Mailboxes { get; set; }

        /// <summary>
        /// Search archive only
        /// </summary>
 bool SearchArchiveOnly { get; set; }
    }

    /// <summary>
    /// Represents get non indexable item statistics parameters.
    /// </summary>
 class GetNonIndexableItemStatisticsParameters extends NonIndexableItemParameters
    {
    }

    /// <summary>
    /// Represents get non indexable item details parameters.
    /// </summary>
 class GetNonIndexableItemDetailsParameters extends NonIndexableItemParameters
    {
        /// <summary>
        /// Page size
        /// </summary>
 int? PageSize { get; set; }

        /// <summary>
        /// Page item reference
        /// </summary>
 String PageItemReference { get; set; }

        /// <summary>
        /// Search page direction
        /// </summary>
 SearchPageDirection? PageDirection { get; set; }
    }
