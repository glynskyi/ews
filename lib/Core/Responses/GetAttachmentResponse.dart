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

import 'package:ews/ComplexProperties/Attachment.dart' as complex;
import 'package:ews/ComplexProperties/FileAttachment.dart';
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents the response to an individual attachment retrieval request.
/// </summary>
class GetAttachmentResponse extends ServiceResponse {
  /* private */ complex.Attachment? attachment;

  /// <summary>
  /// Initializes a new instance of the <see cref="GetAttachmentResponse"/> class.
  /// </summary>
  /// <param name="attachment">The attachment.</param>
  GetAttachmentResponse(complex.Attachment? attachment) : super() {
    this.attachment = attachment;
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    super.ReadElementsFromXml(reader);

    reader.ReadStartElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.Attachments);
    if (!reader.IsEmptyElement) {
      reader.Read(nodeType: XmlNodeType.Element);

      if (this.attachment == null) {
        if (StringUtils.EqualsIgnoreCase(
            reader.LocalName, XmlElementNames.FileAttachment)) {
          this.attachment =
              new FileAttachment.withExchangeService(reader.Service);
        } else if (StringUtils.EqualsIgnoreCase(
            reader.LocalName, XmlElementNames.ItemAttachment)) {
          this.attachment =
              new ItemAttachment.withExchangeService(reader.Service);
        }
      }

      if (this.attachment != null) {
        this.attachment!.LoadFromXml(reader, reader.LocalName);
      }

      reader.ReadEndElementWithNamespace(
          XmlNamespace.Messages, XmlElementNames.Attachments);
    }
  }

  /// <summary>
  /// Gets the attachment that was retrieved.
  /// </summary>
  complex.Attachment? get Attachment => this.attachment;
}
