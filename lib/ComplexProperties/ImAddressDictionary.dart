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

import 'package:ews/ComplexProperties/DictionaryProperty.dart';
import 'package:ews/Enumerations/ImAddressKey.dart';
import 'package:ews/misc/OutParam.dart';

import 'ImAddressEntry.dart';

/// <summary>
/// Represents a dictionary of Instant Messaging addresses.
/// </summary>
class ImAddressDictionary
    extends DictionaryProperty<ImAddressKey, ImAddressEntry> {
  /// <summary>
  /// Gets the field URI.
  /// </summary>
  /// <returns>Field URI.</returns>
  @override
  String GetFieldURI() {
    return "contacts:ImAddress";
  }

  /// <summary>
  /// Creates instance of dictionary entry.
  /// </summary>
  /// <returns>New instance.</returns>
  @override
  ImAddressEntry CreateEntryInstance() {
    return new ImAddressEntry();
  }

  /// <summary>
  /// Gets or sets the Instant Messaging address at the specified key.
  /// </summary>
  /// <param name="key">The key of the Instant Messaging address to get or set.</param>
  /// <returns>The Instant Messaging address at the specified key.</returns>
  String? operator [](ImAddressKey key) {
    return this.Entries[key]!.ImAddress;
  }

  operator []=(ImAddressKey key, String? value) {
    if (value == null) {
      this.InternalRemove(key);
    } else {
      if (this.Entries.containsKey(key)) {
        ImAddressEntry entry = this.Entries[key]!;
        entry.ImAddress = value;
        this.Changed();
      } else {
        ImAddressEntry entry = new ImAddressEntry.withKey(key, value);
        this.InternalAdd(entry);
      }
    }
  }

  /// <summary>
  /// Tries to get the IM address associated with the specified key.
  /// </summary>
  /// <param name="key">The key.</param>
  /// <param name="imAddress">
  /// When this method returns, contains the IM address associated with the specified key,
  /// if the key is found; otherwise, null. This parameter is passed uninitialized.
  /// </param>
  /// <returns>
  /// true if the Dictionary contains an IM address associated with the specified key; otherwise, false.
  /// </returns>
  bool TryGetValue(ImAddressKey key, OutParam<String> imAddressOutParam) {
    ImAddressEntry? entry = null;

    if (this.Entries.containsKey(key)) {
      entry = this.Entries[key];
      imAddressOutParam.param = entry!.ImAddress;

      return true;
    } else {
      imAddressOutParam.param = null;

      return false;
    }
  }
}
