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
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/MultiResponseServiceRequest.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/Search/Filters/SearchFilter.dart' as search;
import 'package:ews/Search/Grouping.dart';
import 'package:ews/Search/SeekToConditionItemView.dart';
import 'package:ews/Search/ViewBase.dart';
import 'package:ews/misc/FolderIdWrapperList.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents an abstract Find request.
/// </summary>
/// <typeparam name="TResponse">The type of the response.</typeparam>
abstract class FindRequest<TResponse extends ServiceResponse>
    extends MultiResponseServiceRequest<TResponse> {
  /* private */
  FolderIdWrapperList parentFolderIds = new FolderIdWrapperList();

  /* private */
  search.SearchFilter searchFilter;

  /* private */
  String queryString;

  /* private */
  bool returnHighlightTerms = false;

  /* private */
  ViewBase view;

  /// <summary>
  /// Initializes a new instance of the <see cref="FindRequest&lt;TResponse&gt;"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  FindRequest(ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode) {}

  /// <summary>
  /// Validate request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();

    this.View.InternalValidate(this);

    // query String parameter is only valid for Exchange2010 or higher
    //
    if (!StringUtils.IsNullOrEmpty(this.queryString) &&
        this.Service.RequestedServerVersion.index <
            ExchangeVersion.Exchange2010.index) {
      throw new ServiceVersionException("""string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "queryString",
                        ExchangeVersion.Exchange2010)""");
    }

    // ReturnHighlightTerms parameter is only valid for Exchange2013 or higher
    //
    if (this.ReturnHighlightTerms &&
        this.Service.RequestedServerVersion.index <
            ExchangeVersion.Exchange2013.index) {
      throw new ServiceVersionException("""string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "returnHighlightTerms",
                        ExchangeVersion.Exchange2013)""");
    }

    // SeekToConditionItemView is only valid for Exchange2013 or higher
    //
    if ((this.View is SeekToConditionItemView) &&
        this.Service.RequestedServerVersion.index <
            ExchangeVersion.Exchange2013.index) {
      throw new ServiceVersionException("""string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "SeekToConditionItemView",
                        ExchangeVersion.Exchange2013)""");
    }

    if (!StringUtils.IsNullOrEmpty(this.queryString) &&
        this.searchFilter != null) {
      throw new ServiceLocalException(
          "Strings.BothSearchFilterAndQueryStringCannotBeSpecified");
    }
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return this.ParentFolderIds.Count;
  }

  /// <summary>
  /// Gets the group by clause.
  /// </summary>
  /// <returns>The group by clause, null if the request does not have or support grouping.</returns>
  Grouping GetGroupBy() {
    return null;
  }

  /// <summary>
  /// Writes XML attributes.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    this.View.WriteAttributesToXml(writer);
  }

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    this.View.WriteToXml(writer, this.GetGroupBy());

    if (this.SearchFilter != null) {
      writer.WriteStartElement(
          XmlNamespace.Messages, XmlElementNames.Restriction);
      this.SearchFilter.WriteToXmlWithWriter(writer);
      writer.WriteEndElement(); // Restriction
    }

    this.View.WriteOrderByToXml(writer);

    this.ParentFolderIds.WriteToXml(
        writer, XmlNamespace.Messages, XmlElementNames.ParentFolderIds);

    if (!StringUtils.IsNullOrEmpty(this.queryString)) {
      // Emit the QueryString
      //
      writer.WriteStartElement(
          XmlNamespace.Messages, XmlElementNames.QueryString);

      if (this.ReturnHighlightTerms) {
        writer.WriteAttributeString(XmlAttributeNames.ReturnHighlightTerms,
            this.ReturnHighlightTerms.toString().toLowerCase());
      }

      writer.WriteValue(this.queryString, XmlElementNames.QueryString);
      writer.WriteEndElement();
    }
  }

  /// <summary>
  /// Gets the parent folder ids.
  /// </summary>
  FolderIdWrapperList get ParentFolderIds => this.parentFolderIds;

  /// <summary>
  /// Gets or sets the search filter. Available search filter classes include SearchFilter.IsEqualTo,
  /// SearchFilter.ContainsSubString and SearchFilter.SearchFilterCollection. If SearchFilter
  /// is null, no search filters are applied.
  /// </summary>
  search.SearchFilter get SearchFilter => this.searchFilter;

  set SearchFilter(search.SearchFilter value) => this.searchFilter = value;

  /// <summary>
  /// Gets or sets the query String for indexed search.
  /// </summary>
  String get QueryString => this.queryString;

  set QueryString(String value) => this.queryString = value;

  /// <summary>
  /// Gets or sets the query String highlight terms.
  /// </summary>
  bool get ReturnHighlightTerms => this.returnHighlightTerms;

  set ReturnHighlightTerms(bool value) => this.returnHighlightTerms = value;

  /// <summary>
  /// Gets or sets the view controlling the number of items or folders returned.
  /// </summary>
  ViewBase get View => this.view;

  set View(ViewBase value) => this.view = value;
}
