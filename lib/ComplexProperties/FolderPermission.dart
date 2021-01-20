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
  static LazyMember<Map<FolderPermissionLevel, FolderPermission>>
      _defaultPermissions =
      new LazyMember<Map<FolderPermissionLevel, FolderPermission>>(() {
    Map<FolderPermissionLevel, FolderPermission> result =
        new Map<FolderPermissionLevel, FolderPermission>();

    FolderPermission permission = new FolderPermission();
    permission._canCreateItems = false;
    permission._canCreateSubFolders = false;
    permission._deleteItems = PermissionScope.None;
    permission._editItems = PermissionScope.None;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = false;
    permission._readItems = FolderPermissionReadAccess.None;

    result[FolderPermissionLevel.None] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = true;
    permission._canCreateSubFolders = false;
    permission._deleteItems = PermissionScope.None;
    permission._editItems = PermissionScope.None;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = true;
    permission._readItems = FolderPermissionReadAccess.None;

    result[FolderPermissionLevel.Contributor] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = false;
    permission._canCreateSubFolders = false;
    permission._deleteItems = PermissionScope.None;
    permission._editItems = PermissionScope.None;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = true;
    permission._readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.Reviewer] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = true;
    permission._canCreateSubFolders = false;
    permission._deleteItems = PermissionScope.Owned;
    permission._editItems = PermissionScope.None;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = true;
    permission._readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.NoneditingAuthor] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = true;
    permission._canCreateSubFolders = false;
    permission._deleteItems = PermissionScope.Owned;
    permission._editItems = PermissionScope.Owned;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = true;
    permission._readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.Author] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = true;
    permission._canCreateSubFolders = true;
    permission._deleteItems = PermissionScope.Owned;
    permission._editItems = PermissionScope.Owned;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = true;
    permission._readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.PublishingAuthor] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = true;
    permission._canCreateSubFolders = false;
    permission._deleteItems = PermissionScope.All;
    permission._editItems = PermissionScope.All;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = true;
    permission._readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.Editor] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = true;
    permission._canCreateSubFolders = true;
    permission._deleteItems = PermissionScope.All;
    permission._editItems = PermissionScope.All;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = true;
    permission._readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.PublishingEditor] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = true;
    permission._canCreateSubFolders = true;
    permission._deleteItems = PermissionScope.All;
    permission._editItems = PermissionScope.All;
    permission._isFolderContact = true;
    permission._isFolderOwner = true;
    permission._isFolderVisible = true;
    permission._readItems = FolderPermissionReadAccess.FullDetails;

    result[FolderPermissionLevel.Owner] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = false;
    permission._canCreateSubFolders = false;
    permission._deleteItems = PermissionScope.None;
    permission._editItems = PermissionScope.None;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = false;
    permission._readItems = FolderPermissionReadAccess.TimeOnly;

    result[FolderPermissionLevel.FreeBusyTimeOnly] = permission;

    permission = new FolderPermission();
    permission._canCreateItems = false;
    permission._canCreateSubFolders = false;
    permission._deleteItems = PermissionScope.None;
    permission._editItems = PermissionScope.None;
    permission._isFolderContact = false;
    permission._isFolderOwner = false;
    permission._isFolderVisible = false;
    permission._readItems =
        FolderPermissionReadAccess.TimeAndSubjectAndLocation;

    result[FolderPermissionLevel.FreeBusyTimeAndSubjectAndLocation] =
        permission;

    return result;
  });

  /// <summary>
  /// Variants of pre-defined permission levels that Outlook also displays with the same levels.
  /// </summary>
  static LazyMember<List<FolderPermission>> _levelVariants =
      new LazyMember<List<FolderPermission>>(() {
    List<FolderPermission> results = <FolderPermission>[];

    FolderPermission permissionNone =
        FolderPermission._defaultPermissions.Member![FolderPermissionLevel.None]!;
    FolderPermission permissionOwner = FolderPermission
        ._defaultPermissions.Member![FolderPermissionLevel.Owner]!;

    // PermissionLevelNoneOption1
    FolderPermission permission = permissionNone.Clone();
    permission._isFolderVisible = true;
    results.add(permission);

    // PermissionLevelNoneOption2
    permission = permissionNone.Clone();
    permission._isFolderContact = true;
    results.add(permission);

    // PermissionLevelNoneOption3
    permission = permissionNone.Clone();
    permission._isFolderContact = true;
    permission._isFolderVisible = true;
    results.add(permission);

    // PermissionLevelOwnerOption1
    permission = permissionOwner.Clone();
    permission._isFolderContact = false;
    results.add(permission);

    return results;
  });

  property.UserId? _userId;

  bool? _canCreateItems;

  bool? _canCreateSubFolders;

  bool? _isFolderOwner;

  bool? _isFolderVisible;

  bool? _isFolderContact;

  PermissionScope? _editItems;

  PermissionScope? _deleteItems;

  FolderPermissionReadAccess? _readItems;

  FolderPermissionLevel? _permissionLevel;

  /// <summary>
  /// Determines whether the specified folder permission is the same as this one. The comparison
  /// does not take property.UserId and PermissionLevel into consideration.
  /// </summary>
  /// <param name="permission">The folder permission to compare with this folder permission.</param>
  /// <returns>
  /// True is the specified folder permission is equal to this one, false otherwise.
  /// </returns>
  bool _IsEqualTo(FolderPermission permission) {
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
  void _AdjustPermissionLevel() {
    for (MapEntry<FolderPermissionLevel, FolderPermission> keyValuePair
        in _defaultPermissions.Member!.entries) {
      if (this._IsEqualTo(keyValuePair.value)) {
        this._permissionLevel = keyValuePair.key;
        return;
      }
    }

    this._permissionLevel = FolderPermissionLevel.Custom;
  }

  /// <summary>
  /// Copies the values of the individual permissions of the specified folder permission
  /// to this folder permissions.
  /// </summary>
  /// <param name="permission">The folder permission to copy the values from.</param>
  void _AssignIndividualPermissions(FolderPermission permission) {
    this._canCreateItems = permission.CanCreateItems;
    this._canCreateSubFolders = permission.CanCreateSubFolders;
    this._isFolderContact = permission.IsFolderContact;
    this._isFolderOwner = permission.IsFolderOwner;
    this._isFolderVisible = permission.IsFolderVisible;
    this._editItems = permission.EditItems;
    this._deleteItems = permission.DeleteItems;
    this._readItems = permission.ReadItems;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderPermission"/> class.
  /// </summary>
  FolderPermission() : super() {
    this._userId = new property.UserId();
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderPermission"/> class.
  /// </summary>
  /// <param name="property.UserId">The Id of the user  the permission applies to.</param>
  /// <param name="permissionLevel">The level of the permission.</param>
  FolderPermission.withUserUd(
      property.UserId userId, FolderPermissionLevel permissionLevel) {
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
      String? primarySmtpAddress, FolderPermissionLevel permissionLevel) {
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
    if (!this._userId!.IsValid()) {
      throw new ServiceValidationException("""string.Format(
                        Strings.FolderPermissionHasInvalidproperty.UserId,
                        permissionIndex)""");
    }

    // If this permission is to be used for a non-calendar folder make sure that read access and permission level aren't set to Calendar-only values
    if (!isCalendarFolder) {
      if ((this._readItems ==
              FolderPermissionReadAccess.TimeAndSubjectAndLocation) ||
          (this._readItems == FolderPermissionReadAccess.TimeOnly)) {
        throw new ServiceLocalException("""string.Format(
                            Strings.ReadAccessInvalidForNonCalendarFolder,
                            this.readItems""");
      }

      if ((this._permissionLevel ==
              FolderPermissionLevel.FreeBusyTimeAndSubjectAndLocation) ||
          (this._permissionLevel == FolderPermissionLevel.FreeBusyTimeOnly)) {
        throw new ServiceLocalException("""string.Format(
                            Strings.PermissionLevelInvalidForNonCalendarFolder,
                            this.permissionLevel)""");
      }
    }
  }

  /// <summary>
  /// Gets the Id of the user the permission applies to.
  /// </summary>
  property.UserId? get UserId => this._userId;

  set UserId(property.UserId? value) {
    if (this._userId != null) {
      this._userId!.removeChangeEvent(this.PropertyChanged);
    }

    if (this.CanSetFieldValue(this._userId, value)) {
      this._userId = value;
      this.Changed();
    }

    if (this.UserId != null) {
      this.UserId!.addOnChangeEvent(this.PropertyChanged);
    }
  }

  /// <summary>
  /// Gets or sets a value indicating whether the user can create new items.
  /// </summary>
  bool? get CanCreateItems => this._canCreateItems;

  set CanCreateItems(bool? value) {
    if (this.CanSetFieldValue(this._canCreateItems, value)) {
      this._canCreateItems = value;
      this.Changed();
    }
    this._AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating whether the user can create sub-folders.
  /// </summary>
  bool? get CanCreateSubFolders => this._canCreateSubFolders;

  set CanCreateSubFolders(bool? value) {
    if (this.CanSetFieldValue(this._canCreateSubFolders, value)) {
      this._canCreateSubFolders = value;
      this.Changed();
    }
    this._AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating whether the user owns the folder.
  /// </summary>
  bool? get IsFolderOwner => this._isFolderOwner;

  set IsFolderOwner(bool? value) {
    if (this.CanSetFieldValue(this._isFolderOwner, value)) {
      this._isFolderOwner = value;
      this.Changed();
    }
    this._AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating whether the folder is visible to the user.
  /// </summary>
  bool? get IsFolderVisible => this._isFolderVisible;

  set IsFolderVisible(bool? value) {
    if (this.CanSetFieldValue(this._isFolderVisible, value)) {
      this._isFolderVisible = value;
      this.Changed();
    }
    this._AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating whether the user is a contact for the folder.
  /// </summary>
  bool? get IsFolderContact => this._isFolderContact;

  set IsFolderContact(bool? value) {
    if (this.CanSetFieldValue(this._isFolderContact, value)) {
      this._isFolderContact = value;
      this.Changed();
    }
    this._AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating if/how the user can edit existing items.
  /// </summary>
  PermissionScope? get EditItems => this._editItems;

  set EditItems(PermissionScope? value) {
    if (this.CanSetFieldValue(this._editItems, value)) {
      this._editItems = value;
      this.Changed();
    }
    this._AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets a value indicating if/how the user can delete existing items.
  /// </summary>
  PermissionScope? get DeleteItems => this._deleteItems;

  set DeleteItems(PermissionScope? value) {
    if (this.CanSetFieldValue(this._deleteItems, value)) {
      this._deleteItems = value;
      this.Changed();
    }
    this._AdjustPermissionLevel();
  }

  FolderPermissionReadAccess? get ReadItems => this._readItems;

  /// <summary>
  /// Gets or sets the read items access permission.
  /// </summary>
  set ReadItems(FolderPermissionReadAccess? value) {
    if (this.CanSetFieldValue(this._readItems, value)) {
      this._readItems = value;
      this.Changed();
    }
    this._AdjustPermissionLevel();
  }

  /// <summary>
  /// Gets or sets the permission level.
  /// </summary>
  FolderPermissionLevel? get PermissionLevel => this._permissionLevel;

  set PermissionLevel(FolderPermissionLevel? value) {
    if (this._permissionLevel != value) {
      if (value == FolderPermissionLevel.Custom) {
        throw new ServiceLocalException(
            "Strings.CannotSetPermissionLevelToCustom");
      }

      this._AssignIndividualPermissions(_defaultPermissions.Member![value!]!);
      if (this.CanSetFieldValue(this._permissionLevel, value)) {
        this._permissionLevel = value;
        this.Changed();
      }
    }
  }

  /// <summary>
  /// Gets the permission level that Outlook would display for this folder permission.
  /// </summary>
  FolderPermissionLevel? get DisplayPermissionLevel {
    // If permission level is set to Custom, see if there's a variant
    // that Outlook would map to the same permission level.
    if (this._permissionLevel == FolderPermissionLevel.Custom) {
      for (FolderPermission variant in FolderPermission._levelVariants.Member!) {
        if (this._IsEqualTo(variant)) {
          return variant.PermissionLevel;
        }
      }
    }

    return this._permissionLevel;
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
        this.UserId = new property.UserId();
        this.UserId!.LoadFromXml(reader, reader.LocalName);
        return true;
      case XmlElementNames.CanCreateItems:
        this._canCreateItems = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.CanCreateSubFolders:
        this._canCreateSubFolders = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.IsFolderOwner:
        this._isFolderOwner = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.IsFolderVisible:
        this._isFolderVisible = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.IsFolderContact:
        this._isFolderContact = reader.ReadValue<bool>();
        return true;
      case XmlElementNames.EditItems:
        this._editItems = reader.ReadValue<PermissionScope>();
        return true;
      case XmlElementNames.DeleteItems:
        this._deleteItems = reader.ReadValue<PermissionScope>();
        return true;
      case XmlElementNames.ReadItems:
        this._readItems = reader.ReadValue<FolderPermissionReadAccess>();
        return true;
      case XmlElementNames.PermissionLevel:
      case XmlElementNames.CalendarPermissionLevel:
        this._permissionLevel = reader.ReadValue<FolderPermissionLevel>();
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
  void LoadFromXmlWithNamespace(EwsServiceXmlReader reader,
      XmlNamespace xmlNamespace, String? xmlElementName) {
    super.LoadFromXmlWithNamespace(reader, xmlNamespace, xmlElementName);

    this._AdjustPermissionLevel();
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="isCalendarFolder">If true, this permission is for a calendar folder.</param>
  void WriteElementsToXmlWithCalendar(
      EwsServiceXmlWriter writer, bool isCalendarFolder) {
    if (this._userId != null) {
      this._userId!.WriteToXml(writer, XmlElementNames.UserId);
    }

    if (this.PermissionLevel == FolderPermissionLevel.Custom) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Types,
          XmlElementNames.CanCreateItems, this.CanCreateItems);

      writer.WriteElementValueWithNamespace(XmlNamespace.Types,
          XmlElementNames.CanCreateSubFolders, this.CanCreateSubFolders);

      writer.WriteElementValueWithNamespace(XmlNamespace.Types,
          XmlElementNames.IsFolderOwner, this.IsFolderOwner);

      writer.WriteElementValueWithNamespace(XmlNamespace.Types,
          XmlElementNames.IsFolderVisible, this.IsFolderVisible);

      writer.WriteElementValueWithNamespace(XmlNamespace.Types,
          XmlElementNames.IsFolderContact, this.IsFolderContact);

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
  void WriteToXmlWithElementNameAndCalendar(EwsServiceXmlWriter writer,
      String xmlElementName, bool isCalendarFolder) {
    writer.WriteStartElement(this.Namespace, xmlElementName);
    this.WriteAttributesToXml(writer);
    this.WriteElementsToXmlWithCalendar(writer, isCalendarFolder);
    writer.WriteEndElement();
  }
}
