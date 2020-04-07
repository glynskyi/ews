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
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents an error returned by the Autodiscover service.
/// </summary>
//    [Serializable]
class AutodiscoverError {
  String _time;
  String _id;
  int _errorCode;
  String _message;
  String _debugData;

  /// <summary>
  /// Initializes a new instance of the <see cref="AutodiscoverError"/> class.
  /// </summary>
  AutodiscoverError._() {}

  /// <summary>
  /// Parses the XML through the specified reader and creates an Autodiscover error.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>An Autodiscover error.</returns>
  static AutodiscoverError Parse(EwsXmlReader reader) {
    AutodiscoverError error = new AutodiscoverError._();

    error._time = reader.ReadAttributeValue(XmlAttributeNames.Time);
    error._id = reader.ReadAttributeValue(XmlAttributeNames.Id);

    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.ErrorCode:
            error._errorCode = reader.ReadElementValue<int>();
            break;
          case XmlElementNames.Message:
            error._message = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.DebugData:
            error._debugData = reader.ReadElementValue<String>();
            break;
          default:
            reader.SkipCurrentElement();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.Error));

    return error;
  }

  /// <summary>
  /// Gets the time when the error was returned.
  /// </summary>
  String get Time => this._time;

  /// <summary>
  /// Gets a hash of the name of the computer that is running Microsoft Exchange Server that has the Client Access server role installed.
  /// </summary>
  String get Id => this._id;

  /// <summary>
  /// Gets the error code.
  /// </summary>
  int get ErrorCode => this._errorCode;

  /// <summary>
  /// Gets the error message.
  /// </summary>
  String get Message => this._message;

  /// <summary>
  /// Gets the debug data.
  /// </summary>
  String get DebugData => this._debugData;
}
