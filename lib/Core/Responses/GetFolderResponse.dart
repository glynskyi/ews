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
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/ServiceObjects/Folders/Folder.dart' as ServiceObjects;
import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// Represents the response to an individual folder retrieval operation.
/// </summary>
class GetFolderResponse extends ServiceResponse {
  ServiceObjects.Folder? _folder;

  PropertySet? _propertySet;

  /// <summary>
  /// Initializes a new instance of the <see cref="GetFolderResponse"/> class.
  /// </summary>
  /// <param name="folder">The folders.</param>
  /// <param name="propertySet">The property set from the request.</param>
  GetFolderResponse(ServiceObjects.Folder? folder, PropertySet? propertySet)
      : super() {
    this._folder = folder;
    this._propertySet = propertySet;

    EwsUtilities.Assert(this._propertySet != null, "GetFolderResponse.ctor",
        "PropertySet should not be null");
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  Future<void> ReadElementsFromXml(EwsServiceXmlReader reader) async {
    await super.ReadElementsFromXml(reader);

    List<ServiceObjects.Folder> folders =
        await reader.ReadServiceObjectsCollectionFromXml<ServiceObjects.Folder>(
            XmlElementNames.Folders,
            this._GetObjectInstance,
            true,
            /* clearPropertyBag */
            this._propertySet,
            /* requestedPropertySet */
            false); /* summaryPropertiesOnly */

    this._folder = folders[0];
  }

  /// <summary>
  /// Gets the folder instance.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>folders.</returns>
  ServiceObjects.Folder _GetObjectInstance(
      ExchangeService? service, String xmlElementName) {
    if (this.Folder != null) {
      return this.Folder!;
    } else {
      return EwsUtilities.CreateEwsObjectFromXmlElementName<
          ServiceObjects.Folder>(service, xmlElementName);
    }
  }

  /// <summary>
  /// Gets the folder that was retrieved.
  /// </summary>
  ServiceObjects.Folder? get Folder => this._folder;
}
