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

import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/Responses/SyncResponse.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Sync/ItemChange.dart';

/// <summary>
/// Represents the response to a folder items synchronization operation.
/// </summary>
class SyncFolderItemsResponse extends SyncResponse<Item, ItemChange> {
  /// <summary>
  /// Initializes a new instance of the <see cref="SyncFolderItemsResponse"/> class.
  /// </summary>
  /// <param name="propertySet">PropertySet from request.</param>
  SyncFolderItemsResponse(PropertySet? propertySet) : super(propertySet) {}

  /// <summary>
  /// Gets the name of the includes last in range XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetIncludesLastInRangeXmlElementName() {
    return XmlElementNames.IncludesLastItemInRange;
  }

  /// <summary>
  /// Creates an item change instance.
  /// </summary>
  /// <returns>ItemChange instance</returns>
  @override
  ItemChange CreateChangeInstance() {
    return new ItemChange();
  }

  /// <summary>
  /// Gets the name of the change element.
  /// </summary>
  /// <returns>Change element name.</returns>
  @override
  String GetChangeElementName() {
    return XmlElementNames.Item;
  }

  /// <summary>
  /// Gets the name of the change id element.
  /// </summary>
  /// <returns>Change id element name.</returns>
  @override
  String GetChangeIdElementName() {
    return XmlElementNames.ItemId;
  }

  /// <summary>
  /// Gets a value indicating whether this request returns full or summary properties.
  /// </summary>
  /// <value>
  /// <c>true</c> if summary properties only; otherwise, <c>false</c>.
  /// </value>
  @override
  bool get SummaryPropertiesOnly => true;
}
