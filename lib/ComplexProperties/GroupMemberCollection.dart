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
import 'package:ews/ComplexProperties/GroupMember.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ContactGroupSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents a collection of members of GroupMember type.
/// </summary>
class GroupMemberCollection
    extends ComplexPropertyCollection<GroupMember> //, ICustomUpdateSerializer
{
  /// <summary>
  /// If the collection is cleared, then store PDL members collection is updated with "SetItemField".
  /// If the collection is not cleared, then store PDL members collection is updated with "AppendToItemField".
  /// </summary>
  /* private */
  bool collectionIsCleared = false;

  /// <summary>
  /// Initializes a new instance of the <see cref="GroupMemberCollection"/> class.
  /// </summary>
  GroupMemberCollection() : super() {}

  /// <summary>
  /// Finds the member with the specified key in the collection.
  /// Members that have not yet been saved do not have a key.
  /// </summary>
  /// <param name="key">The key of the member to find.</param>
  /// <returns>The member with the specified key.</returns>
  GroupMember? Find(String key) {
    EwsUtilities.ValidateParam(key, "key");

    for (GroupMember item in this.Items) {
      if (item.Key == key) {
        return item;
      }
    }

    return null;
  }

  /// <summary>
  /// Clears the collection.
  /// </summary>
  void Clear() {
    // mark the whole collection for deletion
    this.InternalClear();
    this.collectionIsCleared = true;
  }

  /// <summary>
  /// Adds a member to the collection.
  /// </summary>
  /// <param name="member">The member to add.</param>
  void Add(GroupMember member) {
    EwsUtilities.ValidateParam(member, "member");

    EwsUtilities.Assert(member.Key == null, "GroupMemberCollection.Add",
        "member.Key is not null.");

    EwsUtilities.Assert(!this.Contains(member), "GroupMemberCollection.Add",
        "The member is already in the collection");

    this.InternalAdd(member);
  }

  /// <summary>
  /// Adds multiple members to the collection.
  /// </summary>
  /// <param name="members">The members to add.</param>
  void AddRange(Iterable<GroupMember> members) {
    EwsUtilities.ValidateParam(members, "members");

    for (GroupMember member in members) {
      this.Add(member);
    }
  }

  /// <summary>
  /// Adds a member linked to a Contact Group.
  /// </summary>
  /// <param name="contactGroupId">The Id of the contact group.</param>
// void AddContactGroup(ItemId contactGroupId)
//        {
//            this.Add(new GroupMember(contactGroupId));
//        }

  /// <summary>
  /// Adds a member linked to a specific contact's e-mail address.
  /// </summary>
  /// <param name="contactId">The Id of the contact.</param>
  /// <param name="addressToLink">The contact's address to link to.</param>
// void AddPersonalContact(ItemId contactId, String addressToLink)
//        {
//            this.Add(new GroupMember(contactId, addressToLink));
//        }

  /// <summary>
  /// Adds a member linked to a contact's first available e-mail address.
  /// </summary>
  /// <param name="contactId">The Id of the contact.</param>
// void AddPersonalContact(ItemId contactId)
//        {
//            this.AddPersonalContact(contactId, null);
//        }

  /// <summary>
  /// Adds a member linked to an Active Directory user.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address of the member.</param>
// void AddDirectoryUser(String smtpAddress)
//        {
//            this.AddDirectoryUser(smtpAddress, EmailAddress.SmtpRoutingType);
//        }

  /// <summary>
  /// Adds a member linked to an Active Directory user.
  /// </summary>
  /// <param name="address">The address of the member.</param>
  /// <param name="routingType">The routing type of the address.</param>
// void AddDirectoryUser(String address, String routingType)
//        {
//            this.Add(new GroupMember(address, routingType, MailboxType.Mailbox));
//        }

  /// <summary>
  /// Adds a member linked to an Active Directory contact.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address of the Active Directory contact.</param>
// void AddDirectoryContact(String smtpAddress)
//        {
//            this.AddDirectoryContact(smtpAddress, EmailAddress.SmtpRoutingType);
//        }

  /// <summary>
  /// Adds a member linked to an Active Directory contact.
  /// </summary>
  /// <param name="address">The address of the Active Directory contact.</param>
  /// <param name="routingType">The routing type of the address.</param>
// void AddDirectoryContact(String address, String routingType)
//        {
//            this.Add(new GroupMember(address, routingType, MailboxType.Contact));
//        }

  /// <summary>
  /// Adds a member linked to a Public Group.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address of the Public Group.</param>
// void AddPublicGroup(String smtpAddress)
//        {
//            this.Add(new GroupMember(smtpAddress, EmailAddress.SmtpRoutingType, MailboxType.PublicGroup));
//        }

  /// <summary>
  /// Adds a member linked to a mail-enabled Public Folder.
  /// </summary>
  /// <param name="smtpAddress">The SMTP address of the mail-enabled Public Folder.</param>
// void AddDirectoryPublicFolder(String smtpAddress)
//        {
//            this.Add(new GroupMember(smtpAddress, EmailAddress.SmtpRoutingType, MailboxType.PublicFolder));
//        }

  /// <summary>
  /// Adds a one-off member.
  /// </summary>
  /// <param name="displayName">The display name of the member.</param>
  /// <param name="address">The address of the member.</param>
  /// <param name="routingType">The routing type of the address.</param>
// void AddOneOff(String displayName, String address, String routingType)
//        {
//            this.Add(new GroupMember(displayName, address, routingType));
//        }

  /// <summary>
  /// Adds a one-off member.
  /// </summary>
  /// <param name="displayName">The display name of the member.</param>
  /// <param name="smtpAddress">The SMTP address of the member.</param>
// void AddOneOff(String displayName, String smtpAddress)
//        {
//            this.AddOneOff(displayName, smtpAddress, EmailAddress.SmtpRoutingType);
//        }

  /// <summary>
  /// Adds a member that is linked to a specific e-mail address of a contact.
  /// </summary>
  /// <param name="contact">The contact to link to.</param>
  /// <param name="emailAddressKey">The contact's e-mail address to link to.</param>
// void AddContactEmailAddress(Contact contact, EmailAddressKey emailAddressKey)
//        {
//            this.Add(new GroupMember(contact, emailAddressKey));
//        }

  /// <summary>
  /// Removes a member at the specified index.
  /// </summary>
  /// <param name="index">The index of the member to remove.</param>
  void RemoveAt(int index) {
    if (index < 0 || index >= this.Count) {
      throw new ArgumentException("index: $index, IndexIsOutOfRange");
    }

    this.InternalRemoveAt(index);
  }

  /// <summary>
  /// Removes a member from the collection.
  /// </summary>
  /// <param name="member">The member to remove.</param>
  /// <returns>True if the group member was successfully removed from the collection, false otherwise.</returns>
  bool Remove(GroupMember member) {
    return this.InternalRemove(member);
  }

  /// <summary>
  /// Writes the update to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ownerObject">The ews object.</param>
  /// <param name="propertyDefinition">Property definition.</param>
  /// <returns>True if property generated serialization.</returns>
//        bool ICustomUpdateSerializer.WriteSetUpdateToXml(
//            EwsServiceXmlWriter writer,
//            ServiceObject ownerObject,
//            PropertyDefinition propertyDefinition)
//        {
//            if (this.collectionIsCleared)
//            {
//                if (this.AddedItems.Count == 0)
//                {
//                    // Delete the whole members collection
//                    this.WriteDeleteMembersCollectionToXml(writer);
//                }
//                else
//                {
//                    // The collection is cleared, so Set
//                    this.WriteSetOrAppendMembersToXml(writer, this.AddedItems, true);
//                }
//            }
//            else
//            {
//                // The collection is not cleared, i.e. dl.Members.Clear() is not called.
//                // Append AddedItems.
//                this.WriteSetOrAppendMembersToXml(writer, this.AddedItems, false);
//
//                // Since member replacement is not supported by server
//                // Delete old ModifiedItems, then recreate new instead.
//                this.WriteDeleteMembersToXml(writer, this.ModifiedItems);
//                this.WriteSetOrAppendMembersToXml(writer, this.ModifiedItems, false);
//
//                // Delete RemovedItems.
//                this.WriteDeleteMembersToXml(writer, this.RemovedItems);
//            }
//
//            return true;
//        }

  /// <summary>
  /// Writes the deletion update to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="ewsObject">The ews object.</param>
  /// <returns>True if property generated serialization.</returns>
//        bool ICustomUpdateSerializer.WriteDeleteUpdateToXml(EwsServiceXmlWriter writer, ServiceObject ewsObject)
//        {
//            return false;
//        }

  /// <summary>
  /// Creates a GroupMember object from an XML element name.
  /// </summary>
  /// <param name="xmlElementName">The XML element name from which to create the e-mail address.</param>
  /// <returns>An GroupMember object.</returns>
  @override
  GroupMember CreateComplexProperty(String xmlElementName) {
    return new GroupMember();
  }

  /// <summary>
  /// Clears the change log.
  /// </summary>
  @override
  void ClearChangeLog() {
    super.ClearChangeLog();
    this.collectionIsCleared = false;
  }

  /// <summary>
  /// Retrieves the XML element name corresponding to the provided GroupMember object.
  /// </summary>
  /// <param name="member">The GroupMember object from which to determine the XML element name.</param>
  /// <returns>The XML element name corresponding to the provided GroupMember object.</returns>
  @override
  String GetCollectionItemXmlElementName(GroupMember member) {
    return XmlElementNames.Member;
  }

  /// <summary>
  /// Delete the whole members collection.
  /// </summary>
  /// <param name="writer">Xml writer.</param>
  /* private */
  void WriteDeleteMembersCollectionToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(
        XmlNamespace.Types, XmlElementNames.DeleteItemField);
    ContactGroupSchema.Members.WriteToXml(writer);
    writer.WriteEndElement();
  }

  /// <summary>
  /// Generate XML to delete individual members.
  /// </summary>
  /// <param name="writer">Xml writer.</param>
  /// <param name="members">Members to delete.</param>
//        /* private */ void WriteDeleteMembersToXml(EwsServiceXmlWriter writer, List<GroupMember> members)
//        {
//            if (members.length != 0)
//            {
//                GroupMemberPropertyDefinition memberPropDef = new GroupMemberPropertyDefinition();
//
//                for (GroupMember member in members)
//                {
//                    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.DeleteItemField);
//
//                    memberPropDef.Key = member.Key;
//                    memberPropDef.WriteToXml(writer);
//
//                    writer.WriteEndElement();   // DeleteItemField
//                }
//            }
//        }

  /// <summary>
  /// Generate XML to Set or Append members.
  /// When members are set, the existing PDL member collection is cleared.
  /// On append members are added to the PDL existing members collection.
  /// </summary>
  /// <param name="writer">Xml writer.</param>
  /// <param name="members">Members to set or append.</param>
  /// <param name="setMode">True - set members, false - append members.</param>
  /* private */
  void WriteSetOrAppendMembersToXml(
      EwsServiceXmlWriter writer, List<GroupMember> members, bool setMode) {
    if (members.length != 0) {
      writer.WriteStartElement(
          XmlNamespace.Types,
          setMode
              ? XmlElementNames.SetItemField
              : XmlElementNames.AppendToItemField);

      ContactGroupSchema.Members.WriteToXml(writer);

      writer.WriteStartElement(
          XmlNamespace.Types, XmlElementNames.DistributionList);
      writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Members);

      for (GroupMember member in members) {
        member.WriteToXml(writer, XmlElementNames.Member);
      }

      writer.WriteEndElement(); // Members
      writer.WriteEndElement(); // Group
      writer.WriteEndElement(); // setMode ? SetItemField : AppendItemField
    }
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  @override
  void InternalValidate() {
    super.InternalValidate();

    for (GroupMember groupMember in this.ModifiedItems) {
      if (StringUtils.IsNullOrEmpty(groupMember.Key)) {
        throw new ServiceValidationException(
            "Strings.ContactGroupMemberCannotBeUpdatedWithoutBeingLoadedFirst");
      }
    }
  }
}
