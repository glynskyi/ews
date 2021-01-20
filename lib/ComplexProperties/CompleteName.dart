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
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents the complete name of a contact.
/// </summary>
class CompleteName extends ComplexProperty {
  String? _title;

  String? _givenName;

  String? _middleName;

  String? _surname;

  String? _suffix;

  String? _initials;

  String? _fullName;

  String? _nickname;

  String? _yomiGivenName;

  String? _yomiSurname;

  /// <summary>
  /// Gets the contact's title.
  /// </summary>
  String? get Title => this._title;

  /// <summary>
  /// Gets the given name (first name) of the contact.
  /// </summary>
  String? get GivenName => this._givenName;

  /// <summary>
  /// Gets the middle name of the contact.
  /// </summary>
  String? get MiddleName => this._middleName;

  /// <summary>
  /// Gets the surname (last name) of the contact.
  /// </summary>
  String? get Surname => this._surname;

  /// <summary>
  /// Gets the suffix of the contact.
  /// </summary>
  String? get Suffix => this._suffix;

  /// <summary>
  /// Gets the initials of the contact.
  /// </summary>
  String? get Initials => this._initials;

  /// <summary>
  /// Gets the full name of the contact.
  /// </summary>
  String? get FullName => this._fullName;

  /// <summary>
  /// Gets the nickname of the contact.
  /// </summary>
  String? get NickName => this._nickname;

  /// <summary>
  /// Gets the Yomi given name (first name) of the contact.
  /// </summary>
  String? get YomiGivenName => this._yomiGivenName;

  /// <summary>
  /// Gets the Yomi surname (last name) of the contact.
  /// </summary>
  String? get YomiSurname => this._yomiSurname;

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.Title:
        this._title = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.FirstName:
        this._givenName = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.MiddleName:
        this._middleName = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.LastName:
        this._surname = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.Suffix:
        this._suffix = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.Initials:
        this._initials = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.FullName:
        this._fullName = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.NickName:
        this._nickname = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.YomiFirstName:
        this._yomiGivenName = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.YomiLastName:
        this._yomiSurname = reader.ReadElementValue<String>();
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Title, this.Title);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.FirstName, this.GivenName);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.MiddleName, this.MiddleName);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.LastName, this.Surname);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Suffix, this.Suffix);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Initials, this.Initials);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.FullName, this.FullName);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.NickName, this.NickName);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.YomiFirstName, this.YomiGivenName);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.YomiLastName, this.YomiSurname);
  }
}
