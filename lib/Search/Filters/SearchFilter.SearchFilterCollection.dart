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
import 'dart:core';

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Enumerations/LogicalOperator.dart' as enumerations;
import 'package:ews/Exceptions/ArgumentNullException.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/Search/Filters/SearchFilter.dart';
import 'package:ews/misc/Std/EnumToString.dart';

//    /// <content>
//    /// Contains nested type SearchFilter.SearchFilterCollection.
//    /// </content>
// abstract partial class SearchFilter
//    {

/// <summary>
/// Represents a collection of search filters linked by a logical operator. Applications can
/// use SearchFilterCollection to define complex search filters such as "Condition1 AND Condition2".
/// </summary>
class SearchFilterCollection extends SearchFilter
    with IterableMixin<SearchFilter>
    implements Iterable<SearchFilter> {
  List<SearchFilter> _searchFilters = <SearchFilter>[];

  enumerations.LogicalOperator _logicalOperator =
      enumerations.LogicalOperator.And;

  /// <summary>
  /// Initializes a new instance of the <see cref="SearchFilterCollection"/> class.
  /// The LogicalOperator property is initialized to LogicalOperator.And.
  /// </summary>
  SearchFilterCollection() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="SearchFilterCollection"/> class.
  /// </summary>
  /// <param name="logicalOperator">The logical operator used to initialize the collection.</param>
  SearchFilterCollection.withOperator(
      enumerations.LogicalOperator logicalOperator)
      : super() {
    this._logicalOperator = logicalOperator;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="SearchFilterCollection"/> class.
  /// </summary>
  /// <param name="logicalOperator">The logical operator used to initialize the collection.</param>
  /// <param name="searchFilters">The search filters to add to the collection.</param>
  SearchFilterCollection.withOperatorAndSearchFilters(
      enumerations.LogicalOperator logicalOperator,
      List<SearchFilter> searchFilters)
      : super() {
    this._logicalOperator = logicalOperator;
    this.AddRange(searchFilters);
  }

  /// <summary>
  /// Validate instance.
  /// </summary>
  @override
  void InternalValidate() {
    for (int i = 0; i < this.length; i++) {
      try {
        this[i].InternalValidate();
      } on ServiceValidationException catch (ex, stacktrace) {
        throw new ServiceValidationException(
            "SearchFilterAtIndexIsInvalid($i)", ex, stacktrace);
      }
    }
  }

  /// <summary>
  /// A search filter has changed.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  /* private */
  void SearchFilterChanged(ComplexProperty complexProperty) {
    this.Changed();
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String? GetXmlElementName() {
    return EnumToString.parse(this.LogicalOperator);
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  Future<bool> TryReadElementFromXml(EwsServiceXmlReader reader) async {
    this.Add(SearchFilter.LoadFromXmlWithReader(reader));
    return true;
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    for (SearchFilter searchFilter in this) {
      searchFilter.WriteToXmlWithWriter(writer);
    }
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteToXmlWithWriter(EwsServiceXmlWriter writer) {
    // If there is only one filter in the collection, which developers tend to do,
    // we need to not emit the collection and instead only emit the one filter within
    // the collection. This is to work around the fact that EWS does not allow filter
    // collections that have less than two elements.
    if (this.Count == 1) {
      this[0].WriteToXmlWithWriter(writer);
    } else {
      super.WriteToXmlWithWriter(writer);
    }
  }

  /// <summary>
  /// Adds a search filter of any type to the collection.
  /// </summary>
  /// <param name="searchFilter">The search filter to add. Available search filter classes include SearchFilter.IsEqualTo, SearchFilter.ContainsSubString and SearchFilter.SearchFilterCollection.</param>
  void Add(SearchFilter? searchFilter) {
    if (searchFilter == null) {
      throw new ArgumentNullException("searchFilter");
    }

    searchFilter.addOnChangeEvent(this.SearchFilterChanged);
    this._searchFilters.add(searchFilter);
    this.Changed();
  }

  /// <summary>
  /// Adds multiple search filters to the collection.
  /// </summary>
  /// <param name="searchFilters">The search filters to add. Available search filter classes include SearchFilter.IsEqualTo, SearchFilter.ContainsSubString and SearchFilter.SearchFilterCollection.</param>
  void AddRange(Iterable<SearchFilter> searchFilters) {
    if (searchFilters == null) {
      throw new ArgumentNullException("searchFilters");
    }

    for (SearchFilter searchFilter in searchFilters) {
      searchFilter.addOnChangeEvent(this.SearchFilterChanged);
    }
    this._searchFilters.addAll(searchFilters);
    this.Changed();
  }

  /// <summary>
  /// Clears the collection.
  /// </summary>
  void Clear() {
    if (this.Count > 0) {
      for (SearchFilter searchFilter in this) {
        searchFilter.removeChangeEvent(this.SearchFilterChanged);
      }
      this._searchFilters.clear();
      this.Changed();
    }
  }

  /// <summary>
  /// Determines whether a specific search filter is in the collection.
  /// </summary>
  /// <param name="searchFilter">The search filter to locate in the collection.</param>
  /// <returns>True is the search filter was found in the collection, false otherwise.</returns>
  bool Contains(SearchFilter searchFilter) {
    return this._searchFilters.contains(searchFilter);
  }

  /// <summary>
  /// Removes a search filter from the collection.
  /// </summary>
  /// <param name="searchFilter">The search filter to remove.</param>
  void Remove(SearchFilter searchFilter) {
    if (this.Contains(searchFilter)) {
      searchFilter.removeChangeEvent(this.SearchFilterChanged);
      this._searchFilters.remove(searchFilter);
      this.Changed();
    }
  }

  /// <summary>
  /// Removes the search filter at the specified index from the collection.
  /// </summary>
  /// <param name="index">The zero-based index of the search filter to remove.</param>
  void RemoveAt(int index) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.range(
          index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
    }

    this[index].removeChangeEvent(this.SearchFilterChanged);
    this._searchFilters.removeAt(index);
    this.Changed();
  }

  /// <summary>
  /// Gets the total number of search filters in the collection.
  /// </summary>
  int get Count => this._searchFilters.length;

  /// <summary>
  /// Gets or sets the search filter at the specified index.
  /// </summary>
  /// <param name="index">The zero-based index of the search filter to get or set.</param>
  /// <returns>The search filter at the specified index.</returns>
  SearchFilter operator [](int index) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.range(
          index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
    }

    return this._searchFilters[index];
  }

  operator []=(int index, SearchFilter value) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.range(
          index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
    }

    this._searchFilters[index] = value;
  }

  /// <summary>
  /// Gets or sets the logical operator that links the serach filters in this collection.
  /// </summary>
  enumerations.LogicalOperator get LogicalOperator => this._logicalOperator;

  set LogicalOperator(enumerations.LogicalOperator value) =>
      this._logicalOperator = value;

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
  @override
  Iterator<SearchFilter> get iterator => this._searchFilters.iterator;
}
//    }
