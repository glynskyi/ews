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
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/MailboxType.dart' as enumerations;
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Interfaces/ISearchStringProvider.dart';
import 'package:ews/Misc/StringUtils.dart';

/// <summary>
/// Represents an e-mail address.
/// </summary>
class EmailAddress extends ComplexProperty implements ISearchStringProvider {
  /// <summary>
  /// SMTP routing type.
  /// </summary>
  static const String SmtpRoutingType = "SMTP";

  /// <summary>
  /// Display name.
  /// </summary>
  /* private */
  String name;

  /// <summary>
  /// Email address.
  /// </summary>
  /* private */
  String address;

  /// <summary>
  /// Routing type.
  /// </summary>
  /* private */
  String routingType;

  /// <summary>
  /// Mailbox type.
  /// </summary>
  /* private */
  enumerations.MailboxType mailboxType;

  /// <summary>
  /// ItemId - Contact or PDL.
  /// </summary>
  /* private */
  ItemId id;

  /// <summary>
  /// Initializes a new instance of the <see cref="EmailAddress"/> class.
  /// </summary>
  /// <param name="name">The name used to initialize the EmailAddress.</param>
  /// <param name="address">The address used to initialize the EmailAddress.</param>
  /// <param name="routingType">The routing type used to initialize the EmailAddress.</param>
  /// <param name="mailboxType">Mailbox type of the participant.</param>
  EmailAddress(
      {String name, String smtpAddress, String routingType, enumerations.MailboxType mailboxType, ItemId itemId})
      : super() {
    this.name = name;
    this.address = smtpAddress;
    this.routingType = routingType;
    this.mailboxType = mailboxType;
    this.id = itemId;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="EmailAddress"/> class.
  /// </summary>
  /// <param name="name">The name used to initialize the EmailAddress.</param>
  /// <param name="address">The address used to initialize the EmailAddress.</param>
  /// <param name="routingType">The routing type used to initialize the EmailAddress.</param>
  /// <param name="mailboxType">Mailbox type of the participant.</param>
  /// <param name="itemId">ItemId of a Contact or PDL.</param>
//        EmailAddress(
//            String name,
//            String address,
//            String routingType,
//            MailboxType mailboxType,
//            ItemId itemId)
//            : this(name, address, routingType)
//        {
//            this.mailboxType = mailboxType;
//            this.id = itemId;
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="EmailAddress"/> class from another EmailAddress instance.
  /// </summary>
  /// <param name="mailbox">EMailAddress instance to copy.</param>
  EmailAddress.withEmailAddress(EmailAddress mailbox) : super() {
    EwsUtilities.ValidateParam(mailbox, "mailbox");

    this.Name = mailbox.Name;
    this.Address = mailbox.Address;
    this.RoutingType = mailbox.RoutingType;
    this.MailboxType = mailbox.MailboxType;
    this.Id = mailbox.Id;
  }

  /// <summary>
  /// Gets or sets the name associated with the e-mail address.
  /// </summary>
  String get Name => this.name;

  set Name(String value) {
    if (this.CanSetFieldValue(this.name, value)) {
      this.name = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the actual address associated with the e-mail address. The type of the Address property
  /// must match the specified routing type. If RoutingType is not set, Address is assumed to be an SMTP
  /// address.
  /// </summary>
  String get Address => this.address;

  set Address(String value) {
    if (this.CanSetFieldValue(this.address, value)) {
      this.address = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the routing type associated with the e-mail address. If RoutingType is not set,
  /// Address is assumed to be an SMTP address.
  /// </summary>
  String get RoutingType => this.routingType;

  set RoutingType(String value) {
    if (this.CanSetFieldValue(this.routingType, value)) {
      this.routingType = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the type of the e-mail address.
  /// </summary>
  enumerations.MailboxType get MailboxType => this.mailboxType;

  set MailboxType(enumerations.MailboxType value) {
    if (this.CanSetFieldValue(this.mailboxType, value)) {
      this.mailboxType = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the Id of the contact the e-mail address represents. When Id is specified, Address
  /// should be set to null.
  /// </summary>
  ItemId get Id => this.id;

  set Id(ItemId value) {
    if (this.CanSetFieldValue(this.id, value)) {
      this.id = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Defines an implicit conversion between a String representing an SMTP address and EmailAddress.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address to convert to EmailAddress.</param>
  /// <returns>An EmailAddress initialized with the specified SMTP address.</returns>
// static implicit operator EmailAddress(String smtpAddress)
//        {
//            return new EmailAddress(smtpAddress);
//        }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.Name:
        this.name = reader.ReadElementValue();
        return true;
      case XmlElementNames.EmailAddress:
        this.address = reader.ReadElementValue();
        return true;
      case XmlElementNames.RoutingType:
        this.routingType = reader.ReadElementValue();
        return true;
      case XmlElementNames.MailboxType:
        this.mailboxType = reader.ReadElementValue<enumerations.MailboxType>();
        return true;
      case XmlElementNames.ItemId:
        this.id = new ItemId();
        this.id.LoadFromXml(reader, reader.LocalName);
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
    writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Name, this.Name);
    writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.EmailAddress, this.Address);
    writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.RoutingType, this.RoutingType);
    writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.MailboxType, this.MailboxType);

    if (this.Id != null) {
      this.Id.WriteToXml(writer, XmlElementNames.ItemId);
    }
  }

  /// <summary>

  /// </summary>
  /// <returns>String representation of instance.</returns>
  String GetSearchString() {
    return this.Address;
  }

  /// <summary>
  /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  String toString() {
    String addressPart;

    if (StringUtils.IsNullOrEmpty(this.Address)) {
      return "";
    }

    if (!StringUtils.IsNullOrEmpty(this.RoutingType)) {
      addressPart = this.RoutingType + ":" + this.Address;
    } else {
      addressPart = this.Address;
    }

    if (!StringUtils.IsNullOrEmpty(this.Name)) {
      return this.Name + " <" + addressPart + ">";
    } else {
      return addressPart;
    }
  }
}
