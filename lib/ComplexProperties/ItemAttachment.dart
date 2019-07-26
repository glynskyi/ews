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
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart' as items;
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/BodyType.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
    /// Represents an item attachment.
    /// </summary>
 class ItemAttachment extends Attachment
    {
        /// <summary>
        /// The item associated with the attachment.
        /// </summary>
        /* private */ items.Item item;

        /// <summary>
        /// Initializes a new instance of the <see cref="ItemAttachment"/> class.
        /// </summary>
        /// <param name="owner">The owner of the attachment.</param>
        ItemAttachment.withOwner(items.Item owner)
            : super.withOwner(owner);

        /// <summary>
        /// Initializes a new instance of the <see cref="ItemAttachment"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        ItemAttachment.withExchangeService(ExchangeService service)
            : super.withExchangeService(service);

        /// <summary>
        /// Gets the item associated with the attachment.
        /// </summary>
      items.Item get Item  => this.item;

      set (items.Item value) {
        this.ThrowIfThisIsNotNew();

        if (this.item != null)
        {
          this.item.onChange.remove(this.ItemChanged);
        }
        this.item = value;
        if (this.item != null)
        {
          this.item.onChange.add(this.ItemChanged);
        }
      }

        /// <summary>
        /// Implements the OnChange event handler for the item associated with the attachment.
        /// </summary>
        /// <param name="serviceObject">The service object that triggered the OnChange event.</param>
        /* private */ void ItemChanged(ServiceObject serviceObject)
        {
            if (this.Owner != null)
            {
                this.Owner.PropertyBag.Changed();
            }
        }

        /// <summary>
        /// Obtains EWS XML element name for this object.
        /// </summary>
        /// <returns>The XML element name.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.ItemAttachment;
        }

        /// <summary>
        /// Tries to read the element at the current position of the reader.
        /// </summary>
        /// <param name="reader">The reader to read the element from.</param>
        /// <returns>True if the element was read, false otherwise.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            bool result = super.TryReadElementFromXml(reader);

            if (!result)
            {
                this.item = EwsUtilities.CreateItemFromXmlElementName(this, reader.LocalName);

                if (this.item != null)
                {
                    this.item.LoadFromXml(reader, true /* clearPropertyBag */);
                }
            }

            return result;
        }

        /// <summary>
        /// For ItemAttachment, AttachmentId and Item should be patched.
        /// </summary>
        /// <param name="reader"></param>
        /// <returns></returns>
@override
        bool TryReadElementFromXmlToPatch(EwsServiceXmlReader reader)
        {
            // update the attachment id.
            super.TryReadElementFromXml(reader);

            reader.Read();
            Type itemClass = EwsUtilities.GetItemTypeFromXmlElementName(reader.LocalName);

            if (itemClass != null)
            {
                if (this.item == null || this.item.runtimeType != itemClass)
                {
                    throw new ServiceLocalException("Strings.AttachmentItemTypeMismatch");
                }

                this.item.LoadFromXml(reader, false /* clearPropertyBag */);
                return true;
            }

            return false;
        }

        /// <summary>
        /// Writes the properties of this object as XML elements.
        /// </summary>
        /// <param name="writer">The writer to write the elements to.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            super.WriteElementsToXml(writer);

            this.Item.WriteToXml(writer);
        }

        /// <summary>
        /// Validates this instance.
        /// </summary>
        /// <param name="attachmentIndex">Index of this attachment.</param>
@override
        void ValidateWithIndex(int attachmentIndex)
        {
            if (StringUtils.IsNullOrEmpty(this.Name))
            {
                throw new ServiceValidationException("string.Format(Strings.ItemAttachmentMustBeNamed, attachmentIndex)");
            }

            // Recurse through any items attached to item attachment.
            this.Item.Attachments.Validate();
        }

        /// <summary>
        /// Loads this attachment.
        /// </summary>
        /// <param name="additionalProperties">The optional additional properties to load.</param>
 void LoadWithProperties(List<PropertyDefinitionBase> additionalProperties)
        {
            this.InternalLoad(
                null /* bodyType */,
                additionalProperties);
        }

//        /// <summary>
//        /// Loads this attachment.
//        /// </summary>
//        /// <param name="additionalProperties">The optional additional properties to load.</param>
// void Load(Iterable<PropertyDefinitionBase> additionalProperties)
//        {
//            this.InternalLoad(
//                null /* bodyType */,
//                additionalProperties);
//        }

        /// <summary>
        /// Loads this attachment.
        /// </summary>
        /// <param name="bodyType">The body type to load.</param>
        /// <param name="additionalProperties">The optional additional properties to load.</param>
 void LoadWithBodyTypeAndProperties(BodyType bodyType, List<PropertyDefinitionBase> additionalProperties)
        {
            this.InternalLoad(
                bodyType,
                additionalProperties);
        }

//        /// <summary>
//        /// Loads this attachment.
//        /// </summary>
//        /// <param name="bodyType">The body type to load.</param>
//        /// <param name="additionalProperties">The optional additional properties to load.</param>
// void Load(BodyType bodyType, Iterable<PropertyDefinitionBase> additionalProperties)
//        {
//            this.InternalLoad(
//                bodyType,
//                additionalProperties);
//        }
    }
