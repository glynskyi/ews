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
    /// Represents a reply to a post item.
    /// </summary>
    [ServiceObjectDefinition(XmlElementNames.PostReplyItem, ReturnedByServer = false)]
 class PostReply extends ServiceObject
    {
        /* private */ Item referenceItem;

        /// <summary>
        /// Initializes a new instance of the <see cref="PostReply"/> class.
        /// </summary>
        /// <param name="referenceItem">The reference item.</param>
        PostReply(Item referenceItem)
            : super(referenceItem.Service)
        {
            EwsUtilities.Assert(
                referenceItem != null,
                "PostReply.ctor",
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
            return PostReplySchema.Instance;
        }

        /// <summary>
        /// Gets the minimum required server version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2007_SP1;
        }

        /// <summary>
        /// Create a PostItem response.
        /// </summary>
        /// <param name="parentFolderId">The parent folder id.</param>
        /// <param name="messageDisposition">The message disposition.</param>
        /// <returns>Created PostItem.</returns>
        PostItem InternalCreate(FolderId parentFolderId, MessageDisposition? messageDisposition)
        {
            ((ItemId)this.PropertyBag[ResponseObjectSchema.ReferenceItemId]).Assign(this.referenceItem.Id);

            List<Item> items = this.Service.InternalCreateResponseObject(
                this,
                parentFolderId,
                messageDisposition);

            PostItem postItem = EwsUtilities.FindFirstItemOfType<PostItem>(items);

            // This should never happen. If it does, we have a bug.
            EwsUtilities.Assert(
                postItem != null,
                "PostReply.InternalCreate",
                "postItem is null. The CreateItem call did not return the expected PostItem.");

            return postItem;
        }

        /// <summary>
        /// Loads the specified set of properties on the object.
        /// </summary>
        /// <param name="propertySet">The properties to load.</param>
@override
        void InternalLoad(PropertySet propertySet)
        {
            throw new InvalidOperationException(Strings.LoadingThisObjectTypeNotSupported);
        }

        /// <summary>
        /// Deletes the object.
        /// </summary>
        /// <param name="deleteMode">The deletion mode.</param>
        /// <param name="sendCancellationsMode">Indicates whether meeting cancellation messages should be sent.</param>
        /// <param name="affectedTaskOccurrences">Indicate which occurrence of a recurring task should be deleted.</param>
@override
        void InternalDelete(
            DeleteMode deleteMode,
            SendCancellationsMode? sendCancellationsMode,
            AffectedTaskOccurrence? affectedTaskOccurrences)
        {
            throw new InvalidOperationException(Strings.DeletingThisObjectTypeNotAuthorized);
        }

        /// <summary>
        /// Saves the post reply in the same folder as the original post item. Calling this method results in a call to EWS.
        /// </summary>
        /// <returns>A PostItem representing the posted reply.</returns>
 PostItem Save()
        {
            return (PostItem)this.InternalCreate(null, null);
        }

        /// <summary>
        /// Saves the post reply in the specified folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="destinationFolderId">The Id of the folder in which to save the post reply.</param>
        /// <returns>A PostItem representing the posted reply.</returns>
 PostItem Save(FolderId destinationFolderId)
        {
            EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");

            return (PostItem)this.InternalCreate(destinationFolderId, null);
        }

        /// <summary>
        /// Saves the post reply in a specified folder. Calling this method results in a call to EWS.
        /// </summary>
        /// <param name="destinationFolderName">The name of the folder in which to save the post reply.</param>
        /// <returns>A PostItem representing the posted reply.</returns>
 PostItem Save(WellKnownFolderName destinationFolderName)
        {
            return (PostItem)this.InternalCreate(new FolderId(destinationFolderName), null);
        }

        #region Properties

        /// <summary>
        /// Gets or sets the subject of the post reply.
        /// </summary>
        String get Subject => this.PropertyBag[EmailMessageSchema.Subject];
        set Subject(String value) => this.PropertyBag[EmailMessageSchema.Subject] = value;

        /// <summary>
        /// Gets or sets the body of the post reply.
        /// </summary>
        MessageBody get Body => this.PropertyBag[ItemSchema.Body];
        set Body(MessageBody value) => this.PropertyBag[ItemSchema.Body] = value;

        /// <summary>
        /// Gets or sets the body prefix that should be prepended to the original post item's body.
        /// </summary>
        MessageBody get BodyPrefix => this.PropertyBag[ResponseObjectSchema.BodyPrefix];
        set BodyPrefix(MessageBody value) => this.PropertyBag[ResponseObjectSchema.BodyPrefix] = value;

        #endregion
    }
