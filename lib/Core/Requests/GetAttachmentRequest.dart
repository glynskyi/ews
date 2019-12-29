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
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/Requests/MultiResponseServiceRequest.dart';
import 'package:ews/Core/Responses/GetAttachmentResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/BodyType.dart' as enumerations;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';

/// <summary>
/// Represents a GetAttachment request.
/// </summary>
class GetAttachmentRequest
    extends MultiResponseServiceRequest<GetAttachmentResponse> {
  List<Attachment> _attachments = new List<Attachment>();

  List<String> _attachmentIds = new List<String>();

  List<PropertyDefinitionBase> _additionalProperties =
      new List<PropertyDefinitionBase>();

  enumerations.BodyType _bodyType;

  /// <summary>
  /// Initializes a new instance of the <see cref="GetAttachmentRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  GetAttachmentRequest(
      ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode);

  /// <summary>
  /// Validate request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    if (this.Attachments.length > 0) {
      EwsUtilities.ValidateParamCollection(this.Attachments, "Attachments");
    }

    if (this.AttachmentIds.length > 0) {
      EwsUtilities.ValidateParamCollection(this.AttachmentIds, "AttachmentIds");
    }

    if (this.AttachmentIds.length == 0 && this.Attachments.length == 0) {
      throw new ArgumentError(
          "Strings.CollectionIsEmpty, Attachments/AttachmentIds");
    }
    for (int i = 0; i < this.AdditionalProperties.length; i++) {
      EwsUtilities.ValidateParam(
          this.AdditionalProperties[i], "AdditionalProperties[$i]");
    }
  }

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  @override
  GetAttachmentResponse CreateServiceResponse(
      ExchangeService service, int responseIndex) {
    return new GetAttachmentResponse(
        this.Attachments.length > 0 ? this.Attachments[responseIndex] : null);
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return this.Attachments.length + this.AttachmentIds.length;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.GetAttachment;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.GetAttachmentResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.GetAttachmentResponseMessage;
  }

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    if (this.BodyType != null || this.AdditionalProperties.length > 0) {
      writer.WriteStartElement(
          XmlNamespace.Messages, XmlElementNames.AttachmentShape);

      if (this.BodyType != null) {
        writer.WriteElementValueWithNamespace(
            XmlNamespace.Types, XmlElementNames.BodyType, this.BodyType);
      }

      if (this.AdditionalProperties.length > 0) {
        PropertySet.WriteAdditionalPropertiesToXml(
            writer, this.AdditionalProperties);
      }

      writer.WriteEndElement(); // AttachmentShape
    }

    writer.WriteStartElement(
        XmlNamespace.Messages, XmlElementNames.AttachmentIds);

    for (Attachment attachment in this.Attachments) {
      this._WriteAttachmentIdXml(writer, attachment.Id);
    }

    for (String attachmentId in this.AttachmentIds) {
      this._WriteAttachmentIdXml(writer, attachmentId);
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
  /// Gets the attachments.
  /// </summary>
  /// <value>The attachments.</value>
  List<Attachment> get Attachments => this._attachments;

  /// <summary>
  /// Gets the attachment ids.
  /// </summary>
  /// <value>The attachment ids.</value>
  List<String> get AttachmentIds => this._attachmentIds;

  /// <summary>
  /// Gets the additional properties.
  /// </summary>
  /// <value>The additional properties.</value>
  List<PropertyDefinitionBase> get AdditionalProperties =>
      this._additionalProperties;

  /// <summary>
  /// Gets or sets the type of the body.
  /// </summary>
  /// <value>The type of the body.</value>
  enumerations.BodyType get BodyType => this._bodyType;

  set BodyType(enumerations.BodyType value) => this._bodyType = value;

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
//                // we currently do not emit "AttachmentResponseShapeType.IncludeMimeContent"
//                //
//                return this.additionalProperties.Contains(ItemSchema.MimeContent);
//            }
//        }

  /// <summary>
  /// Writes attachment id elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="attachmentId">The attachment id.</param>
  void _WriteAttachmentIdXml(EwsServiceXmlWriter writer, String attachmentId) {
    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.AttachmentId);
    writer.WriteAttributeValue(XmlAttributeNames.Id, attachmentId);
    writer.WriteEndElement();
  }
}
