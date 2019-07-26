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

import 'dart:collection';

import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Sync/Change.dart';

/// <summary>
/// Represents a collection of changes as returned by a synchronization operation.
/// </summary>
/// <typeparam name="TChange">Type representing the type of change (e.g. FolderChange or ItemChange)</typeparam>
class ChangeCollection<TChange extends Change> with IterableMixin<TChange> implements Iterable<TChange> {
  /* private */
  List<TChange> changes = new List<TChange>();

  /* private */
  String syncState;

  /* private */
  bool moreChangesAvailable;

  /// <summary>
  /// Initializes a new instance of the <see cref="ChangeCollection&lt;TChange&gt;"/> class.
  /// </summary>
  ChangeCollection() {}

  /// <summary>
  /// Adds the specified change.
  /// </summary>
  /// <param name="change">The change.</param>
  void Add(TChange change) {
    EwsUtilities.Assert(change != null, "ChangeList.Add", "change is null");

    this.changes.add(change);
  }

  /// <summary>
  /// Gets the number of changes in the collection.
  /// </summary>
  int get Count => this.changes.length;

  /// <summary>
  /// Gets an individual change from the change collection.
  /// </summary>
  /// <param name="index">Zero-based index.</param>
  /// <returns>An single change.</returns>
  TChange operator [](int index) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.range(index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
    }

    return this.changes[index];
  }

  /// <summary>
  /// Gets the SyncState blob returned by a synchronization operation.
  /// </summary>
  String get SyncState => this.syncState;

  set SyncState(String value) {
    this.syncState = value;
  }

  /// <summary>
  /// Gets a value indicating whether the there are more changes to be synchronized from the server.
  /// </summary>
  bool get MoreChangesAvailable => this.moreChangesAvailable;

  set MoreChangesAvailable(bool value) {
    this.moreChangesAvailable = value;
  }

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
  @override
  Iterator<TChange> get iterator => this.changes.iterator;
}
