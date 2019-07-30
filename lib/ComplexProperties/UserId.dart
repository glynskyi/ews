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
import 'package:ews/Enumerations/StandardUser.dart' as enumerations;
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents the Id of a user.
/// </summary>
class UserId extends ComplexProperty {
  String _sID;

  String _primarySmtpAddress;

  String _displayName;

  enumerations.StandardUser _standardUser;

  /// <summary>
  /// Initializes a new instance of the <see cref="UserId"/> class.
  /// </summary>
  UserId() : super();

  /// <summary>
  /// Initializes a new instance of the <see cref="UserId"/> class.
  /// </summary>
  /// <param name="primarySmtpAddress">The primary SMTP address used to initialize the UserId.</param>
  UserId.withSmtpAddress(this._primarySmtpAddress) : super();

  /// <summary>
  /// Initializes a new instance of the <see cref="UserId"/> class.
  /// </summary>
  /// <param name="standardUser">The StandardUser value used to initialize the UserId.</param>
  UserId.withStandardUser(this._standardUser) : super();

  /// <summary>
  /// Determines whether this instance is valid.
  /// </summary>
  /// <returns><c>true</c> if this instance is valid; otherwise, <c>false</c>.</returns>
  bool IsValid() {
    return this.StandardUser != null ||
        !StringUtils.IsNullOrEmpty(this.PrimarySmtpAddress) ||
        !StringUtils.IsNullOrEmpty(this.SID);
  }

  /// <summary>
  /// Gets or sets the SID of the user.
  /// </summary>
  String get SID => this._sID;

  set SID(String value) {
    if (this.CanSetFieldValue(this._sID, value)) {
      this._sID = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the primary SMTP address or the user.
  /// </summary>
  String get PrimarySmtpAddress => this._primarySmtpAddress;

  set PrimarySmtpAddress(String value) {
    if (this.CanSetFieldValue(this._primarySmtpAddress, value)) {
      this._primarySmtpAddress = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the display name of the user.
  /// </summary>
  String get DisplayName => this._displayName;

  set DisplayName(String value) {
    if (this.CanSetFieldValue(this._displayName, value)) {
      this._displayName = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets a value indicating which standard user the user represents.
  /// </summary>
  enumerations.StandardUser get StandardUser => this._standardUser;

  set StandardUser(enumerations.StandardUser value) {
    if (this.CanSetFieldValue(this._standardUser, value)) {
      this._standardUser = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Implements an implicit conversion between a String representing a primary SMTP address and UserId.
  /// </summary>
  /// <param name="primarySmtpAddress">The String representing a primary SMTP address.</param>
  /// <returns>A UserId initialized with the specified primary SMTP address.</returns>
// static implicit operator UserId(String primarySmtpAddress)
//        {
//            return new UserId(primarySmtpAddress);
//        }

  /// <summary>
  /// Implements an implicit conversion between StandardUser and UserId.
  /// </summary>
  /// <param name="standardUser">The standard user used to initialize the user Id.</param>
  /// <returns>A UserId initialized with the specified standard user value.</returns>
// static implicit operator UserId(StandardUser standardUser)
//        {
//            return new UserId(standardUser);
//        }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.SID:
        this._sID = reader.ReadValue();
        return true;
      case XmlElementNames.PrimarySmtpAddress:
        this._primarySmtpAddress = reader.ReadValue();
        return true;
      case XmlElementNames.DisplayName:
        this._displayName = reader.ReadValue();
        return true;
      case XmlElementNames.DistinguishedUser:
        this._standardUser = reader.ReadValue<enumerations.StandardUser>();
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.SID, this.SID);

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.PrimarySmtpAddress, this.PrimarySmtpAddress);

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.DisplayName, this.DisplayName);

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.DistinguishedUser, this.StandardUser);
  }
}
