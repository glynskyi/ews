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
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents the response to an individual attachment deletion operation.
/// </summary>
class DeleteAttachmentResponse extends ServiceResponse {
  complex.Attachment _attachment;

  /// <summary>
  /// Initializes a new instance of the <see cref="DeleteAttachmentResponse"/> class.
  /// </summary>
  /// <param name="attachment">The attachment.</param>
  DeleteAttachmentResponse(complex.Attachment attachment) : super() {
    EwsUtilities.Assert(attachment != null, "DeleteAttachmentResponse.ctor", "attachment is null");

    this._attachment = attachment;
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    super.ReadElementsFromXml(reader);

    reader.ReadStartElementWithNamespace(XmlNamespace.Messages, XmlElementNames.RootItemId);

    String changeKey = reader.ReadAttributeValue(XmlAttributeNames.RootItemChangeKey);
    if (!StringUtils.IsNullOrEmpty(changeKey) && this._attachment.Owner != null) {
      this._attachment.Owner.RootItemId.ChangeKey = changeKey;
    }

    reader.ReadEndElementIfNecessary(XmlNamespace.Messages, XmlElementNames.RootItemId);
  }

  /// <summary>
  /// Gets the attachment that was deleted.
  /// </summary>
  complex.Attachment get Attachment => this._attachment;
}
