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
/// Defines the action of a retention policy tag.
/// </summary>
enum RetentionActionType {
  /// <summary>
  /// Never tags (RetentionEnabled = false) do not have retention action in the FAI.
  /// </summary>
  None,

  /// <summary>
  /// Expired items will be moved to the Deleted Items folder.
  /// </summary>
  MoveToDeletedItems,

  /// <summary>
  /// Expired items will be moved to the organizational folder specified
  /// in the ExpirationDestination field.
  /// </summary>
  MoveToFolder,

  /// <summary>
  /// Expired items will be soft deleted.
  /// </summary>
  DeleteAndAllowRecovery,

  /// <summary>
  /// Expired items will be hard deleted.
  /// </summary>
  PermanentlyDelete,

  /// <summary>
  /// Expired items will be tagged as expired.
  /// </summary>
  MarkAsPastRetentionLimit,

  /// <summary>
  /// Expired items will be moved to the archive.
  /// </summary>
  MoveToArchive,
}
