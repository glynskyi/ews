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

import 'package:ews/ComplexProperties/AttachmentCollection.dart';
import 'package:ews/ComplexProperties/EmailAddressCollection.dart';
import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/Core/ServiceObjects/Items/EmailMessage.dart' as serviceObjects;
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/ResponseObjects/CalendarResponseMessageBase.dart';
import 'package:ews/Core/ServiceObjects/Schemas/CalendarResponseObjectSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/EmailMessageSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Enumerations/Sensitivity.dart' as enumerations;

/// <summary>
/// Represents the base class for accept, tentatively accept and decline response messages.
/// </summary>
/// <typeparam name="TMessage">The type of message that is created when this response message is saved.</typeparam>
abstract class CalendarResponseMessage<TMessage extends serviceObjects.EmailMessage>
    extends CalendarResponseMessageBase<TMessage> {
  /// <summary>
  /// Initializes a new instance of the <see cref="CalendarResponseMessage&lt;TMessage&gt;"/> class.
  /// </summary>
  /// <param name="referenceItem">The reference item.</param>
  CalendarResponseMessage(Item referenceItem) : super(referenceItem) {}

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return CalendarResponseObjectSchema.Instance;
  }

  /// <summary>
  /// Gets or sets the body of the response.
  /// </summary>
  MessageBody get Body => this.PropertyBag[ItemSchema.Body];

  set Body(MessageBody value) => this.PropertyBag[ItemSchema.Body] = value;

  /// <summary>
  /// Gets a list of recipients the response will be sent to.
  /// </summary>
  EmailAddressCollection get ToRecipients => this.PropertyBag[EmailMessageSchema.ToRecipients];

  /// <summary>
  /// Gets a list of recipients the response will be sent to as Cc.
  /// </summary>
  EmailAddressCollection get CcRecipients => this.PropertyBag[EmailMessageSchema.CcRecipients];

  /// <summary>
  /// Gets a list of recipients this response will be sent to as Bcc.
  /// </summary>
  EmailAddressCollection get BccRecipients => this.PropertyBag[EmailMessageSchema.BccRecipients];

  // TODO : Does this need to be exposed?
  String get ItemClass => this.PropertyBag[ItemSchema.ItemClass];

  set ItemClass(String value) => this.PropertyBag[ItemSchema.ItemClass] = value;

  /// <summary>
  /// Gets or sets the sensitivity of this response.
  /// </summary>
  enumerations.Sensitivity get Sensitivity => this.PropertyBag[ItemSchema.Sensitivity];

  set Sensitivity(enumerations.Sensitivity value) => this.PropertyBag[ItemSchema.Sensitivity] = value;

  /// <summary>
  /// Gets a list of attachments to this response.
  /// </summary>
  AttachmentCollection get Attachments => this.PropertyBag[ItemSchema.Attachments];

// TODO : Does this need to be exposed?
//               InternetMessageHeaderCollection get InternetMessageHeaders => this.PropertyBag[ItemSchema.InternetMessageHeaders];

  /// <summary>
  /// Gets or sets the sender of this response.
  /// </summary>
//        EmailAddress get Sender => this.PropertyBag[EmailMessageSchema.Sender];
//        set Sender(EmailAddress value) => this.PropertyBag[EmailMessageSchema.Sender] = value;

}
