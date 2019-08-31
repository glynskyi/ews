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

import 'dart:core';
import 'dart:core' as core;
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
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents an attachment to an item.
/// </summary>
abstract class Attachment extends ComplexProperty {
  Item _owner;
  String _id;
  String _name;
  String _contentType;
  String _contentId;
  String _contentLocation;
  int _size;
  core.DateTime _lastModifiedTime;
  bool _isInline;
  ExchangeService _service;

  /// <summary>
  /// Initializes a new instance of the <see cref="Attachment"/> class.
  /// </summary>
  /// <param name="owner">The owner.</param>
  Attachment.withOwner(Item owner) {
    this._owner = owner;

    if (owner != null) {
      this._service = this._owner.Service;
    }
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="Attachment"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  Attachment.withExchangeService(ExchangeService service) {
    this._service = service;
  }

  /// <summary>
  /// Throws exception if this is not a new service object.
  /// </summary>
  void ThrowIfThisIsNotNew() {
    if (!this.IsNew) {
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
  bool CanSetFieldValue<T>(T field, T value) {
    this.ThrowIfThisIsNotNew();
    return super.CanSetFieldValue<T>(field, value);
  }

  /// <summary>
  /// Gets the Id of the attachment.
  /// </summary>
  String get Id => this._id;

  set Id(String value) {
    this._id = value;
  }

  /// <summary>
  /// Gets or sets the name of the attachment.
  /// </summary>
  String get Name => this._name;

  set Name(String value) {
    if (CanSetFieldValue(this._name, value)) {
      this._name = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the content type of the attachment.
  /// </summary>
  String get ContentType => this._contentType;

  set ContentType(String value) {
    if (CanSetFieldValue(this._contentType, value)) {
      this._contentType = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the content Id of the attachment. ContentId can be used as a custom way to identify
  /// an attachment in order to reference it from within the body of the item the attachment belongs to.
  /// </summary>
  String get ContentId => this._contentId;

  set ContentId(String value) {
    if (CanSetFieldValue(this._contentId, value)) {
      this._contentType = value;
      Changed();
    }
  }

  /// <summary>
  /// Gets or sets the content location of the attachment. ContentLocation can be used to associate
  /// an attachment with a Url defining its location on the Web.
  /// </summary>
  String get ContentLocation => this._contentLocation;

  set ContentLocation(String value) {
    if (CanSetFieldValue(this._contentLocation, value)) {
      this._contentLocation = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets the size of the attachment.
  /// </summary>
  int get Size {
    EwsUtilities.ValidatePropertyVersion(this._service, ExchangeVersion.Exchange2010, "Size");

    return this._size;
  }

  set Size(int value) {
    EwsUtilities.ValidatePropertyVersion(this._service, ExchangeVersion.Exchange2010, "Size");
    if (CanSetFieldValue(this._size, value)) {
      this._size = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets the date and time when this attachment was last modified.
  /// </summary>
  core.DateTime get LastModifiedTime {
    EwsUtilities.ValidatePropertyVersion(
        this._service, ExchangeVersion.Exchange2010, "LastModifiedTime");

    return this._lastModifiedTime;
  }

  set DateTime(core.DateTime value) {
    EwsUtilities.ValidatePropertyVersion(
        this._service, ExchangeVersion.Exchange2010, "LastModifiedTime");

    if (this.CanSetFieldValue(this._lastModifiedTime, value)) {
      this._lastModifiedTime = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets a value indicating whether this is an inline attachment.
  /// Inline attachments are not visible to end users.
  /// </summary>
  bool get IsInline {
    EwsUtilities.ValidatePropertyVersion(this._service, ExchangeVersion.Exchange2010, "IsInline");

    return this._isInline;
  }

  set IsInline(bool value) {
    EwsUtilities.ValidatePropertyVersion(this._service, ExchangeVersion.Exchange2010, "IsInline");

    if (CanSetFieldValue(this._isInline, value)) {
      this._isInline = value;
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
  Item get Owner => this._owner;

  /// <summary>
  /// Gets the related exchange service.
  /// </summary>
  ExchangeService get Service => this._service;

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
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.AttachmentId:
        this._id = reader.ReadAttributeValue(XmlAttributeNames.Id);

        if (this.Owner != null) {
          String rootItemChangeKey = reader.ReadAttributeValue(XmlAttributeNames.RootItemChangeKey);

          if (!StringUtils.IsNullOrEmpty(rootItemChangeKey)) {
            this.Owner.RootItemId.ChangeKey = rootItemChangeKey;
          }
        }
        reader.ReadEndElementIfNecessary(XmlNamespace.Types, XmlElementNames.AttachmentId);
        return true;
      case XmlElementNames.Name:
        this._name = reader.ReadElementValue();
        return true;
      case XmlElementNames.ContentType:
        this._contentType = reader.ReadElementValue();
        return true;
      case XmlElementNames.ContentId:
        this._contentId = reader.ReadElementValue();
        return true;
      case XmlElementNames.ContentLocation:
        this._contentLocation = reader.ReadElementValue();
        return true;
      case XmlElementNames.Size:
        this._size = reader.ReadElementValue<int>();
        return true;
      case XmlElementNames.LastModifiedTime:
        this._lastModifiedTime = reader.ReadElementValueAsDateTime();
        return true;
      case XmlElementNames.IsInline:
        this._isInline = reader.ReadElementValue<bool>();
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
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Name, this.Name);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.ContentType, this.ContentType);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.ContentId, this.ContentId);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.ContentLocation, this.ContentLocation);
    if (writer.Service.RequestedServerVersion.index > ExchangeVersion.Exchange2007_SP1.index) {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.IsInline, this.IsInline);
    }
  }

  /// <summary>
  /// Load the attachment.
  /// </summary>
  /// <param name="bodyType">Type of the body.</param>
  /// <param name="additionalProperties">The additional properties.</param>
  Future<void> InternalLoad(BodyType bodyType, Iterable<PropertyDefinitionBase> additionalProperties) {
    return this._service.GetAttachment(this, bodyType, additionalProperties);
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  /// <param name="attachmentIndex">Index of this attachment.</param>
  void ValidateWithIndex(int attachmentIndex) {}

  /// <summary>
  /// Loads the attachment. Calling this method results in a call to EWS.
  /// </summary>
  Future<void> Load() {
    return this.InternalLoad(null, null);
  }
}
