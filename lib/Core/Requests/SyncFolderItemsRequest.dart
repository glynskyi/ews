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
import 'package:ews/Core/Responses/SyncFolderItemsResponse.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/ServiceObjectType.dart';
import 'package:ews/Enumerations/SyncFolderItemsScope.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/misc/ItemIdWrapperList.dart';

/// <summary>
/// Represents a SyncFolderItems request.
/// </summary>
class SyncFolderItemsRequest extends MultiResponseServiceRequest<SyncFolderItemsResponse> {
  /* private */ core.PropertySet propertySet;

  /* private */
  FolderId syncFolderId;

  /* private */
  SyncFolderItemsScope syncScope;

  /* private */
  String syncState;

  /* private */
  ItemIdWrapperList ignoredItemIds = new ItemIdWrapperList();

  /* private */
  int maxChangesReturned = 100;

  /* private */
  int numberOfDays = 0;

  /// <summary>
  /// Initializes a new instance of the <see cref="SyncFolderItemsRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  SyncFolderItemsRequest(ExchangeService service) : super(service, ServiceErrorHandling.ThrowOnError) {}

  /// <summary>
  /// Creates service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  @override
  SyncFolderItemsResponse CreateServiceResponse(ExchangeService service, int responseIndex) {
    return new SyncFolderItemsResponse(this.PropertySet);
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
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
    return XmlElementNames.SyncFolderItems;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.SyncFolderItemsResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.SyncFolderItemsResponseMessage;
  }

  /// <summary>
  /// Validate request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParam(this.PropertySet, "PropertySet");
    EwsUtilities.ValidateParam(this.SyncFolderId, "SyncFolderId");
    this.SyncFolderId.ValidateExchangeVersion(this.Service.RequestedServerVersion);

    // SyncFolderItemsScope enum was introduced with Exchange2010.  Only
    // value NormalItems is valid with previous server versions.
    if (this.Service.RequestedServerVersion.index < ExchangeVersion.Exchange2010.index &&
        this.syncScope != SyncFolderItemsScope.NormalItems) {
      throw new ServiceVersionException("""string.Format(
                                  Strings.EnumValueIncompatibleWithRequestVersion,
                                  this.syncScope.ToString(),
                                  this.syncScope.GetType().Name,
                                  ExchangeVersion.Exchange2010)""");
    }

    // NumberOfDays was introduced with Exchange 2013.
    if (this.Service.RequestedServerVersion.index < ExchangeVersion.Exchange2013.index && this.NumberOfDays != 0) {
      throw new ServiceVersionException("""string.Format(
                                  Strings.ParameterIncompatibleWithRequestVersion,
                                  "numberOfDays",
                                  ExchangeVersion.Exchange2013)""");
    }

    // SyncFolderItems can only handle summary properties
    this.PropertySet.ValidateForRequest(this, true /*summaryPropertiesOnly*/);
  }

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    this.PropertySet.WriteToXml(writer, ServiceObjectType.Item);

    writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.SyncFolderId);
    this.SyncFolderId.WriteToXmlElemenetName(writer);
    writer.WriteEndElement();

    writer.WriteElementValueWithNamespace(XmlNamespace.Messages, XmlElementNames.SyncState, this.SyncState);

    this.IgnoredItemIds.WriteToXml(writer, XmlNamespace.Messages, XmlElementNames.Ignore);

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Messages, XmlElementNames.MaxChangesReturned, this.MaxChangesReturned);

    if (this.Service.RequestedServerVersion.index >= ExchangeVersion.Exchange2010.index) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Messages, XmlElementNames.SyncScope, this.syncScope);
    }

    if (this.NumberOfDays != 0) {
      writer.WriteElementValueWithNamespace(XmlNamespace.Messages, XmlElementNames.NumberOfDays, this.numberOfDays);
    }
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
  core.PropertySet get PropertySet => this.propertySet;

  set PropertySet(core.PropertySet value) {
    this.propertySet = value;
  }

  /// <summary>
  /// Gets or sets the sync folder id.
  /// </summary>
  /// <value>The sync folder id.</value>
  FolderId get SyncFolderId => this.syncFolderId;

  set SyncFolderId(FolderId value) {
    this.syncFolderId = value;
  }

  /// <summary>
  /// Gets or sets the scope of the sync.
  /// </summary>
  /// <value>The scope of the sync.</value>
  SyncFolderItemsScope get SyncScope => this.syncScope;

  set SyncScope(SyncFolderItemsScope value) {
    this.syncScope = value;
  }

  /// <summary>
  /// Gets or sets the state of the sync.
  /// </summary>
  /// <value>The state of the sync.</value>
  String get SyncState => this.syncState;

  set SyncState(String value) {
    this.syncState = value;
  }

  /// <summary>
  /// Gets the list of ignored item ids.
  /// </summary>
  /// <value>The ignored item ids.</value>
  ItemIdWrapperList get IgnoredItemIds => this.ignoredItemIds;

  /// <summary>
  /// Gets or sets the maximum number of changes returned by SyncFolderItems.
  /// Values must be between 1 and 512.
  /// Default is 100.
  /// </summary>
  int get MaxChangesReturned => this.maxChangesReturned;

  set MaxChangesReturned(int value) {
    if (value >= 1 && value <= 512) {
      this.maxChangesReturned = value;
    } else {
      throw new RangeError.range(value, 1, 512, "Strings.MaxChangesMustBeBetween1And512");
    }
  }

  /// <summary>
  /// Gets or sets the number of days of content returned by SyncFolderItems.
  /// Zero means return all content.
  /// Default is zero.
  /// </summary>
  int get NumberOfDays => this.numberOfDays;

  set NumberOfDays(int value) {
    if (value >= 0) {
      this.numberOfDays = value;
    } else {
      throw new RangeError("Strings.NumberOfDaysMustBePositive");
    }
  }
}
