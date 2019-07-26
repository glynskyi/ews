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

import 'dart:convert';
import 'dart:typed_data';

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlAttributeNames.dart';

/// <summary>
    /// Represents the MIME content of an item.
    /// </summary>
 abstract class MimeContentBase extends ComplexProperty
    {
        /// <summary>
        /// characterSet returned
        /// </summary>
        /* private */ String characterSet;

        /// <summary>
        /// content received
        /// </summary>
          /* private */ Uint8List content;

        /// <summary>
        /// Reads attributes from XML.
        /// This should always be UTF-8 for MimeContentUTF8
        /// </summary>
        /// <param name="reader">The reader.</param>
@override
        void ReadAttributesFromXml(EwsServiceXmlReader reader)
        {
            this.characterSet = reader.ReadAttributeValue<String>(XmlAttributeNames.CharacterSet);
        }

        /// <summary>
        /// Reads text value from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
@override
        void ReadTextValueFromXml(EwsServiceXmlReader reader)
        {
            this.content = base64.decode(reader.ReadValue());
        }

        /// <summary>
        /// Writes attributes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteAttributesToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteAttributeValue(XmlAttributeNames.CharacterSet, this.CharacterSet);
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            if (this.Content != null && this.Content.length > 0)
            {
                writer.WriteBase64ElementValue(this.Content);
            }
        }

        /// <summary>
        /// Gets or sets the character set of the content.
        /// </summary>
        String get CharacterSet => this.characterSet;

        set CharacterSet(String value) {
          if (this.CanSetFieldValue(this.characterSet, value)) {
            this.characterSet = value;
            this.Changed();
          }
        }

        /// <summary>
        /// Gets or sets the content.
        /// </summary>
        Uint8List get Content => this.content;

        set Content(Uint8List value) {
          if (this.CanSetFieldValue(this.content, value)) {
            this.content = value;
            this.Changed();
          }
        }
    }
