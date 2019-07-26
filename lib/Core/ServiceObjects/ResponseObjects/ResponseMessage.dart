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







    import 'package:ews/Attributes/ServiceObjectDefinitionAttribute.dart';
import 'package:ews/ComplexProperties/EmailAddressCollection.dart';
import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/PropertyBag.dart';
import 'package:ews/Core/ServiceObjects/Items/EmailMessage.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/ResponseObject.dart';
import 'package:ews/Core/ServiceObjects/Schemas/EmailMessageSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ResponseMessageSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ResponseObjectSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ResponseMessageType.dart';

/// <summary>
    /// Represents the base class for e-mail related responses (Reply, Reply all and Forward).
    /// </summary>
 class ResponseMessage extends ResponseObject<EmailMessage>
    {
        /* private */ ResponseMessageType responseType;


    @override
    ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
      return null;
    }

    /// <summary>
        /// Initializes a new instance of the <see cref="ResponseMessage"/> class.
        /// </summary>
        /// <param name="referenceItem">The reference item.</param>
        /// <param name="responseType">Type of the response.</param>
        ResponseMessage(Item referenceItem, ResponseMessageType responseType)
            : super(referenceItem)
        {
            this.responseType = responseType;
        }

        /// <summary>
        /// method to return the schema associated with this type of object.
        /// </summary>
        /// <returns>The schema associated with this type of object.</returns>
@override
        ServiceObjectSchema GetSchema()
        {
            return ResponseMessageSchema.Instance;
        }

        /// <summary>
        /// Gets the minimum required server version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2007_SP1;
        }

        /// <summary>
        /// This methods lets subclasses of ServiceObject override the default mechanism
        /// by which the XML element name associated with their type is retrieved.
        /// </summary>
        /// <returns>
        /// The XML element name associated with this type.
        /// If this method returns null or empty, the XML element name associated with this
        /// type is determined by the EwsObjectDefinition attribute that decorates the type,
        /// if present.
        /// </returns>
        /// <remarks>
        /// Item and folder classes that can be returned by EWS MUST rely on the EwsObjectDefinition
        /// attribute for XML element name determination.
        /// </remarks>
@override
        String GetXmlElementNameOverride()
        {
            switch (this.responseType)
            {
                case ResponseMessageType.Reply:
                    return XmlElementNames.ReplyToItem;
                case ResponseMessageType.ReplyAll:
                    return XmlElementNames.ReplyAllToItem;
                case ResponseMessageType.Forward:
                    return XmlElementNames.ForwardItem;
                default:
                    EwsUtilities.Assert(
                        false,
                        "ResponseMessage.GetXmlElementNameOverride",
                        "An unexpected value for responseType could not be handled.");
                    return null; // Because the compiler wants it
            }
        }

        /// <summary>
        /// Gets a value indicating the type of response this object represents.
        /// </summary>
 ResponseMessageType get ResponseType => this.responseType;

        /// <summary>
        /// Gets or sets the body of the response.
        /// </summary>
        MessageBody get Body => this.PropertyBag[ItemSchema.Body];
        set Body(MessageBody value) => this.PropertyBag[ItemSchema.Body] = value;

        /// <summary>
        /// Gets a list of recipients the response will be sent to.
        /// </summary>
        EmailAddressCollection get ToRecipients => this.PropertyBag[EmailMessageSchema.ToRecipients];

        /// <summary>
        /// Gets a list of recipients the response will be sent to as Cc.
        /// </summary>
        EmailAddressCollection get CcRecipients => this.PropertyBag[EmailMessageSchema.CcRecipients];

        /// <summary>
        /// Gets a list of recipients this response will be sent to as Bcc.
        /// </summary>
        EmailAddressCollection get BccRecipients => this.PropertyBag[EmailMessageSchema.BccRecipients];

        /// <summary>
        /// Gets or sets the subject of this response.
        /// </summary>
//        String get Subject => this.PropertyBag[EmailMessageSchema.Subject];
//        set Subject(String value) => this.PropertyBag[EmailMessageSchema.Subject] = value;

        /// <summary>
        /// Gets or sets the body prefix of this response. The body prefix will be prepended to the original
        /// message's body when the response is created.
        /// </summary>
        MessageBody get BodyPrefix => this.PropertyBag[ResponseObjectSchema.BodyPrefix];
        set BodyPrefix(MessageBody value) => this.PropertyBag[ResponseObjectSchema.BodyPrefix] = value;
    }
