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

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/MeetingAttendeeType.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Interfaces/ISelfValidate.dart';

/// <summary>
/// Represents information about an attendee for which to request availability information.
/// </summary>
class AttendeeInfo extends ISelfValidate {
  String _smtpAddress;
  MeetingAttendeeType _attendeeType = MeetingAttendeeType.Required;
  bool _excludeConflicts;

  /// <summary>
  /// Initializes a new instance of the <see cref="AttendeeInfo"/> class.
  /// </summary>
  AttendeeInfo() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="AttendeeInfo"/> class.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address of the attendee.</param>
  /// <param name="attendeeType">The yype of the attendee.</param>
  /// <param name="excludeConflicts">Indicates whether times when this attendee is not available should be returned.</param>
  AttendeeInfo.withSmtpAddress(this._smtpAddress,
      [this._attendeeType = MeetingAttendeeType.Required,
      this._excludeConflicts = false]);

  /// <summary>
  /// Defines an implicit conversion between a String representing an SMTP address and AttendeeInfo.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address to convert to AttendeeInfo.</param>
  /// <returns>An AttendeeInfo initialized with the specified SMTP address.</returns>
// static implicit operator AttendeeInfo(String smtpAddress)
//        {
//            return new AttendeeInfo(smtpAddress);
//        }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.MailboxData);

    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Email);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Address, this.SmtpAddress);
    writer.WriteEndElement(); // Email

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.AttendeeType, this._attendeeType);

    writer.WriteElementValueWithNamespace(XmlNamespace.Types,
        XmlElementNames.ExcludeConflicts, this._excludeConflicts);

    writer.WriteEndElement(); // MailboxData
  }

  /// <summary>
  /// Gets or sets the SMTP address of this attendee.
  /// </summary>
  String get SmtpAddress => this._smtpAddress;

  set SmtpAddress(String value) => this._smtpAddress = value;

  /// <summary>
  /// Gets or sets the type of this attendee.
  /// </summary>
  MeetingAttendeeType get AttendeeType => this._attendeeType;

  set AttendeeType(MeetingAttendeeType value) => this._attendeeType = value;

  /// <summary>
  /// Gets or sets a value indicating whether times when this attendee is not available should be returned.
  /// </summary>
  bool get ExcludeConflicts => this._excludeConflicts;

  set ExcludeConflicts(bool value) => this._excludeConflicts = value;

  /// <summary>
  /// Validates this instance.
  /// </summary>
  void Validate() {
    EwsUtilities.ValidateParam(this._smtpAddress, "SmtpAddress");
  }
}
