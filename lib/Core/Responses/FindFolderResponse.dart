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
import 'package:ews/Core/ServiceObjects/Folders/Folder.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Search/FindFoldersResults.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents the response to a folder search operation.
/// </summary>
class FindFolderResponse extends ServiceResponse {
  FindFoldersResults _results = new FindFoldersResults();

  PropertySet _propertySet;

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    reader.ReadStartElementWithNamespace(XmlNamespace.Messages, XmlElementNames.RootFolder);

    this._results.TotalCount = reader.ReadAttributeValue<int>(XmlAttributeNames.TotalItemsInView);
    this._results.MoreAvailable =
        !reader.ReadAttributeValue<bool>(XmlAttributeNames.IncludesLastItemInRange);

    // Ignore IndexedPagingOffset attribute if MoreAvailable is false.
    this._results.NextPageOffset = _results.MoreAvailable
        ? reader.ReadNullableAttributeValue<int>(XmlAttributeNames.IndexedPagingOffset)
        : null;

    reader.ReadStartElementWithNamespace(XmlNamespace.Types, XmlElementNames.Folders);
    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if (reader.NodeType == XmlNodeType.Element) {
          Folder folder = EwsUtilities.CreateEwsObjectFromXmlElementName<Folder>(
              reader.Service, reader.LocalName);

          if (folder == null) {
            reader.SkipCurrentElement();
          } else {
            folder.LoadFromXmlWithPropertySet(
                reader,
                true,
                /* clearPropertyBag */
                this._propertySet,
                true /* summaryPropertiesOnly */);

            this._results.Folders.add(folder);
          }
        }
      } while (!reader.IsEndElementWithNamespace(XmlNamespace.Types, XmlElementNames.Folders));
    }

    reader.ReadEndElementWithNamespace(XmlNamespace.Messages, XmlElementNames.RootFolder);
  }

  /// <summary>
  /// Creates a folder instance.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>Folder</returns>
  /* private */
  Folder CreateFolderInstance(ExchangeService service, String xmlElementName) {
    return EwsUtilities.CreateEwsObjectFromXmlElementName<Folder>(service, xmlElementName);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="FindFolderResponse"/> class.
  /// </summary>
  /// <param name="propertySet">The property set from, the request.</param>
  FindFolderResponse(PropertySet propertySet) : super() {
    this._propertySet = propertySet;

    EwsUtilities.Assert(
        this._propertySet != null, "FindFolderResponse.ctor", "PropertySet should not be null");
  }

  /// <summary>
  /// Gets the results of the search operation.
  /// </summary>
  FindFoldersResults get Results => this._results;
}
