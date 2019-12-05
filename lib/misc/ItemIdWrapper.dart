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

import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/misc/AbstractItemIdWrapper.dart';

/// <summary>
/// Represents an item Id provided by a ItemId object.
/// </summary>
class ItemIdWrapper extends AbstractItemIdWrapper {
  /// <summary>
  /// The ItemId object providing the Id.
  /// </summary>
  ItemId _itemId;

  /// <summary>
  /// Initializes a new instance of ItemIdWrapper.
  /// </summary>
  /// <param name="itemId">The ItemId object providing the Id.</param>
  ItemIdWrapper(ItemId itemId) {
    EwsUtilities.Assert(itemId != null, "ItemIdWrapper.ctor", "itemId is null");

    this._itemId = itemId;
  }

  /// <summary>
  /// Writes the Id encapsulated in the wrapper to XML.
  /// </summary>
  /// <param name="writer">The writer to write the Id to.</param>
  @override
  void WriteToXml(EwsServiceXmlWriter writer) {
    this._itemId.WriteToXmlElemenetName(writer);
  }
}
