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
/// Defines the view filter for queries.
/// </summary>
enum ViewFilter {
  /// <summary>
  /// Show all item (no filter)
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  All,

  /// <summary>
  /// Item has flag
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  Flagged,

  /// <summary>
  /// Item has attachment
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  HasAttachment,

  /// <summary>
  /// Item is to or cc me
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  ToOrCcMe,

  /// <summary>
  /// Item is unread
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  Unread,

  /// <summary>
  /// Active task items
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  TaskActive,

  /// <summary>
  /// Overdue task items
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  TaskOverdue,

  /// <summary>
  /// Completed task items
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  TaskCompleted,

  /// <summary>
  /// Suggestions (aka Predicted Actions) from the Inference engine
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  Suggestions,

  /// <summary>
  /// Respond suggestions
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  SuggestionsRespond,

  /// <summary>
  /// Delete suggestions
  /// </summary>
  /// [RequiredServerVersion(ExchangeVersion.Exchange2013)]
  SuggestionsDelete,
}
