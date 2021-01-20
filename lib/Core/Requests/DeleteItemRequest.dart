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
import 'package:ews/Core/Requests/DeleteRequest.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AffectedTaskOccurrence.dart' as enumerations;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/SendCancellationsMode.dart' as enumerations;
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/misc/ItemIdWrapperList.dart';

/// <summary>
/// Represents a DeleteItem request.
/// </summary>
class DeleteItemRequest extends DeleteRequest<ServiceResponse> {
  ItemIdWrapperList _itemIds = new ItemIdWrapperList();

  enumerations.AffectedTaskOccurrence? _affectedTaskOccurrences;

  enumerations.SendCancellationsMode? _sendCancellationsMode;

  /// <summary>
  /// Initializes a new instance of the <see cref="DeleteItemRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  DeleteItemRequest(
      ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode);

  /// <summary>
  /// Validate request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParam(this.ItemIds, "ItemIds");

    if (this.SuppressReadReceipts &&
        this.Service.RequestedServerVersion.index <
            ExchangeVersion.Exchange2013.index) {
      throw new ServiceVersionException("""string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "SuppressReadReceipts",
                        ExchangeVersion.Exchange2013)""");
    }
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return this._itemIds.Count;
  }

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  @override
  ServiceResponse CreateServiceResponse(
      ExchangeService service, int responseIndex) {
    return new ServiceResponse();
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.DeleteItem;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.DeleteItemResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.DeleteItemResponseMessage;
  }

  /// <summary>
  /// Writes XML attributes.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    if (this.AffectedTaskOccurrences != null) {
      writer.WriteAttributeValue(XmlAttributeNames.AffectedTaskOccurrences,
          this.AffectedTaskOccurrences);
    }

    if (this.SendCancellationsMode != null) {
      writer.WriteAttributeValue(XmlAttributeNames.SendMeetingCancellations,
          this.SendCancellationsMode);
    }

    if (this.SuppressReadReceipts) {
      writer.WriteAttributeValue(XmlAttributeNames.SuppressReadReceipts, true);
    }
  }

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    this
        ._itemIds
        .WriteToXml(writer, XmlNamespace.Messages, XmlElementNames.ItemIds);
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
  /// Gets or sets the affected task occurrences.
  /// </summary>
  /// <value>The affected task occurrences.</value>
  enumerations.AffectedTaskOccurrence? get AffectedTaskOccurrences =>
      this._affectedTaskOccurrences;

  set AffectedTaskOccurrences(enumerations.AffectedTaskOccurrence? value) {
    this._affectedTaskOccurrences = value;
  }

  /// <summary>
  /// Gets or sets the send cancellations.
  /// </summary>
  /// <value>The send cancellations.</value>
  enumerations.SendCancellationsMode? get SendCancellationsMode =>
      this._sendCancellationsMode;

  set SendCancellationsMode(enumerations.SendCancellationsMode? value) {
    this._sendCancellationsMode = value;
  }

  /// <summary>
  /// Gets or sets whether to suppress read receipts
  /// </summary>
  /// <value>Whether to suppress read receipts</value>
  late bool SuppressReadReceipts;
}
