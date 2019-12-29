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

import 'package:ews/ComplexProperties/ComplexPropertyCollection.dart';
import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart';

/// <summary>
/// Represents a collection of folder Ids.
/// </summary>
class FolderIdCollection extends ComplexPropertyCollection<FolderId> {
  /// <summary>
  /// Initializes a new instance of the <see cref="FolderIdCollection"/> class.
  /// </summary>
  FolderIdCollection() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderIdCollection"/> class.
  /// </summary>
  /// <param name="folderIds">The folder ids to include.</param>
  FolderIdCollection.withFolderIds(Iterable<FolderId> folderIds) {
    if (folderIds != null) {
      folderIds.forEach((folderId) => this.InternalAdd(folderId));
    }
  }

  /// <summary>
  /// Creates the complex property.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>FolderId.</returns>
  @override
  FolderId CreateComplexProperty(String xmlElementName) {
    return new FolderId();
  }

  /// <summary>
  /// Gets the name of the collection item XML element.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  /// <returns>XML element name.</returns>
  @override
  String GetCollectionItemXmlElementName(FolderId complexProperty) {
    return complexProperty.GetXmlElementName();
  }

  /// <summary>
  /// Adds a folder Id to the collection.
  /// </summary>
  /// <param name="folderId">The folder Id to add.</param>
  void AddWithFolderId(FolderId folderId) {
    EwsUtilities.ValidateParam(folderId, "folderId");

    if (this.Contains(folderId)) {
      throw new ArgumentError("""Strings.IdAlreadyInList, "folderId""" "");
    }

    this.InternalAdd(folderId);
  }

  /// <summary>
  /// Adds a well-known folder to the collection.
  /// </summary>
  /// <param name="folderName">The well known folder to add.</param>
  /// <returns>A FolderId encapsulating the specified Id.</returns>
  FolderId AddWithWellKnownFolder(WellKnownFolderName folderName) {
    if (this.contains(folderName)) {
      throw new ArgumentError("""Strings.IdAlreadyInList, "folderName""" "");
    }

    FolderId folderId = new FolderId.fromWellKnownFolder(folderName);

    this.InternalAdd(folderId);

    return folderId;
  }

  /// <summary>
  /// Clears the collection.
  /// </summary>
  void Clear() {
    this.InternalClear();
  }

  /// <summary>
  /// Removes the folder Id at the specified index.
  /// </summary>
  /// <param name="index">The zero-based index of the folder Id to remove.</param>
  void RemoveAt(int index) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.range(
          index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
    }

    this.InternalRemoveAt(index);
  }

  /// <summary>
  /// Removes the specified folder Id from the collection.
  /// </summary>
  /// <param name="folderId">The folder Id to remove from the collection.</param>
  /// <returns>True if the folder id was successfully removed from the collection, false otherwise.</returns>
  bool Remove(FolderId folderId) {
    EwsUtilities.ValidateParam(folderId, "folderId");

    return this.InternalRemove(folderId);
  }

  /// <summary>
  /// Removes the specified well-known folder from the collection.
  /// </summary>
  /// <param name="folderName">The well-knwon folder to remove from the collection.</param>
  /// <returns>True if the well-known folder was successfully removed from the collection, false otherwise.</returns>
//  bool RemoveWithWellKnownFolder(WellKnownFolderName folderName) {
//    return super.InternalRemove(folderName);
//  }
}
