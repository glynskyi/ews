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

import 'package:ews/ComplexProperties/HighlightTerm.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Search/FindItemsResults.dart';
import 'package:ews/Search/GroupedFindItemsResults.dart';
import 'package:ews/Search/ItemGroup.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents the response to a item search operation.
/// </summary>
/// <typeparam name="TItem">The type of items that the opeartion returned.</typeparam>
class FindItemResponse<TItem extends Item> extends ServiceResponse {
  FindItemsResults<TItem> _results;

  bool _isGrouped;

  GroupedFindItemsResults<TItem> _groupedFindResults;

  PropertySet _propertySet;

  /// <summary>
  /// Initializes a new instance of the <see cref="FindItemResponse&lt;TItem&gt;"/> class.
  /// </summary>
  /// <param name="isGrouped">if set to <c>true</c> if grouped.</param>
  /// <param name="propertySet">The property set.</param>
  FindItemResponse(bool isGrouped, PropertySet propertySet) : super() {
    this._isGrouped = isGrouped;
    this._propertySet = propertySet;

    EwsUtilities.Assert(this._propertySet != null, "FindItemResponse.ctor",
        "PropertySet should not be null");
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    reader.ReadStartElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.RootFolder);

    int totalItemsInView =
        reader.ReadAttributeValue<int>(XmlAttributeNames.TotalItemsInView);
    bool moreItemsAvailable = !reader.ReadAttributeValue<bool>(
        XmlAttributeNames.IncludesLastItemInRange);

    // Ignore IndexedPagingOffset attribute if moreItemsAvailable is false.
    int nextPageOffset = moreItemsAvailable
        ? reader.ReadNullableAttributeValue<int>(
            XmlAttributeNames.IndexedPagingOffset)
        : null;

    if (!this._isGrouped) {
      this._results = new FindItemsResults<TItem>();
      this._results.TotalCount = totalItemsInView;
      this._results.NextPageOffset = nextPageOffset;
      this._results.MoreAvailable = moreItemsAvailable;
      _InternalReadItemsFromXml(reader, this._propertySet, this._results.Items);
    } else {
      this._groupedFindResults = new GroupedFindItemsResults<TItem>();
      this._groupedFindResults.TotalCount = totalItemsInView;
      this._groupedFindResults.NextPageOffset = nextPageOffset;
      this._groupedFindResults.MoreAvailable = moreItemsAvailable;

      reader.ReadStartElementWithNamespace(
          XmlNamespace.Types, XmlElementNames.Groups);

      if (!reader.IsEmptyElement) {
        do {
          reader.Read();

          if (reader.IsStartElementWithNamespace(
              XmlNamespace.Types, XmlElementNames.GroupedItems)) {
            String groupIndex = reader.ReadElementValueWithNamespace(
                XmlNamespace.Types, XmlElementNames.GroupIndex);

            List<TItem> itemList = <TItem>[];
            _InternalReadItemsFromXml(reader, this._propertySet, itemList);

            reader.ReadEndElementWithNamespace(
                XmlNamespace.Types, XmlElementNames.GroupedItems);

            this
                ._groupedFindResults
                .ItemGroups
                .add(new ItemGroup<TItem>(groupIndex, itemList));
          }
        } while (!reader.IsEndElementWithNamespace(
            XmlNamespace.Types, XmlElementNames.Groups));
      }
    }

    reader.ReadEndElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.RootFolder);

    reader.Read();

    if (reader.IsStartElementWithNamespace(
            XmlNamespace.Messages, XmlElementNames.HighlightTerms) &&
        !reader.IsEmptyElement) {
      do {
        reader.Read();

        if (reader.NodeType == XmlNodeType.Element) {
          HighlightTerm term = new HighlightTerm();

          term.LoadFromXmlWithNamespace(
              reader, XmlNamespace.Types, XmlElementNames.HighlightTerm);
          this._results.HighlightTerms.add(term);
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Messages, XmlElementNames.HighlightTerms));
    }
  }

  /// <summary>
  /// Read items from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="propertySet">The property set.</param>
  /// <param name="destinationList">The list in which to add the read items.</param>
  static void _InternalReadItemsFromXml<TItem extends Item>(
      EwsServiceXmlReader reader,
      PropertySet propertySet,
      List<TItem> destinationList) {
    EwsUtilities.Assert(
        destinationList != null,
        "FindItemResponse.InternalReadItemsFromXml",
        "destinationList is null.");

    reader.ReadStartElementWithNamespace(
        XmlNamespace.Types, XmlElementNames.Items);
    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if (reader.NodeType == XmlNodeType.Element) {
          TItem item = EwsUtilities.CreateEwsObjectFromXmlElementName<TItem>(
              reader.Service, reader.LocalName);

          if (item == null) {
            reader.SkipCurrentElement();
          } else {
            item.LoadFromXmlWithPropertySet(
                reader,
                true,
                /* clearPropertyBag */
                propertySet,
                true /* summaryPropertiesOnly */);

            destinationList.add(item);
          }
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Types, XmlElementNames.Items));
    }
  }

  /// <summary>
  /// Creates an item instance.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>Item</returns>
  TItem _CreateItemInstance(ExchangeService service, String xmlElementName) {
    return EwsUtilities.CreateEwsObjectFromXmlElementName<TItem>(
        service, xmlElementName);
  }

  /// <summary>
  /// Gets a grouped list of items matching the specified search criteria that were found in Exchange. ItemGroups is
  /// null if the search operation did not specify grouping options.
  /// </summary>
  GroupedFindItemsResults<TItem> get GroupedFindResults =>
      this._groupedFindResults;

  /// <summary>
  /// Gets the results of the search operation.
  /// </summary>
  FindItemsResults<TItem> get Results => this._results;
}
