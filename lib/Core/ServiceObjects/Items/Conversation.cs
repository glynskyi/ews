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






    /// <summary>
    /// Represents a collection of Conversation related properties.
    /// Properties available on this object are defined in the ConversationSchema class.
    /// </summary>
    [ServiceObjectDefinition(XmlElementNames.Conversation)]
 class Conversation : ServiceObject
    {
        /// <summary>
        /// Initializes an unsaved local instance of <see cref="Conversation"/>.
        /// </summary>
        /// <param name="service">The ExchangeService object to which the item will be bound.</param>
        Conversation(ExchangeService service)
            : super(service)
        {
        }

        /// <summary>
        /// method to return the schema associated with this type of object.
        /// </summary>
        /// <returns>The schema associated with this type of object.</returns>
@override
        ServiceObjectSchema GetSchema()
        {
            return ConversationSchema.Instance;
        }

        /// <summary>
        /// Gets the minimum required server version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2010_SP1;
        }

        /// <summary>
        /// The property definition for the Id of this object.
        /// </summary>
        /// <returns>A PropertyDefinition instance.</returns>
@override
        PropertyDefinition GetIdPropertyDefinition()
        {
            return ConversationSchema.Id;
        }

        #region Not Supported Methods or properties

        /// <summary>
        /// This method is not supported in this object.
        /// Loads the specified set of properties on the object.
        /// </summary>
        /// <param name="propertySet">The properties to load.</param>
@override
        void InternalLoad(PropertySet propertySet)
        {
            throw new NotSupportedException();
        }

        /// <summary>
        /// This is not supported in this object.
        /// Deletes the object.
        /// </summary>
        /// <param name="deleteMode">The deletion mode.</param>
        /// <param name="sendCancellationsMode">Indicates whether meeting cancellation messages should be sent.</param>
        /// <param name="affectedTaskOccurrences">Indicate which occurrence of a recurring task should be deleted.</param>
@override
        void InternalDelete(DeleteMode deleteMode, SendCancellationsMode? sendCancellationsMode, AffectedTaskOccurrence? affectedTaskOccurrences)
        {
            throw new NotSupportedException();
        }

        /// <summary>
        /// This method is not supported in this object.
        /// Gets the name of the change XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetChangeXmlElementName()
        {
            throw new NotSupportedException();
        }

        /// <summary>
        /// This method is not supported in this object.
        /// Gets the name of the delete field XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetDeleteFieldXmlElementName()
        {
            throw new NotSupportedException();
        }

        /// <summary>
        /// This method is not supported in this object.
        /// Gets the name of the set field XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetSetFieldXmlElementName()
        {
            throw new NotSupportedException();
        }

        /// <summary>
        /// This method is not supported in this object.
        /// Gets a value indicating whether a time zone SOAP header should be emitted in a CreateItem
        /// or UpdateItem request so this item can be property saved or updated.
        /// </summary>
        /// <param name="isUpdateOperation">Indicates whether the operation being petrformed is an update operation.</param>
        /// <returns><c>true</c> if a time zone SOAP header should be emitted; otherwise, <c>false</c>.</returns>
@override
        bool GetIsTimeZoneHeaderRequired(bool isUpdateOperation)
        {
            throw new NotSupportedException();
        }

        #endregion

        #region Conversation Action Methods
        /// <summary>
        /// Sets up a conversation so that any item received within that conversation is always categorized.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="categories">The categories that should be stamped on items in the conversation.</param>
        /// <param name="processSynchronously">Indicates whether the method should return only once enabling this rule and stamping existing items
        /// in the conversation is completely done. If processSynchronously is false, the method returns immediately.
        /// </param>
 void EnableAlwaysCategorizeItems(Iterable<string> categories, bool processSynchronously)
        {
            this.Service.EnableAlwaysCategorizeItemsInConversations(
                    new ConversationId[] { this.Id },
                    categories,
                    processSynchronously)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Sets up a conversation so that any item received within that conversation is no longer categorized.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="processSynchronously">Indicates whether the method should return only once disabling this rule and removing the categories from existing items
        /// in the conversation is completely done. If processSynchronously is false, the method returns immediately.
        /// </param>
 void DisableAlwaysCategorizeItems(bool processSynchronously)
        {
            this.Service.DisableAlwaysCategorizeItemsInConversations(
                new ConversationId[] { this.Id },
                processSynchronously)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Sets up a conversation so that any item received within that conversation is always moved to Deleted Items folder.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="processSynchronously">Indicates whether the method should return only once enabling this rule and deleting existing items
        /// in the conversation is completely done. If processSynchronously is false, the method returns immediately.
        /// </param>
 void EnableAlwaysDeleteItems(bool processSynchronously)
        {
            this.Service.EnableAlwaysDeleteItemsInConversations(
                new ConversationId[] { this.Id },
                processSynchronously)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Sets up a conversation so that any item received within that conversation is no longer moved to Deleted Items folder.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="processSynchronously">Indicates whether the method should return only once disabling this rule and restoring the items
        /// in the conversation is completely done. If processSynchronously is false, the method returns immediately.
        /// </param>
 void DisableAlwaysDeleteItems(bool processSynchronously)
        {
            this.Service.DisableAlwaysDeleteItemsInConversations(
                new ConversationId[] { this.Id },
                processSynchronously)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Sets up a conversation so that any item received within that conversation is always moved to a specific folder.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="destinationFolderId">The Id of the folder to which conversation items should be moved.</param>
        /// <param name="processSynchronously">Indicates whether the method should return only once enabling this rule
        /// and moving existing items in the conversation is completely done. If processSynchronously is false, the method
        /// returns immediately.
        /// </param>
 void EnableAlwaysMoveItems(FolderId destinationFolderId, bool processSynchronously)
        {
            this.Service.EnableAlwaysMoveItemsInConversations(
                        new ConversationId[] { this.Id },
                        destinationFolderId,
                        processSynchronously)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Sets up a conversation so that any item received within that conversation is no longer moved to a specific
        /// folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="processSynchronously">Indicates whether the method should return only once disabling this
        /// rule is completely done. If processSynchronously is false, the method returns immediately.
        /// </param>
 void DisableAlwaysMoveItemsInConversation(bool processSynchronously)
        {
            this.Service.DisableAlwaysMoveItemsInConversations(
                new ConversationId[] { this.Id },
                processSynchronously)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Deletes items in the specified conversation.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order to be deleted. If contextFolderId is
        /// null, items across the entire mailbox are deleted.</param>
        /// <param name="deleteMode">The deletion mode.</param>
 void DeleteItems(
            FolderId contextFolderId,
            DeleteMode deleteMode)
        {
            this.Service.DeleteItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                deleteMode)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Moves items in the specified conversation to a specific folder.
        /// Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order to be moved. If contextFolderId is null,
        /// items across the entire mailbox are moved.</param>
        /// <param name="destinationFolderId">The Id of the destination folder.</param>
 void MoveItemsInConversation(
            FolderId contextFolderId,
            FolderId destinationFolderId)
        {
            this.Service.MoveItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                destinationFolderId)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Copies items in the specified conversation to a specific folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order to be copied. If contextFolderId
        /// is null, items across the entire mailbox are copied.</param>
        /// <param name="destinationFolderId">The Id of the destination folder.</param>
 void CopyItemsInConversation(
            FolderId contextFolderId,
            FolderId destinationFolderId)
        {
            this.Service.CopyItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                destinationFolderId)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Sets the read state of items in the specified conversation. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order for their read state to
        /// be set. If contextFolderId is null, the read states of items across the entire mailbox are set.</param>
        /// <param name="isRead">if set to <c>true</c>, conversation items are marked as read; otherwise they are
        /// marked as unread.</param>
 void SetReadStateForItemsInConversation(
            FolderId contextFolderId,
            bool isRead)
        {
            this.Service.SetReadStateForItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                isRead)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Sets the read state of items in the specified conversation. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order for their read state to
        /// be set. If contextFolderId is null, the read states of items across the entire mailbox are set.</param>
        /// <param name="isRead">if set to <c>true</c>, conversation items are marked as read; otherwise they are
        /// marked as unread.</param>
        /// <param name="suppressReadReceipts">if set to <c>true</c> read receipts are suppressed.</param>
 void SetReadStateForItemsInConversation(
            FolderId contextFolderId,
            bool isRead,
            bool suppressReadReceipts)
        {
            this.Service.SetReadStateForItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                isRead,
                suppressReadReceipts)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Sets the retention policy of items in the specified conversation. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order for their retention policy to
        /// be set. If contextFolderId is null, the retention policy of items across the entire mailbox are set.</param>
        /// <param name="retentionPolicyType">Retention policy type.</param>
        /// <param name="retentionPolicyTagId">Retention policy tag id.  Null will clear the policy.</param>
 void SetRetentionPolicyForItemsInConversation(
            FolderId contextFolderId,
            RetentionType retentionPolicyType,
            Guid? retentionPolicyTagId)
        {
            this.Service.SetRetentionPolicyForItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                retentionPolicyType,
                retentionPolicyTagId)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Flag conversation items as complete. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order to be flagged as complete. If contextFolderId is
        /// null, items in conversation across the entire mailbox are marked as complete.</param>
        /// <param name="completeDate">The complete date (can be null).</param>
 void FlagItemsComplete(
            FolderId contextFolderId,
            DateTime? completeDate)
        {
            Flag flag = new Flag() { FlagStatus = ItemFlagStatus.Complete };
            if (completeDate.HasValue)
            {
                flag.CompleteDate = completeDate.Value;
            }

            this.Service.SetFlagStatusForItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                flag)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Clear flags for conversation items. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order to be unflagged. If contextFolderId is
        /// null, flags for items in conversation across the entire mailbox are cleared.</param>
 void ClearItemFlags(FolderId contextFolderId)
        {
            Flag flag = new Flag() { FlagStatus = ItemFlagStatus.NotFlagged };

            this.Service.SetFlagStatusForItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                flag)[0].ThrowIfNecessary();
        }

        /// <summary>
        /// Flags conversation items. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="contextFolderId">The Id of the folder items must belong to in order to be flagged. If contextFolderId is
        /// null, items in conversation across the entire mailbox are flagged.</param>
        /// <param name="startDate">The start date (can be null).</param>
        /// <param name="dueDate">The due date (can be null).</param>
 void FlagItems(
            FolderId contextFolderId,
            DateTime? startDate,
            DateTime? dueDate)
        {
            Flag flag = new Flag() { FlagStatus = ItemFlagStatus.Flagged };
            if (startDate.HasValue)
            {
                flag.StartDate = startDate.Value;
            }
            if (dueDate.HasValue)
            {
                flag.DueDate = dueDate.Value;
            }

            this.Service.SetFlagStatusForItemsInConversations(
                new MapEntry<ConversationId, DateTime?>[]
                {
                    new MapEntry<ConversationId, DateTime?>(
                        this.Id,
                        this.GlobalLastDeliveryTime)
                },
                contextFolderId,
                flag)[0].ThrowIfNecessary();
        }
        #endregion

        #region Properties
        /// <summary>
        /// Gets the Id of this Conversation.
        /// </summary>
        ConversationId get Id => this.PropertyBag[this.GetIdPropertyDefinition()];

        /// <summary>
        /// Gets the topic of this Conversation.
        /// </summary>
 String Topic
        {
            get
            {
                String returnValue = String.Empty;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.Topic))
                {
                    this.PropertyBag.TryGetProperty<string>(
                        ConversationSchema.Topic,
                        out returnValue);
                }

                return returnValue;
            }
        }

        /// <summary>
        /// Gets a list of all the people who have received messages in this conversation in the current folder only.
        /// </summary>
        StringList get UniqueRecipients => this.PropertyBag[ConversationSchema.UniqueRecipients];

        /// <summary>
        /// Gets a list of all the people who have received messages in this conversation across all folders in the mailbox.
        /// </summary>
        StringList get GlobalUniqueRecipients => this.PropertyBag[ConversationSchema.GlobalUniqueRecipients];

        /// <summary>
        /// Gets a list of all the people who have sent messages that are currently unread in this conversation in the current folder only.
        /// </summary>
 StringList UniqueUnreadSenders
        {
            get
            {
                StringList unreadSenders = null;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.UniqueUnreadSenders))
                {
                    this.PropertyBag.TryGetProperty<StringList>(
                                            ConversationSchema.UniqueUnreadSenders,
                                            out unreadSenders);
                }

                return unreadSenders;
            }
        }

        /// <summary>
        /// Gets a list of all the people who have sent messages that are currently unread in this conversation across all folders in the mailbox.
        /// </summary>
 StringList GlobalUniqueUnreadSenders
        {
            get
            {
                StringList unreadSenders = null;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.GlobalUniqueUnreadSenders))
                {
                    this.PropertyBag.TryGetProperty<StringList>(
                                            ConversationSchema.GlobalUniqueUnreadSenders,
                                            out unreadSenders);
                }

                return unreadSenders;
            }
        }

        /// <summary>
        /// Gets a list of all the people who have sent messages in this conversation in the current folder only.
        /// </summary>
        StringList get UniqueSenders => this.PropertyBag[ConversationSchema.UniqueSenders];

        /// <summary>
        /// Gets a list of all the people who have sent messages in this conversation across all folders in the mailbox.
        /// </summary>
        StringList get GlobalUniqueSenders => this.PropertyBag[ConversationSchema.GlobalUniqueSenders];

        /// <summary>
        /// Gets the delivery time of the message that was last received in this conversation in the current folder only.
        /// </summary>
        DateTime get LastDeliveryTime => this.PropertyBag[ConversationSchema.LastDeliveryTime];

        /// <summary>
        /// Gets the delivery time of the message that was last received in this conversation across all folders in the mailbox.
        /// </summary>
        DateTime get GlobalLastDeliveryTime => this.PropertyBag[ConversationSchema.GlobalLastDeliveryTime];

        /// <summary>
        /// Gets a list summarizing the categories stamped on messages in this conversation, in the current folder only.
        /// </summary>
 StringList Categories
        {
            get
            {
                StringList returnValue = null;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.Categories))
                {
                    this.PropertyBag.TryGetProperty<StringList>(
                                            ConversationSchema.Categories,
                                            out returnValue);
                }

                return returnValue;
            }
        }

        /// <summary>
        /// Gets a list summarizing the categories stamped on messages in this conversation, across all folders in the mailbox.
        /// </summary>
 StringList GlobalCategories
        {
            get
            {
                StringList returnValue = null;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.GlobalCategories))
                {
                    this.PropertyBag.TryGetProperty<StringList>(
                                            ConversationSchema.GlobalCategories,
                                            out returnValue);
                }

                return returnValue;
            }
        }

        /// <summary>
        /// Gets the flag status for this conversation, calculated by aggregating individual messages flag status in the current folder.
        /// </summary>
 ConversationFlagStatus FlagStatus
        {
            get
            {
                ConversationFlagStatus returnValue = ConversationFlagStatus.NotFlagged;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.FlagStatus))
                {
                    this.PropertyBag.TryGetProperty<ConversationFlagStatus>(ConversationSchema.FlagStatus, out returnValue);
                }

                return returnValue;
            }
        }

        /// <summary>
        /// Gets the flag status for this conversation, calculated by aggregating individual messages flag status across all folders in the mailbox.
        /// </summary>
 ConversationFlagStatus GlobalFlagStatus
        {
            get
            {
                ConversationFlagStatus returnValue = ConversationFlagStatus.NotFlagged;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.GlobalFlagStatus))
                {
                    this.PropertyBag.TryGetProperty<ConversationFlagStatus>(
                            ConversationSchema.GlobalFlagStatus,
                            out returnValue);
                }

                return returnValue;
            }
        }

        /// <summary>
        /// Gets a value indicating if at least one message in this conversation, in the current folder only, has an attachment.
        /// </summary>
        bool get HasAttachments => this.PropertyBag[ConversationSchema.HasAttachments];

        /// <summary>
        /// Gets a value indicating if at least one message in this conversation, across all folders in the mailbox, has an attachment.
        /// </summary>
        bool get GlobalHasAttachments => this.PropertyBag[ConversationSchema.GlobalHasAttachments];

        /// <summary>
        /// Gets the total number of messages in this conversation in the current folder only.
        /// </summary>
        int get MessageCount => this.PropertyBag[ConversationSchema.MessageCount];

        /// <summary>
        /// Gets the total number of messages in this conversation across all folders in the mailbox.
        /// </summary>
        int get GlobalMessageCount => this.PropertyBag[ConversationSchema.GlobalMessageCount];

        /// <summary>
        /// Gets the total number of unread messages in this conversation in the current folder only.
        /// </summary>
 int UnreadCount
        {
            get
            {
                int returnValue = 0;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.UnreadCount))
                {
                    this.PropertyBag.TryGetProperty<int>(
                                                ConversationSchema.UnreadCount,
                                                out returnValue);
                }

                return returnValue;
            }
        }

        /// <summary>
        /// Gets the total number of unread messages in this conversation across all folders in the mailbox.
        /// </summary>
 int GlobalUnreadCount
        {
            get
            {
                int returnValue = 0;

                // This property need not be present hence the property bag may not contain it.
                // Check for the presence of this property before accessing it.
                if (this.PropertyBag.Contains(ConversationSchema.GlobalUnreadCount))
                {
                    this.PropertyBag.TryGetProperty<int>(
                                                ConversationSchema.GlobalUnreadCount,
                                                out returnValue);
                }

                return returnValue;
            }
        }

        /// <summary>
        /// Gets the size of this conversation, calculated by adding the sizes of all messages in the conversation in the current folder only.
        /// </summary>
        int get Size => this.PropertyBag[ConversationSchema.Size];

        /// <summary>
        /// Gets the size of this conversation, calculated by adding the sizes of all messages in the conversation across all folders in the mailbox.
        /// </summary>
        int get GlobalSize => this.PropertyBag[ConversationSchema.GlobalSize];

        /// <summary>
        /// Gets a list summarizing the classes of the items in this conversation, in the current folder only.
        /// </summary>
        StringList get ItemClasses => this.PropertyBag[ConversationSchema.ItemClasses];

        /// <summary>
        /// Gets a list summarizing the classes of the items in this conversation, across all folders in the mailbox.
        /// </summary>
        StringList get GlobalItemClasses => this.PropertyBag[ConversationSchema.GlobalItemClasses];

        /// <summary>
        /// Gets the importance of this conversation, calculated by aggregating individual messages importance in the current folder only.
        /// </summary>
        Importance get Importance => this.PropertyBag[ConversationSchema.Importance];

        /// <summary>
        /// Gets the importance of this conversation, calculated by aggregating individual messages importance across all folders in the mailbox.
        /// </summary>
        Importance get GlobalImportance => this.PropertyBag[ConversationSchema.GlobalImportance];

        /// <summary>
        /// Gets the Ids of the messages in this conversation, in the current folder only.
        /// </summary>
        ItemIdCollection get ItemIds => this.PropertyBag[ConversationSchema.ItemIds];

        /// <summary>
        /// Gets the Ids of the messages in this conversation, across all folders in the mailbox.
        /// </summary>
        ItemIdCollection get GlobalItemIds => this.PropertyBag[ConversationSchema.GlobalItemIds];

        /// <summary>
        /// Gets the date and time this conversation was last modified.
        /// </summary>
        DateTime get LastModifiedTime => this.PropertyBag[ConversationSchema.LastModifiedTime];

        /// <summary>
        /// Gets the conversation instance key.
        /// </summary>
        Uint8List get InstanceKey => this.PropertyBag[ConversationSchema.InstanceKey];

        /// <summary>
        /// Gets the conversation Preview.
        /// </summary>
        String get Preview => this.PropertyBag[ConversationSchema.Preview];

        /// <summary>
        /// Gets the conversation IconIndex.
        /// </summary>
        IconIndex get IconIndex => this.PropertyBag[ConversationSchema.IconIndex];

        /// <summary>
        /// Gets the conversation global IconIndex.
        /// </summary>
        IconIndex get GlobalIconIndex => this.PropertyBag[ConversationSchema.GlobalIconIndex];

        /// <summary>
        /// Gets the draft item ids.
        /// </summary>
        ItemIdCollection get DraftItemIds => this.PropertyBag[ConversationSchema.DraftItemIds];

        /// <summary>
        /// Gets a value indicating if at least one message in this conversation, in the current folder only, is an IRM.
        /// </summary>
        bool get HasIrm => this.PropertyBag[ConversationSchema.HasIrm];

        /// <summary>
        /// Gets a value indicating if at least one message in this conversation, across all folders in the mailbox, is an IRM.
        /// </summary>
        bool get GlobalHasIrm => this.PropertyBag[ConversationSchema.GlobalHasIrm];

        #endregion
    }
