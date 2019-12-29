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

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ServiceResult.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents the response to an individual item update operation.
/// </summary>
class UpdateItemResponse extends ServiceResponse {
  Item _item;

  Item _returnedItem;

  int _conflictCount;

  /// <summary>
  /// Initializes a new instance of the <see cref="UpdateItemResponse"/> class.
  /// </summary>
  /// <param name="item">The item.</param>
  UpdateItemResponse(Item item) : super() {
    EwsUtilities.Assert(
        item != null, "UpdateItemResponse.ctor", "item is null");

    this._item = item;
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    super.ReadElementsFromXml(reader);

    reader.ReadServiceObjectsCollectionFromXml<Item>(
        XmlElementNames.Items,
        this._GetObjectInstance,
        false,
        /* clearPropertyBag */
        null,
        /* requestedPropertySet */
        false); /* summaryPropertiesOnly */

    // ConflictResults was only added in 2007 SP1 so if this was a 2007 RTM request we shouldn't expect to find the element
    if (!reader.Service.Exchange2007CompatibilityMode) {
      reader.ReadStartElementWithNamespace(
          XmlNamespace.Messages, XmlElementNames.ConflictResults);
      this._conflictCount = reader.ReadElementValueWithNamespace<int>(
          XmlNamespace.Types, XmlElementNames.Count);
      reader.ReadEndElementWithNamespace(
          XmlNamespace.Messages, XmlElementNames.ConflictResults);
    }

    // If UpdateItem returned an item that has the same Id as the item that
    // is being updated, this is a "normal" UpdateItem operation, and we need
    // to update the ChangeKey of the item being updated with the one that was
    // returned. Also set returnedItem to indicate that no new item was returned.
    //
    // Otherwise, this in a "special" UpdateItem operation, such as a recurring
    // task marked as complete (the returned item in that case is the one-off
    // task that represents the completed instance).
    //
    // Note that there can be no returned item at all, as in an UpdateItem call
    // with MessageDisposition set to SendOnly or SendAndSaveCopy.
    if (this._returnedItem != null) {
      if (this._item.Id.UniqueId == this._returnedItem.Id.UniqueId) {
        this._item.Id.ChangeKey = this._returnedItem.Id.ChangeKey;
        this._returnedItem = null;
      }
    }
  }

  /// <summary>
  /// Clears the change log of the created folder if the creation succeeded.
  /// </summary>
  @override
  void Loaded() {
    if (this.Result == ServiceResult.Success) {
      this._item.ClearChangeLog();
    }
  }

  /// <summary>
  /// Gets Item instance.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>Item.</returns>
  Item _GetObjectInstance(ExchangeService service, String xmlElementName) {
    this._returnedItem = EwsUtilities.CreateEwsObjectFromXmlElementName<Item>(
        service, xmlElementName);

    return this._returnedItem;
  }

  /// <summary>
  /// Gets the item that was returned by the update operation. ReturnedItem is set only when a recurring Task
  /// is marked as complete or when its recurrence pattern changes.
  /// </summary>
  Item get ReturnedItem => this._returnedItem;

  /// <summary>
  /// Gets the number of property conflicts that were resolved during the update operation.
  /// </summary>
  int get ConflictCount => this._conflictCount;
}
