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
    /// Represents the permissions of a delegate user.
    /// </summary>
 class DelegatePermissions extends ComplexProperty
    {
        /* private */ Map<string, DelegateFolderPermission> delegateFolderPermissions;

        /// <summary>
        /// Initializes a new instance of the <see cref="DelegatePermissions"/> class.
        /// </summary>
        DelegatePermissions()
            : super()
        {
            this.delegateFolderPermissions = new Map<string, DelegateFolderPermission>()
            {
                { XmlElementNames.CalendarFolderPermissionLevel, new DelegateFolderPermission() },
                { XmlElementNames.TasksFolderPermissionLevel, new DelegateFolderPermission() },
                { XmlElementNames.InboxFolderPermissionLevel, new DelegateFolderPermission() },
                { XmlElementNames.ContactsFolderPermissionLevel, new DelegateFolderPermission() },
                { XmlElementNames.NotesFolderPermissionLevel, new DelegateFolderPermission() },
                { XmlElementNames.JournalFolderPermissionLevel, new DelegateFolderPermission() }
            };
        }

        /// <summary>
        /// Gets or sets the delegate user's permission on the principal's calendar.
        /// </summary>
 DelegateFolderPermissionLevel CalendarFolderPermissionLevel
        {
            get { return this.delegateFolderPermissions[XmlElementNames.CalendarFolderPermissionLevel].PermissionLevel; }
            set { this.delegateFolderPermissions[XmlElementNames.CalendarFolderPermissionLevel].PermissionLevel = value; }
        }

        /// <summary>
        /// Gets or sets the delegate user's permission on the principal's tasks folder.
        /// </summary>
 DelegateFolderPermissionLevel TasksFolderPermissionLevel
        {
            get { return this.delegateFolderPermissions[XmlElementNames.TasksFolderPermissionLevel].PermissionLevel; }
            set { this.delegateFolderPermissions[XmlElementNames.TasksFolderPermissionLevel].PermissionLevel = value; }
        }

        /// <summary>
        /// Gets or sets the delegate user's permission on the principal's inbox.
        /// </summary>
 DelegateFolderPermissionLevel InboxFolderPermissionLevel
        {
            get { return this.delegateFolderPermissions[XmlElementNames.InboxFolderPermissionLevel].PermissionLevel; }
            set { this.delegateFolderPermissions[XmlElementNames.InboxFolderPermissionLevel].PermissionLevel = value; }
        }

        /// <summary>
        /// Gets or sets the delegate user's permission on the principal's contacts folder.
        /// </summary>
 DelegateFolderPermissionLevel ContactsFolderPermissionLevel
        {
            get { return this.delegateFolderPermissions[XmlElementNames.ContactsFolderPermissionLevel].PermissionLevel; }
            set { this.delegateFolderPermissions[XmlElementNames.ContactsFolderPermissionLevel].PermissionLevel = value; }
        }

        /// <summary>
        /// Gets or sets the delegate user's permission on the principal's notes folder.
        /// </summary>
 DelegateFolderPermissionLevel NotesFolderPermissionLevel
        {
            get { return this.delegateFolderPermissions[XmlElementNames.NotesFolderPermissionLevel].PermissionLevel; }
            set { this.delegateFolderPermissions[XmlElementNames.NotesFolderPermissionLevel].PermissionLevel = value; }
        }

        /// <summary>
        /// Gets or sets the delegate user's permission on the principal's journal folder.
        /// </summary>
 DelegateFolderPermissionLevel JournalFolderPermissionLevel
        {
            get { return this.delegateFolderPermissions[XmlElementNames.JournalFolderPermissionLevel].PermissionLevel; }
            set { this.delegateFolderPermissions[XmlElementNames.JournalFolderPermissionLevel].PermissionLevel = value; }
        }

        /// <summary>
        /// Resets this instance.
        /// </summary>
        void Reset()
        {
            for (DelegateFolderPermission delegateFolderPermission in this.delegateFolderPermissions.Values)
            {
                delegateFolderPermission.Reset();
            }
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>Returns true if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            DelegateFolderPermission delegateFolderPermission = null;

            if (this.delegateFolderPermissions.TryGetValue(reader.LocalName, out delegateFolderPermission))
            {
                delegateFolderPermission.Initialize(reader.ReadElementValue<DelegateFolderPermissionLevel>());
            }

            return delegateFolderPermission != null;
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            this.WritePermissionToXml(
                writer,
                XmlElementNames.CalendarFolderPermissionLevel);

            this.WritePermissionToXml(
                writer,
                XmlElementNames.TasksFolderPermissionLevel);

            this.WritePermissionToXml(
                writer,
                XmlElementNames.InboxFolderPermissionLevel);

            this.WritePermissionToXml(
                writer,
                XmlElementNames.ContactsFolderPermissionLevel);

            this.WritePermissionToXml(
                writer,
                XmlElementNames.NotesFolderPermissionLevel);

            this.WritePermissionToXml(
                writer,
                XmlElementNames.JournalFolderPermissionLevel);
        }

        /// <summary>
        /// Write permission to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlElementName">The element name.</param>
        /* private */ void WritePermissionToXml(
            EwsServiceXmlWriter writer,
            String xmlElementName)
        {
            DelegateFolderPermissionLevel delegateFolderPermissionLevel = this.delegateFolderPermissions[xmlElementName].PermissionLevel;

            // UpdateDelegate fails if Custom permission level is round tripped
            //
            if (delegateFolderPermissionLevel != DelegateFolderPermissionLevel.Custom)
            {
                writer.WriteElementValue(
                    XmlNamespace.Types,
                    xmlElementName,
                    delegateFolderPermissionLevel);
            }
        }

        /// <summary>
        /// Validates this instance for AddDelegate.
        /// </summary>
        void ValidateAddDelegate()
        {
            // If any folder permission is Custom, throw
            //
            if (this.delegateFolderPermissions.Any<MapEntry<string, DelegateFolderPermission>>(kvp => kvp.Value.PermissionLevel == DelegateFolderPermissionLevel.Custom))
            {
                throw new ServiceValidationException(Strings.CannotSetDelegateFolderPermissionLevelToCustom);
            }
        }

        /// <summary>
        /// Validates this instance for UpdateDelegate.
        /// </summary>
        void ValidateUpdateDelegate()
        {
            // If any folder permission was changed to custom, throw
            //
            if (this.delegateFolderPermissions.Any<MapEntry<string, DelegateFolderPermission>>(kvp => kvp.Value.PermissionLevel == DelegateFolderPermissionLevel.Custom && !kvp.Value.IsExistingPermissionLevelCustom))
            {
                throw new ServiceValidationException(Strings.CannotSetDelegateFolderPermissionLevelToCustom);
            }
        }

        /// <summary>
        /// Represents a folder's DelegateFolderPermissionLevel
        /// </summary>
        /* private */ class DelegateFolderPermission
        {
            /// <summary>
            /// Intializes this DelegateFolderPermission.
            /// </summary>
            /// <param name="permissionLevel">The DelegateFolderPermissionLevel</param>
            void Initialize(DelegateFolderPermissionLevel permissionLevel)
            {
                this.PermissionLevel = permissionLevel;
                this.IsExistingPermissionLevelCustom = permissionLevel == DelegateFolderPermissionLevel.Custom;
            }

            /// <summary>
            /// Resets this DelegateFolderPermission.
            /// </summary>
            void Reset()
            {
                this.Initialize(DelegateFolderPermissionLevel.None);
            }

            /// <summary>
            /// Gets or sets the delegate user's permission on a principal's folder.
            /// </summary>
            DelegateFolderPermissionLevel PermissionLevel { get; set; }

            /// <summary>
            /// Gets IsExistingPermissionLevelCustom.
            /// </summary>
            bool IsExistingPermissionLevelCustom { get; /* private */ set; }
        }
    }
