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

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/ServiceObjects/Folders/Folder.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ServiceResult.dart';

/// <summary>
/// Represents the response to an individual folder creation operation.
/// </summary>
class CreateFolderResponse extends ServiceResponse {
  Folder _folder;

  /// <summary>
  /// Initializes a new instance of the <see cref="CreateFolderResponse"/> class.
  /// </summary>
  /// <param name="folder">The folder.</param>
  CreateFolderResponse(Folder folder) : super() {
    this._folder = folder;
  }

  /// <summary>
  /// Gets the object instance.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>Folder.</returns>
  Folder _GetObjectInstance(ExchangeService service, String xmlElementName) {
    if (this._folder != null) {
      return this._folder;
    } else {
      return EwsUtilities.CreateEwsObjectFromXmlElementName<Folder>(
          service, xmlElementName);
    }
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    super.ReadElementsFromXml(reader);

    List<Folder> folders = reader.ReadServiceObjectsCollectionFromXml<Folder>(
        XmlElementNames.Folders,
        this._GetObjectInstance,
        false,
        /* clearPropertyBag */
        null,
        /* requestedPropertySet */
        false); /* summaryPropertiesOnly */

    this._folder = folders[0];
  }

  /// <summary>
  /// Clears the change log of the created folder if the creation succeeded.
  /// </summary>
  @override
  void Loaded() {
    if (this.Result == ServiceResult.Success) {
      this._folder.ClearChangeLog();
    }
  }
}
