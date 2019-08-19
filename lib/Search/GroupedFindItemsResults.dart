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

import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Search/ItemGroup.dart' as search;

/// <summary>
/// Represents the results of an item search operation.
/// </summary>
/// <typeparam name="TItem">The type of item returned by the search operation.</typeparam>
class GroupedFindItemsResults<TItem extends Item>
    with IterableMixin<search.ItemGroup<TItem>>
    implements Iterable<search.ItemGroup<TItem>> {
  int _totalCount = 0;

  int _nextPageOffset;

  bool _moreAvailable = false;

  /// <summary>
  /// List of ItemGroups.
  /// </summary>
  /* private */
  List<search.ItemGroup<TItem>> itemGroups = new List<search.ItemGroup<TItem>>();

  /// <summary>
  /// Initializes a new instance of the <see cref="GroupedFindItemsResults&lt;TItem&gt;"/> class.
  /// </summary>
  GroupedFindItemsResults() {}

  /// <summary>
  /// Gets the total number of items matching the search criteria available in the searched folder.
  /// </summary>
  int get TotalCount => this._totalCount;

  set TotalCount(int value) => this._totalCount = value;

  /// <summary>
  /// Gets the offset that should be used with ItemView to retrieve the next page of items in a FindItems operation.
  /// </summary>
  int get NextPageOffset => this._nextPageOffset;

  set NextPageOffset(int value) => this._nextPageOffset = value;

  /// <summary>
  /// Gets a value indicating whether more items corresponding to the search criteria
  /// are available in the searched folder.
  /// </summary>
  bool get MoreAvailable => this._moreAvailable;

  set MoreAvailable(bool value) => this._moreAvailable = value;

  /// <summary>
  /// Gets the item groups returned by the search operation.
  /// </summary>
  List<search.ItemGroup<TItem>> get ItemGroups => this.itemGroups;

  /// <summary>
  /// Returns an enumerator that iterates through the collection.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.Collections.Generic.IEnumerator`1"/> that can be used to iterate through the collection.
  /// </returns>
  @override
  Iterator<search.ItemGroup<TItem>> get iterator => this.itemGroups.iterator;
}
