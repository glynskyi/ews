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
/// Represents the email Protocol connection settings for pop/imap/smtp protocols.
/// </summary>
class ProtocolConnection {
  String? _encryptionMethod;
  String? _hostname;
  int? _port = 0;

  /// <summary>
  /// Initializes a new instance of the <see cref="ProtocolConnection"/> class.
  /// </summary>
  ProtocolConnection() {}

  /// <summary>
  /// Read user setting with ProtocolConnection value.
  /// </summary>
  /// <param name="reader">EwsServiceXmlReader</param>
  static ProtocolConnection LoadFromXml(EwsXmlReader reader) {
    ProtocolConnection connection = new ProtocolConnection();

    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.EncryptionMethod:
            connection.EncryptionMethod = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.Hostname:
            connection.Hostname = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.Port:
            connection.Port = reader.ReadElementValue<int>();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.ProtocolConnection));

    return connection;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ProtocolConnection"/> class.
  /// </summary>
  /// <param name="encryptionMethod">The encryption method.</param>
  /// <param name="hostname">The hostname.</param>
  /// <param name="port">The port number to use for the portocol.</param>
  ProtocolConnection.withEncryptionMethodAndHostnameAndPort(
      String encryptionMethod, String hostname, int port) {
    this._encryptionMethod = encryptionMethod;
    this._hostname = hostname;
    this._port = port;
  }

  /// <summary>
  /// Gets or sets the encryption method.
  /// </summary>
  /// <value>The encryption method.</value>
  String? get EncryptionMethod => this._encryptionMethod;

  set EncryptionMethod(String? value) => this._encryptionMethod = value;

  /// <summary>
  /// Gets or sets the Hostname.
  /// </summary>
  /// <value>The hostname.</value>
  String? get Hostname => this._hostname;

  set Hostname(String? value) => this._hostname = value;

  /// <summary>
  /// Gets or sets the port number.
  /// </summary>
  /// <value>The port number.</value>
  int? get Port => this._port;

  set Port(int? value) => this._port = value;
}
