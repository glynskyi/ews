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
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/BodyType.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/InvalidOperationException.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/Xml/XmlWriter.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
    /// Represents an attachment to an item.
    /// </summary>
 abstract class Attachment extends ComplexProperty
    {
        /* private */ Item owner;
        /* private */ String id;
        /* private */ String name;
        /* private */ String contentType;
        /* private */ String contentId;
        /* private */ String contentLocation;
        /* private */ int size;
        /* private */ DateTime lastModifiedTime;
        /* private */ bool isInline;
        /* private */ ExchangeService service;

        /// <summary>
        /// Initializes a new instance of the <see cref="Attachment"/> class.
        /// </summary>
        /// <param name="owner">The owner.</param>
        Attachment.withOwner(Item owner)
        {
            this.owner = owner;

            if (owner != null)
            {
                this.service = this.owner.Service;
            }
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="Attachment"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        Attachment.withExchangeService(ExchangeService service)
        {
            this.service = service;
        }

        /// <summary>
        /// Throws exception if this is not a new service object.
        /// </summary>
        void ThrowIfThisIsNotNew()
        {
            if (!this.IsNew)
            {
                throw new InvalidOperationException("Strings.AttachmentCannotBeUpdated");
            }
        }

        /// <summary>
        /// Sets value of field.
        /// </summary>
        /// <remarks>
        /// We override the base implementation. Attachments cannot be modified so any attempts
        /// the change a property on an existing attachment is an error.
        /// </remarks>
        /// <typeparam name="T">Field type.</typeparam>
        /// <param name="field">The field.</param>
        /// <param name="value">The value.</param>
@override
        bool CanSetFieldValue<T>(T field, T value)
        {
            this.ThrowIfThisIsNotNew();
            return super.CanSetFieldValue<T>(field, value);
        }

        /// <summary>
        /// Gets the Id of the attachment.
        /// </summary>
        String get Id => this.id;

        set Id(String value) {
            this.id = value;
        }

        /// <summary>
        /// Gets or sets the name of the attachment.
        /// </summary>
        String get Name => this.name;

        set Name(String value) {
          if (CanSetFieldValue(this.name, value)) {
            this.name =value;
            this.Changed();
          }
        }

        /// <summary>
        /// Gets or sets the content type of the attachment.
        /// </summary>
        String get ContentType => this.contentType;

        set ContentType(String value) {
          if (CanSetFieldValue(this.contentType, value)) {
            this.contentType = value;
            this.Changed();
          }
        }

        /// <summary>
        /// Gets or sets the content Id of the attachment. ContentId can be used as a custom way to identify
        /// an attachment in order to reference it from within the body of the item the attachment belongs to.
        /// </summary>
        String get ContentId => this.contentId;

        set ContentId(String value) {
          if (CanSetFieldValue(this.contentId, value)) {
            this.contentType = value;
                Changed();
          }
        }



        /// <summary>
        /// Gets or sets the content location of the attachment. ContentLocation can be used to associate
        /// an attachment with a Url defining its location on the Web.
        /// </summary>
        String get ContentLocation => this.contentLocation;

        set ContentLocation(String value) {
          if (CanSetFieldValue(this.contentLocation, value)) {
            this.contentLocation = value;
            this.Changed();
          }
        }

        /// <summary>
        /// Gets the size of the attachment.
        /// </summary>
        int get Size {
//          EwsUtilities.ValidatePropertyVersion(this.service, ExchangeVersion.Exchange2010, "Size");

          return this.size;
        }

        set Size(int value) {
//          EwsUtilities.ValidatePropertyVersion(this.service, ExchangeVersion.Exchange2010, "Size");
          if (CanSetFieldValue(this.size, value)) {
            this.size = value;
            this.Changed();
          }
        }

        /// <summary>
        /// Gets the date and time when this attachment was last modified.
        /// </summary>
// DateTime get LastModifiedTime
// {
////                EwsUtilities.ValidatePropertyVersion(this.service, ExchangeVersion.Exchange2010, "LastModifiedTime");
//
//                return this.lastModifiedTime;
//            }
//            set DateTime(DateTime value)
//            {
////                EwsUtilities.ValidatePropertyVersion(this.service, ExchangeVersion.Exchange2010, "LastModifiedTime");
//
//                this.SetFieldValue<DateTime>(ref this.lastModifiedTime, value);
//            }

        /// <summary>
        /// Gets or sets a value indicating whether this is an inline attachment.
        /// Inline attachments are not visible to end users.
        /// </summary>
        bool get IsInline {
          ////                EwsUtilities.ValidatePropertyVersion(this.service, ExchangeVersion.Exchange2010, "IsInline");
//
//                return this.isInline;
        }

        set IsInline(bool value) {
          ////                EwsUtilities.ValidatePropertyVersion(this.service, ExchangeVersion.Exchange2010, "IsInline");
//
//                this.SetFieldValue<bool>(ref this.isInline, value);
          if (CanSetFieldValue(this.isInline, value)) {
            this.isInline = value;
            this.Changed();
          }
        }

        /// <summary>
        /// True if the attachment has not yet been saved, false otherwise.
        /// </summary>
        bool get IsNew => StringUtils.IsNullOrEmpty(this.Id);

        /// <summary>
        /// Gets the owner of the attachment.
        /// </summary>
        Item get Owner => this.owner;

        /// <summary>
        /// Gets the related exchange service.
        /// </summary>
        ExchangeService get Service =>this.service;

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name.</returns>
        String GetXmlElementName();

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.AttachmentId:
                    this.id = reader.ReadAttributeValue(XmlAttributeNames.Id);

                    if (this.Owner != null)
                    {
                        String rootItemChangeKey = reader.ReadAttributeValue(XmlAttributeNames.RootItemChangeKey);

                        if (!StringUtils.IsNullOrEmpty(rootItemChangeKey))
                        {
                            this.Owner.RootItemId.ChangeKey = rootItemChangeKey;
                        }
                    }
                    reader.ReadEndElementIfNecessary(XmlNamespace.Types, XmlElementNames.AttachmentId);
                    return true;
                case XmlElementNames.Name:
                    this.name = reader.ReadElementValue();
                    return true;
                case XmlElementNames.ContentType:
                    this.contentType = reader.ReadElementValue();
                    return true;
                case XmlElementNames.ContentId:
                    this.contentId = reader.ReadElementValue();
                    return true;
                case XmlElementNames.ContentLocation:
                    this.contentLocation = reader.ReadElementValue();
                    return true;
                case XmlElementNames.Size:
                    this.size = reader.ReadElementValue<int>();
                    return true;
                case XmlElementNames.LastModifiedTime:
                    this.lastModifiedTime = reader.ReadElementValueAsDateTime();
                    return true;
                case XmlElementNames.IsInline:
                    this.isInline = reader.ReadElementValue<bool>();
                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Name, this.Name);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.ContentType, this.ContentType);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.ContentId, this.ContentId);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.ContentLocation, this.ContentLocation);
            if (writer.Service.RequestedServerVersion.index > ExchangeVersion.Exchange2007_SP1.index)
            {
                writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.IsInline, this.IsInline);
            }
        }

        /// <summary>
        /// Load the attachment.
        /// </summary>
        /// <param name="bodyType">Type of the body.</param>
        /// <param name="additionalProperties">The additional properties.</param>
        void InternalLoad(BodyType bodyType, Iterable<PropertyDefinitionBase> additionalProperties)
        {
            this.service.GetAttachment(
                this,
                bodyType,
                additionalProperties);
        }

        /// <summary>
        /// Validates this instance.
        /// </summary>
        /// <param name="attachmentIndex">Index of this attachment.</param>
        void ValidateWithIndex(int attachmentIndex)
        {
        }

        /// <summary>
        /// Loads the attachment. Calling this method results in a call to EWS.
        /// </summary>
 void Load()
        {
            this.InternalLoad(null, null);
        }
    }
