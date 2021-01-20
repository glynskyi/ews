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

import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/FindRequest.dart';
import 'package:ews/Core/Responses/FindItemResponse.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Search/Grouping.dart';

/// <summary>
/// Represents a FindItem request.
/// </summary>
/// <typeparam name="TItem">The type of the item.</typeparam>
class FindItemRequest<TItem extends Item>
    extends FindRequest<FindItemResponse<TItem>> {
  Grouping? _groupBy;

  /// <summary>
  /// Initializes a new instance of the <see cref="FindItemRequest&lt;TItem&gt;"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  FindItemRequest(
      ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode) {}

  /// <summary>
  /// Gets the group by clause.
  /// </summary>
  /// <returns>The group by clause, null if the request does not have or support grouping.</returns>
  @override
  Grouping? GetGroupBy() {
    return this.GroupBy;
  }

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  @override
  FindItemResponse<TItem> CreateServiceResponse(
      ExchangeService service, int responseIndex) {
    return new FindItemResponse<TItem>(
        this.GroupBy != null, this.View!.GetPropertySetOrDefault());
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.FindItem;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.FindItemResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.FindItemResponseMessage;
  }

  /// <summary>
  /// Gets the request version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this request is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// Gets or sets the group by.
  /// </summary>
  /// <value>The group by.</value>
  Grouping? get GroupBy => this._groupBy;

  set GroupBy(Grouping? value) => this._groupBy = value;
}
