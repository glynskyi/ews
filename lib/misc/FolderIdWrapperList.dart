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

import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ServiceObjects/Folders/Folder.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/AbstractFolderIdWrapper.dart';
import 'package:ews/misc/FolderIdWrapper.dart';
import 'package:ews/misc/FolderWrapper.dart';

/// <summary>
/// Represents a list a abstracted folder Ids.
/// </summary>
class FolderIdWrapperList
    with IterableMixin<AbstractFolderIdWrapper>
    implements Iterable<AbstractFolderIdWrapper> {
  /// <summary>
  /// List of <see cref="Microsoft.Exchange.WebServices.Data.AbstractFolderIdWrapper"/>.
  /// </summary>
  List<AbstractFolderIdWrapper> _ids = new List<AbstractFolderIdWrapper>();

  /// <summary>
  /// Adds the specified folder.
  /// </summary>
  /// <param name="folder">The folder.</param>
  void Add(Folder folder) {
    this._ids.add(new FolderWrapper(folder));
  }

  /// <summary>
  /// Adds the range.
  /// </summary>
  /// <param name="folders">The folders.</param>
  void AddRange(Iterable<Folder> folders) {
    if (folders != null) {
      for (Folder folder in folders) {
        this.Add(folder);
      }
    }
  }

  /// <summary>
  /// Adds the specified folder id.
  /// </summary>
  /// <param name="folderId">The folder id.</param>
  void AddFolderId(FolderId folderId) {
    this._ids.add(new FolderIdWrapper(folderId));
  }

  /// <summary>
  /// Adds the range of folder ids.
  /// </summary>
  /// <param name="folderIds">The folder ids.</param>
  void AddRangeFolderIds(Iterable<FolderId> folderIds) {
    if (folderIds != null) {
      for (FolderId folderId in folderIds) {
        this.AddFolderId(folderId);
      }
    }
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsNamesapce">The ews namesapce.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void WriteToXml(EwsServiceXmlWriter writer, XmlNamespace ewsNamesapce,
      String xmlElementName) {
    if (this.Count > 0) {
      writer.WriteStartElement(ewsNamesapce, xmlElementName);

      for (AbstractFolderIdWrapper folderIdWrapper in this._ids) {
        folderIdWrapper.WriteToXml(writer);
      }

      writer.WriteEndElement();
    }
  }

  /// <summary>
  /// Gets the id count.
  /// </summary>
  /// <value>The count.</value>
  int get Count => this._ids.length;

  /// <summary>
  /// Gets the <see cref="Microsoft.Exchange.WebServices.Data.AbstractFolderIdWrapper"/> at the specified index.
  /// </summary>
  /// <param name="index">the index</param>
  AbstractFolderIdWrapper operator [](int index) {
    return this._ids[index];
  }

  /// <summary>
  /// Validates list of folderIds against a specified request version.
  /// </summary>
  /// <param name="version">The version.</param>
  void Validate(ExchangeVersion version) {
    for (AbstractFolderIdWrapper folderIdWrapper in this._ids) {
      folderIdWrapper.Validate(version);
    }
  }

  @override
  Iterator<AbstractFolderIdWrapper> get iterator => this._ids.iterator;
}
