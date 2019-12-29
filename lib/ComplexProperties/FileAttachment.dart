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

import 'dart:typed_data';

import 'package:ews/ComplexProperties/Attachment.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents a file attachment.
/// </summary>
class FileAttachment extends Attachment {
  String _fileName;

  Stream _contentStream;

  Uint8List _content;

  Stream<Uint8List> _loadToStream;

  bool _isContactPhoto = false;

  /// <summary>
  /// Initializes a new instance of the <see cref="FileAttachment"/> class.
  /// </summary>
  /// <param name="owner">The owner.</param>
  FileAttachment.withOwner(Item owner) : super.withOwner(owner);

  /// <summary>
  /// Initializes a new instance of the <see cref="FileAttachment"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  FileAttachment.withExchangeService(ExchangeService service)
      : super.withExchangeService(service);

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.FileAttachment;
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  /// <param name="attachmentIndex">Index of this attachment.</param>
  @override
  void ValidateWithIndex(int attachmentIndex) {
    if (StringUtils.IsNullOrEmpty(this._fileName) &&
        (this._content == null) &&
        (this._contentStream == null)) {
      throw new ServiceValidationException(
          "string.Format(Strings.FileAttachmentContentIsNotSet, attachmentIndex)");
    }
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    bool result = super.TryReadElementFromXml(reader);

    if (!result) {
      if (reader.LocalName == XmlElementNames.IsContactPhoto) {
        this._isContactPhoto = reader.ReadElementValue<bool>();
      } else if (reader.LocalName == XmlElementNames.Content) {
        if (this._loadToStream != null) {
          reader.ReadBase64ElementValueWithStream(this._loadToStream);
        } else {
          // If there's a file attachment content handler, use it. Otherwise
          // load the content into a byte array.
          // TODO: Should we mark the attachment to indicate that content is stored elsewhere?
          if (reader.Service.FileAttachmentContentHandler != null) {
            Stream outputStream = reader.Service.FileAttachmentContentHandler
                .GetOutputStream(this.Id);

            if (outputStream != null) {
              reader.ReadBase64ElementValueWithStream(outputStream);
            } else {
              this._content = reader.ReadBase64ElementValue();
            }
          } else {
            this._content = reader.ReadBase64ElementValue();
          }
        }

        result = true;
      }
    }

    return result;
  }

  /// <summary>
  /// For FileAttachment, the only thing need to patch is the AttachmentId.
  /// </summary>
  /// <param name="reader"></param>
  /// <returns></returns>
  @override
  bool TryReadElementFromXmlToPatch(EwsServiceXmlReader reader) {
    return super.TryReadElementFromXml(reader);
  }

  /// <summary>
  /// Writes elements and content to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    super.WriteElementsToXml(writer);

    if (writer.Service.RequestedServerVersion.index >
        ExchangeVersion.Exchange2007_SP1.index) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Types,
          XmlElementNames.IsContactPhoto, this._isContactPhoto);
    }

    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Content);

    if (!StringUtils.IsNullOrEmpty(this.FileName)) {
      throw UnsupportedError("Can't send attachment with a file");
//                {
//                    writer.WriteBase64ElementValue(fileStream);
//                }
    } else if (this.ContentStream != null) {
      throw UnsupportedError("Can't send attachment with a stream");
//                writer.WriteBase64ElementValue(this.ContentStream);
    } else if (this.Content != null) {
      writer.WriteBase64ElementValue(this.Content);
    } else {
      EwsUtilities.Assert(false, "FileAttachment.WriteElementsToXml",
          "The attachment's content is not set.");
    }

    writer.WriteEndElement();
  }

  /// <summary>
  /// Loads the content of the file attachment into the specified stream. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="stream">The stream to load the content of the attachment into.</param>
  void LoadWithStream(Stream stream) {
    this._loadToStream = stream;

    try {
      this.Load();
    } finally {
      this._loadToStream = null;
    }
  }

  /// <summary>
  /// Loads the content of the file attachment into the specified file. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="fileName">The name of the file to load the content of the attachment into. If the file already exists, it is overwritten.</param>
// void LoadWithFileName(String fileName)
//        {
//            this.loadToStream = new FileStream(fileName, FileMode.Create);
//
//            try
//            {
//                this.Load();
//            }
//            finally
//            {
//                this.loadToStream.Dispose();
//                this.loadToStream = null;
//            }
//
//            this.fileName = fileName;
//            this.content = null;
//            this.contentStream = null;
//        }

  /// <summary>
  /// Gets the name of the file the attachment is linked to.
  /// </summary>
  String get FileName => this._fileName;

  set FileName(String value) {
    this.ThrowIfThisIsNotNew();

    this._fileName = value;
    this._content = null;
    this._contentStream = null;
  }

  /// <summary>
  /// Gets or sets the content stream.
  /// </summary>
  /// <value>The content stream.</value>
  Stream<List<int>> get ContentStream => this._contentStream;

  set ContentStream(Stream<List<int>> value) {
    this.ThrowIfThisIsNotNew();

    this._contentStream = value;
    this._content = null;
    this._fileName = null;
  }

  /// <summary>
  /// Gets the content of the attachment into memory. Content is set only when Load() is called.
  /// </summary>
  Uint8List get Content => this._content;

  set Content(Uint8List value) {
    this.ThrowIfThisIsNotNew();

    this._content = value;
    this._fileName = null;
    this._contentStream = null;
  }

  /// <summary>
  /// Gets or sets a value indicating whether this attachment is a contact photo.
  /// </summary>
  bool get IsContactPhoto {
    EwsUtilities.ValidatePropertyVersion(
        this.Service, ExchangeVersion.Exchange2010, "IsContactPhoto");
    return this._isContactPhoto;
  }

  set IsContactPhoto(bool value) {
    EwsUtilities.ValidatePropertyVersion(
        this.Service, ExchangeVersion.Exchange2010, "IsContactPhoto");
    this.ThrowIfThisIsNotNew();
    this._isContactPhoto = value;
  }
}
