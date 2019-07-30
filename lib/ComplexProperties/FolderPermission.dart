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

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/ComplexProperties/UserId.dart' as property;
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/FolderPermissionLevel.dart';
import 'package:ews/Enumerations/FolderPermissionReadAccess.dart';
import 'package:ews/Enumerations/PermissionScope.dart';
import 'package:ews/Enumerations/StandardUser.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';

/// <summary>
/// Represents a permission on a folder.
/// </summary>
class FolderPermission extends ComplexProperty {
  /* private */
  static LazyMember<Map<FolderPermissionLevel, FolderPermission>> defaultPermissions =
      new LazyMember<Map<FolderPermissionLevel, FolderPermission>>(() {
    Map<FolderPermissionLevel, FolderPermission> result =
        new Map<FolderPermissionLevel, FolderPermission>();

    FolderPermission permission = new FolderPermission();
    permission.canCreateItems = false;
    permission.canCreateSubFolders = false;
    permission.deleteItems = PermissionScope.None;
    permission.editItems = PermissionScope.None;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = false;
    permission.readItems = FolderPermissionReadAccess.None;

    result[FolderPermissionLevel.None] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = true;
    permission.canCreateSubFolders = false;
    permission.deleteItems = PermissionScope.None;
    permission.editItems = PermissionScope.None;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = true;
    permission.readItems = FolderPermissionReadAccess.None;

    result[FolderPermissionLevel.Contributor] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = false;
    permission.canCreateSubFolders = false;
    permission.deleteItems = PermissionScope.None;
    permission.editItems = PermissionScope.None;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = true;
    permission.readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.Reviewer] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = true;
    permission.canCreateSubFolders = false;
    permission.deleteItems = PermissionScope.Owned;
    permission.editItems = PermissionScope.None;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = true;
    permission.readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.NoneditingAuthor] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = true;
    permission.canCreateSubFolders = false;
    permission.deleteItems = PermissionScope.Owned;
    permission.editItems = PermissionScope.Owned;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = true;
    permission.readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.Author] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = true;
    permission.canCreateSubFolders = true;
    permission.deleteItems = PermissionScope.Owned;
    permission.editItems = PermissionScope.Owned;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = true;
    permission.readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.PublishingAuthor] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = true;
    permission.canCreateSubFolders = false;
    permission.deleteItems = PermissionScope.All;
    permission.editItems = PermissionScope.All;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = true;
    permission.readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.Editor] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = true;
    permission.canCreateSubFolders = true;
    permission.deleteItems = PermissionScope.All;
    permission.editItems = PermissionScope.All;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = true;
    permission.readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.PublishingEditor] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = true;
    permission.canCreateSubFolders = true;
    permission.deleteItems = PermissionScope.All;
    permission.editItems = PermissionScope.All;
    permission.isFolderContact = true;
    permission.isFolderOwner = true;
    permission.isFolderVisible = true;
    permission.readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.Owner] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = false;
    permission.canCreateSubFolders = false;
    permission.deleteItems = PermissionScope.None;
    permission.editItems = PermissionScope.None;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = false;
    permission.readItems = FolderPermissionReadAccess.TimeOnly;

    result[FolderPermissionLevel.FreeBusyTimeOnly] = permission;

    permission = new FolderPermission();
    permission.canCreateItems = false;
    permission.canCreateSubFolders = false;
    permission.deleteItems = PermissionScope.None;
    permission.editItems = PermissionScope.None;
    permission.isFolderContact = false;
    permission.isFolderOwner = false;
    permission.isFolderVisible = false;
    permission.readItems = FolderPermissionReadAccess.TimeAndSubjectAndLocation;

    result[FolderPermissionLevel.FreeBusyTimeAndSubjectAndLocation] = permission;

    return result;
  });

  /// <summary>
  /// Variants of pre-defined permission levels that Outlook also displays with the same levels.
  /// </summary>
  /* private */
  static LazyMember<List<FolderPermission>> levelVariants =
      new LazyMember<List<FolderPermission>>(() {
    List<FolderPermission> results = new List<FolderPermission>();

    FolderPermission permissionNone =
        FolderPermission.defaultPermissions.Member[FolderPermissionLevel.None];
    FolderPermission permissionOwner =
        FolderPermission.defaultPermissions.Member[FolderPermissionLevel.Owner];

    // PermissionLevelNoneOption1
    FolderPermission permission = permissionNone.Clone();
    permission.isFolderVisible = true;
    results.add(permission);

    // PermissionLevelNoneOption2
    permission = permissionNone.Clone();
    permission.isFolderContact = true;
    results.add(permission);

    // PermissionLevelNoneOption3
    permission = permissionNone.Clone();
    permission.isFolderContact = true;
    permission.isFolderVisible = true;
    results.add(permission);

    // PermissionLevelOwnerOption1
    permission = permissionOwner.Clone();
    permission.isFolderContact = false;
    results.add(permission);

    return results;
  });

  /* private */
  property.UserId userId;

  /* private */
  bool canCreateItems;

  /* private */
  bool canCreateSubFolders;

  /* private */
  bool isFolderOwner;

  /* private */
  bool isFolderVisible;

  /* private */
  bool isFolderContact;

  /* private */
  PermissionScope editItems;

  /* private */
  PermissionScope deleteItems;

  /* private */
  FolderPermissionReadAccess readItems;

  /* private */
  FolderPermissionLevel permissionLevel;

  /// <summary>
  /// Determines whether the specified folder permission is the same as this one. The comparison
  /// does not take property.UserId and PermissionLevel into consideration.
  /// </summary>
  /// <param name="permission">The folder permission to compare with this folder permission.</param>
  /// <returns>
  /// True is the specified folder permission is equal to this one, false otherwise.
  /// </returns>
  /* private */
  bool IsEqualTo(FolderPermission permission) {
    return this.CanCreateItems == permission.CanCreateItems &&
        this.CanCreateSubFolders == permission.CanCreateSubFolders &&
        this.IsFolderContact == permission.IsFolderContact &&
        this.IsFolderVisible == permission.IsFolderVisible &&
        this.IsFolderOwner == permission.IsFolderOwner &&
        this.EditItems == permission.EditItems &&
        this.DeleteItems == permission.DeleteItems &&
        this.ReadItems == permission.ReadItems;
  }

  /// <summary>
  /// Create a copy of this FolderPermission instance.
  /// </summary>
  /// <returns>
  /// Clone of this instance.
  /// </returns>
//        /* private */ FolderPermission Clone()
//        {
//            return (FolderPermission)this.MemberwiseClone();
//        }

  /// <summary>
  /// Determines the permission level of this folder permission based on its individual settings,
  /// and sets the PermissionLevel property accordingly.
  /// </summary>
  /* private */
  void AdjustPermissionLevel() {
    // todo("Adjust permission level")
//            for (MapEntry<FolderPermissionLevel, FolderPermission> keyValuePair in defaultPermissions.Member)
//            {
//                if (this.IsEqualTo(keyValuePair.Value))
//                {
//                    this.permissionLevel = keyValuePair.Key;
//                    return;
//                }
//            }
//
//            this.permissionLevel = FolderPermissionLevel.Custom;
  }

  /// <summary>
  /// Copies the values of the individual permissions of the specified folder permission
  /// to this folder permissions.
  /// </summary>
  /// <param name="permission">The folder permission to copy the values from.</param>
  /* private */
  void AssignIndividualPermissions(FolderPermission permission) {
    this.canCreateItems = permission.CanCreateItems;
    this.canCreateSubFolders = permission.CanCreateSubFolders;
    this.isFolderContact = permission.IsFolderContact;
    this.isFolderOwner = permission.IsFolderOwner;
    this.isFolderVisible = permission.IsFolderVisible;
    this.editItems = permission.EditItems;
    this.deleteItems = permission.DeleteItems;
    this.readItems = permission.ReadItems;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderPermission"/> class.
  /// </summary>
  FolderPermission() : super() {
    this.userId = new property.UserId();
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderPermission"/> class.
  /// </summary>
  /// <param name="property.UserId">The Id of the user  the permission applies to.</param>
  /// <param name="permissionLevel">The level of the permission.</param>
  FolderPermission.withUserUd(property.UserId userId, FolderPermissionLevel permissionLevel) {
    EwsUtilities.ValidateParam(property.UserId, "property.UserId");

    this.UserId = userId;
    this.PermissionLevel = permissionLevel;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderPermission"/> class.
  /// </summary>
  /// <param name="primarySmtpAddress">The primary SMTP address of the user the permission applies to.</param>
  /// <param name="permissionLevel">The level of the permission.</param>
  FolderPermission.withSmtpAddress(
      String primarySmtpAddress, FolderPermissionLevel permissionLevel) {
    this.UserId = new property.UserId.withSmtpAddress(primarySmtpAddress);
    this.PermissionLevel = permissionLevel;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderPermission"/> class.
  /// </summary>
  /// <param name="standardUser">The standard user the permission applies to.</param>
  /// <param name="permissionLevel">The level of the permission.</param>
  FolderPermission.withStandardUser(
      StandardUser standardUser, FolderPermissionLevel permissionLevel) {
    this.UserId = new property.UserId.withStandardUser(standardUser);
    this.PermissionLevel = permissionLevel;
  }

  FolderPermission Clone() {
    // todo("implement correct clone")
    return FolderPermission();
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  /// <param name="isCalendarFolder">if set to <c>true</c> calendar permissions are allowed.</param>
  /// <param name="permissionIndex">Index of the permission.</param>
  void ValidateWithPermissionIndex(bool isCalendarFolder, int permissionIndex) {
    // Check property.UserId
    if (!this.userId.IsValid()) {
      throw new ServiceValidationException("""string.Format(
                        Strings.FolderPermissionHasInvalidproperty.UserId,
                        permissionIndex)""");
    }

    // If this permission is to be used for a non-calendar folder make sure that read access and permission level aren't set to Calendar-only values
    if (!isCalendarFolder) {
      if ((this.readItems == FolderPermissionReadAccess.TimeAndSubjectAndLocation) ||
          (this.readItems == FolderPermissionReadAccess.TimeOnly)) {
        throw new ServiceLocalException("""string.Format(
                            Strings.ReadAccessInvalidForNonCalendarFolder,
                            this.readItems""");
      }

      if ((this.permissionLevel == FolderPermissionLevel.FreeBusyTimeAndSubjectAndLocation) ||
          (this.permissionLevel == FolderPermissionLevel.FreeBusyTimeOnly)) {
        throw new ServiceLocalException("""string.Format(
                            Strings.PermissionLevelInvalidForNonCalendarFolder,
                            this.permissionLevel)""");
      }
    }
  }

  /// <summary>
  /// Gets the Id of the user the permission applies to.
  /// </summary>
  property.UserId get UserId => this.userId;

  set UserId(property.UserId value) {
    if (this.userId != null) {
      this.userId.removeChangeEvent(this.PropertyChanged);
    }

    if (this.CanSetFieldValue(this.userId, value)) {
      this.userId = value;
      this.Changed();
    }

    if (this.UserId != null) {
      this.UserId.addOnChangeEvent(this.PropertyChanged);
    }
  }

  /// <summary>
  /// Gets or sets a value indicating whether the user can create new items.
  /// </summary>
  bool get CanCreateItems => this.canCreateItems;

//        set CanCreateItems(bool value) {
//            this.SetFieldValue<bool>(ref this.canCreateItems, value);
//            this.AdjustPermissionLevel();
//        }

  /// <summary>
  /// Gets or sets a value indicating whether the user can create sub-folders.
  /// </summary>
  bool get CanCreateSubFolders => this.canCreateSubFolders;

//        set CanCreateSubFolders(bool value) {
//            this.SetFieldValue<bool>(ref this.canCreateSubFolders, value);
//            this.AdjustPermissionLevel();
//        }

  /// <summary>
  /// Gets or sets a value indicating whether the user owns the folder.
  /// </summary>
  bool get IsFolderOwner => this.isFolderOwner;

//        set IsFolderOwner(bool value) {
//            this.SetFieldValue<bool>(ref this.isFolderOwner, value);
//            this.AdjustPermissionLevel();
//        }

  /// <summary>
  /// Gets or sets a value indicating whether the folder is visible to the user.
  /// </summary>
  bool get IsFolderVisible => this.isFolderVisible;

  set IsFolderVisible(bool value) {
    if (this.CanSetFieldValue(this.isFolderVisible, value)) {
      this.isFolderVisible = value;
      this.Changed();
    }
    this.AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating whether the user is a contact for the folder.
  /// </summary>
  bool get IsFolderContact => this.isFolderContact;

  set IsFolderContact(bool value) {
    if (this.CanSetFieldValue(this.isFolderContact, value)) {
      this.isFolderContact = value;
      this.Changed();
    }
    this.AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating if/how the user can edit existing items.
  /// </summary>
  PermissionScope get EditItems => this.editItems;

  set EditItems(PermissionScope value) {
    if (this.CanSetFieldValue(this.editItems, value)) {
      this.editItems = value;
      this.Changed();
    }
    this.AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating if/how the user can delete existing items.
  /// </summary>
  PermissionScope get DeleteItems => this.deleteItems;

  set DeleteItems(PermissionScope value) {
    if (this.CanSetFieldValue(this.deleteItems, value)) {
      this.deleteItems = value;
      this.Changed();
    }
    this.AdjustPermissionLevel();
  }

  FolderPermissionReadAccess get ReadItems => this.readItems;

  /// <summary>
  /// Gets or sets the read items access permission.
  /// </summary>
  set ReadItems(FolderPermissionReadAccess value) {
    if (this.CanSetFieldValue(this.readItems, value)) {
      this.readItems = value;
      this.Changed();
    }
    this.AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets the permission level.
  /// </summary>
  FolderPermissionLevel get PermissionLevel => this.permissionLevel;

  set PermissionLevel(FolderPermissionLevel value) {
    if (this.permissionLevel != value) {
      if (value == FolderPermissionLevel.Custom) {
        throw new ServiceLocalException("Strings.CannotSetPermissionLevelToCustom");
      }

      this.AssignIndividualPermissions(defaultPermissions.Member[value]);
      if (this.CanSetFieldValue(this.permissionLevel, value)) {
        this.permissionLevel = value;
        this.Changed();
      }
    }
  }

  /// <summary>
  /// Gets the permission level that Outlook would display for this folder permission.
  /// </summary>
  FolderPermissionLevel get DisplayPermissionLevel {
    // If permission level is set to Custom, see if there's a variant
    // that Outlook would map to the same permission level.
    if (this.permissionLevel == FolderPermissionLevel.Custom) {
      for (FolderPermission variant in FolderPermission.levelVariants.Member) {
        if (this.IsEqualTo(variant)) {
          return variant.PermissionLevel;
        }
      }
    }

    return this.permissionLevel;
  }

  /// <summary>
  /// Property was changed.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  /* private */
  void PropertyChanged(ComplexProperty complexProperty) {
    this.Changed();
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.UserId:
        throw UnsupportedError("Doesn't support UserId permission");
//                    this.UserId = new property.UserId();
//                    this.UserId.LoadFromXml(reader, reader.LocalName);
        return true;
      case XmlElementNames.CanCreateItems:
        this.canCreateItems = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.CanCreateSubFolders:
        this.canCreateSubFolders = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.IsFolderOwner:
        this.isFolderOwner = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.IsFolderVisible:
        this.isFolderVisible = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.IsFolderContact:
        this.isFolderContact = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.EditItems:
        this.editItems = reader.ReadValue<PermissionScope>();
        return true;
      case XmlElementNames.DeleteItems:
        this.deleteItems = reader.ReadValue<PermissionScope>();
        return true;
      case XmlElementNames.ReadItems:
        this.readItems = reader.ReadValue<FolderPermissionReadAccess>();
        return true;
      case XmlElementNames.PermissionLevel:
      case XmlElementNames.CalendarPermissionLevel:
        this.permissionLevel = reader.ReadValue<FolderPermissionLevel>();
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  @override
  void LoadFromXmlWithNamespace(
      EwsServiceXmlReader reader, XmlNamespace xmlNamespace, String xmlElementName) {
    super.LoadFromXmlWithNamespace(reader, xmlNamespace, xmlElementName);

    this.AdjustPermissionLevel();
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="isCalendarFolder">If true, this permission is for a calendar folder.</param>
  void WriteElementsToXmlWithCalendar(EwsServiceXmlWriter writer, bool isCalendarFolder) {
    if (this.userId != null) {
      this.userId.WriteToXml(writer, XmlElementNames.UserId);
    }

    if (this.PermissionLevel == FolderPermissionLevel.Custom) {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.CanCreateItems, this.CanCreateItems);

      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.CanCreateSubFolders, this.CanCreateSubFolders);

      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.IsFolderOwner, this.IsFolderOwner);

      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.IsFolderVisible, this.IsFolderVisible);

      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.IsFolderContact, this.IsFolderContact);

      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.EditItems, this.EditItems);

      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.DeleteItems, this.DeleteItems);

      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types, XmlElementNames.ReadItems, this.ReadItems);
    }

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types,
        isCalendarFolder
            ? XmlElementNames.CalendarPermissionLevel
            : XmlElementNames.PermissionLevel,
        this.PermissionLevel);
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="isCalendarFolder">If true, this permission is for a calendar folder.</param>
  void WriteToXmlWithElementNameAndCalendar(
      EwsServiceXmlWriter writer, String xmlElementName, bool isCalendarFolder) {
    writer.WriteStartElement(this.Namespace, xmlElementName);
    this.WriteAttributesToXml(writer);
    this.WriteElementsToXmlWithCalendar(writer, isCalendarFolder);
    writer.WriteEndElement();
  }
}
