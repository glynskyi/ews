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

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/Requests/ServiceRequestBase.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ItemTraversal.dart';
import 'package:ews/Enumerations/OffsetBasePoint.dart';
import 'package:ews/Enumerations/ServiceObjectType.dart';
import 'package:ews/Search/Grouping.dart';
import 'package:ews/Search/OrderByCollection.dart';
import 'package:ews/Search/PagedView.dart';

/// <summary>
/// Represents the view settings in a folder search operation.
/// </summary>
class ItemView extends PagedView {
  ItemTraversal _traversal;

  OrderByCollection _orderBy = new OrderByCollection();

  /// <summary>
  /// Gets the name of the view XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetViewXmlElementName() {
    return XmlElementNames.IndexedPageItemView;
  }

  /// <summary>
  /// Gets the type of service object this view applies to.
  /// </summary>
  /// <returns>A ServiceObjectType value.</returns>
  @override
  ServiceObjectType GetServiceObjectType() {
    return ServiceObjectType.Item;
  }

  /// <summary>
  /// Validates this view.
  /// </summary>
  @override
  void InternalValidate(ServiceRequestBase request) {
    super.InternalValidate(request);

    EwsUtilities.ValidateEnumVersionValue(
        this._traversal, request.Service.RequestedServerVersion);
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    writer.WriteAttributeValue(XmlAttributeNames.Traversal, this.Traversal);
  }

  /// <summary>
  /// Internals the write search settings to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="groupBy">The group by.</param>
  @override
  void InternalWriteSearchSettingsToXml(
      EwsServiceXmlWriter writer, Grouping groupBy) {
    super.InternalWriteSearchSettingsToXml(writer, groupBy);
  }

  /// <summary>
  /// Writes OrderBy property to XML.
  /// </summary>
  /// <param name="writer">The writer</param>
  @override
  void WriteOrderByToXml(EwsServiceXmlWriter writer) {
    this._orderBy.WriteToXml(writer, XmlElementNames.SortOrder);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ItemView"/> class.
  /// </summary>
  /// <param name="pageSize">The maximum number of elements the search operation should return.</param>
  ItemView.withPageSize(int pageSize) : super.withPageSize(pageSize) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="ItemView"/> class.
  /// </summary>
  /// <param name="pageSize">The maximum number of elements the search operation should return.</param>
  /// <param name="offset">The offset of the view from the base point.</param>
  ItemView.withPageSizeAndOffset(int pageSize, int offset)
      : super.withPageSizeAndOffset(pageSize, offset) {
    this.Offset = offset;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ItemView"/> class.
  /// </summary>
  /// <param name="pageSize">The maximum number of elements the search operation should return.</param>
  /// <param name="offset">The offset of the view from the base point.</param>
  /// <param name="offsetBasePoint">The base point of the offset.</param>
  ItemView.withPageSizeAndOffsetAndBasePoint(
      int pageSize, int offset, OffsetBasePoint offsetBasePoint)
      : super.withPageSizeAndOffsetAndBasePoint(
            pageSize, offset, offsetBasePoint) {}

  /// <summary>
  /// Gets or sets the search traversal mode. Defaults to ItemTraversal.Shallow.
  /// </summary>
  ItemTraversal get Traversal => this._traversal;

  set Traversal(ItemTraversal value) => this._traversal = value;

  /// <summary>
  /// Gets the properties against which the returned items should be ordered.
  /// </summary>
  OrderByCollection get OrderBy => this._orderBy;
}
