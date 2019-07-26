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

import 'package:ews/ComplexProperties/ItemId.dart' as complex;
import 'package:ews/ComplexProperties/ServiceId.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart' as core;
import 'package:ews/Sync/Change.dart';

/// <summary>
/// Represents a change on an item as returned by a synchronization operation.
/// </summary>
class ItemChange extends Change {
  /* private */ bool isRead;

  /// <summary>
  /// Initializes a new instance of ItemChange.
  /// </summary>
  ItemChange() : super() {}

  /// <summary>
  /// Creates an ItemId instance.
  /// </summary>
  /// <returns>A ItemId.</returns>
  @override
  ServiceId CreateId() {
    return new complex.ItemId();
  }

  /// <summary>
  /// Gets the item the change applies to. Item is null when ChangeType is equal to
  /// either ChangeType.Delete or ChangeType.ReadFlagChange. In those cases, use the
  /// ItemId property to retrieve the Id of the item that was deleted or whose IsRead
  /// property changed.
  /// </summary>
  core.Item get Item => this.ServiceObject;

  /// <summary>
  /// Gets the IsRead property for the item that the change applies to. IsRead is
  /// only valid when ChangeType is equal to ChangeType.ReadFlagChange.
  /// </summary>
  bool get IsRead => this.isRead;

  set IsRead(bool value) {
    this.isRead = value;
  }

  /// <summary>
  /// Gets the Id of the item the change applies to.
  /// </summary>
  complex.ItemId get ItemId => this.Id;
}
