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
import 'package:ews/Enumerations/LogicalOperator.dart';
import 'package:ews/Search/Filters/SearchFilter.ContainsSubstring.dart';
import 'package:ews/Search/Filters/SearchFilter.ExcludesBitmask.dart';
import 'package:ews/Search/Filters/SearchFilter.Exists.dart';
import 'package:ews/Search/Filters/SearchFilter.IsEqualTo.dart';
import 'package:ews/Search/Filters/SearchFilter.IsGreaterThan.dart';
import 'package:ews/Search/Filters/SearchFilter.IsGreaterThanOrEqualTo.dart';
import 'package:ews/Search/Filters/SearchFilter.IsLessThan.dart';
import 'package:ews/Search/Filters/SearchFilter.IsLessThanOrEqualTo.dart';
import 'package:ews/Search/Filters/SearchFilter.IsNotEqualTo.dart';
import 'package:ews/Search/Filters/SearchFilter.Not.dart';
import 'package:ews/Search/Filters/SearchFilter.SearchFilterCollection.dart';

/// <summary>
/// Represents the base search filter class. Use descendant search filter classes such as SearchFilter.IsEqualTo,
/// SearchFilter.ContainsSubString and SearchFilter.SearchFilterCollection to define search filters.
/// </summary>
abstract class SearchFilter extends ComplexProperty {
  /// <summary>
  /// Initializes a new instance of the <see cref="SearchFilter"/> class.
  /// </summary>
  SearchFilter() {}

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>SearchFilter.</returns>
  static SearchFilter LoadFromXmlWithReader(EwsServiceXmlReader reader) {
    reader.EnsureCurrentNodeIsStartElement();

    String localName = reader.LocalName;

    SearchFilter searchFilter = GetSearchFilterInstance(localName);

    if (searchFilter != null) {
      searchFilter.LoadFromXml(reader, reader.LocalName);
    }

    return searchFilter;
  }

  /// <summary>
  /// Gets the search filter instance.
  /// </summary>
  /// <param name="localName">Name of the local.</param>
  /// <returns></returns>
  /* private */
  static SearchFilter GetSearchFilterInstance(String localName) {
    SearchFilter searchFilter;
    switch (localName) {
      case XmlElementNames.Exists:
        searchFilter = new Exists();
        break;
      case XmlElementNames.Contains:
        searchFilter = new ContainsSubString();
        break;
      case XmlElementNames.Excludes:
        searchFilter = new ExcludesBitmask();
        break;
      case XmlElementNames.Not:
        searchFilter = new Not();
        break;
      case XmlElementNames.And:
        searchFilter =
            new SearchFilterCollection.withOperator(LogicalOperator.And);
        break;
      case XmlElementNames.Or:
        searchFilter =
            new SearchFilterCollection.withOperator(LogicalOperator.Or);
        break;
      case XmlElementNames.IsEqualTo:
        searchFilter = new IsEqualTo();
        break;
      case XmlElementNames.IsNotEqualTo:
        searchFilter = new IsNotEqualTo();
        break;
      case XmlElementNames.IsGreaterThan:
        searchFilter = new IsGreaterThan();
        break;
      case XmlElementNames.IsGreaterThanOrEqualTo:
        searchFilter = new IsGreaterThanOrEqualTo();
        break;
      case XmlElementNames.IsLessThan:
        searchFilter = new IsLessThan();
        break;
      case XmlElementNames.IsLessThanOrEqualTo:
        searchFilter = new IsLessThanOrEqualTo();
        break;
      default:
        searchFilter = null;
        break;
    }
    return searchFilter;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  String GetXmlElementName();

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXmlWithWriter(EwsServiceXmlWriter writer) {
    super.WriteToXml(writer, this.GetXmlElementName());
  }
}
