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
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/GetRequest.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/ServiceObjectType.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/ItemIdWrapperList.dart';

/// <summary>
/// Represents an abstract GetItem request.
/// </summary>
/// <typeparam name="TResponse">The type of ServiceResponse.</typeparam>
abstract class GetItemRequestBase<TResponse extends ServiceResponse>
    extends GetRequest<Item, TResponse> {
  ItemIdWrapperList _itemIds = new ItemIdWrapperList();

  /// <summary>
  /// Initializes a new instance of the <see cref="GetItemRequestBase&lt;TResponse&gt;"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  GetItemRequestBase(
      ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode) {}

  /// <summary>
  /// Validate request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParamCollection(this.ItemIds, "ItemIds");
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return this.ItemIds.Count;
  }

  /// <summary>
  /// Gets the type of the service object this request applies to.
  /// </summary>
  /// <returns>The type of service object the request applies to.</returns>
  @override
  ServiceObjectType GetServiceObjectType() {
    return ServiceObjectType.Item;
  }

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    super.WriteElementsToXml(writer);

    this
        .ItemIds
        .WriteToXml(writer, XmlNamespace.Messages, XmlElementNames.ItemIds);
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.GetItem;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.GetItemResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.GetItemResponseMessage;
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
  /// Gets the item ids.
  /// </summary>
  /// <value>The item ids.</value>
  ItemIdWrapperList get ItemIds => this._itemIds;

  /// <summary>
  /// Gets a value indicating whether the TimeZoneContext SOAP header should be emitted.
  /// </summary>
  /// <value>
  ///     <c>true</c> if the time zone should be emitted; otherwise, <c>false</c>.
  /// </value>
//@override
//        bool EmitTimeZoneHeader
//        {
//            get
//            {
//                // currently we do not emit "ItemResponseShapeType.IncludeMimeContent".
//                //
//                return this.PropertySet.Contains(ItemSchema.MimeContent);
//            }
//        }
}
