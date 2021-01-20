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

import 'package:ews/Attributes/ServiceObjectDefinitionAttribute.dart';
import 'package:ews/ComplexProperties/ExtendedPropertyCollection.dart';
import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/ComplexProperties/FolderPermissionCollection.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/Responses/FindItemResponse.dart';
import 'package:ews/Core/Responses/ServiceResponseCollection.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/Schemas/FolderSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AffectedTaskOccurrence.dart';
import 'package:ews/Enumerations/DeleteMode.dart';
import 'package:ews/Enumerations/EffectiveRights.dart' as enumerations;
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/SendCancellationsMode.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart' as enumerations;
import 'package:ews/PropertyDefinitions/ExtendedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/Search/Filters/SearchFilter.dart';
import 'package:ews/Search/FindItemsResults.dart';
import 'package:ews/Search/Grouping.dart';
import 'package:ews/Search/ItemView.dart';
import 'package:ews/Search/ViewBase.dart';
import 'package:ews/misc/OutParam.dart';

/// <summary>
/// Represents a generic folder.
/// </summary>
//    [ServiceObjectDefinition(XmlElementNames.Folder)]
//@ServiceObjectDefinitionAttribute(XmlElementNames.Folder, true)
class Folder extends ServiceObject {
  /// <summary>
  /// Initializes an unsaved local instance of <see cref="Folder"/>. To bind to an existing folder, use Folder.Bind() instead.
  /// </summary>
  /// <param name="service">EWS service to which this object belongs.</param>
  Folder(ExchangeService service) : super(service) {}

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return new ServiceObjectDefinitionAttribute(XmlElementNames.Folder);
  }

  /// <summary>
  /// Binds to an existing folder, whatever its actual type is, and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the folder.</param>
  /// <param name="id">The Id of the folder to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>A Folder instance representing the folder corresponding to the specified Id.</returns>
  static Future<Folder> BindWithPropertySet(
      ExchangeService service, FolderId id, PropertySet propertySet) async {
    return await service.BindToFolderGeneric<Folder>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing folder, whatever its actual type is, and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the folder.</param>
  /// <param name="id">The Id of the folder to bind to.</param>
  /// <returns>A Folder instance representing the folder corresponding to the specified Id.</returns>
  static Future<Folder> Bind(ExchangeService service, FolderId id) async {
    return await Folder.BindWithPropertySet(
        service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// Binds to an existing folder, whatever its actual type is, and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the folder.</param>
  /// <param name="name">The name of the folder to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>A Folder instance representing the folder with the specified name.</returns>
  static Future<Folder> BindWithWellKnownFolderAndProperySet(
      ExchangeService service,
      enumerations.WellKnownFolderName name,
      PropertySet propertySet) {
    return Folder.BindWithPropertySet(
        service, new FolderId.fromWellKnownFolder(name), propertySet);
  }

  /// <summary>
  /// Binds to an existing folder, whatever its actual type is, and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the folder.</param>
  /// <param name="name">The name of the folder to bind to.</param>
  /// <returns>A Folder instance representing the folder with the specified name.</returns>
  static Future<Folder> BindWithWellKnownFolder(
      ExchangeService service, enumerations.WellKnownFolderName name) {
    return Folder.BindWithPropertySet(service,
        FolderId.fromWellKnownFolder(name), PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  @override
  void Validate() {
    super.Validate();

    // Validate folder permissions
    if (this.PropertyBag.Contains(FolderSchema.Permissions)) {
      this.Permissions.Validate();
    }
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return FolderSchema.Instance;
  }

  /// <summary>
  /// Gets the minimum required server version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// Gets the name of the change XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetChangeXmlElementName() {
    return XmlElementNames.FolderChange;
  }

  /// <summary>
  /// Gets the name of the set field XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetSetFieldXmlElementName() {
    return XmlElementNames.SetFolderField;
  }

  /// <summary>
  /// Gets the name of the delete field XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetDeleteFieldXmlElementName() {
    return XmlElementNames.DeleteFolderField;
  }

  /// <summary>
  /// Loads the specified set of properties on the object.
  /// </summary>
  /// <param name="propertySet">The properties to load.</param>
  @override
  Future<void> InternalLoad(PropertySet propertySet) {
    this.ThrowIfThisIsNew();

    return this.Service.LoadPropertiesForFolder(this, propertySet);
  }

  /// <summary>
  /// Deletes the object.
  /// </summary>
  /// <param name="deleteMode">The deletion mode.</param>
  /// <param name="sendCancellationsMode">Indicates whether meeting cancellation messages should be sent.</param>
  /// <param name="affectedTaskOccurrences">Indicate which occurrence of a recurring task should be deleted.</param>
  @override
  Future<void> InternalDelete(
      DeleteMode deleteMode,
      SendCancellationsMode? sendCancellationsMode,
      AffectedTaskOccurrence? affectedTaskOccurrences) {
    this.ThrowIfThisIsNew();

    return this.Service.DeleteFolder(this.Id, deleteMode);
  }

  /// <summary>
  /// Deletes the folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="deleteMode">Deletion mode.</param>
  Future<void> Delete(DeleteMode deleteMode) {
    return this.InternalDelete(deleteMode, null, null);
  }

  /// <summary>
  /// Empties the folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="deleteMode">The deletion mode.</param>
  /// <param name="deleteSubFolders">Indicates whether sub-folders should also be deleted.</param>
// void Empty(
//            DeleteMode deleteMode,
//            bool deleteSubFolders)
//        {
//            this.ThrowIfThisIsNew();
//            this.Service.EmptyFolder(
//                this.Id,
//                deleteMode,
//                deleteSubFolders);
//        }

  /// <summary>
  /// Marks all items in folder as read. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="suppressReadReceipts">If true, suppress sending read receipts for items.</param>
// void MarkAllItemsAsRead(bool suppressReadReceipts)
//        {
//            this.ThrowIfThisIsNew();
//            this.Service.MarkAllItemsAsRead(
//                this.Id,
//                true,
//                suppressReadReceipts);
//        }

  /// <summary>
  /// Marks all items in folder as read. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="suppressReadReceipts">If true, suppress sending read receipts for items.</param>
// void MarkAllItemsAsUnread(bool suppressReadReceipts)
//        {
//            this.ThrowIfThisIsNew();
//            this.Service.MarkAllItemsAsRead(
//                this.Id,
//                false,
//                suppressReadReceipts);
//        }

  /// <summary>
  /// Saves this folder in a specific folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="parentFolderId">The Id of the folder in which to save this folder.</param>
  Future<void> Save(FolderId parentFolderId) async {
    this.ThrowIfThisIsNotNew();

//            EwsUtilities.ValidateParam(parentFolderId, "parentFolderId");

    if (this.IsDirty) {
      await this.Service.CreateFolder(this, parentFolderId);
    }
  }

  /// <summary>
  /// Saves this folder in a specific folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="parentFolderName">The name of the folder in which to save this folder.</param>
  Future<void> SaveWithWellKnownFolderName(
      enumerations.WellKnownFolderName parentFolderName) async {
    await this.Save(new FolderId.fromWellKnownFolder(parentFolderName));
  }

  /// <summary>
  /// Applies the local changes that have been made to this folder. Calling this method results in a call to EWS.
  /// </summary>
  Future<void> Update() async {
    if (this.IsDirty) {
      if (this.PropertyBag.GetIsUpdateCallNecessary()) {
        await this.Service.UpdateFolder(this);
      }
    }
  }

  /// <summary>
  /// Copies this folder into a specific folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="destinationFolderId">The Id of the folder in which to copy this folder.</param>
  /// <returns>A Folder representing the copy of this folder.</returns>
// Folder Copy(FolderId destinationFolderId)
//        {
//            this.ThrowIfThisIsNew();
//
////            EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");
//
//            return this.Service.CopyFolder(this.Id, destinationFolderId);
//        }

  /// <summary>
  /// Copies this folder into the specified folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="destinationFolderName">The name of the folder in which to copy this folder.</param>
  /// <returns>A Folder representing the copy of this folder.</returns>
// Folder CopyWithWellKnownFolderName(enumerations.WellKnownFolderName destinationFolderName)
//        {
//            return this.Copy(new FolderId.fromWellKnownFolder(destinationFolderName));
//        }

  /// <summary>
  /// Moves this folder to a specific folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="destinationFolderId">The Id of the folder in which to move this folder.</param>
  /// <returns>A new folder representing this folder in its new location. After Move completes, this folder does not exist anymore.</returns>
// Folder Move(FolderId destinationFolderId)
//        {
//            this.ThrowIfThisIsNew();
//
////            EwsUtilities.ValidateParam(destinationFolderId, "destinationFolderId");
//
//            return this.Service.MoveFolder(this.Id, destinationFolderId);
//        }

  /// <summary>
  /// Moves this folder to the specified folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="destinationFolderName">The name of the folder in which to move this folder.</param>
  /// <returns>A new folder representing this folder in its new location. After Move completes, this folder does not exist anymore.</returns>
// Folder MoveWithWellKnownFolderName(enumerations.WellKnownFolderName destinationFolderName)
//        {
//            return this.Move(new FolderId.fromWellKnownFolder(destinationFolderName));
//        }

  /// <summary>
  /// Find items.
  /// </summary>
  /// <typeparam name="TItem">The type of the item.</typeparam>
  /// <param name="queryString">query String to be used for indexed search</param>
  /// <param name="view">The view controlling the number of items returned.</param>
  /// <param name="groupBy">The group by.</param>
  /// <returns>FindItems response collection.</returns>
  Future<ServiceResponseCollection<FindItemResponse<TItem>>>
      InternalFindItems<TItem extends Item>(
          String? queryString, ViewBase view, Grouping? groupBy) {
    this.ThrowIfThisIsNew();

    return this.Service.FindItemsGeneric<TItem>(
        [this.Id],
        null,
        /* searchFilter */
        queryString,
        view,
        groupBy,
        ServiceErrorHandling.ThrowOnError);
  }

  /// <summary>
  /// Find items.
  /// </summary>
  /// <typeparam name="TItem">The type of the item.</typeparam>
  /// <param name="searchFilter">The search filter. Available search filter classes
  /// include SearchFilter.IsEqualTo, SearchFilter.ContainsSubString and
  /// SearchFilter.SearchFilterCollection</param>
  /// <param name="view">The view controlling the number of items returned.</param>
  /// <param name="groupBy">The group by.</param>
  /// <returns>FindItems response collection.</returns>
  Future<ServiceResponseCollection<FindItemResponse<TItem>>>
      InternalFindItemsGeneric<TItem extends Item>(
          SearchFilter searchFilter, ViewBase view, Grouping? groupBy) {
    this.ThrowIfThisIsNew();

    return this.Service.FindItemsGeneric<TItem>(
        [this.Id],
        searchFilter,
        null,
        /* queryString */
        view,
        groupBy,
        ServiceErrorHandling.ThrowOnError);
  }

  /// <summary>
  /// Obtains a list of items by searching the contents of this folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="searchFilter">The search filter. Available search filter classes
  /// include SearchFilter.IsEqualTo, SearchFilter.ContainsSubString and
  /// SearchFilter.SearchFilterCollection</param>
  /// <param name="view">The view controlling the number of items returned.</param>
  /// <returns>An object representing the results of the search operation.</returns>
  Future<FindItemsResults<Item>?> FindItems(
      SearchFilter searchFilter, ItemView view) async {
    EwsUtilities.ValidateParamAllowNull(searchFilter, "searchFilter");

    ServiceResponseCollection<FindItemResponse<Item>> responses = await this
        .InternalFindItemsGeneric<Item>(searchFilter, view, null /* groupBy */);

    return responses[0].Results;
  }

  /// <summary>
  /// Obtains a list of items by searching the contents of this folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="queryString">query String to be used for indexed search</param>
  /// <param name="view">The view controlling the number of items returned.</param>
  /// <returns>An object representing the results of the search operation.</returns>
// FindItemsResults<Item> FindItems(String queryString, ItemView view)
//        {
////            EwsUtilities.ValidateParamAllowNull(queryString, "queryString");
//
//            ServiceResponseCollection<FindItemResponse<Item>> responses = this.InternalFindItems<Item>(queryString, view, null /* groupBy */);
//
//            return responses[0].Results;
//        }

  /// <summary>
  /// Obtains a list of items by searching the contents of this folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="view">The view controlling the number of items returned.</param>
  /// <returns>An object representing the results of the search operation.</returns>
// FindItemsResults<Item> FindItems(ItemView view)
//        {
//            ServiceResponseCollection<FindItemResponse<Item>> responses = this.InternalFindItems<Item>(
//                (SearchFilter)null,
//                view,
//                null /* groupBy */ );
//
//            return responses[0].Results;
//        }

  /// <summary>
  /// Obtains a grouped list of items by searching the contents of this folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="searchFilter">The search filter. Available search filter classes
  /// include SearchFilter.IsEqualTo, SearchFilter.ContainsSubString and
  /// SearchFilter.SearchFilterCollection</param>
  /// <param name="view">The view controlling the number of items returned.</param>
  /// <param name="groupBy">The grouping criteria.</param>
  /// <returns>A collection of grouped items representing the contents of this folder.</returns>
// GroupedFindItemsResults<Item> FindItems(SearchFilter searchFilter, ItemView view, Grouping groupBy)
//        {
////            EwsUtilities.ValidateParam(groupBy, "groupBy");
////            EwsUtilities.ValidateParamAllowNull(searchFilter, "searchFilter");
//
//            ServiceResponseCollection<FindItemResponse<Item>> responses = this.InternalFindItems<Item>(
//                searchFilter,
//                view,
//                groupBy);
//
//            return responses[0].GroupedFindResults;
//        }

  /// <summary>
  /// Obtains a grouped list of items by searching the contents of this folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="queryString">query String to be used for indexed search</param>
  /// <param name="view">The view controlling the number of items returned.</param>
  /// <param name="groupBy">The grouping criteria.</param>
  /// <returns>A collection of grouped items representing the contents of this folder.</returns>
// GroupedFindItemsResults<Item> FindItems(String queryString, ItemView view, Grouping groupBy)
//        {
////            EwsUtilities.ValidateParam(groupBy, "groupBy");
//
//            ServiceResponseCollection<FindItemResponse<Item>> responses = this.InternalFindItems<Item>(queryString, view, groupBy);
//
//            return responses[0].GroupedFindResults;
//        }

  /// <summary>
  /// Obtains a list of folders by searching the sub-folders of this folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="view">The view controlling the number of folders returned.</param>
  /// <returns>An object representing the results of the search operation.</returns>
// FindFoldersResults FindFolders(FolderView view)
//        {
//            this.ThrowIfThisIsNew();
//
//            return this.Service.FindFolders(this.Id, view);
//        }

  /// <summary>
  /// Obtains a list of folders by searching the sub-folders of this folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="searchFilter">The search filter. Available search filter classes
  /// include SearchFilter.IsEqualTo, SearchFilter.ContainsSubString and
  /// SearchFilter.SearchFilterCollection</param>
  /// <param name="view">The view controlling the number of folders returned.</param>
  /// <returns>An object representing the results of the search operation.</returns>
// FindFoldersResults FindFolders(SearchFilter searchFilter, FolderView view)
//        {
//            this.ThrowIfThisIsNew();
//
//            return this.Service.FindFolders(this.Id, searchFilter, view);
//        }

  /// <summary>
  /// Obtains a grouped list of items by searching the contents of this folder. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="view">The view controlling the number of items returned.</param>
  /// <param name="groupBy">The grouping criteria.</param>
  /// <returns>A collection of grouped items representing the contents of this folder.</returns>
// GroupedFindItemsResults<Item> FindItems(ItemView view, Grouping groupBy)
//        {
////            EwsUtilities.ValidateParam(groupBy, "groupBy");
//
//            return this.FindItems(
//                (SearchFilter)null,
//                view,
//                groupBy);
//        }

  /// <summary>
  /// Get the property definition for the Id property.
  /// </summary>
  /// <returns>A PropertyDefinition instance.</returns>
  @override
  PropertyDefinition GetIdPropertyDefinition() {
    return FolderSchema.Id;
  }

  /// <summary>
  /// Sets the extended property.
  /// </summary>
  /// <param name="extendedPropertyDefinition">The extended property definition.</param>
  /// <param name="value">The value.</param>
  void SetExtendedProperty(
      ExtendedPropertyDefinition extendedPropertyDefinition, Object value) {
    this
        .ExtendedProperties
        .SetExtendedProperty(extendedPropertyDefinition, value);
  }

  /// <summary>
  /// Removes an extended property.
  /// </summary>
  /// <param name="extendedPropertyDefinition">The extended property definition.</param>
  /// <returns>True if property was removed.</returns>
  bool RemoveExtendedProperty(
      ExtendedPropertyDefinition extendedPropertyDefinition) {
    return this
        .ExtendedProperties
        .RemoveExtendedProperty(extendedPropertyDefinition);
  }

  /// <summary>
  /// Gets a list of extended properties defined on this object.
  /// </summary>
  /// <returns>Extended properties collection.</returns>
  @override
  ExtendedPropertyCollection? GetExtendedProperties() {
    return this.ExtendedProperties;
  }

  /// <summary>
  /// Gets the Id of the folder.
  /// </summary>
  FolderId? get Id =>
      this.PropertyBag[this.GetIdPropertyDefinition()] as FolderId?;

  /// <summary>
  /// Gets the Id of this folder's parent folder.
  /// </summary>
  FolderId? get ParentFolderId =>
      this.PropertyBag[FolderSchema.ParentFolderId] as FolderId?;

  /// <summary>
  /// Gets the number of child folders this folder has.
  /// </summary>
  int? get ChildFolderCount =>
      this.PropertyBag[FolderSchema.ChildFolderCount] as int?;

  /// <summary>
  /// Gets or sets the display name of the folder.
  /// </summary>
  String? get DisplayName =>
      this.PropertyBag[FolderSchema.DisplayName] as String?;

  set DisplayName(String? value) =>
      this.PropertyBag[FolderSchema.DisplayName] = value;

  /// <summary>
  /// Gets or sets the custom class name of this folder.
  /// </summary>
  String? get FolderClass =>
      this.PropertyBag[FolderSchema.FolderClass] as String?;

  set FolderClass(String? value) =>
      this.PropertyBag[FolderSchema.FolderClass] = value;

  /// <summary>
  /// Gets the total number of items contained in the folder.
  /// </summary>
  int? get TotalCount => this.PropertyBag[FolderSchema.TotalCount] as int?;

  /// <summary>
  /// Gets a list of extended properties associated with the folder.
  /// </summary>
  ExtendedPropertyCollection get ExtendedProperties =>
      this.PropertyBag[ServiceObjectSchema.ExtendedProperties]
          as ExtendedPropertyCollection;

  /// <summary>
  /// Gets the Email Lifecycle Management (ELC) information associated with the folder.
  /// </summary>
// ManagedFolderInformation get ManagedFolderInformation => this.PropertyBag[FolderSchema.ManagedFolderInformation];

  /// <summary>
  /// Gets a value indicating the effective rights the current authenticated user has on the folder.
  /// </summary>
  enumerations.EffectiveRights? get EffectiveRights =>
      this.PropertyBag[FolderSchema.EffectiveRights]
          as enumerations.EffectiveRights?;

  /// <summary>
  /// Gets a list of permissions for the folder.
  /// </summary>
  FolderPermissionCollection get Permissions =>
      this.PropertyBag[FolderSchema.Permissions] as FolderPermissionCollection;

  /// <summary>
  /// Gets the number of unread items in the folder.
  /// </summary>
  int? get UnreadCount => this.PropertyBag[FolderSchema.UnreadCount] as int?;

  /// <summary>
  /// Gets or sets the policy tag.
  /// </summary>
// PolicyTag PolicyTag
//        {
//            get { return (PolicyTag)this.PropertyBag[FolderSchema.PolicyTag]; }
//            set { this.PropertyBag[FolderSchema.PolicyTag] = value; }
//        }

  /// <summary>
  /// Gets or sets the archive tag.
  /// </summary>
// ArchiveTag get ArchiveTag = (ArchiveTag)this.PropertyBag[FolderSchema.ArchiveTag];
//
//            set ArchiveTag (ArchiveTag value) { this.PropertyBag[FolderSchema.ArchiveTag] = value; }
//        }

  /// <summary>
  /// Gets the well known name of this folder, if any, as a string.
  /// </summary>
  /// <value>The well known name of this folder as a string, or null if this folder isn't a well known folder.</value>
  String? get WellKnownFolderNameAsString =>
      this.PropertyBag[FolderSchema.WellKnownFolderName] as String?;

  /// <summary>
  /// Gets the well known name of this folder, if any.
  /// </summary>
  /// <value>The well known name of this folder, or null if this folder isn't a well known folder.</value>
  enumerations.WellKnownFolderName? get WellKnownFolderName {
    OutParam<enumerations.WellKnownFolderName> resultOutParam = OutParam();

    if (EwsUtilities.TryParse<enumerations.WellKnownFolderName>(
        this.WellKnownFolderNameAsString, resultOutParam)) {
      return resultOutParam.param;
    } else {
      return null;
    }
  }
}
