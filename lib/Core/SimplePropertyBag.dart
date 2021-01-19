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

import 'package:ews/misc/OutParam.dart';

/// <summary>
/// The Interface PropertyBagChangedDelegateInterface.
/// </summary>
typedef IPropertyBagChangedDelegate<TKey> = void Function(
    SimplePropertyBag<TKey> simplePropertyBag);

/// <summary>
/// Represents a simple property bag.
/// </summary>
/// <typeparam name="TKey">The type of the key.</typeparam>
class SimplePropertyBag<TKey>
    with IterableMixin<MapEntry<TKey, Object>>
    implements Iterable<MapEntry<TKey, Object>> {
  Map<TKey, Object> _items = new Map<TKey, Object>();
  List<TKey> _removedItems = <TKey>[];
  List<TKey> _addedItems = <TKey>[];
  List<TKey> _modifiedItems = <TKey>[];

  /// <summary>
  /// Add item to change list.
  /// </summary>
  /// <param name="key">The key.</param>
  /// <param name="changeList">The change list.</param>
  static void _InternalAddItemToChangeList<TKey>(
      TKey key, List<TKey> changeList) {
    if (!changeList.contains(key)) {
      changeList.add(key);
    }
  }

  /// <summary>
  /// Triggers dispatch of the change event.
  /// </summary>
  void _Changed() {
    this._onChange.forEach((delegate) => delegate(this));
  }

  /// <summary>
  /// Remove item.
  /// </summary>
  /// <param name="key">The key.</param>
  void _InternalRemoveItem(TKey key) {
    OutParam<Object> valueOutParam = OutParam();

    if (this.TryGetValue(key, valueOutParam)) {
      this._items.remove(key);
      this._removedItems.add(key);
      this._Changed();
    }
  }

  /// <summary>
  /// Gets the added items.
  /// </summary>
  /// <value>The added items.</value>
  Iterable<TKey> get AddedItems => this._addedItems;

  /// <summary>
  /// Gets the removed items.
  /// </summary>
  /// <value>The removed items.</value>
  Iterable<TKey> get RemovedItems => this._removedItems;

  /// <summary>
  /// Gets the modified items.
  /// </summary>
  /// <value>The modified items.</value>
  Iterable<TKey> get ModifiedItems => this._modifiedItems;

  /// <summary>
  /// Initializes a new instance of the <see cref="SimplePropertyBag&lt;TKey&gt;"/> class.
  /// </summary>
  SimplePropertyBag() {}

  /// <summary>
  /// Clears the change log.
  /// </summary>
  void ClearChangeLog() {
    this._removedItems.clear();
    this._addedItems.clear();
    this._modifiedItems.clear();
  }

  /// <summary>
  /// Determines whether the specified key is in the property bag.
  /// </summary>
  /// <param name="key">The key.</param>
  /// <returns>
  ///     <c>true</c> if the specified key exists; otherwise, <c>false</c>.
  /// </returns>
  bool ContainsKey(TKey key) {
    return this._items.containsKey(key);
  }

  /// <summary>
  /// Tries to get value.
  /// </summary>
  /// <param name="key">The key.</param>
  /// <param name="value">The value.</param>
  /// <returns>True if value exists in property bag.</returns>
  bool TryGetValue(TKey key, OutParam<Object> valueOutParam) {
    if (this._items.containsKey(key)) {
      valueOutParam.param = this._items[key];
      return true;
    } else {
      valueOutParam.param = null;
      return false;
    }
  }

  /// <summary>
  /// Gets or sets the <see cref="System.Object"/> with the specified key.
  /// </summary>
  /// <param name="key">Key.</param>
  /// <value>Value associated with key.</value>
  operator [](TKey key) {
    OutParam<Object> valueOutParam = OutParam();

    if (this.TryGetValue(key, valueOutParam)) {
      return valueOutParam.param;
    } else {
      return null;
    }
  }

  operator []=(TKey key, Object value) {
    if (value == null) {
      this._InternalRemoveItem(key);
    } else {
      // If the item was to be deleted, the deletion becomes an update.
      if (this._removedItems.remove(key)) {
        _InternalAddItemToChangeList(key, this._modifiedItems);
      } else {
        // If the property value was not set, we have a newly set property.
        if (!this.ContainsKey(key)) {
          _InternalAddItemToChangeList(key, this._addedItems);
        } else {
          // The last case is that we have a modified property.
          if (!this._modifiedItems.contains(key)) {
            _InternalAddItemToChangeList(key, this._modifiedItems);
          }
        }
      }

      this._items[key] = value;
      this._Changed();
    }
  }

  /// <summary>
  /// Occurs when Changed.
  /// </summary>
  List<IPropertyBagChangedDelegate<TKey>> _onChange = [];

  void addOnChangeEvent(IPropertyBagChangedDelegate<TKey> change) {
    _onChange.add(change);
  }

  void removeChangeEvent(IPropertyBagChangedDelegate<TKey> change) {
    _onChange.remove(change);
  }

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
  @override
  Iterator<MapEntry<TKey, Object>> get iterator => this._items.entries.iterator;
}
