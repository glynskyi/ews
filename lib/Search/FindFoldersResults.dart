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

import 'package:ews/Core/ServiceObjects/Folders/Folder.dart';

/// <summary>
/// Represents the results of a folder search operation.
/// </summary>
class FindFoldersResults extends Iterable<Folder> with IterableMixin<Folder> {
  int _totalCount;

  int _nextPageOffset;

  bool _moreAvailable = false;

  List<Folder> _folders = <Folder>[];

  /// <summary>
  /// Initializes a new instance of the <see cref="FindFoldersResults"/> class.
  /// </summary>
  FindFoldersResults() {}

  /// <summary>
  /// Gets the total number of folders matching the search criteria available in the searched folder.
  /// </summary>
  int get TotalCount => this._totalCount;

  set TotalCount(int value) => this._totalCount = value;

  /// <summary>
  /// Gets the offset that should be used with FolderView to retrieve the next page of folders in a FindFolders operation.
  /// </summary>
  int get NextPageOffset => this._nextPageOffset;

  set NextPageOffset(int value) => this._nextPageOffset = value;

  /// <summary>
  /// Gets a value indicating whether more folders matching the search criteria.
  /// are available in the searched folder.
  /// </summary>
  bool get MoreAvailable => this._moreAvailable;

  set MoreAvailable(bool value) => this._moreAvailable = value;

  /// <summary>
  /// Gets a collection containing the folders that were found by the search operation.
  /// </summary>
  List<Folder> get Folders => this._folders;

  set Folders(List<Folder> value) => this._folders = value;

  /// <summary>
  /// Returns an enumerator that iterates through the collection.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.Collections.Generic.IEnumerator`1"/> that can be used to iterate through the collection.
  /// </returns>
  @override
  Iterator<Folder> get iterator => this._folders.iterator;
}
