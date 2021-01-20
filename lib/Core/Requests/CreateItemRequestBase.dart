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
import 'package:ews/Core/Requests/CreateRequest.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/MessageDisposition.dart' as enumerations;
import 'package:ews/Enumerations/SendInvitationsMode.dart' as enumerations;
import 'package:ews/Enumerations/ServiceErrorHandling.dart';

/// <summary>
/// Represents an abstract CreateItem request.
/// </summary>
/// <typeparam name="TServiceObject">The type of the service object.</typeparam>
/// <typeparam name="TResponse">The type of the response.</typeparam>
abstract class CreateItemRequestBase<TServiceObject extends ServiceObject,
        TResponse extends ServiceResponse>
    extends CreateRequest<TServiceObject, TResponse> {
  enumerations.MessageDisposition? _messageDisposition;

  enumerations.SendInvitationsMode? _sendInvitationsMode;

  /// <summary>
  /// Initializes a new instance of the <see cref="CreateItemRequestBase&lt;TServiceObject, TResponse&gt;"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  CreateItemRequestBase(
      ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode);

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
//                for (TServiceObject serviceObject in this.Items)
//                {
//                    if (serviceObject.GetIsTimeZoneHeaderRequired(false /* isUpdateOperation */))
//                    {
//                        return true;
//                    }
//                }
//
//                return false;
//            }
//        }

  /// <summary>
  /// Validate the request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();

    EwsUtilities.ValidateParam(this.Items, "Items");
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.CreateItem;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.CreateItemResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.CreateItemResponseMessage;
  }

  /// <summary>
  /// Gets the name of the parent folder XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetParentFolderXmlElementName() {
    return XmlElementNames.SavedItemFolderId;
  }

  /// <summary>
  /// Gets the name of the object collection XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetObjectCollectionXmlElementName() {
    return XmlElementNames.Items;
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    if (this.MessageDisposition != null) {
      writer.WriteAttributeValue(
          XmlAttributeNames.MessageDisposition, this.MessageDisposition);
    }

    if (this.SendInvitationsMode != null) {
      writer.WriteAttributeValue(
          XmlAttributeNames.SendMeetingInvitations, this.SendInvitationsMode);
    }
  }

  /// <summary>
  /// Gets or sets the message disposition.
  /// </summary>
  /// <value>The message disposition.</value>
  enumerations.MessageDisposition? get MessageDisposition =>
      this._messageDisposition;

  set MessageDisposition(enumerations.MessageDisposition? value) {
    this._messageDisposition = value;
  }

  /// <summary>
  /// Gets or sets the send invitations mode.
  /// </summary>
  /// <value>The send invitations mode.</value>
  enumerations.SendInvitationsMode? get SendInvitationsMode =>
      this._sendInvitationsMode;

  set SendInvitationsMode(enumerations.SendInvitationsMode? value) {
    this._sendInvitationsMode = value;
  }

  /// <summary>
  /// Gets or sets the items.
  /// </summary>
  /// <value>The items.</value>
  Iterable<TServiceObject>? get Items => this.Objects;

  set Items(Iterable<TServiceObject>? value) {
    this.Objects = value;
  }
}
