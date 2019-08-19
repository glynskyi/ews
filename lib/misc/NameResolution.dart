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

import 'package:ews/ComplexProperties/EmailAddress.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/Contact.dart' as items;
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/NameResolutionCollection.dart';

/// <summary>
/// Represents a suggested name resolution.
/// </summary>
class NameResolution {
  NameResolutionCollection _owner;
  EmailAddress _mailbox = new EmailAddress();
  items.Contact _contact;

  /// <summary>
  /// Initializes a new instance of the <see cref="NameResolution"/> class.
  /// </summary>
  /// <param name="owner">The owner.</param>
  NameResolution(NameResolutionCollection owner) {
    EwsUtilities.Assert(owner != null, "NameResolution.ctor", "owner is null.");

    this._owner = owner;
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXml(EwsServiceXmlReader reader) {
    reader.ReadStartElementWithNamespace(
        XmlNamespace.Types, XmlElementNames.Resolution);

    reader.ReadStartElementWithNamespace(
        XmlNamespace.Types, XmlElementNames.Mailbox);
    this._mailbox.LoadFromXml(reader, XmlElementNames.Mailbox);

    reader.Read();
    if (reader.IsStartElementWithNamespace(
        XmlNamespace.Types, XmlElementNames.Contact)) {
      this._contact = new items.Contact(this._owner.Session);

      // Contacts returned by ResolveNames should behave like Contact.Load with FirstClassPropertySet specified.
      this._contact.LoadFromXmlWithPropertySet(
          reader,
          true,
          /* clearPropertyBag */
          PropertySet.FirstClassProperties,
          false); /* summaryPropertiesOnly */

      reader.ReadEndElementWithNamespace(
          XmlNamespace.Types, XmlElementNames.Resolution);
    } else {
      reader.EnsureCurrentNodeIsEndElement(
          XmlNamespace.Types, XmlElementNames.Resolution);
    }
  }

  /// <summary>
  /// Gets the mailbox of the suggested resolved name.
  /// </summary>
  EmailAddress get Mailbox => this._mailbox;

  /// <summary>
  /// Gets the contact information of the suggested resolved name. This property is only available when
  /// ResolveName is called with returnContactDetails = true.
  /// </summary>
  items.Contact get Contact => this._contact;
}
