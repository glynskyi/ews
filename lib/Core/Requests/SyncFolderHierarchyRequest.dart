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

import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart' as core;
import 'package:ews/Core/Requests/MultiResponseServiceRequest.dart';
import 'package:ews/Core/Responses/SyncFolderHierarchyResponse.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/ServiceObjectType.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents a SyncFolderHierarchy request.
/// </summary>
class SyncFolderHierarchyRequest
    extends MultiResponseServiceRequest<SyncFolderHierarchyResponse> {
  core.PropertySet? _propertySet;

  FolderId? _syncFolderId;

  String? _syncState;

  /// <summary>
  /// Initializes a new instance of the <see cref="SyncFolderHierarchyRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  SyncFolderHierarchyRequest(ExchangeService service)
      : super(service, ServiceErrorHandling.ThrowOnError) {}

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  @override
  SyncFolderHierarchyResponse CreateServiceResponse(
      ExchangeService service, int responseIndex) {
    return new SyncFolderHierarchyResponse(this.PropertySet);
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected responses.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return 1;
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.SyncFolderHierarchy;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.SyncFolderHierarchyResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.SyncFolderHierarchyResponseMessage;
  }

  /// <summary>
  /// Validates request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParam(this.PropertySet, "PropertySet");
    if (this.SyncFolderId != null) {
      this
          .SyncFolderId!
          .ValidateExchangeVersion(this.Service.RequestedServerVersion);
    }

    this.PropertySet!.ValidateForRequest(this, false /*summaryPropertiesOnly*/);
  }

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    this.PropertySet!.WriteToXml(writer, ServiceObjectType.Folder);

    if (this.SyncFolderId != null) {
      writer.WriteStartElement(
          XmlNamespace.Messages, XmlElementNames.SyncFolderId);
      this.SyncFolderId!.WriteToXmlElemenetName(writer);
      writer.WriteEndElement();
    }

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Messages, XmlElementNames.SyncState, this.SyncState);
  }

  /// <summary>
  /// Gets the request version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this request is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// Gets or sets the property set.
  /// </summary>
  /// <value>The property set.</value>
  core.PropertySet? get PropertySet => this._propertySet;

  set PropertySet(core.PropertySet? value) {
    this._propertySet = value;
  }

  /// <summary>
  /// Gets or sets the sync folder id.
  /// </summary>
  /// <value>The sync folder id.</value>
  FolderId? get SyncFolderId => this._syncFolderId;

  set SyncFolderId(FolderId? value) {
    this._syncFolderId = value;
  }

  /// <summary>
  /// Gets or sets the state of the sync.
  /// </summary>
  /// <value>The state of the sync.</value>
  String? get SyncState => this._syncState;

  set SyncState(String? value) {
    this._syncState = value;
  }
}
