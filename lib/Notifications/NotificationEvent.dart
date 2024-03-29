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

import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Enumerations/EventType.dart' as enumerations;
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents an event as exposed by push and pull notifications.
/// </summary>
abstract class NotificationEvent {
  /// <summary>
  /// Type of this event.
  /// </summary>
  /* private */ enumerations.EventType? eventType;

  /// <summary>
  /// Date and time when the event occurred.
  /// </summary>
  /* private */
  DateTime? timestamp;

  /// <summary>
  /// Id of parent folder of the item or folder this event applies to.
  /// </summary>
  /* private */
  FolderId? parentFolderId;

  /// <summary>
  /// Id of the old prarent foldero of the item or folder this event applies to.
  /// This property is only meaningful when EventType is equal to either EventType.Moved
  /// or EventType.Copied. For all other event types, oldParentFolderId will be null.
  /// </summary>
  /* private */
  FolderId? oldParentFolderId;

  /// <summary>
  /// Initializes a new instance of the <see cref="NotificationEvent"/> class.
  /// </summary>
  /// <param name="eventType">Type of the event.</param>
  /// <param name="timestamp">The event timestamp.</param>
  NotificationEvent(enumerations.EventType? eventType, DateTime? timestamp) {
    this.eventType = eventType;
    this.timestamp = timestamp;
  }

  /// <summary>
  /// Load from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  Future<void> InternalLoadFromXml(EwsServiceXmlReader reader) async {}

  /// <summary>
  /// Loads this NotificationEvent from XML.
  /// </summary>
  /// <param name="reader">The reader from which to read the notification event.</param>
  /// <param name="xmlElementName">The start XML element name of this notification event.</param>
  Future<void> LoadFromXml(
      EwsServiceXmlReader reader, String xmlElementName) async {
    await this.InternalLoadFromXml(reader);

    await reader.ReadEndElementIfNecessary(XmlNamespace.Types, xmlElementName);
  }

  /// <summary>
  /// Gets the type of this event.
  /// </summary>
  enumerations.EventType? get EventType => this.eventType;

  /// <summary>
  /// Gets the date and time when the event occurred.
  /// </summary>
  DateTime? get TimeStamp => this.timestamp;

  /// <summary>
  /// Gets the Id of the parent folder of the item or folder this event applie to.
  /// </summary>
  FolderId? get ParentFolderId => this.parentFolderId;

  set ParentFolderId(FolderId? value) => this.parentFolderId = value;

  /// <summary>
  /// Gets the Id of the old parent folder of the item or folder this event applies to.
  /// OldParentFolderId is only meaningful when EventType is equal to either EventType.Moved or
  /// EventType.Copied. For all other event types, OldParentFolderId is null.
  /// </summary>
  FolderId? get OldParentFolderId => this.oldParentFolderId;

  set OldParentFolderId(FolderId? value) => this.oldParentFolderId = value;
}
