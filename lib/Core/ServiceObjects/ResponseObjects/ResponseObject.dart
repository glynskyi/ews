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






    import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/EmailMessage.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/Schemas/EmailMessageSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ResponseObjectSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Enumerations/AffectedTaskOccurrence.dart';
import 'package:ews/Enumerations/DeleteMode.dart';
import 'package:ews/Enumerations/MessageDisposition.dart';
import 'package:ews/Enumerations/SendCancellationsMode.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart';
import 'package:ews/Exceptions/NotSupportedException.dart';

/// <summary>
    /// Represents the base class for all responses that can be sent.
    /// </summary>
    /// <typeparam name="TMessage">Type of message.</typeparam>
 abstract class ResponseObject<TMessage extends EmailMessage> extends ServiceObject
    {
        /* private */ Item referenceItem;

        /// <summary>
        /// Initializes a new instance of the <see cref="ResponseObject&lt;TMessage&gt;"/> class.
        /// </summary>
        /// <param name="referenceItem">The reference item.</param>
        ResponseObject(Item referenceItem)
            : super(referenceItem.Service)
        {
            EwsUtilities.Assert(
                referenceItem != null,
                "ResponseObject.ctor",
                "referenceItem is null");

            referenceItem.ThrowIfThisIsNew();

            this.referenceItem = referenceItem;
        }

        /// <summary>
        /// method to return the schema associated with this type of object.
        /// </summary>
        /// <returns>The schema associated with this type of object.</returns>
@override
        ServiceObjectSchema GetSchema()
        {
            return ResponseObjectSchema.Instance;
        }

        /// <summary>
        /// Loads the specified set of properties on the object.
        /// </summary>
        /// <param name="propertySet">The properties to load.</param>
@override
        Future<void> InternalLoad(PropertySet propertySet)
        {
            throw new NotSupportedException();
        }

        /// <summary>
        /// Deletes the object.
        /// </summary>
        /// <param name="deleteMode">The deletion mode.</param>
        /// <param name="sendCancellationsMode">Indicates whether meeting cancellation messages should be sent.</param>
        /// <param name="affectedTaskOccurrences">Indicate which occurrence of a recurring task should be deleted.</param>
@override
        Future<void> InternalDelete(
            DeleteMode deleteMode,
            SendCancellationsMode sendCancellationsMode,
            AffectedTaskOccurrence affectedTaskOccurrences)
        {
            throw new NotSupportedException();
        }

        /// <summary>
        /// Create the response object.
        /// </summary>
        /// <param name="destinationFolderId">The destination folder id.</param>
        /// <param name="messageDisposition">The message disposition.</param>
        /// <returns>The list of items returned by EWS.</returns>
        Future<List<Item>> InternalCreate(FolderId destinationFolderId, MessageDisposition messageDisposition)
        {
            (this.PropertyBag[ResponseObjectSchema.ReferenceItemId] as ItemId).Assign(this.referenceItem.Id);

            return this.Service.InternalCreateResponseObject(
                this,
                destinationFolderId,
                messageDisposition);
        }

        /// <summary>
        /// Saves the response in the specified folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="destinationFolderId">The Id of the folder in which to save the response.</param>
        /// <returns>A TMessage that represents the response.</returns>
 Future<TMessage> SaveWithFolderId(FolderId destinationFolderId) async
        {
            EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");

            return (await this.InternalCreate(destinationFolderId, MessageDisposition.SaveOnly))[0] as TMessage;
        }

        /// <summary>
        /// Saves the response in the specified folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="destinationFolderName">The name of the folder in which to save the response.</param>
        /// <returns>A TMessage that represents the response.</returns>
 Future<TMessage> SaveWithWellKnownFolder(WellKnownFolderName destinationFolderName) async
        {
            return (await this.InternalCreate(new FolderId.fromWellKnownFolder(destinationFolderName), MessageDisposition.SaveOnly))[0] as TMessage;
        }

        /// <summary>
        /// Saves the response in the Drafts folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <returns>A TMessage that represents the response.</returns>
 Future<TMessage> Save() async
        {
            return (await this.InternalCreate(null, MessageDisposition.SaveOnly))[0] as TMessage;
        }

        /// <summary>
        /// Sends this response without saving a copy. Calling this method results in a call to EWS.
        /// </summary>
 Future<void> Send() async
        {
            await this.InternalCreate(null, MessageDisposition.SendOnly);
        }

        /// <summary>
        /// Sends this response and saves a copy in the specified folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="destinationFolderId">The Id of the folder in which to save the copy of the message.</param>
 void SendAndSaveCopyWithFolderId(FolderId destinationFolderId)
        {
            EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");

            this.InternalCreate(destinationFolderId, MessageDisposition.SendAndSaveCopy);
        }

        /// <summary>
        /// Sends this response and saves a copy in the specified folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="destinationFolderName">The name of the folder in which to save the copy of the message.</param>
 void SendAndSaveCopyWithWellKnownFolder(WellKnownFolderName destinationFolderName)
        {
            this.InternalCreate(new FolderId.fromWellKnownFolder(destinationFolderName), MessageDisposition.SendAndSaveCopy);
        }

        /// <summary>
        /// Sends this response and saves a copy in the Sent Items folder. Calling this method results in a call to EWS.
        /// </summary>
 void SendAndSaveCopy()
        {
            this.InternalCreate(
                null,
                MessageDisposition.SendAndSaveCopy);
        }

        /// <summary>
        /// Gets or sets a value indicating whether read receipts will be requested from recipients of this response.
        /// </summary>
        bool get IsReadReceiptRequested => this.PropertyBag[EmailMessageSchema.IsReadReceiptRequested];
        set IsReadReceiptRequested(bool value) => this.PropertyBag[EmailMessageSchema.IsReadReceiptRequested] = value;

        /// <summary>
        /// Gets or sets a value indicating whether delivery receipts should be sent to the sender.
        /// </summary>
        bool get IsDeliveryReceiptRequested => this.PropertyBag[EmailMessageSchema.IsDeliveryReceiptRequested];
        set IsDeliveryReceiptRequested(bool value) => this.PropertyBag[EmailMessageSchema.IsDeliveryReceiptRequested] = value;
    }
