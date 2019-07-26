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

import 'package:ews/ComplexProperties/ComplexPropertyCollection.dart';
import 'package:ews/ComplexProperties/FolderPermission.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ServiceObjects/Folders/CalendarFolder.dart';
import 'package:ews/Core/ServiceObjects/Folders/Folder.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
    /// Represents a collection of folder permissions.
    /// </summary>
  class FolderPermissionCollection extends ComplexPropertyCollection<FolderPermission>
    {
        /* private */ bool isCalendarFolder;
        /* private */ List<String> unknownEntries = List<String>();

        /// <summary>
        /// Initializes a new instance of the <see cref="FolderPermissionCollection"/> class.
        /// </summary>
        /// <param name="owner">The folder owner.</param>
        FolderPermissionCollection(Folder owner)
            : super()
        {
            this.isCalendarFolder = owner is CalendarFolder;
        }

        /// <summary>
        /// Gets the name of the inner collection XML element.
        /// </summary>
        /// <value>XML element name.</value>
        /* private */ String get InnerCollectionXmlElementName => this.isCalendarFolder ? XmlElementNames.CalendarPermissions : XmlElementNames.Permissions;

        /// <summary>
        /// Gets the name of the collection item XML element.
        /// </summary>
        /// <value>XML element name.</value>
        /* private */ String get CollectionItemXmlElementName => this.isCalendarFolder ? XmlElementNames.CalendarPermission : XmlElementNames.Permission;

        /// <summary>
        /// Gets the name of the collection item XML element.
        /// </summary>
        /// <param name="complexProperty">The complex property.</param>
        /// <returns>XML element name.</returns>
@override
        String GetCollectionItemXmlElementName(FolderPermission complexProperty)
        {
            return this.CollectionItemXmlElementName;
        }

        /// <summary>
        /// Loads from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <param name="localElementName">Name of the local element.</param>
@override
        void LoadFromXml(EwsServiceXmlReader reader, String localElementName)
        {
            reader.EnsureCurrentNodeIsStartElementWithNamespace(XmlNamespace.Types, localElementName);

            reader.ReadStartElementWithNamespace(XmlNamespace.Types, this.InnerCollectionXmlElementName);
            super.LoadFromXml(reader, this.InnerCollectionXmlElementName);
            reader.ReadEndElementIfNecessary(XmlNamespace.Types, this.InnerCollectionXmlElementName);

            reader.Read();

            if (reader.IsStartElementWithNamespace(XmlNamespace.Types, XmlElementNames.UnknownEntries))
            {
                do
                {
                    reader.Read();

                    if (reader.IsStartElementWithNamespace(XmlNamespace.Types, XmlElementNames.UnknownEntry))
                    {
                        this.unknownEntries.add(reader.ReadElementValue());
                    }
                }
                while (!reader.IsEndElementWithNamespace(XmlNamespace.Types, XmlElementNames.UnknownEntries));
            }
        }

        /// <summary>
        /// Validates this instance.
        /// </summary>
        void Validate()
        {
            for (int permissionIndex = 0; permissionIndex < this.Items.length; permissionIndex++)
            {
                FolderPermission permission = this.Items[permissionIndex];
                permission.ValidateWithPermissionIndex(this.isCalendarFolder, permissionIndex);
            }
        }

        /// <summary>
        /// Writes the elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteStartElement(XmlNamespace.Types, this.InnerCollectionXmlElementName);
            for (FolderPermission folderPermission in this)
            {
                folderPermission.WriteToXmlWithElementNameAndCalendar(
                            writer,
                            this.GetCollectionItemXmlElementName(folderPermission),
                            this.isCalendarFolder);
            }
            writer.WriteEndElement(); // this.InnerCollectionXmlElementName
        }

        /// <summary>
        /// Creates the complex property.
        /// </summary>
        /// <param name="xmlElementName">Name of the XML element.</param>
        /// <returns>FolderPermission instance.</returns>
@override
        FolderPermission CreateComplexProperty(String xmlElementName)
        {
            return new FolderPermission();
        }

        /// <summary>
        /// Adds a permission to the collection.
        /// </summary>
        /// <param name="permission">The permission to add.</param>
 void Add(FolderPermission permission)
        {
            this.InternalAdd(permission);
        }

        /// <summary>
        /// Adds the specified permissions to the collection.
        /// </summary>
        /// <param name="permissions">The permissions to add.</param>
 void AddRange(Iterable<FolderPermission> permissions)
        {
//            EwsUtilities.ValidateParam(permissions, "permissions");

            for (FolderPermission permission in permissions)
            {
                this.Add(permission);
            }
        }

        /// <summary>
        /// Clears this collection.
        /// </summary>
 void Clear()
        {
            this.InternalClear();
        }

        /// <summary>
        /// Removes a permission from the collection.
        /// </summary>
        /// <param name="permission">The permission to remove.</param>
        /// <returns>True if the folder permission was successfully removed from the collection, false otherwise.</returns>
 bool Remove(FolderPermission permission)
        {
            return this.InternalRemove(permission);
        }

        /// <summary>
        /// Removes a permission from the collection.
        /// </summary>
        /// <param name="index">The zero-based index of the permission to remove.</param>
 void RemoveAt(int index)
        {
            this.InternalRemoveAt(index);
        }

        /// <summary>
        /// Gets a list of unknown user Ids in the collection.
        /// </summary>
 List<String> get UnknownEntries => this.unknownEntries;
    }
