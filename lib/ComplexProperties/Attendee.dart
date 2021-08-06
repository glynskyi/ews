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
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ResponseType.dart';

/// <summary>
/// Represents an attendee to a meeting.
/// </summary>
class Attendee extends EmailAddress {
  MeetingResponseType? _responseType;

  DateTime? _lastResponseTime;

  /// <summary>
  /// Initializes a new instance of the <see cref="Attendee"/> class.
  /// </summary>
  /// <param name="name">The name used to initialize the Attendee.</param>
  /// <param name="smtpAddress">The SMTP address used to initialize the Attendee.</param>
  /// <param name="routingType">The routing type used to initialize the Attendee.</param>
  Attendee({String? name, String? smtpAddress, String? routingType})
      : super(name: name, smtpAddress: smtpAddress, routingType: routingType);

  /// <summary>
  /// Initializes a new instance of the <see cref="Attendee"/> class from an EmailAddress.
  /// </summary>
  /// <param name="mailbox">The mailbox used to initialize the Attendee.</param>
  Attendee.withEmailAddress(EmailAddress mailbox)
      : super.withEmailAddress(mailbox);

  /// <summary>
  /// Gets the type of response the attendee gave to the meeting invitation it received.
  /// </summary>
  MeetingResponseType? get ResponseType => this._responseType;

  /// <summary>
  /// Gets the date and time when the attendee last responded to a meeting invitation or update.
  /// </summary>
  DateTime? get LastResponseTime => this._lastResponseTime;

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  Future<bool> TryReadElementFromXml(EwsServiceXmlReader reader) async {
    switch (reader.LocalName) {
      case XmlElementNames.Mailbox:
        await this.LoadFromXml(reader, reader.LocalName);
        return true;
      case XmlElementNames.ResponseType:
        this._responseType =
            await reader.ReadElementValue<MeetingResponseType>();
        return true;
      case XmlElementNames.LastResponseTime:
        this._lastResponseTime = await reader.ReadElementValueAsDateTime();
        return true;
      default:
        return super.TryReadElementFromXml(reader);
    }
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(this.Namespace, XmlElementNames.Mailbox);
    super.WriteElementsToXml(writer);
    writer.WriteEndElement();
  }
}
