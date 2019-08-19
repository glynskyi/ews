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

import 'package:ews/ComplexProperties/Mailbox.dart'
    as complexProperties;
import 'package:ews/ComplexProperties/ServiceId.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart';
import 'package:ews/misc/Std/EnumToString.dart';

/// <summary>
/// Represents the Id of a folder.
/// </summary>
class FolderId extends ServiceId {
  /* private */ WellKnownFolderName folderName;

  /* private */
  complexProperties.Mailbox mailbox;

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderId"/> class.
  /// </summary>
  FolderId() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderId"/> class. Use this constructor
  /// to link this FolderId to an existing folder that you have the unique Id of.
  /// </summary>
  /// <param name="uniqueId">The unique Id used to initialize the FolderId.</param>
  FolderId.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderId"/> class. Use this constructor
  /// to link this FolderId to a well known folder (e.g. Inbox, Calendar or Contacts).
  /// </summary>
  /// <param name="folderName">The folder name used to initialize the FolderId.</param>
  FolderId.fromWellKnownFolder(WellKnownFolderName folderName) : super() {
    this.folderName = folderName;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="FolderId"/> class. Use this constructor
  /// to link this FolderId to a well known folder (e.g. Inbox, Calendar or Contacts) in a
  /// specific mailbox.
  /// </summary>
  /// <param name="folderName">The folder name used to initialize the FolderId.</param>
  /// <param name="mailbox">The mailbox used to initialize the FolderId.</param>
  FolderId.fromWellKnownFolderAndMailbox(
      WellKnownFolderName folderName, complexProperties.Mailbox mailbox)
      : super() {
    this.folderName = folderName;
    this.mailbox = mailbox;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return this.FolderName != null
        ? XmlElementNames.DistinguishedFolderId
        : XmlElementNames.FolderId;
  }

  /// <summary>
  /// Writes attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    if (this.FolderName != null) {
      writer.WriteAttributeValue(
          XmlAttributeNames.Id, EnumToString.parse(this.FolderName).toLowerCase());

      if (this.Mailbox != null) {
        this.Mailbox.WriteToXml(writer, XmlElementNames.Mailbox);
      }
    } else {
      super.WriteAttributesToXml(writer);
    }
  }

  /// <summary>
  /// Validates FolderId against a specified request version.
  /// </summary>
  /// <param name="version">The version.</param>
  void ValidateExchangeVersion(ExchangeVersion version) {
    // The FolderName property is a WellKnownFolderName, an enumeration type. If the property
    // is set, make sure that the value is valid for the request version.
    if (this.FolderName != null) {
      // todo("Implement ValidateEnumVersionValue")
//                EwsUtilities.ValidateEnumVersionValue(this.FolderName, version);
    }
  }

  /// <summary>
  /// Gets the name of the folder associated with the folder Id. Name and Id are mutually exclusive; if one is set, the other is null.
  /// </summary>
  WellKnownFolderName get FolderName => this.folderName;

  /// <summary>
  /// Gets the mailbox of the folder. Mailbox is only set when FolderName is set.
  /// </summary>
  complexProperties.Mailbox get Mailbox => this.mailbox;

  /// <summary>
  ///  Defines an implicit conversion between String and FolderId.
  /// </summary>
  /// <param name="uniqueId">The unique Id to convert to FolderId.</param>
  /// <returns>A FolderId initialized with the specified unique Id.</returns>
// static implicit operator FolderId(String uniqueId)
//        {
//            return new FolderId(uniqueId);
//        }

  /// <summary>
  /// Defines an implicit conversion between WellKnownFolderName and FolderId.
  /// </summary>
  /// <param name="folderName">The folder name to convert to FolderId.</param>
  /// <returns>A FolderId initialized with the specified folder name.</returns>
// static implicit operator FolderId(WellKnownFolderName folderName)
//        {
//            return new FolderId(folderName);
//        }

  /// <summary>
  /// True if this instance is valid, false otherthise.
  /// </summary>
  /// <value><c>true</c> if this instance is valid; otherwise, <c>false</c>.</value>
  @override
  bool get IsValid {
    if (this.FolderName != null) {
      return (this.Mailbox == null) || this.Mailbox.IsValid;
    } else {
      return super.IsValid;
    }
  }

  /// <summary>
  /// Determines whether the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <param name="obj">The <see cref="T:System.Object"/> to compare with the current <see cref="T:System.Object"/>.</param>
  /// <returns>
  /// true if the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>; otherwise, false.
  /// </returns>
  /// <exception cref="T:System.NullReferenceException">The <paramref name="obj"/> parameter is null.</exception>
  @override
  bool operator ==(obj) {
    if (identical(this, obj)) {
      return true;
    } else {
      FolderId other = obj is FolderId ? obj : null;

      if (other == null) {
        return false;
      } else if (this.FolderName != null) {
        if (other.FolderName != null && this.FolderName == other.FolderName) {
          if (this.Mailbox != null) {
            return this.Mailbox == other.Mailbox;
          } else if (other.Mailbox == null) {
            return true;
          }
        }
      } else if (super == other) {
        return true;
      }

      return false;
    }
  }

  /// <summary>
  /// Serves as a hash function for a particular type.
  /// </summary>
  /// <returns>
  /// A hash code for the current <see cref="T:System.Object"/>.
  /// </returns>

  @override
  int get hashCode {
    int hashCode;

    if (this.FolderName != null) {
      hashCode = this.FolderName.hashCode;

      if ((this.Mailbox != null) && this.Mailbox.IsValid) {
        hashCode = hashCode ^ this.Mailbox.hashCode;
      }
    } else {
      hashCode = super.hashCode;
    }

    return hashCode;
  }

  /// <summary>
  /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  String toString() {
    if (this.IsValid) {
      if (this.FolderName != null) {
        if ((this.Mailbox != null) && mailbox.IsValid) {
          return "$FolderName ($Mailbox)";
        } else {
          return this.FolderName.toString();
        }
      } else {
        return super.toString();
      }
    } else {
      return "";
    }
  }
}
