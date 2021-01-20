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

import 'ProtocolConnection.dart';

/// <summary>
/// Represents a user setting that is a collection of protocol connection.
/// </summary>
class ProtocolConnectionCollection {
  List<ProtocolConnection>? _connections;

  /// <summary>
  /// Initializes a new instance of the <see cref="ProtocolConnectionCollection"/> class.
  /// </summary>
  ProtocolConnectionCollection() {
    this._connections = <ProtocolConnection>[];
  }

  /// <summary>
  /// Read user setting with ProtocolConnectionCollection value.
  /// </summary>
  /// <param name="reader">EwsServiceXmlReader</param>
  static ProtocolConnectionCollection LoadFromXml(EwsXmlReader reader) {
    ProtocolConnectionCollection value = new ProtocolConnectionCollection();
    ProtocolConnection? connection = null;

    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        if (reader.LocalName == XmlElementNames.ProtocolConnection) {
          connection = ProtocolConnection.LoadFromXml(reader);
          if (connection != null) {
            value.Connections!.add(connection);
          }
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.ProtocolConnections));

    return value;
  }

  /// <summary>
  /// Gets the Connections.
  /// </summary>
  List<ProtocolConnection>? get Connections => this._connections;

  set Connections(List<ProtocolConnection>? value) => this._connections = value;
}
