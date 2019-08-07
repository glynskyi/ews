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
import 'package:ews/Enumerations/OffsetBasePoint.dart' as enumerations;
import 'package:ews/Search/Grouping.dart';
import 'package:ews/Search/ViewBase.dart';

/// <summary>
/// Represents a view settings that support paging in a search operation.
/// </summary>
abstract class PagedView extends ViewBase {
  /* private */
  int pageSize = 0;

  /* private */
  enumerations.OffsetBasePoint offsetBasePoint = enumerations.OffsetBasePoint.Beginning;

  /* private */
  int offset = 0;

  /// <summary>
  /// Write to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void InternalWriteViewToXml(EwsServiceXmlWriter writer) {
    super.InternalWriteViewToXml(writer);

    writer.WriteAttributeValue(XmlAttributeNames.Offset, this.Offset);
    writer.WriteAttributeValue(XmlAttributeNames.BasePoint, this.OffsetBasePoint);
  }

  /// <summary>
  /// Gets the maximum number of items or folders the search operation should return.
  /// </summary>
  /// <returns>The maximum number of items or folders that should be returned by the search operation.</returns>
  @override
  int GetMaxEntriesReturned() {
    return this.PageSize;
  }

  /// <summary>
  /// Internals the write search settings to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="groupBy">The group by clause.</param>
  @override
  void InternalWriteSearchSettingsToXml(EwsServiceXmlWriter writer, Grouping groupBy) {
    if (groupBy != null) {
      groupBy.WriteToXml(writer);
    }
  }

  /// <summary>
  /// Writes OrderBy property to XML.
  /// </summary>
  /// <param name="writer">The writer</param>
  @override
  void WriteOrderByToXml(EwsServiceXmlWriter writer) {
    // No order by for paged view
  }

  /// <summary>
  /// Validates this view.
  /// </summary>
  @override
  void InternalValidate(ServiceRequestBase request) {
    super.InternalValidate(request);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="PagedView"/> class.
  /// </summary>
  /// <param name="pageSize">The maximum number of elements the search operation should return.</param>
  PagedView.withPageSize(int pageSize) : super() {
    this.PageSize = pageSize;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="PagedView"/> class.
  /// </summary>
  /// <param name="pageSize">The maximum number of elements the search operation should return.</param>
  /// <param name="offset">The offset of the view from the base point.</param>
  PagedView.withPageSizeAndOffset(int pageSize, int offset) : super() {
    this.PageSize = pageSize;
    this.Offset = offset;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="PagedView"/> class.
  /// </summary>
  /// <param name="pageSize">The maximum number of elements the search operation should return.</param>
  /// <param name="offset">The offset of the view from the base point.</param>
  /// <param name="offsetBasePoint">The base point of the offset.</param>
  PagedView.withPageSizeAndOffsetAndBasePoint(int pageSize, int offset, enumerations.OffsetBasePoint offsetBasePoint)
      : super() {
    this.PageSize = pageSize;
    this.Offset = offset;
    this.OffsetBasePoint = offsetBasePoint;
  }

  /// <summary>
  /// The maximum number of items or folders the search operation should return.
  /// </summary>
  int get PageSize => this.pageSize;

  set PageSize(int value) {
    if (value <= 0) {
      throw new ArgumentError("Strings.ValueMustBeGreaterThanZero");
    }

    this.pageSize = value;
  }

  /// <summary>
  /// Gets or sets the base point of the offset.
  /// </summary>
  enumerations.OffsetBasePoint get OffsetBasePoint => this.offsetBasePoint;

  set OffsetBasePoint(enumerations.OffsetBasePoint value) => this.offsetBasePoint = value;

  /// <summary>
  /// Gets or sets the offset.
  /// </summary>
  int get Offset => this.offset;

  set Offset(int value) {
    if (value >= 0) {
      this.offset = value;
    } else {
      throw new ArgumentError("Strings.OffsetMustBeGreaterThanZero");
    }
  }
}
