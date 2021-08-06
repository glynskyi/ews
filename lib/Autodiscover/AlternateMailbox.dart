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

import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents an alternate mailbox.
/// </summary>
class AlternateMailbox {
  String? _type;
  String? _displayName;
  String? _legacyDN;
  String? _server;
  String? _smtpAddress;
  String? _ownerSmtpAddress;

  /// <summary>
  /// Initializes a new instance of the <see cref="AlternateMailbox"/> class.
  /// </summary>
  AlternateMailbox._() {}

  /// <summary>
  /// Loads AlternateMailbox instance from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>AlternateMailbox.</returns>
  static Future<AlternateMailbox> LoadFromXml(EwsXmlReader reader) async {
    AlternateMailbox altMailbox = new AlternateMailbox._();

    do {
      await reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.Type:
            altMailbox.Type = await reader.ReadElementValue<String>();
            break;
          case XmlElementNames.DisplayName:
            altMailbox.DisplayName = await reader.ReadElementValue<String>();
            break;
          case XmlElementNames.LegacyDN:
            altMailbox.LegacyDN = await reader.ReadElementValue<String>();
            break;
          case XmlElementNames.Server:
            altMailbox.Server = await reader.ReadElementValue<String>();
            break;
          case XmlElementNames.SmtpAddress:
            altMailbox.SmtpAddress = await reader.ReadElementValue<String>();
            break;
          case XmlElementNames.OwnerSmtpAddress:
            altMailbox.OwnerSmtpAddress =
                await reader.ReadElementValue<String>();
            break;
          default:
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.AlternateMailbox));

    return altMailbox;
  }

  /// <summary>
  /// Gets the alternate mailbox type.
  /// </summary>
  /// <value>The type.</value>
  String? get Type => this._type;

  set Type(String? value) => this._type = value;

  /// <summary>
  /// Gets the alternate mailbox display name.
  /// </summary>
  String? get DisplayName => this._displayName;

  set DisplayName(String? value) => this._displayName = value;

  /// <summary>
  /// Gets the alternate mailbox legacy DN.
  /// </summary>
  String? get LegacyDN => this._legacyDN;

  set LegacyDN(String? value) => this._legacyDN = value;

  /// <summary>
  /// Gets the alernate mailbox server.
  /// </summary>
  String? get Server => this._server;

  set Server(String? value) => this._server = value;

  /// <summary>
  /// Gets the alternate mailbox address.
  /// It has value only when Server and LegacyDN is empty.
  /// </summary>
  String? get SmtpAddress => this._smtpAddress;

  set SmtpAddress(String? value) => this._smtpAddress = value;

  /// <summary>
  /// Gets the alternate mailbox owner SmtpAddress.
  /// </summary>
  String? get OwnerSmtpAddress => this._ownerSmtpAddress;

  set OwnerSmtpAddress(String? value) => this._ownerSmtpAddress = value;
}
