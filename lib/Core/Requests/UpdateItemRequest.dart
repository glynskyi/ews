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

import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/MultiResponseServiceRequest.dart';
import 'package:ews/Core/Responses/UpdateItemResponse.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ConflictResolutionMode.dart' as enumerations;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/MessageDisposition.dart' as enumerations;
import 'package:ews/Enumerations/SendInvitationsOrCancellationsMode.dart' as enumerations;
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';

/// <summary>
/// Represents an UpdateItem request.
/// </summary>
class UpdateItemRequest extends MultiResponseServiceRequest<UpdateItemResponse> {
  List<Item> _items = new List<Item>();

  FolderId _savedItemsDestinationFolder;

  enumerations.ConflictResolutionMode _conflictResolutionMode;

  enumerations.MessageDisposition _messageDisposition;

  enumerations.SendInvitationsOrCancellationsMode _sendInvitationsOrCancellationsMode;

  /// <summary>
  /// Initializes a new instance of the <see cref="UpdateItemRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  UpdateItemRequest(ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode) {}

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
//                for (Item item in this.Items)
//                {
//                    if (item.GetIsTimeZoneHeaderRequired(true /* isUpdateOperation */))
//                    {
//                        return true;
//                    }
//                }
//
//                return false;
//            }
//        }

  /// <summary>
  /// Validates the request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParamCollection(this.Items, "Items");
    for (int i = 0; i < this.Items.length; i++) {
      if ((this.Items[i] == null) || this.Items[i].IsNew) {
        throw new ArgumentError("string.Format(Strings.ItemToUpdateCannotBeNullOrNew, i)");
      }
    }

    if (this.SavedItemsDestinationFolder != null) {
      this.SavedItemsDestinationFolder.ValidateExchangeVersion(this.Service.RequestedServerVersion);
    }

    // Validate each item.
    for (Item item in this.Items) {
      item.Validate();
    }

    if (this.SuppressReadReceipts &&
        this.Service.RequestedServerVersion.index < ExchangeVersion.Exchange2013.index) {
      throw new ServiceVersionException("""string.Format(
                        Strings.ParameterIncompatibleWithRequestVersion,
                        "SuppressReadReceipts",
                        ExchangeVersion.Exchange2013)""");
    }
  }

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Response object.</returns>
  @override
  UpdateItemResponse CreateServiceResponse(ExchangeService service, int responseIndex) {
    return new UpdateItemResponse(this.Items[responseIndex]);
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.UpdateItem;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>Xml element name.</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.UpdateItemResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>Xml element name.</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.UpdateItemResponseMessage;
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of items in response.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return this._items.length;
  }

  /// <summary>
  /// Writes XML attributes.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    if (this.MessageDisposition != null) {
      writer.WriteAttributeValue(XmlAttributeNames.MessageDisposition, this.MessageDisposition);
    }

    if (this.SuppressReadReceipts) {
      writer.WriteAttributeValue(XmlAttributeNames.SuppressReadReceipts, true);
    }

    writer.WriteAttributeValue(XmlAttributeNames.ConflictResolution, this.ConflictResolutionMode);

    if (this.SendInvitationsOrCancellationsMode != null) {
      writer.WriteAttributeValue(XmlAttributeNames.SendMeetingInvitationsOrCancellations,
          this.SendInvitationsOrCancellationsMode);
    }
  }

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    if (this.SavedItemsDestinationFolder != null) {
      writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.SavedItemFolderId);
      this.SavedItemsDestinationFolder.WriteToXmlElemenetName(writer);
      writer.WriteEndElement();
    }

    writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.ItemChanges);

    for (Item item in this._items) {
      item.WriteToXmlForUpdate(writer);
    }

    writer.WriteEndElement();
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
  /// Gets or sets the message disposition.
  /// </summary>
  /// <value>The message disposition.</value>
  enumerations.MessageDisposition get MessageDisposition => this._messageDisposition;

  set MessageDisposition(enumerations.MessageDisposition value) {
    this._messageDisposition = value;
  }

  /// <summary>
  /// Gets or sets the conflict resolution mode.
  /// </summary>
  /// <value>The conflict resolution mode.</value>
  enumerations.ConflictResolutionMode get ConflictResolutionMode => this._conflictResolutionMode;

  set ConflictResolutionMode(enumerations.ConflictResolutionMode value) {
    this._conflictResolutionMode = value;
  }

  /// <summary>
  /// Gets or sets the send invitations or cancellations mode.
  /// </summary>
  /// <value>The send invitations or cancellations mode.</value>
  enumerations.SendInvitationsOrCancellationsMode get SendInvitationsOrCancellationsMode =>
      this._sendInvitationsOrCancellationsMode;

  set SendInvitationsOrCancellationsMode(enumerations.SendInvitationsOrCancellationsMode value) {
    this._sendInvitationsOrCancellationsMode = value;
  }

  /// <summary>
  /// Gets or sets whether to suppress read receipts
  /// </summary>
  /// <value>Whether to suppress read receipts</value>
  bool SuppressReadReceipts;

  /// <summary>
  /// Gets the items.
  /// </summary>
  /// <value>The items.</value>
  List<Item> get Items => this._items;

  /// <summary>
  /// Gets or sets the saved items destination folder.
  /// </summary>
  /// <value>The saved items destination folder.</value>
  FolderId get SavedItemsDestinationFolder => this._savedItemsDestinationFolder;

  set SavedItemsDestinationFolder(FolderId value) {
    this._savedItemsDestinationFolder = value;
  }
}
