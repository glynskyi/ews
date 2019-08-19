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
import 'package:ews/ComplexProperties/EmailAddress.dart';
import 'package:ews/ComplexProperties/EmailAddressEntry.dart';
import 'package:ews/Enumerations/EmailAddressKey.dart';
import 'package:ews/misc/OutParam.dart';

/// <summary>
/// Represents a dictionary of e-mail addresses.
/// </summary>
class EmailAddressDictionary
    extends DictionaryProperty<EmailAddressKey, EmailAddressEntry> {
  /// <summary>
  /// Gets the field URI.
  /// </summary>
  /// <returns>Field URI.</returns>
  @override
  String GetFieldURI() {
    return "contacts:EmailAddress";
  }

  /// <summary>
  /// Creates instance of dictionary entry.
  /// </summary>
  /// <returns>New instance.</returns>
  @override
  EmailAddressEntry CreateEntryInstance() {
    return new EmailAddressEntry();
  }

  /// <summary>
  /// Gets or sets the e-mail address at the specified key.
  /// </summary>
  /// <param name="key">The key of the e-mail address to get or set.</param>
  /// <returns>The e-mail address at the specified key.</returns>
  EmailAddress operator [](EmailAddressKey key) {
    return this.Entries[key].EmailAddress;
  }

  operator []=(EmailAddressKey key, EmailAddress value) {
    if (value == null) {
      this.InternalRemove(key);
    } else {
      if (this.Entries.containsKey(key)) {
        EmailAddressEntry entry = this.Entries[key];
        entry.EmailAddress = value;
        this.Changed();
      } else {
        EmailAddressEntry entry =
            new EmailAddressEntry.withKeyAndEmail(key, value);
        this.InternalAdd(entry);
      }
    }
  }

  /// <summary>
  /// Tries to get the e-mail address associated with the specified key.
  /// </summary>
  /// <param name="key">The key.</param>
  /// <param name="emailAddress">
  /// When this method returns, contains the e-mail address associated with the specified key,
  /// if the key is found; otherwise, null. This parameter is passed uninitialized.
  /// </param>
  /// <returns>
  /// true if the Dictionary contains an e-mail address associated with the specified key; otherwise, false.
  /// </returns>
  bool TryGetValue(
      EmailAddressKey key, OutParam<EmailAddress> emailAddressOutParam) {
    if (this.Entries.containsKey(key)) {
      emailAddressOutParam.param = this.Entries[key].EmailAddress;
      return true;
    } else {
      emailAddressOutParam.param = null;
      return false;
    }
  }
}
