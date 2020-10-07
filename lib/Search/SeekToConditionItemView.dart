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
import 'package:ews/Core/Requests/ServiceRequestBase.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ItemTraversal.dart';
import 'package:ews/Enumerations/OffsetBasePoint.dart' as enumerations;
import 'package:ews/Enumerations/ServiceObjectType.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Exceptions/ArgumentNullException.dart';
import 'package:ews/Search/Filters/SearchFilter.dart';
import 'package:ews/Search/Grouping.dart';
import 'package:ews/Search/OrderByCollection.dart';
import 'package:ews/Search/ViewBase.dart';

/// <summary>
/// Represents the view settings in a folder search operation.
/// </summary>
class SeekToConditionItemView extends ViewBase {
  /* private */ int pageSize;

  /* private */
  ItemTraversal traversal;

  /* private */
  SearchFilter condition;

  /* private */
  enumerations.OffsetBasePoint offsetBasePoint =
      enumerations.OffsetBasePoint.Beginning;

  /* private */
  OrderByCollection orderBy = new OrderByCollection();

  /* private */
  ServiceObjectType serviceObjType;

  /// <summary>
  /// Gets the type of service object this view applies to.
  /// </summary>
  /// <returns>A ServiceObjectType value.</returns>
  @override
  ServiceObjectType GetServiceObjectType() {
    return this.serviceObjType;
  }

  /// <summary>
  /// Sets the type of service object this view applies to.
  /// </summary>
  /// <param name="objType">Service object type</param>
  void SetServiceObjectType(ServiceObjectType objType) {
    this.serviceObjType = objType;
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    if (this.serviceObjType == ServiceObjectType.Item) {
      writer.WriteAttributeValue(XmlAttributeNames.Traversal, this.Traversal);
    }
  }

  /// <summary>
  /// Gets the name of the view XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetViewXmlElementName() {
    return XmlElementNames.SeekToConditionPageItemView;
  }

  /// <summary>
  /// Validates this view.
  /// </summary>
  @override
  void InternalValidate(ServiceRequestBase request) {
    super.InternalValidate(request);
  }

  /// <summary>
  /// Write to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void InternalWriteViewToXml(EwsServiceXmlWriter writer) {
    super.InternalWriteViewToXml(writer);

    writer.WriteAttributeValue(
        XmlAttributeNames.BasePoint, this.OffsetBasePoint);

    if (this.Condition != null) {
      writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Condition);
      this.Condition.WriteToXmlWithWriter(writer);
      writer.WriteEndElement(); // Restriction
    }
  }

  /// <summary>
  /// Internals the write search settings to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="groupBy">The group by.</param>
  @override
  void InternalWriteSearchSettingsToXml(
      EwsServiceXmlWriter writer, Grouping groupBy) {
    if (groupBy != null) {
      groupBy.WriteToXml(writer);
    }
  }

  /// <summary>
  /// Gets the maximum number of items or folders the search operation should return.
  /// </summary>
  /// <returns>The maximum number of items that should be returned by the search operation.</returns>
  @override
  int GetMaxEntriesReturned() {
    return this.PageSize;
  }

  /// <summary>
  /// Writes OrderBy property to XML.
  /// </summary>
  /// <param name="writer">The writer</param>
  @override
  void WriteOrderByToXml(EwsServiceXmlWriter writer) {
    this.orderBy.WriteToXml(writer, XmlElementNames.SortOrder);
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="groupBy">The group by clause.</param>
  @override
  void WriteToXml(EwsServiceXmlWriter writer, Grouping groupBy) {
    if (this.serviceObjType == ServiceObjectType.Item) {
      this
          .GetPropertySetOrDefault()
          .WriteToXml(writer, this.GetServiceObjectType());
    }

    writer.WriteStartElement(
        XmlNamespace.Messages, this.GetViewXmlElementName());

    this.InternalWriteViewToXml(writer);

    writer.WriteEndElement(); // this.GetViewXmlElementName()

    this.InternalWriteSearchSettingsToXml(writer, groupBy);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="SeekToConditionItemView"/> class.
  /// </summary>
  /// <param name="condition">Condition to be used when seeking.</param>
  /// <param name="pageSize">The maximum number of elements the search operation should return.</param>
  SeekToConditionItemView(SearchFilter condition, int pageSize) {
    this.Condition = condition;
    this.PageSize = pageSize;
    this.serviceObjType = ServiceObjectType.Item;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="SeekToConditionItemView"/> class.
  /// </summary>
  /// <param name="condition">Condition to be used when seeking.</param>
  /// <param name="pageSize">The maximum number of elements the search operation should return.</param>
  /// <param name="offsetBasePoint">The base point of the offset.</param>
  SeekToConditionItemView.withBasePoint(SearchFilter condition, int pageSize,
      enumerations.OffsetBasePoint offsetBasePoint) {
    this.Condition = condition;
    this.PageSize = pageSize;
    this.serviceObjType = ServiceObjectType.Item;
    this.OffsetBasePoint = offsetBasePoint;
  }

  /// <summary>
  /// The maximum number of items or folders the search operation should return.
  /// </summary>
  int get PageSize => this.pageSize;

  set PageSize(int value) {
    if (value <= 0) {
      throw new ArgumentException("ValueMustBeGreaterThanZero");
    }

    this.pageSize = value;
  }

  /// <summary>
  /// Gets or sets the base point of the offset.
  /// </summary>
  enumerations.OffsetBasePoint get OffsetBasePoint => this.offsetBasePoint;

  set OffsetBasePoint(enumerations.OffsetBasePoint value) =>
      this.offsetBasePoint = value;

  /// <summary>
  /// Gets or sets the condition for seek. Available search filter classes include SearchFilter.IsEqualTo,
  /// SearchFilter.ContainsSubString and SearchFilter.SearchFilterCollection. If SearchFilter
  /// is null, no search filters are applied.
  /// </summary>
  SearchFilter get Condition => this.condition;

  set Condition(SearchFilter value) {
    if (value == null) {
      throw new ArgumentNullException("Condition");
    }

    this.condition = value;
  }

  /// <summary>
  /// Gets or sets the search traversal mode. Defaults to ItemTraversal.Shallow.
  /// </summary>
  ItemTraversal get Traversal => this.traversal;

  set Traversal(ItemTraversal value) => this.traversal = value;

  /// <summary>
  /// Gets the properties against which the returned items should be ordered.
  /// </summary>
  OrderByCollection get OrderBy => this.orderBy;
}
