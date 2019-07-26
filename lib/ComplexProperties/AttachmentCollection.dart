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

import 'dart:typed_data';

import 'package:ews/ComplexProperties/Attachment.dart';
import 'package:ews/ComplexProperties/ComplexPropertyCollection.dart';
import 'package:ews/ComplexProperties/FileAttachment.dart';
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ReferenceAttachment.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/Responses/CreateAttachmentResponse.dart';
import 'package:ews/Core/Responses/DeleteAttachmentResponse.dart';
import 'package:ews/Core/Responses/ServiceResponseCollection.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceResult.dart';
import 'package:ews/Exceptions/CreateAttachmentException.dart';
import 'package:ews/Exceptions/DeleteAttachmentException.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/Interfaces/IOwnedProperty.dart';

/// <summary>
    /// Represents an item's attachment collection.
    /// </summary>
//    [EditorBrowsable(EditorBrowsableState.Never)]
  class AttachmentCollection extends ComplexPropertyCollection<Attachment> implements IOwnedProperty
    {
        /// <summary>
        /// The item owner that owns this attachment collection
        /// </summary>
        /* private */ Item owner;

        /// <summary>
        /// Initializes a new instance of AttachmentCollection.
        /// </summary>
        AttachmentCollection()
            : super();

        /// <summary>
        /// The owner of this attachment collection.
        /// </summary>
      ServiceObject get Owner => this.owner;

      set Owner(ServiceObject value) {
        Item item = value as Item;

//        EwsUtilities.Assert(
//            item != null,
//            "AttachmentCollection.IOwnedProperty.set_Owner",
//            "value is not a descendant of ItemBase");

        this.owner = item;
      }

        /// <summary>
        /// Adds a file attachment to the collection.
        /// </summary>
        /// <param name="fileName">The name of the file representing the content of the attachment.</param>
        /// <returns>A FileAttachment instance.</returns>
// FileAttachment AddFileAttachment(String fileName)
//        {
//            return this.AddFileAttachment(Path.GetFileName(fileName), fileName);
//        }

        /// <summary>
        /// Adds a file attachment to the collection.
        /// </summary>
        /// <param name="name">The display name of the new attachment.</param>
        /// <param name="fileName">The name of the file representing the content of the attachment.</param>
        /// <returns>A FileAttachment instance.</returns>
// FileAttachment AddFileAttachment(String name, String fileName)
//        {
//            FileAttachment fileAttachment = new FileAttachment.withOwner(this.owner);
//            fileAttachment.Name = name;
//            fileAttachment.FileName = fileName;
//
//            this.InternalAdd(fileAttachment);
//
//            return fileAttachment;
//        }

        /// <summary>
        /// Adds a file attachment to the collection.
        /// </summary>
        /// <param name="name">The display name of the new attachment.</param>
        /// <param name="contentStream">The stream from which to read the content of the attachment.</param>
        /// <returns>A FileAttachment instance.</returns>
 FileAttachment AddFileAttachmentWithStream(String name, Stream contentStream)
        {
            FileAttachment fileAttachment = new FileAttachment.withOwner(this.owner);
            fileAttachment.Name = name;
            fileAttachment.ContentStream = contentStream;

            this.InternalAdd(fileAttachment);

            return fileAttachment;
        }

        /// <summary>
        /// Adds a file attachment to the collection.
        /// </summary>
        /// <param name="name">The display name of the new attachment.</param>
        /// <param name="content">A byte arrays representing the content of the attachment.</param>
        /// <returns>A FileAttachment instance.</returns>
 FileAttachment AddFileAttachmentWithContent(String name, Uint8List content)
        {
            FileAttachment fileAttachment = new FileAttachment.withOwner(this.owner);
            fileAttachment.Name = name;
            fileAttachment.Content = content;

            this.InternalAdd(fileAttachment);

            return fileAttachment;
        }

        /// <summary>
        /// Adds a reference attachment to the collection
        /// </summary>
        /// <param name="name">The display name of the new attachment.</param>
        /// <param name="attachLongPathName">The fully-qualified path identifying the attachment</param>
        /// <returns>A ReferenceAttachment instance</returns>
// ReferenceAttachment AddReferenceAttachment(
//            String name,
//            String attachLongPathName)
//        {
//            ReferenceAttachment referenceAttachment = new ReferenceAttachment(this.owner);
//
//            referenceAttachment.Name = name;
//            referenceAttachment.AttachLongPathName = attachLongPathName;
//
//            this.InternalAdd(referenceAttachment);
//
//            return referenceAttachment;
//        }

        /// <summary>
        /// Adds an item attachment to the collection
        /// </summary>
        /// <typeparam name="TItem">The type of the item to attach.</typeparam>
        /// <returns>An ItemAttachment instance.</returns>
// ItemAttachment<TItem> AddItemAttachment<TItem extends Item>()
//        {
//            if (typeof(TItem).GetCustomAttributes(typeof(AttachableAttribute), false).Length == 0)
//            {
//                throw new InvalidOperationException(
//                    string.Format(
//                        "Items of type {0} are not supported as attachments.",
//                        typeof(TItem).Name));
//            }
//
//            ItemAttachment<TItem> itemAttachment = new ItemAttachment<TItem>(this.owner);
//            itemAttachment.Item = (TItem)EwsUtilities.CreateItemFromItemClass(itemAttachment, typeof(TItem), true);
//
//            this.InternalAdd(itemAttachment);
//
//            return itemAttachment;
//        }

        /// <summary>
        /// Removes all attachments from this collection.
        /// </summary>
 void Clear()
        {
            this.InternalClear();
        }

        /// <summary>
        /// Removes the attachment at the specified index.
        /// </summary>
        /// <param name="index">Index of the attachment to remove.</param>
 void RemoveAt(int index)
        {
            if (index < 0 || index >= this.Count)
            {
                throw new RangeError.range(index, 0, this.Count, "index", "Strings.IndexIsOutOfRange");
            }

            this.InternalRemoveAt(index);
        }

        /// <summary>
        /// Removes the specified attachment.
        /// </summary>
        /// <param name="attachment">The attachment to remove.</param>
        /// <returns>True if the attachment was successfully removed from the collection, false otherwise.</returns>
 bool Remove(Attachment attachment)
        {
            EwsUtilities.ValidateParam(attachment, "attachment");

            return this.InternalRemove(attachment);
        }

        /// <summary>
        /// Instantiate the appropriate attachment type depending on the current XML element name.
        /// </summary>
        /// <param name="xmlElementName">The XML element name from which to determine the type of attachment to create.</param>
        /// <returns>An Attachment instance.</returns>
@override
        Attachment CreateComplexProperty(String xmlElementName)
        {
            switch (xmlElementName)
            {
                case XmlElementNames.FileAttachment:
                    return new FileAttachment.withOwner(this.owner);
                case XmlElementNames.ItemAttachment:
                    return new ItemAttachment.withOwner(this.owner);
                case XmlElementNames.ReferenceAttachment:
                    return new ReferenceAttachment.withOwner(this.owner);
                default:
                    return null;
            }
        }

        /// <summary>
        /// Determines the name of the XML element associated with the complexProperty parameter.
        /// </summary>
        /// <param name="complexProperty">The attachment object for which to determine the XML element name with.</param>
        /// <returns>The XML element name associated with the complexProperty parameter.</returns>
@override
        String GetCollectionItemXmlElementName(Attachment complexProperty)
        {
            if (complexProperty is FileAttachment)
            {
                return XmlElementNames.FileAttachment;
            }
            else if (complexProperty is ReferenceAttachment)
            {
                return XmlElementNames.ReferenceAttachment;
            }
            else
            {
                return XmlElementNames.ItemAttachment;
            }
        }

        /// <summary>
        /// Saves this collection by creating new attachment and deleting removed ones.
        /// </summary>
        Future<void> Save() async
        {
            List<Attachment> attachments = new List<Attachment>();

            // Retrieve a list of attachments that have to be deleted.
            for (Attachment attachment in this.RemovedItems)
            {
                if (!attachment.IsNew)
                {
                    attachments.add(attachment);
                }
            }

            // If any, delete them by calling the DeleteAttachment web method.
            if (attachments.length > 0)
            {
                await this.InternalDeleteAttachments(attachments);
            }

            attachments.clear();

            // Retrieve a list of attachments that have to be created.
            for (Attachment attachment in this)
            {
                if (attachment.IsNew)
                {
                    attachments.add(attachment);
                }
            }

            // If there are any, create them by calling the CreateAttachment web method.
            if (attachments.length > 0)
            {
                if (this.owner.IsAttachment)
                {
                    await this.InternalCreateAttachments(this.owner.ParentAttachment.Id, attachments);
                }
                else
                {
                  await this.InternalCreateAttachments(this.owner.Id.UniqueId, attachments);
                }
            }

            // Process all of the item attachments in this collection.
            for (Attachment attachment in this)
            {
                ItemAttachment itemAttachment = attachment as ItemAttachment;
                if (itemAttachment != null)
                {
                    // Make sure item was created/loaded before trying to create/delete sub-attachments
                    if (itemAttachment.Item != null)
                    {
                        // Create/delete any sub-attachments
                        await itemAttachment.Item.Attachments.Save();

                        // Clear the item's change log
                        itemAttachment.Item.ClearChangeLog();
                    }
                }
            }

            super.ClearChangeLog();
        }

        /// <summary>
        /// Determines whether there are any unsaved attachment collection changes.
        /// </summary>
        /// <returns>True if attachment adds or deletes haven't been processed yet.</returns>
        bool HasUnprocessedChanges()
        {
            // Any new attachments?
            for (Attachment attachment in this)
            {
                if (attachment.IsNew)
                {
                    return true;
                }
            }

            // Any pending deletions?
            for (Attachment attachment in this.RemovedItems)
            {
                if (!attachment.IsNew)
                {
                    return true;
                }
            }

            // Recurse: process item attachments to check for new or deleted sub-attachments.
            for (ItemAttachment itemAttachment in this.OfType<ItemAttachment>())
            {
                if (itemAttachment.Item != null)
                {
                    if (itemAttachment.Item.Attachments.HasUnprocessedChanges())
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        /// <summary>
        /// Disables the change log clearing mechanism. Attachment collections are saved separately
        /// from the items they belong to.
        /// </summary>
@override
        void ClearChangeLog()
        {
            // Do nothing
        }

        /// <summary>
        /// Validates this instance.
        /// </summary>
        void Validate()
        {
            // Validate all added attachments
            bool contactPhotoFound = false;

            for (int attachmentIndex = 0; attachmentIndex < this.AddedItems.length; attachmentIndex++)
            {
                Attachment attachment = this.AddedItems[attachmentIndex];
                if (attachment.IsNew)
                {
                    // At the server side, only the last attachment with IsContactPhoto is kept, all other IsContactPhoto
                    // attachments are removed. CreateAttachment will generate AttachmentId for each of such attachments (although
                    // only the last one is valid).
                    //
                    // With E14 SP2 CreateItemWithAttachment, such request will only return 1 AttachmentId; but the client
                    // expects to see all, so let us prevent such "invalid" request in the first place.
                    //
                    // The IsNew check is to still let CreateAttachmentRequest allow multiple IsContactPhoto attachments.
                    //
                    if (this.owner.IsNew && this.owner.Service.RequestedServerVersion.index >= ExchangeVersion.Exchange2010_SP2.index)
                    {
                        FileAttachment fileAttachment = attachment as FileAttachment;

                        if (fileAttachment != null && fileAttachment.IsContactPhoto)
                        {
                            if (contactPhotoFound)
                            {
                                throw new ServiceValidationException("Strings.MultipleContactPhotosInAttachment");
                            }

                            contactPhotoFound = true;
                        }
                    }

                    attachment.ValidateWithIndex(attachmentIndex);
                }
            }
        }

        /// <summary>
        /// Calls the DeleteAttachment web method to delete a list of attachments.
        /// </summary>
        /// <param name="attachments">The attachments to delete.</param>
        /* private */ Future<void> InternalDeleteAttachments(Iterable<Attachment> attachments) async
        {
            ServiceResponseCollection<DeleteAttachmentResponse> responses = await this.owner.Service.DeleteAttachments(attachments);

            for (DeleteAttachmentResponse response in responses)
            {
                // We remove all attachments that were successfully deleted from the change log. We should never
                // receive a warning from EWS, so we ignore them.
                if (response.Result != ServiceResult.Error)
                {
                    this.RemoveFromChangeLog(response.Attachment);
                }
            }

            // TODO : Should we throw for warnings as well?
            if (responses.OverallResult == ServiceResult.Error)
            {
                throw new DeleteAttachmentException(responses, "Strings.AtLeastOneAttachmentCouldNotBeDeleted");
            }
        }

        /// <summary>
        /// Calls the CreateAttachment web method to create a list of attachments.
        /// </summary>
        /// <param name="parentItemId">The Id of the parent item of the new attachments.</param>
        /// <param name="attachments">The attachments to create.</param>
        /* private */ Future<void> InternalCreateAttachments(String parentItemId, Iterable<Attachment> attachments) async
        {
            ServiceResponseCollection<CreateAttachmentResponse> responses = await this.owner.Service.CreateAttachments(parentItemId, attachments);

            for (CreateAttachmentResponse response in responses)
            {
                // We remove all attachments that were successfully created from the change log. We should never
                // receive a warning from EWS, so we ignore them.
                if (response.Result != ServiceResult.Error)
                {
                    this.RemoveFromChangeLog(response.Attachment);
                }
            }

            // TODO : Should we throw for warnings as well?
            if (responses.OverallResult == ServiceResult.Error)
            {
                throw new CreateAttachmentException(responses, "Strings.AttachmentCreationFailed");
            }
        }

        List<T> OfType<T extends Attachment>() {
          return this.where((attachment) => attachment is T)
              .map((attachment) => attachment as T)
              .toList();
        }
    }
