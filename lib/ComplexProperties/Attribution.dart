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
import 'package:ews/ComplexProperties/FolderId.dart' as complex;
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// Represents an attribution of an attributed string
/// </summary>
class Attribution extends ComplexProperty {
  /// <summary>
  /// Attribution id
  /// </summary>
  String? Id;

  /// <summary>
  /// Attribution source
  /// </summary>
  late ItemId SourceId;

  /// <summary>
  /// Display name
  /// </summary>
  String? DisplayName;

  /// <summary>
  /// Whether writable
  /// </summary>
  bool? IsWritable;

  /// <summary>
  /// Whether a quick contact
  /// </summary>
  bool? IsQuickContact;

  /// <summary>
  /// Whether hidden
  /// </summary>
  bool? IsHidden;

  /// <summary>
  /// Folder id
  /// </summary>
  complex.FolderId? FolderId;

  /// <summary>
  /// Default constructor
  /// </summary>
  Attribution() : super() {}

  /// <summary>
  /// Creates an instance with required values only
  /// </summary>
  /// <param name="id">Attribution id</param>
  /// <param name="sourceId">Source Id</param>
  /// <param name="displayName">Display name</param>
  Attribution.withRequiredValues(String id, ItemId sourceId, String displayName)
      : this.withAllValues(
            id, sourceId, displayName, false, false, false, null);

  /// <summary>
  /// Creates an instance with all values
  /// </summary>
  /// <param name="id">Attribution id</param>
  /// <param name="sourceId">Source Id</param>
  /// <param name="displayName">Display name</param>
  /// <param name="isWritable">Whether writable</param>
  /// <param name="isQuickContact">Wther quick contact</param>
  /// <param name="isHidden">Whether hidden</param>
  /// <param name="folderId">Folder id</param>
  Attribution.withAllValues(
      String id,
      ItemId sourceId,
      String displayName,
      bool isWritable,
      bool isQuickContact,
      bool isHidden,
      complex.FolderId? folderId)
      : super() {
    EwsUtilities.ValidateParam(id, "id");
    EwsUtilities.ValidateParam(displayName, "displayName");

    this.Id = id;
    this.SourceId = sourceId;
    this.DisplayName = displayName;
    this.IsWritable = isWritable;
    this.IsQuickContact = isQuickContact;
    this.IsHidden = isHidden;
    this.FolderId = folderId;
  }

  /// <summary>
  /// Tries to read element from XML
  /// </summary>
  /// <param name="reader">XML reader</param>
  /// <returns>Whether reading succeeded</returns>
  @override
  Future<bool> TryReadElementFromXml(EwsServiceXmlReader reader) async {
    switch (reader.LocalName) {
      case XmlElementNames.Id:
        this.Id = await reader.ReadElementValue<String>();
        break;
      case XmlElementNames.SourceId:
        this.SourceId = new ItemId();
        await this.SourceId.LoadFromXml(reader, reader.LocalName);
        break;
      case XmlElementNames.DisplayName:
        this.DisplayName = await reader.ReadElementValue<String>();
        break;
      case XmlElementNames.IsWritable:
        this.IsWritable = await reader.ReadElementValue<bool>();
        break;
      case XmlElementNames.IsQuickContact:
        this.IsQuickContact = await reader.ReadElementValue<bool>();
        break;
      case XmlElementNames.IsHidden:
        this.IsHidden = await reader.ReadElementValue<bool>();
        break;
      case XmlElementNames.FolderId:
        this.FolderId = new complex.FolderId();
        await this.FolderId!.LoadFromXml(reader, reader.LocalName);
        break;

      default:
        return super.TryReadElementFromXml(reader);
    }

    return true;
  }
}
