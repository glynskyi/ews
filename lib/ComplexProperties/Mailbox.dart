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
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Interfaces/ISearchStringProvider.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents a mailbox reference.
/// </summary>
class Mailbox extends ComplexProperty implements ISearchStringProvider {
  /// <summary>
  /// Initializes a new instance of the <see cref="Mailbox"/> class.
  /// </summary>
  Mailbox() : super();

  /// <summary>
  /// Initializes a new instance of the <see cref="Mailbox"/> class.
  /// </summary>
  /// <param name="smtpAddress">The primary SMTP address of the mailbox.</param>
  Mailbox.fromSmtpAddress(this.Address);

  /// <summary>
  /// Initializes a new instance of the <see cref="Mailbox"/> class.
  /// </summary>
  /// <param name="address">The address used to reference the user mailbox.</param>
  /// <param name="routingType">The routing type of the address used to reference the user mailbox.</param>
  Mailbox.fromAddress(this.Address, this.RoutingType);

  /// <summary>
  /// True if this instance is valid, false otherthise.
  /// </summary>
  /// <value><c>true</c> if this instance is valid; otherwise, <c>false</c>.</value>
  bool get IsValid => !StringUtils.IsNullOrEmpty(this.Address);

  /// <summary>
  /// Gets or sets the address used to refer to the user mailbox.
  /// </summary>
  String Address;

  /// <summary>
  /// Gets or sets the routing type of the address used to refer to the user mailbox.
  /// </summary>
  String RoutingType;

  /// <summary>
  /// Defines an implicit conversion between a String representing an SMTP address and Mailbox.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address to convert to EmailAddress.</param>
  /// <returns>A Mailbox initialized with the specified SMTP address.</returns>
// static implicit operator Mailbox(String smtpAddress)
//        {
//            return new Mailbox(smtpAddress);
//        }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.EmailAddress:
        this.Address = reader.ReadElementValue<String>();
        return true;
      case XmlElementNames.RoutingType:
        this.RoutingType = reader.ReadElementValue<String>();
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
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.EmailAddress, this.Address);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.RoutingType, this.RoutingType);
  }

  /// <summary>

  /// </summary>
  /// <returns>String representation of instance.</returns>
  @override
  String GetSearchString() {
    return this.Address;
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  @override
  void InternalValidate() {
    super.InternalValidate();

    EwsUtilities.ValidateNonBlankStringParamAllowNull(this.Address, "address");
    EwsUtilities.ValidateNonBlankStringParamAllowNull(this.RoutingType, "routingType");
  }

  /// <summary>
  /// Determines whether the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <param name="obj">The <see cref="T:System.Object"/> to compare with the current <see cref="T:System.Object"/>.</param>
  /// <returns>
  /// true if the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>; otherwise, false.
  /// </returns>
  /// <exception cref="T:System.NullReferenceException">The <paramref name="obj"/> parameter is null.</exception>
  @override
  bool operator ==(obj) {
    if (identical(this, obj)) {
      return true;
    } else {
      Mailbox other = obj is Mailbox ? obj : null;

      if (other == null) {
        return false;
      } else if (((this.Address == null) && (other.Address == null)) ||
          ((this.Address != null) && this.Address == other.Address)) {
        return ((this.RoutingType == null) && (other.RoutingType == null)) ||
            ((this.RoutingType != null) && this.RoutingType == other.RoutingType);
      } else {
        return false;
      }
    }
  }

  /// <summary>
  /// Serves as a hash function for a particular type.
  /// </summary>
  /// <returns>
  /// A hash code for the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  int get hashCode {
    if (!StringUtils.IsNullOrEmpty(this.Address)) {
      int hashCode = this.Address.hashCode;

      if (!StringUtils.IsNullOrEmpty(this.RoutingType)) {
        hashCode ^= this.RoutingType.hashCode;
      }

      return hashCode;
    } else {
      return super.hashCode;
    }
  }

  /// <summary>
  /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  String toString() {
    if (!this.IsValid) {
      return "";
    } else if (!StringUtils.IsNullOrEmpty(this.RoutingType)) {
      return this.RoutingType + ":" + this.Address;
    } else {
      return this.Address;
    }
  }
}
