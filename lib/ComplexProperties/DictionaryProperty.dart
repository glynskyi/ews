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

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/ComplexProperties/DictionaryEntryProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Interfaces/ICustomUpdateSerializer.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';

/// <summary>
/// Represents a generic dictionary that can be sent to or retrieved from EWS.
/// </summary>
/// <typeparam name="TKey">The type of key.</typeparam>
/// <typeparam name="TEntry">The type of entry.</typeparam>
abstract class DictionaryProperty<TKey,
        TEntry extends DictionaryEntryProperty<TKey>> extends ComplexProperty
    implements ICustomUpdateSerializer {
  Map<TKey, TEntry> _entries = new Map<TKey, TEntry>();

  Map<TKey, TEntry> _removedEntries = new Map<TKey, TEntry>();

  List<TKey> _addedEntries = new List<TKey>();

  List<TKey> _modifiedEntries = new List<TKey>();

  /// <summary>
  /// Entry was changed.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  void _EntryChanged(ComplexProperty complexProperty) {
    TKey key = (complexProperty as TEntry).Key;

    if (!this._addedEntries.contains(key) &&
        !this._modifiedEntries.contains(key)) {
      this._modifiedEntries.add(key);
      this.Changed();
    }
  }

  /// <summary>
  /// Writes the URI to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="key">The key.</param>
  void _WriteUriToXml(EwsServiceXmlWriter writer, TKey key) {
    writer.WriteStartElement(
        XmlNamespace.Types, XmlElementNames.IndexedFieldURI);
    writer.WriteAttributeValue(XmlAttributeNames.FieldURI, this.GetFieldURI());
    writer.WriteAttributeValue(
        XmlAttributeNames.FieldIndex, this.GetFieldIndex(key));
    writer.WriteEndElement();
  }

  /// <summary>
  /// Gets the index of the field.
  /// </summary>
  /// <param name="key">The key.</param>
  /// <returns>Key index.</returns>
  String GetFieldIndex(TKey key) {
    return key.toString();
  }

  /// <summary>
  /// Gets the field URI.
  /// </summary>
  /// <returns>Field URI.</returns>
  String GetFieldURI() {
    return null;
  }

  /// <summary>
  /// Creates the entry.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>Dictionary entry.</returns>
  TEntry CreateEntry(EwsServiceXmlReader reader) {
    if (reader.LocalName == XmlElementNames.Entry) {
      return this.CreateEntryInstance();
    } else {
      return null;
    }
  }

  /// <summary>
  /// Creates instance of dictionary entry.
  /// </summary>
  /// <returns>New instance.</returns>
  TEntry CreateEntryInstance();

  /// <summary>
  /// Gets the name of the entry XML element.
  /// </summary>
  /// <param name="entry">The entry.</param>
  /// <returns>XML element name.</returns>
  String GetEntryXmlElementName(TEntry entry) {
    return XmlElementNames.Entry;
  }

  /// <summary>
  /// Clears the change log.
  /// </summary>
  @override
  void ClearChangeLog() {
    this._addedEntries.clear();
    this._removedEntries.clear();
    this._modifiedEntries.clear();

    for (TEntry entry in this._entries.values) {
      entry.ClearChangeLog();
    }
  }

  /// <summary>
  /// Add entry.
  /// </summary>
  /// <param name="entry">The entry.</param>
  void InternalAdd(TEntry entry) {
    entry.addOnChangeEvent(this._EntryChanged);

    this._entries[entry.Key] = entry;
    this._addedEntries.add(entry.Key);
    this._removedEntries.remove(entry.Key);

    this.Changed();
  }

  /// <summary>
  /// Add or replace entry.
  /// </summary>
  /// <param name="entry">The entry.</param>
  void InternalAddOrReplace(TEntry entry) {
    if (this._entries.containsKey(entry.Key)) {
      TEntry oldEntry = this._entries[entry.Key];
      oldEntry.removeChangeEvent(this._EntryChanged);

      entry.addOnChangeEvent(this._EntryChanged);

      if (!this._addedEntries.contains(entry.Key)) {
        if (!this._modifiedEntries.contains(entry.Key)) {
          this._modifiedEntries.add(entry.Key);
        }
      }

      this.Changed();
    } else {
      this.InternalAdd(entry);
    }
  }

  /// <summary>
  /// Remove entry based on key.
  /// </summary>
  /// <param name="key">The key.</param>
  void InternalRemove(TKey key) {
//            TEntry entry;

    if (this._entries.containsKey(key)) {
      TEntry entry = this._entries[key];
      entry.removeChangeEvent(this._EntryChanged);

      this._entries.remove(key);
      this._removedEntries[key] = entry;

      this.Changed();
    }

    this._addedEntries.remove(key);
    this._modifiedEntries.remove(key);
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="localElementName">Name of the local element.</param>
  @override
  void LoadFromXml(EwsServiceXmlReader reader, String localElementName) {
    reader.EnsureCurrentNodeIsStartElementWithNamespace(
        XmlNamespace.Types, localElementName);

    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if (reader.IsStartElement()) {
          TEntry entry = this.CreateEntry(reader);

          if (entry != null) {
            entry.LoadFromXml(reader, reader.LocalName);
            this.InternalAdd(entry);
          } else {
            reader.SkipCurrentElement();
          }
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Types, localElementName));
    }
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  @override
  void WriteToXmlWithNamespace(EwsServiceXmlWriter writer,
      XmlNamespace xmlNamespace, String xmlElementName) {
    // Only write collection if it has at least one element.
    if (this._entries.length > 0) {
      super.WriteToXmlWithNamespace(writer, xmlNamespace, xmlElementName);
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    for (MapEntry<TKey, TEntry> keyValuePair in this._entries.entries) {
      keyValuePair.value
          .WriteToXml(writer, this.GetEntryXmlElementName(keyValuePair.value));
    }
  }

  /// <summary>
  /// Gets the entries.
  /// </summary>
  /// <value>The entries.</value>
  Map<TKey, TEntry> get Entries => this._entries;

  /// <summary>
  /// Determines whether this instance contains the specified key.
  /// </summary>
  /// <param name="key">The key.</param>
  /// <returns>
  ///     <c>true</c> if this instance contains the specified key; otherwise, <c>false</c>.
  /// </returns>
  bool Contains(TKey key) {
    return this.Entries.containsKey(key);
  }

  /// <summary>
  /// Writes updates to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsObject">The ews object.</param>
  /// <param name="propertyDefinition">Property definition.</param>
  /// <returns>
  /// True if property generated serialization.
  /// </returns>
  bool WriteSetUpdateToXml(EwsServiceXmlWriter writer, ServiceObject ewsObject,
      PropertyDefinition propertyDefinition) {
    List<TEntry> tempEntries = new List<TEntry>();

    for (TKey key in this._addedEntries) {
      tempEntries.add(this._entries[key]);
    }
    for (TKey key in this._modifiedEntries) {
      tempEntries.add(this._entries[key]);
    }

    for (TEntry entry in tempEntries) {
      if (!entry.WriteSetUpdateToXml(
          writer, ewsObject, propertyDefinition.XmlElementName)) {
        writer.WriteStartElement(
            XmlNamespace.Types, ewsObject.GetSetFieldXmlElementName());
        this._WriteUriToXml(writer, entry.Key);

        writer.WriteStartElement(
            XmlNamespace.Types, ewsObject.GetXmlElementName());
        writer.WriteStartElement(
            XmlNamespace.Types, propertyDefinition.XmlElementName);
        entry.WriteToXml(writer, this.GetEntryXmlElementName(entry));
        writer.WriteEndElement();
        writer.WriteEndElement();

        writer.WriteEndElement();
      }
    }

    for (TEntry entry in this._removedEntries.values) {
      if (!entry.WriteDeleteUpdateToXml(writer, ewsObject)) {
        writer.WriteStartElement(
            XmlNamespace.Types, ewsObject.GetDeleteFieldXmlElementName());
        this._WriteUriToXml(writer, entry.Key);
        writer.WriteEndElement();
      }
    }

    return true;
  }

  /// <summary>
  /// Writes deletion update to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsObject">The ews object.</param>
  /// <returns>
  /// True if property generated serialization.
  /// </returns>
  bool WriteDeleteUpdateToXml(
      EwsServiceXmlWriter writer, ServiceObject ewsObject) {
    return false;
  }
}
