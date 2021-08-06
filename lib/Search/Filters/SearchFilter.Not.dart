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

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/Search/Filters/SearchFilter.dart';
import 'package:ews/Search/Filters/SearchFilter.dart' as search;

///// <content>
//    /// Contains nested type SearchFilter.Not.
//    /// </content>
// abstract partial class SearchFilter
//    {
/// <summary>
/// Represents a search filter that negates another. Applications can use NotFilter to define
/// conditions such as "NOT(other filter)".
/// </summary>
class Not extends SearchFilter {
  /* private */ search.SearchFilter? searchFilter;

  /// <summary>
  /// Initializes a new instance of the <see cref="Not"/> class.
  /// </summary>
  Not() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="Not"/> class.
  /// </summary>
  /// <param name="searchFilter">The search filter to negate. Available search filter classes include SearchFilter.IsEqualTo, SearchFilter.ContainsSubString and SearchFilter.SearchFilterCollection.</param>
  Not.withSearchFilter(search.SearchFilter searchFilter) : super() {
    this.searchFilter = searchFilter;
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
  /// Validate instance.
  /// </summary>
  @override
  void InternalValidate() {
    if (this.searchFilter == null) {
      throw new ServiceValidationException("Strings.SearchFilterMustBeSet");
    }
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.Not;
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  Future<bool> TryReadElementFromXml(EwsServiceXmlReader reader) async {
    this.searchFilter = search.SearchFilter.LoadFromXmlWithReader(reader);
    return true;
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    this.SearchFilter!.WriteToXmlWithWriter(writer);
  }

  /// <summary>
  /// Gets or sets the search filter to negate. Available search filter classes include
  /// SearchFilter.IsEqualTo, SearchFilter.ContainsSubString and SearchFilter.SearchFilterCollection.
  /// </summary>
  search.SearchFilter? get SearchFilter => this.searchFilter;

  set SearchFilter(search.SearchFilter? value) {
    if (this.searchFilter != null) {
      this.searchFilter!.removeChangeEvent(this.SearchFilterChanged);
    }

    if (this.CanSetFieldValue(this.searchFilter, searchFilter)) {
      this.searchFilter = searchFilter;
      this.Changed();
    }

    if (this.searchFilter != null) {
      this.searchFilter!.addOnChangeEvent(this.SearchFilterChanged);
    }
  }
}
//    }
