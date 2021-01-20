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

import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents a sharing location.
/// </summary>
class DocumentSharingLocation {
  /// <summary>
  /// The URL of the web service to use to manipulate documents at the
  /// sharing location.
  /// </summary>
  String? _serviceUrl;

  /// <summary>
  /// The URL of the sharing location (for viewing the contents in a web
  /// browser).
  /// </summary>
  String? _locationUrl;

  /// <summary>
  /// The display name of the location.
  /// </summary>
  String? _displayName;

  /// <summary>
  /// The set of file extensions that are allowed at the location.
  /// </summary>
  Iterable<String?>? _supportedFileExtensions;

  /// <summary>
  /// Indicates whether external users (outside the enterprise/tenant)
  /// can view documents at the location.
  /// </summary>
  bool? _externalAccessAllowed = false;

  /// <summary>
  /// Indicates whether anonymous users can view documents at the location.
  /// </summary>
  bool? _anonymousAccessAllowed = false;

  /// <summary>
  /// Indicates whether the user can modify permissions for documents at
  /// the location.
  /// </summary>
  bool? _canModifyPermissions = false;

  /// <summary>
  /// Indicates whether this location is the user's default location.
  /// This will generally be their My Site.
  /// </summary>
  bool? _isDefault = false;

  /// <summary>
  /// Gets the URL of the web service to use to manipulate
  /// documents at the sharing location.
  /// </summary>
  String? get ServiceUrl => this._serviceUrl;

  set ServiceUrl(String? value) => this._serviceUrl = value;

  /// <summary>
  /// Gets the URL of the sharing location (for viewing the
  /// contents in a web browser).
  /// </summary>
  String? get LocationUrl => this._locationUrl;

  set LocationUrl(String? value) => this._locationUrl = value;

  /// <summary>
  /// Gets the display name of the location.
  /// </summary>
  String? get DisplayName => this._displayName;

  set DisplayName(String? value) => this._displayName = value;

  /// <summary>
  /// Gets the space-separated list of file extensions that are
  /// allowed at the location.
  /// </summary>
  /// <remarks>
  /// Example:  "docx pptx xlsx"
  /// </remarks>
  Iterable<String?>? get SupportedFileExtensions => this._supportedFileExtensions;

  set SupportedFileExtensions(Iterable<String?>? value) =>
      this._supportedFileExtensions = value;

  /// <summary>
  /// Gets a flag indicating whether external users (outside the
  /// enterprise/tenant) can view documents at the location.
  /// </summary>
  bool? get ExternalAccessAllowed => this._externalAccessAllowed;

  set ExternalAccessAllowed(bool? value) => this._externalAccessAllowed = value;

  /// <summary>
  /// Gets a flag indicating whether anonymous users can view
  /// documents at the location.
  /// </summary>
  bool? get AnonymousAccessAllowed => this._anonymousAccessAllowed;

  set AnonymousAccessAllowed(bool? value) =>
      this._anonymousAccessAllowed = value;

  /// <summary>
  /// Gets a flag indicating whether the user can modify
  /// permissions for documents at the location.
  /// </summary>
  /// <remarks>
  /// This will be true for the user's "My Site," for example. However,
  /// documents at team and project sites will typically be ACLed by the
  /// site owner, so the user will not be able to modify permissions.
  /// This will most likely by false even if the caller is the owner,
  /// to avoid surprises.  They should go to SharePoint to modify
  /// permissions for team and project sites.
  /// </remarks>
  bool? get CanModifyPermissions => this._canModifyPermissions;

  set CanModifyPermissions(bool? value) => this._canModifyPermissions = value;

  /// <summary>
  /// Gets a flag indicating whether this location is the user's
  /// default location.  This will generally be their My Site.
  /// </summary>
  bool? get IsDefault => this._isDefault;

  set IsDefault(bool? value) => this._isDefault = value;

  /// <summary>
  /// Initializes a new instance of the <see cref="DocumentSharingLocation"/> class.
  /// </summary>
  DocumentSharingLocation._() {}

  /// <summary>
  /// Loads DocumentSharingLocation instance from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>DocumentSharingLocation.</returns>
  static DocumentSharingLocation LoadFromXml(EwsXmlReader reader) {
    DocumentSharingLocation location = new DocumentSharingLocation._();

    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.ServiceUrl:
            location.ServiceUrl = reader.ReadElementValue<String>();
            break;

          case XmlElementNames.LocationUrl:
            location.LocationUrl = reader.ReadElementValue<String>();
            break;

          case XmlElementNames.DisplayName:
            location.DisplayName = reader.ReadElementValue<String>();
            break;

          case XmlElementNames.SupportedFileExtensions:
            List<String?> fileExtensions = <String?>[];
            reader.Read();
            while (reader.IsStartElementWithNamespace(
                XmlNamespace.Autodiscover, XmlElementNames.FileExtension)) {
              String? extension = reader.ReadElementValue<String>();
              fileExtensions.add(extension);
              reader.Read();
            }

            location.SupportedFileExtensions = fileExtensions;
            break;

          case XmlElementNames.ExternalAccessAllowed:
            location.ExternalAccessAllowed = reader.ReadElementValue<bool>();
            break;

          case XmlElementNames.AnonymousAccessAllowed:
            location.AnonymousAccessAllowed = reader.ReadElementValue<bool>();
            break;

          case XmlElementNames.CanModifyPermissions:
            location.CanModifyPermissions = reader.ReadElementValue<bool>();
            break;

          case XmlElementNames.IsDefault:
            location.IsDefault = reader.ReadElementValue<bool>();
            break;

          default:
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.DocumentSharingLocation));

    return location;
  }
}
