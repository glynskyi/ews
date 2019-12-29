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
import 'package:ews/Enumerations/ServiceObjectType.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/Search/Grouping.dart';
import 'package:ews/Search/ViewBase.dart';

/// <summary>
/// Represents a date range view of appointments in calendar folder search operations.
/// </summary>
class CalendarView extends ViewBase {
  ItemTraversal _traversal = ItemTraversal.Shallow;

  int _maxItemsReturned;

  DateTime _startDate;

  DateTime _endDate;

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    writer.WriteAttributeValue(XmlAttributeNames.Traversal, this.Traversal);
  }

  /// <summary>
  /// Writes the search settings to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="groupBy">The group by clause.</param>
  @override
  void InternalWriteSearchSettingsToXml(
      EwsServiceXmlWriter writer, Grouping groupBy) {
    // No search settings for calendar views.
  }

  /// <summary>
  /// Writes OrderBy property to XML.
  /// </summary>
  /// <param name="writer">The writer</param>
  @override
  void WriteOrderByToXml(EwsServiceXmlWriter writer) {
    // No OrderBy for calendar views.
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
  /// Initializes a new instance of CalendarView.
  /// </summary>
  /// <param name="startDate">The start date.</param>
  /// <param name="endDate">The end date.</param>
  CalendarView(DateTime startDate, DateTime endDate) : super() {
    this._startDate = startDate;
    this._endDate = endDate;
  }

  /// <summary>
  /// Initializes a new instance of CalendarView.
  /// </summary>
  /// <param name="startDate">The start date.</param>
  /// <param name="endDate">The end date.</param>
  /// <param name="maxItemsReturned">The maximum number of items the search operation should return.</param>
  CalendarView.withMaxItemsReturned(
      DateTime startDate, DateTime endDate, int maxItemsReturned)
      : super() {
    this._startDate = startDate;
    this._endDate = endDate;
    this.MaxItemsReturned = maxItemsReturned;
  }

  /// <summary>
  /// Validate instance.
  /// </summary>
  @override
  void InternalValidate(ServiceRequestBase request) {
    super.InternalValidate(request);

    // todo : review time comparision
    if (this._endDate.millisecondsSinceEpoch <
        this.StartDate.millisecondsSinceEpoch) {
      throw new ServiceValidationException(
          "Strings.EndDateMustBeGreaterThanStartDate");
    }
  }

  /// <summary>
  /// Write to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void InternalWriteViewToXml(EwsServiceXmlWriter writer) {
    super.InternalWriteViewToXml(writer);

    writer.WriteAttributeValue(XmlAttributeNames.StartDate, this.StartDate);
    writer.WriteAttributeValue(XmlAttributeNames.EndDate, this.EndDate);
  }

  /// <summary>
  /// Gets the name of the view XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetViewXmlElementName() {
    return XmlElementNames.CalendarView;
  }

  /// <summary>
  /// Gets the maximum number of items or folders the search operation should return.
  /// </summary>
  /// <returns>The maximum number of items the search operation should return.
  /// </returns>
  @override
  int GetMaxEntriesReturned() {
    return this.MaxItemsReturned;
  }

  /// <summary>
  /// Gets or sets the start date.
  /// </summary>
  DateTime get StartDate => this._startDate;

  set StartDate(DateTime value) => this._startDate = value;

  /// <summary>
  /// Gets or sets the end date.
  /// </summary>
  DateTime get EndDate => this._endDate;

  set EndDate(DateTime value) => this._endDate = value;

  /// <summary>
  /// The maximum number of items the search operation should return.
  /// </summary>
  int get MaxItemsReturned => this._maxItemsReturned;

  set MaxItemsReturned(int value) {
    if (value != null) {
      if (value <= 0) {
        throw new ArgumentError("Strings.ValueMustBeGreaterThanZero");
      }
    }

    this._maxItemsReturned = value;
  }

  /// <summary>
  /// Gets or sets the search traversal mode. Defaults to ItemTraversal.Shallow.
  /// </summary>
  ItemTraversal get Traversal => this._traversal;

  set Traversal(ItemTraversal value) => this._traversal = value;
}
