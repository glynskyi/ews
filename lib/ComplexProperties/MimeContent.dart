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

import 'package:ews/ComplexProperties/MimeContentBase.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents the MIME content of an item.
/// </summary>
class MimeContent extends MimeContentBase {
  /// <summary>
  /// Initializes a new instance of the <see cref="MimeContent"/> class.
  /// </summary>
  MimeContent() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="MimeContent"/> class.
  /// </summary>
  /// <param name="characterSet">The character set of the content.</param>
  /// <param name="content">The content.</param>
  MimeContent.withContent(String characterSet, Uint8List content) {
    this.CharacterSet = characterSet;
    this.Content = content;
  }

  /// <summary>
  /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  String toString() {
    if (this.Content == null) {
      return "";
    } else {
      try {
        // return the Base64 representation of the content.
        // Note: Encoding.GetString can throw DecoderFallbackException which is a subclass
        // of ArgumentException.
        String? charSet = StringUtils.IsNullOrEmpty(this.CharacterSet)
            ? utf8.name
            : this.CharacterSet;
        Encoding encoding = Encoding.getByName(charSet)!;
        return encoding.decode(this.Content!);
      } catch (ArgumentException) {
        return base64.encode(this.Content!);
      }
    }
  }
}
