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
import 'package:ews/ComplexProperties/ItemId.dart' as complex;
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/EventType.dart';
import 'package:ews/Notifications/NotificationEvent.dart';

/// <summary>
/// Represents an event that applies to an item.
/// </summary>
class ItemEvent extends NotificationEvent {
  /// <summary>
  /// Id of the item this event applies to.
  /// </summary>
  complex.ItemId _itemId;

  /// <summary>
  /// Id of the item that moved or copied. This is only meaningful when EventType
  /// is equal to either EventType.Moved or EventType.Copied. For all other event
  /// types, it's null.
  /// </summary>
  complex.ItemId _oldItemId;

  /// <summary>
  /// Initializes a new instance of the <see cref="ItemEvent"/> class.
  /// </summary>
  /// <param name="eventType">Type of the event.</param>
  /// <param name="timestamp">The event timestamp.</param>
  ItemEvent(EventType eventType, DateTime timestamp) : super(eventType, timestamp) {}

  /// <summary>
  /// Load from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void InternalLoadFromXml(EwsServiceXmlReader reader) {
    super.InternalLoadFromXml(reader);

    this._itemId = new complex.ItemId();
    this._itemId.LoadFromXml(reader, reader.LocalName);

    reader.Read();

    this.ParentFolderId = new FolderId();
    this.ParentFolderId.LoadFromXml(reader, XmlElementNames.ParentFolderId);

    switch (this.EventType) {
      case EventType.Moved:
      case EventType.Copied:
        reader.Read();

        this._oldItemId = new complex.ItemId();
        this._oldItemId.LoadFromXml(reader, reader.LocalName);

        reader.Read();

        this.OldParentFolderId = new FolderId();
        this.OldParentFolderId.LoadFromXml(reader, reader.LocalName);
        break;

      default:
        break;
    }
  }

  /// <summary>
  /// Gets the Id of the item this event applies to.
  /// </summary>
  complex.ItemId get ItemId => this._itemId;

  /// <summary>
  /// Gets the Id of the item that was moved or copied. OldItemId is only meaningful
  /// when EventType is equal to either EventType.Moved or EventType.Copied. For
  /// all other event types, OldItemId is null.
  /// </summary>
  complex.ItemId get OldItemId => this._oldItemId;
}
