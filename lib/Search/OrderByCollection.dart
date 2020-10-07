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

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/SortDirection.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/misc/OutParam.dart';

/// <summary>
/// Represents an ordered collection of property definitions qualified with a sort direction.
/// </summary>
class OrderByCollection
    with IterableMixin<MapEntry<PropertyDefinitionBase, SortDirection>>
    implements Iterable<MapEntry<PropertyDefinitionBase, SortDirection>> {
  List<MapEntry<PropertyDefinitionBase, SortDirection>>
      _propDefSortOrderPairList;

  /// <summary>
  /// Initializes a new instance of the <see cref="OrderByCollection"/> class.
  /// </summary>
  OrderByCollection() {
    this._propDefSortOrderPairList =
        new List<MapEntry<PropertyDefinitionBase, SortDirection>>();
  }

  /// <summary>
  /// Adds the specified property definition / sort direction pair to the collection.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="sortDirection">The sort direction.</param>
  void Add(
      PropertyDefinitionBase propertyDefinition, SortDirection sortDirection) {
    if (this.Contains(propertyDefinition)) {
      throw new ServiceLocalException(
          "PropertyAlreadyExistsInOrderByCollection(${propertyDefinition.GetPrintableName()})");
    }

    this._propDefSortOrderPairList.add(
        new MapEntry<PropertyDefinitionBase, SortDirection>(
            propertyDefinition, sortDirection));
  }

  /// <summary>
  /// Removes all elements from the collection.
  /// </summary>
  void Clear() {
    this._propDefSortOrderPairList.clear();
  }

  /// <summary>
  /// Determines whether the collection contains the specified property definition.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <returns>True if the collection contains the specified property definition; otherwise, false.</returns>
  bool Contains(PropertyDefinitionBase propertyDefinition) {
    return this
        ._propDefSortOrderPairList
        .any((pair) => pair.key == propertyDefinition);
  }

  /// <summary>
  /// Gets the number of elements contained in the collection.
  /// </summary>
  int get Count => this._propDefSortOrderPairList.length;

  /// <summary>
  /// Removes the specified property definition from the collection.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <returns>True if the property definition is successfully removed; otherwise, false</returns>
  bool Remove(PropertyDefinitionBase propertyDefinition) {
    final forRemove = this
        ._propDefSortOrderPairList
        .where((pair) => pair.key == propertyDefinition);
    forRemove.forEach(this._propDefSortOrderPairList.remove);
    int count = forRemove.length;
    return count > 0;
  }

  /// <summary>
  /// Removes the element at the specified index from the collection.
  /// </summary>
  /// <param name="index">The index.</param>
  /// <exception cref="System.ArgumentOutOfRangeException">
  /// Index is less than 0 or index is equal to or greater than Count.
  /// </exception>
  void RemoveAt(int index) {
    this._propDefSortOrderPairList.removeAt(index);
  }

  /// <summary>
  /// Tries to get the value for a property definition in the collection.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="sortDirection">The sort direction.</param>
  /// <returns>True if collection contains property definition, otherwise false.</returns>
  bool TryGetValue(PropertyDefinitionBase propertyDefinition,
      OutParam<SortDirection> sortDirectionOutParam) {
    for (MapEntry<PropertyDefinitionBase, SortDirection> pair
        in this._propDefSortOrderPairList) {
      if (pair.value == propertyDefinition) {
        sortDirectionOutParam.param = pair.value;
        return true;
      }
    }

    sortDirectionOutParam.param =
        SortDirection.Ascending; // out parameter has to be set to some value.
    return false;
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void WriteToXml(EwsServiceXmlWriter writer, String xmlElementName) {
    if (this.Count > 0) {
      writer.WriteStartElement(XmlNamespace.Messages, xmlElementName);

      for (MapEntry<PropertyDefinitionBase, SortDirection> keyValuePair
          in this) {
        writer.WriteStartElement(
            XmlNamespace.Types, XmlElementNames.FieldOrder);

        writer.WriteAttributeValue(XmlAttributeNames.Order, keyValuePair.value);
        keyValuePair.key.WriteToXml(writer);

        writer.WriteEndElement(); // FieldOrder
      }

      writer.WriteEndElement();
    }
  }

  /// <summary>
  /// Gets the element at the specified index from the collection.
  /// </summary>
  /// <param name="index">Index.</param>
  MapEntry<PropertyDefinitionBase, SortDirection> operator [](int index) =>
      this._propDefSortOrderPairList[index];

  /// <summary>
  /// Returns an enumerator that iterates through the collection.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.Collections.Generic.IEnumerator`1"/> that can be used to iterate through the collection.
  /// </returns>
  @override
  Iterator<MapEntry<PropertyDefinitionBase, SortDirection>> get iterator =>
      this._propDefSortOrderPairList.iterator;
}
