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

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents a collection of properties that can be sent to and retrieved from EWS.
/// </summary>
/// <typeparam name="TComplexProperty">ComplexProperty type.</typeparam>
abstract class ComplexPropertyCollection<TComplexProperty extends ComplexProperty>
    extends ComplexProperty
    with IterableMixin<TComplexProperty>
    implements Iterable<TComplexProperty> //, ICustomUpdateSerializer
{
  List<TComplexProperty> _items = new List<TComplexProperty>();
  List<TComplexProperty> _addedItems = new List<TComplexProperty>();
  List<TComplexProperty> _modifiedItems = new List<TComplexProperty>();
  List<TComplexProperty> _removedItems = new List<TComplexProperty>();

  /// <summary>
  /// Creates the complex property.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>Complex property instance.</returns>
  TComplexProperty CreateComplexProperty(String xmlElementName);

  /// <summary>
  /// Gets the name of the collection item XML element.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  /// <returns>XML element name.</returns>
  String GetCollectionItemXmlElementName(TComplexProperty complexProperty);

  /// <summary>
  /// Initializes a new instance of the <see cref="ComplexPropertyCollection&lt;TComplexProperty&gt;"/> class.
  /// </summary>
  ComplexPropertyCollection() : super();

  /// <summary>
  /// Item changed.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  void ItemChanged(ComplexProperty complexProperty) {
    TComplexProperty property = complexProperty as TComplexProperty;

    EwsUtilities.Assert(property != null, "ComplexPropertyCollection.ItemChanged",
        "ComplexPropertyCollection.ItemChanged: the type of the complexProperty argument (${complexProperty.runtimeType}) is not supported.");

    if (!this._addedItems.contains(property)) {
      if (!this._modifiedItems.contains(property)) {
        this._modifiedItems.add(property);
        this.Changed();
      }
    }
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="localElementName">Name of the local element.</param>
  @override
  void LoadFromXml(EwsServiceXmlReader reader, String localElementName) {
    this.LoadFromXmlWithNamespace(reader, XmlNamespace.Types, localElementName);
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localElementName">Name of the local element.</param>
  @override
  void LoadFromXmlWithNamespace(
      EwsServiceXmlReader reader, XmlNamespace xmlNamespace, String localElementName) {
    reader.EnsureCurrentNodeIsStartElementWithNamespace(xmlNamespace, localElementName);

    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if (reader.IsStartElement()) {
          TComplexProperty complexProperty = this.CreateComplexProperty(reader.LocalName);

          if (complexProperty != null) {
            complexProperty.LoadFromXml(reader, reader.LocalName);
            this.InternalAdd(complexProperty, true);
          } else {
            reader.SkipCurrentElement();
          }
        }
      } while (!reader.IsEndElementWithNamespace(xmlNamespace, localElementName));
    }
  }

  /// <summary>
  /// Loads from XML to update itself.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  @override
  void UpdateFromXmlWithNamespace(
      EwsServiceXmlReader reader, XmlNamespace xmlNamespace, String xmlElementName) {
    reader.EnsureCurrentNodeIsStartElementWithNamespace(xmlNamespace, xmlElementName);

    if (!reader.IsEmptyElement) {
      int index = 0;
      do {
        reader.Read();

        if (reader.IsStartElement()) {
          TComplexProperty complexProperty = this.CreateComplexProperty(reader.LocalName);
          TComplexProperty actualComplexProperty = this[index++];

          // todo("implement check")
//                        if (complexProperty == null || !complexProperty.GetType().IsInstanceOfType(actualComplexProperty))
//                        {
//                            throw new ServiceLocalException("Strings.PropertyTypeIncompatibleWhenUpdatingCollection");
//                        }

          actualComplexProperty.UpdateFromXmlWithNamespace(reader, xmlNamespace, reader.LocalName);
        }
      } while (!reader.IsEndElementWithNamespace(xmlNamespace, xmlElementName));
    }
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  @override
  void WriteToXmlWithNamespace(
      EwsServiceXmlWriter writer, XmlNamespace xmlNamespace, String xmlElementName) {
    if (this.ShouldWriteToRequest()) {
      super.WriteToXmlWithNamespace(writer, xmlNamespace, xmlElementName);
    }
  }

  /// <summary>
  /// Determine whether we should write collection to XML or not.
  /// </summary>
  /// <returns>True if collection contains at least one element.</returns>
  bool ShouldWriteToRequest() {
    // Only write collection if it has at least one element.
    return this.Count > 0;
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    for (TComplexProperty complexProperty in this) {
      complexProperty.WriteToXml(writer, this.GetCollectionItemXmlElementName(complexProperty));
    }
  }

  /// <summary>
  /// Clears the change log.
  /// </summary>
  @override
  void ClearChangeLog() {
    this._removedItems.clear();
    this._addedItems.clear();
    this._modifiedItems.clear();
  }

  /// <summary>
  /// Removes from change log.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  void RemoveFromChangeLog(TComplexProperty complexProperty) {
    this._removedItems.remove(complexProperty);
    this._modifiedItems.remove(complexProperty);
    this._addedItems.remove(complexProperty);
  }

  /// <summary>
  /// Gets the items.
  /// </summary>
  /// <value>The items.</value>
  List<TComplexProperty> get Items => this._items;

  /// <summary>
  /// Gets the added items.
  /// </summary>
  /// <value>The added items.</value>
  List<TComplexProperty> get AddedItems => this._addedItems;

  /// <summary>
  /// Gets the modified items.
  /// </summary>
  /// <value>The modified items.</value>
  List<TComplexProperty> get ModifiedItems => this._modifiedItems;

  /// <summary>
  /// Gets the removed items.
  /// </summary>
  /// <value>The removed items.</value>
  List<TComplexProperty> get RemovedItems => this._removedItems;

  /// <summary>
  /// Add complex property.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  /// <param name="loading">If true, collection is being loaded.</param>
  /* private */
  void InternalAdd(TComplexProperty complexProperty, [bool loading = false]) {
    EwsUtilities.Assert(complexProperty != null, "ComplexPropertyCollection.InternalAdd",
        "complexProperty is null");

    if (!this._items.contains(complexProperty)) {
      this._items.add(complexProperty);
      if (!loading) {
        this._removedItems.remove(complexProperty);
        this._addedItems.add(complexProperty);
      }
      complexProperty.addOnChangeEvent(this.ItemChanged);
      this.Changed();
    }
  }

  /// <summary>
  /// Clear collection.
  /// </summary>
  void InternalClear() {
    while (this.Count > 0) {
      this.InternalRemoveAt(0);
    }
  }

  /// <summary>
  /// Remote entry at index.
  /// </summary>
  /// <param name="index">The index.</param>
  void InternalRemoveAt(int index) {
    EwsUtilities.Assert(index >= 0 && index < this.Count,
        "ComplexPropertyCollection.InternalRemoveAt", "index is out of range.");

    this.InternalRemove(this._items[index]);
  }

  /// <summary>
  /// Remove specified complex property.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  /// <returns>True if the complex property was successfully removed from the collection, false otherwise.</returns>
  bool InternalRemove(TComplexProperty complexProperty) {
    EwsUtilities.Assert(complexProperty != null, "ComplexPropertyCollection.InternalRemove",
        "complexProperty is null");

    if (this._items.remove(complexProperty)) {
      complexProperty.removeChangeEvent(this.ItemChanged);

      if (!this._addedItems.contains(complexProperty)) {
        this._removedItems.add(complexProperty);
      } else {
        this._addedItems.remove(complexProperty);
      }
      this._modifiedItems.remove(complexProperty);
      this.Changed();
      return true;
    } else {
      return false;
    }
  }

  /// <summary>
  /// Determines whether a specific property is in the collection.
  /// </summary>
  /// <param name="complexProperty">The property to locate in the collection.</param>
  /// <returns>True if the property was found in the collection, false otherwise.</returns>
  bool Contains(TComplexProperty complexProperty) {
    return this._items.contains(complexProperty);
  }

  /// <summary>
  /// Searches for a specific property and return its zero-based index within the collection.
  /// </summary>
  /// <param name="complexProperty">The property to locate in the collection.</param>
  /// <returns>The zero-based index of the property within the collection.</returns>
  int IndexOf(TComplexProperty complexProperty) {
    return this._items.indexOf(complexProperty);
  }

  /// <summary>
  /// Gets the total number of properties in the collection.
  /// </summary>
  int get Count => this._items.length;

  /// <summary>
  /// Gets the property at the specified index.
  /// </summary>
  /// <param name="index">The zero-based index of the property to get.</param>
  /// <returns>The property at the specified index.</returns>
  TComplexProperty operator [](int index) {
    if (index < 0 || index >= this.length) {
      throw new RangeError.range(index, 0, this.length, "index", "Strings.IndexIsOutOfRange");
    }

    return this._items[index];
  }

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
  @override
  Iterator<TComplexProperty> get iterator => this._items.iterator;

// IEnumerator<TComplexProperty> GetEnumerator() {
//   return this.items.GetEnumerator();
// }

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
//        System.Collections.IEnumerator System.Collections.Iterable.GetEnumerator()
//        {
//            return this.items.GetEnumerator();
//        }

  /// <summary>
  /// Writes the update to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsObject">The ews object.</param>
  /// <param name="propertyDefinition">Property definition.</param>
  /// <returns>True if property generated serialization.</returns>
//        bool ICustomUpdateSerializer.WriteSetUpdateToXml(
//            EwsServiceXmlWriter writer,
//            ServiceObject ewsObject,
//            PropertyDefinition propertyDefinition)
//        {
//            // If the collection is empty, delete the property.
//            if (this.Count == 0)
//            {
//                writer.WriteStartElement(XmlNamespace.Types, ewsObject.GetDeleteFieldXmlElementName());
//                propertyDefinition.WriteToXml(writer);
//                writer.WriteEndElement();
//                return true;
//            }
//
//            // Otherwise, use the default XML serializer.
//            else
//            {
//                return false;
//            }
//        }

  /// <summary>
  /// Writes the deletion update to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsObject">The ews object.</param>
  /// <returns>True if property generated serialization.</returns>
//        bool ICustomUpdateSerializer.WriteDeleteUpdateToXml(EwsServiceXmlWriter writer, ServiceObject ewsObject)
//        {
//            // Use the default XML serializer.
//            return false;
//        }
}
