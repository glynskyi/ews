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

import 'dart:collection';
import 'dart:core';

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents a list of strings.
/// </summary>
class StringList extends ComplexProperty
    with IterableMixin<String>
    implements Iterable<String> {
  List<String> _items = <String>[];

  String _itemXmlElementName = XmlElementNames.String;

  /// <summary>
  /// Initializes a new instance of the <see cref="StringList"/> class.
  /// </summary>
  StringList();

  /// <summary>
  /// Initializes a new instance of the <see cref="StringList"/> class.
  /// </summary>
  /// <param name="strings">The strings.</param>
  StringList.fromStrings(Iterable<String> strings) {
    this.AddRange(strings);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="StringList"/> class.
  /// </summary>
  /// <param name="itemXmlElementName">Name of the item XML element.</param>
  StringList.fromElementName(String itemXmlElementName) {
    this._itemXmlElementName = itemXmlElementName;
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    if (reader.LocalName == this._itemXmlElementName) {
      this.Add(reader.ReadValue());

      return true;
    } else {
      return false;
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    for (String item in this) {
      writer.WriteStartElement(XmlNamespace.Types, this._itemXmlElementName);
      writer.WriteValue(item, this._itemXmlElementName);
      writer.WriteEndElement();
    }
  }

  /// <summary>
  /// Adds a String to the list.
  /// </summary>
  /// <param name="s">The String to add.</param>
  void Add(String s) {
    this._items.add(s);
    this.Changed();
  }

  /// <summary>
  /// Adds multiple strings to the list.
  /// </summary>
  /// <param name="strings">The strings to add.</param>
  void AddRange(Iterable<String> strings) {
    bool changed = false;

    for (String s in strings) {
      if (!this.Contains(s)) {
        this._items.add(s);
        changed = true;
      }
    }

    if (changed) {
      this.Changed();
    }
  }

  /// <summary>
  /// Determines whether the list contains a specific string.
  /// </summary>
  /// <param name="s">The String to check the presence of.</param>
  /// <returns>True if s is present in the list, false otherwise.</returns>
  bool Contains(String s) {
    return this._items.contains(s);
  }

  /// <summary>
  /// Removes a String from the list.
  /// </summary>
  /// <param name="s">The String to remove.</param>
  /// <returns>True is s was removed, false otherwise.</returns>
  bool Remove(String s) {
    bool result = this._items.remove(s);

    if (result) {
      this.Changed();
    }

    return result;
  }

  /// <summary>
  /// Removes the String at the specified position from the list.
  /// </summary>
  /// <param name="index">The index of the String to remove.</param>
  void RemoveAt(int index) {
    if (index < 0 || index >= this.length) {
      throw new RangeError.range(
          index, 0, this.length, "index", "Strings.IndexIsOutOfRange");
    }

    this._items.removeAt(index);

    this.Changed();
  }

  /// <summary>
  /// Clears the list.
  /// </summary>
  void Clear() {
    this._items.clear();
    this.Changed();
  }

  /// <summary>
  /// Generates a String representation of all the items in the list.
  /// </summary>
  /// <returns>A comma-separated list of the strings present in the list.</returns>
  @override
  String toString() {
    return this._items.join(",");
  }

  /// <summary>
  /// Gets the number of strings in the list.
  /// </summary>
  int get Count => this._items.length;

  /// <summary>
  /// Gets or sets the String at the specified index.
  /// </summary>
  /// <param name="index">The index of the String to get or set.</param>
  /// <returns>The String at the specified index.</returns>
  String operator [](int index) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.range(
          index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
    }

    return this._items[index];
  }

  void operator []=(int index, String value) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.range(
          index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
    }

    if (this._items[index] != value) {
      this._items[index] = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
  Iterator<String> get iterator => this._items.iterator;

  /// <summary>
  /// Determines whether the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <param name="obj">The <see cref="T:System.Object"/> to compare with the current <see cref="T:System.Object"/>.</param>
  /// <returns>
  /// true if the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>; otherwise, false.
  /// </returns>
  /// <exception cref="T:System.NullReferenceException">The <paramref name="obj"/> parameter is null.</exception>
  @override
  bool operator ==(obj) {
    StringList other = obj is StringList ? obj : null;
    if (other != null) {
      return this.toString() == other.toString();
    } else {
      return false;
    }
  }

  /// <summary>
  /// Serves as a hash function for a particular type.
  /// </summary>
  /// <returns>
  /// A hash code for the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  int get hashCode {
    return this.toString().hashCode;
  }
}
