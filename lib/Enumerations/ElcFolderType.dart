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
/// Defines the folder type of a retention policy tag.
/// </summary>
enum ElcFolderType {
  /// <summary>
  /// Calendar folder.
  /// </summary>
  Calendar,

  /// <summary>
  /// Contacts folder.
  /// </summary>
  Contacts,

  /// <summary>
  /// Deleted Items.
  /// </summary>
  DeletedItems,

  /// <summary>
  /// Drafts folder.
  /// </summary>
  Drafts,

  /// <summary>
  /// Inbox.
  /// </summary>
  Inbox,

  /// <summary>
  /// Junk mail.
  /// </summary>
  JunkEmail,

  /// <summary>
  /// Journal.
  /// </summary>
  Journal,

  /// <summary>
  /// Notes.
  /// </summary>
  Notes,

  /// <summary>
  /// Outbox.
  /// </summary>
  Outbox,

  /// <summary>
  /// Sent Items.
  /// </summary>
  SentItems,

  /// <summary>
  /// Tasks folder.
  /// </summary>
  Tasks,

  /// <summary>
  /// Policy applies to all folders that do not have a policy.
  /// </summary>
  All,

  /// <summary>
  /// Policy is for an organizational policy.
  /// </summary>
  ManagedCustomFolder,

  /// <summary>
  /// Policy is for the RSS Subscription (default) folder.
  /// </summary>
  RssSubscriptions,

  /// <summary>
  /// Policy is for the Sync Issues (default) folder.
  /// </summary>
  SyncIssues,

  /// <summary>
  /// Policy is for the Conversation History (default) folder.
  /// This folder is used by the Office Communicator to archive IM conversations.
  /// </summary>
  ConversationHistory,

  /// <summary>
  /// Policy is for the personal folders.
  /// </summary>
  Personal,

  /// <summary>
  /// Policy is for Dumpster 2.0.
  /// </summary>
  RecoverableItems,

  /// <summary>
  /// Non IPM Subtree root.
  /// </summary>
  NonIpmRoot,
}
