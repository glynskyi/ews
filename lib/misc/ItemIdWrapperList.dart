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

import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart' as serviceObjects;
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/AbstractItemIdWrapper.dart';
import 'package:ews/misc/ItemIdWrapper.dart';
import 'package:ews/misc/ItemWrapper.dart';

/// <summary>
/// Represents a list a abstracted item Ids.
/// </summary>
class ItemIdWrapperList
    with IterableMixin<AbstractItemIdWrapper>
    implements Iterable<AbstractItemIdWrapper> {
  /// <summary>
  /// List of <see cref="Microsoft.Exchange.WebServices.Data.Item"/>.
  /// </summary>
  /* private */
  List<AbstractItemIdWrapper> itemIds = <AbstractItemIdWrapper>[];

  /// <summary>
  /// Initializes a new instance of the <see cref="ItemIdWrapperList"/> class.
  /// </summary>
  ItemIdWrapperList() {}

  /// <summary>
  /// Adds the specified item.
  /// </summary>
  /// <param name="item">The item.</param>
  void Add(serviceObjects.Item item) {
    this.itemIds.add(new ItemWrapper(item));
  }

  /// <summary>
  /// Adds the range.
  /// </summary>
  /// <param name="items">The items.</param>
  void AddRange(Iterable<serviceObjects.Item> items) {
    for (serviceObjects.Item item in items) {
      this.Add(item);
    }
  }

  /// <summary>
  /// Adds the specified item id.
  /// </summary>
  /// <param name="itemId">The item id.</param>
  void AddItemId(ItemId itemId) {
    this.itemIds.add(new ItemIdWrapper(itemId));
  }

  /// <summary>
  /// Adds the range.
  /// </summary>
  /// <param name="itemIds">The item ids.</param>
  void AddRangeItemIds(Iterable<ItemId> itemIds) {
    for (ItemId itemId in itemIds) {
      this.AddItemId(itemId);
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

      for (AbstractItemIdWrapper itemIdWrapper in this.itemIds) {
        itemIdWrapper.WriteToXml(writer);
      }

      writer.WriteEndElement();
    }
  }

  /// <summary>
  /// Gets the count.
  /// </summary>
  /// <value>The count.</value>
  int get Count => this.itemIds.length;

  /// <summary>
  /// Gets the <see cref="Microsoft.Exchange.WebServices.Data.Item"/> at the specified index.
  /// </summary>
  /// <param name="index">the index</param>
  serviceObjects.Item operator [](int index) {
    return this.itemIds[index].GetItem();
  }

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
  ///
  @override
  // TODO: implement iterator
  Iterator<AbstractItemIdWrapper> get iterator => this.itemIds.iterator;

//
// IEnumerator<AbstractItemIdWrapper> GetEnumerator()
//        {
//            return this.itemIds.GetEnumerator();
//        }

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
//        System.Collections.IEnumerator System.Collections.Iterable.GetEnumerator()
//        {
//            return this.itemIds.GetEnumerator();
//        }
}
