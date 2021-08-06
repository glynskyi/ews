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
import 'package:ews/ComplexProperties/EmailAddress.dart' as complex;
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/EmailAddressKey.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/MailboxType.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents an entry of an EmailAddressDictionary.
/// </summary>
class EmailAddressEntry extends DictionaryEntryProperty<EmailAddressKey> {
  /// <summary>
  /// The email address.
  /// </summary>
  /* private */ complex.EmailAddress? emailAddress;

  /// <summary>
  /// Initializes a new instance of the <see cref="EmailAddressEntry"/> class.
  /// </summary>
  EmailAddressEntry() : super() {
    this.emailAddress = new complex.EmailAddress();
    this.emailAddress!.addOnChangeEvent(this.EmailAddressChanged);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="EmailAddressEntry"/> class.
  /// </summary>
  /// <param name="key">The key.</param>
  /// <param name="emailAddress">The email address.</param>
  EmailAddressEntry.withKeyAndEmail(
      EmailAddressKey key, complex.EmailAddress emailAddress)
      : super.withKey(key) {
    this.emailAddress = emailAddress;

    if (this.emailAddress != null) {
      this.emailAddress!.addOnChangeEvent(this.EmailAddressChanged);
    }
  }

  /// <summary>
  /// Reads the attributes from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadAttributesFromXml(EwsServiceXmlReader reader) {
    super.ReadAttributesFromXml(reader);

    this.EmailAddress!.Name =
        reader.ReadAttributeValue<String>(XmlAttributeNames.Name);
    this.EmailAddress!.RoutingType =
        reader.ReadAttributeValue<String>(XmlAttributeNames.RoutingType);

    String? mailboxTypeString =
        reader.ReadAttributeValue(XmlAttributeNames.MailboxType);
    if (!StringUtils.IsNullOrEmpty(mailboxTypeString)) {
      this.EmailAddress!.MailboxType =
          EwsUtilities.Parse<MailboxType>(mailboxTypeString);
    } else {
      this.EmailAddress!.MailboxType = null;
    }
  }

  /// <summary>
  /// Reads the text value from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  Future<void> ReadTextValueFromXml(EwsServiceXmlReader reader) async {
    this.EmailAddress!.Address = await reader.ReadValue();
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    if (writer.Service.RequestedServerVersion.index >
        ExchangeVersion.Exchange2007_SP1.index) {
      writer.WriteAttributeValue(
          XmlAttributeNames.Name, this.EmailAddress!.Name);
      writer.WriteAttributeValue(
          XmlAttributeNames.RoutingType, this.EmailAddress!.RoutingType);
      if (this.EmailAddress!.MailboxType != MailboxType.Unknown) {
        writer.WriteAttributeValue(
            XmlAttributeNames.MailboxType, this.EmailAddress!.MailboxType);
      }
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteValue(this.EmailAddress!.Address, XmlElementNames.EmailAddress);
  }

  /// <summary>
  /// Gets or sets the e-mail address of the entry.
  /// </summary>
  complex.EmailAddress? get EmailAddress => this.emailAddress;

  set EmailAddress(complex.EmailAddress? value) {
    if (this.CanSetFieldValue(this.emailAddress, value)) {
      this.emailAddress = value;
    }

    if (this.emailAddress != null) {
      this.emailAddress!.addOnChangeEvent(this.EmailAddressChanged);
    }
  }

  /// <summary>
  /// E-mail address was changed.
  /// </summary>
  /// <param name="complexProperty">Property that changed.</param>
  /* private */
  void EmailAddressChanged(ComplexProperty complexProperty) {
    this.Changed();
  }
}
