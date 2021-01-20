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

import 'package:ews/ComplexProperties/FolderId.dart' as complex;
import 'package:ews/ComplexProperties/ServiceId.dart';
import 'package:ews/Core/ServiceObjects/Folders/Folder.dart' as core;
import 'package:ews/Sync/Change.dart';

/// <summary>
/// Represents a change on a folder as returned by a synchronization operation.
/// </summary>
class FolderChange extends Change {
  /// <summary>
  /// Initializes a new instance of FolderChange.
  /// </summary>
  FolderChange() : super() {}

  /// <summary>
  /// Creates a FolderId instance.
  /// </summary>
  /// <returns>A FolderId.</returns>
  @override
  ServiceId CreateId() {
    return new complex.FolderId();
  }

  /// <summary>
  /// Gets the folder the change applies to. Folder is null when ChangeType is equal to
  /// ChangeType.Delete. In that case, use the FolderId property to retrieve the Id of
  /// the folder that was deleted.
  /// </summary>
  core.Folder? get Folder => this.ServiceObject as core.Folder?;

  /// <summary>
  /// Gets the Id of the folder the change applies to.
  /// </summary>
  complex.FolderId? get FolderId => this.Id as complex.FolderId?;
}
