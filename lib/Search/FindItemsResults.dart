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

import 'package:ews/ComplexProperties/HighlightTerm.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';

/// <summary>
/// Represents the results of an item search operation.
/// </summary>
/// <typeparam name="TItem">The type of item returned by the search operation.</typeparam>
class FindItemsResults<TItem extends Item>
    with IterableMixin<TItem>
    implements Iterable<TItem> {
  /* private */
  int totalCount = 0;

  /* private */
  int nextPageOffset;

  /* private */
  bool moreAvailable = false;

  /* private */
  List<TItem> items = new List<TItem>();

  /* private */
  List<HighlightTerm> highlightTerms = new List<HighlightTerm>();

  /// <summary>
  /// Initializes a new instance of the <see cref="FindItemsResults&lt;T&gt;"/> class.
  /// </summary>
  FindItemsResults() {}

  /// <summary>
  /// Gets the total number of items matching the search criteria available in the searched folder.
  /// </summary>
  int get TotalCount => this.totalCount;

  set TotalCount(int value) => this.totalCount = value;

  /// <summary>
  /// Gets the offset that should be used with ItemView to retrieve the next page of items in a FindItems operation.
  /// </summary>
  int get NextPageOffset => this.nextPageOffset;

  set NextPageOffset(int value) => this.nextPageOffset = value;

  /// <summary>
  /// Gets a value indicating whether more items matching the search criteria
  /// are available in the searched folder.
  /// </summary>
  bool get MoreAvailable => this.moreAvailable;

  set MoreAvailable(bool value) => this.moreAvailable = value;

  /// <summary>
  /// Gets a collection containing the items that were found by the search operation.
  /// </summary>
  List<TItem> get Items => this.items;

  /// <summary>
  /// Gets a collection containing the highlight terms that were found by the search operation.
  /// </summary>
  List<HighlightTerm> get HighlightTerms => this.highlightTerms;

  @override
  Iterator<TItem> get iterator => this.items.iterator;
}
