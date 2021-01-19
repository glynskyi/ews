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

import 'package:ews/Autodiscover/AlternateMailbox.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents a user setting that is a collection of alternate mailboxes.
/// </summary>
class AlternateMailboxCollection {
  /// <summary>
  /// Initializes a new instance of the <see cref="AlternateMailboxCollection"/> class.
  /// </summary>
  AlternateMailboxCollection() {
    this.Entries = <AlternateMailbox>[];
  }

  /// <summary>
  /// Loads instance of AlternateMailboxCollection from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>AlternateMailboxCollection</returns>
  static AlternateMailboxCollection LoadFromXml(EwsXmlReader reader) {
    AlternateMailboxCollection instance = new AlternateMailboxCollection();

    do {
      reader.Read();

      if ((reader.NodeType == XmlNodeType.Element) &&
          (reader.LocalName == XmlElementNames.AlternateMailbox)) {
        instance.Entries.add(AlternateMailbox.LoadFromXml(reader));
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.AlternateMailboxes));

    return instance;
  }

  /// <summary>
  /// Gets the collection of alternate mailboxes.
  /// </summary>
  List<AlternateMailbox> Entries;
}
