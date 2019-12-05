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

import 'package:ews/ComplexProperties/Attachment.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/MultiResponseServiceRequest.dart';
import 'package:ews/Core/Responses/CreateAttachmentResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents a CreateAttachment request.
/// </summary>
class CreateAttachmentRequest extends MultiResponseServiceRequest<CreateAttachmentResponse> {
  String _parentItemId;

  List<Attachment> _attachments = new List<Attachment>();

  /// <summary>
  /// Initializes a new instance of the <see cref="CreateAttachmentRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  CreateAttachmentRequest(ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode) {}

  /// <summary>
  /// Validate request..
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParam(this.ParentItemId, "ParentItemId");
  }

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  @override
  CreateAttachmentResponse CreateServiceResponse(ExchangeService service, int responseIndex) {
    return new CreateAttachmentResponse(this.Attachments[responseIndex]);
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return this.Attachments.length;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.CreateAttachment;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.CreateAttachmentResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.CreateAttachmentResponseMessage;
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.ParentItemId);
    writer.WriteAttributeValue(XmlAttributeNames.Id, this.ParentItemId);
    writer.WriteEndElement();

    writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.Attachments);
    for (Attachment attachment in this.Attachments) {
      attachment.WriteToXml(writer, attachment.GetXmlElementName());
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
  /// Gets a value indicating whether the TimeZoneContext SOAP header should be emitted.
  /// </summary>
//@override
//        bool EmitTimeZoneHeader
//        {
//            get
//            {
//                for (ItemAttachment itemAttachment in this.attachments.OfType<ItemAttachment>())
//                {
//                    if ((itemAttachment.Item != null) && itemAttachment.Item.GetIsTimeZoneHeaderRequired(false /* isUpdateOperation */))
//                    {
//                        return true;
//                    }
//                }
//
//                return false;
//            }
//        }

  /// <summary>
  /// Gets the attachments.
  /// </summary>
  /// <value>The attachments.</value>
  List<Attachment> get Attachments => this._attachments;

  /// <summary>
  /// Gets or sets the parent item id.
  /// </summary>
  /// <value>The parent item id.</value>
  String get ParentItemId => this._parentItemId;

  set ParentItemId(String value) {
    this._parentItemId = value;
  }
}
