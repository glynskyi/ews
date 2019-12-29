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

import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// XML attribute names.
/// </summary>
class XmlAttributeNames {
  static const XmlNs = "xmlns";
  static const Id = "Id";
  static const ChangeKey = "ChangeKey";
  static const RecurringMasterId = "RecurringMasterId";
  static const InstanceIndex = "InstanceIndex";
  static const OccurrenceId = "OccurrenceId";
  static const Traversal = "Traversal";
  static const ViewFilter = "ViewFilter";
  static const Offset = "Offset";
  static const MaxEntriesReturned = "MaxEntriesReturned";
  static const BasePoint = "BasePoint";
  static const ResponseClass = "ResponseClass";
  static const IndexedPagingOffset = "IndexedPagingOffset";
  static const TotalItemsInView = "TotalItemsInView";
  static const IncludesLastItemInRange = "IncludesLastItemInRange";
  static const BodyType = "BodyType";
  static const MessageDisposition = "MessageDisposition";
  static const SaveItemToFolder = "SaveItemToFolder";
  static const RootItemChangeKey = "RootItemChangeKey";
  static const DeleteType = "DeleteType";
  static const DeleteSubFolders = "DeleteSubFolders";
  static const AffectedTaskOccurrences = "AffectedTaskOccurrences";
  static const SendMeetingCancellations = "SendMeetingCancellations";
  static const SuppressReadReceipts = XmlElementNames.SuppressReadReceipts;
  static const FieldURI = "FieldURI";
  static const FieldIndex = "FieldIndex";
  static const ConflictResolution = "ConflictResolution";
  static const SendMeetingInvitationsOrCancellations =
      "SendMeetingInvitationsOrCancellations";
  static const CharacterSet = "CharacterSet";
  static const HeaderName = "HeaderName";
  static const SendMeetingInvitations = "SendMeetingInvitations";
  static const Key = "Key";
  static const RoutingType = "RoutingType";
  static const MailboxType = "MailboxType";
  static const DistinguishedPropertySetId = "DistinguishedPropertySetId";
  static const PropertySetId = "PropertySetId";
  static const PropertyTag = "PropertyTag";
  static const PropertyName = "PropertyName";
  static const PropertyId = "PropertyId";
  static const PropertyType = "PropertyType";
  static const TimeZoneName = "TimeZoneName";
  static const ReturnFullContactData = "ReturnFullContactData";
  static const ContactDataShape = "ContactDataShape";
  static const Numerator = "Numerator";
  static const Denominator = "Numerator";
  static const Value = "Value";
  static const ContainmentMode = "ContainmentMode";
  static const ContainmentComparison = "ContainmentComparison";
  static const Order = "Order";
  static const StartDate = "StartDate";
  static const EndDate = "EndDate";
  static const Version = "Version";
  static const Aggregate = "Aggregate";
  static const SearchScope = "SearchScope";
  static const Format = "Format";
  static const Mailbox = "Mailbox";
  static const DestinationFormat = "DestinationFormat";
  static const FolderId = "FolderId";
  static const ItemId = "ItemId";
  static const IncludePermissions = "IncludePermissions";
  static const InitialName = "InitialName";
  static const FinalName = "FinalName";
  static const AuthenticationMethod = "AuthenticationMethod";
  static const Time = "Time";
  static const Name = "Name";
  static const Bias = "Bias";
  static const Kind = "Kind";
  static const SubscribeToAllFolders = "SubscribeToAllFolders";
  static const PublicFolderServer = "PublicFolderServer";
  static const IsArchive = "IsArchive";
  static const ReturnHighlightTerms = "ReturnHighlightTerms";
  static const IsExplicit = "IsExplicit";
  static const ClientExtensionUserIdentity = "UserId";
  static const ClientExtensionEnabledOnly = "EnabledOnly";
  static const SetClientExtensionActionId = "ActionId";
  static const ClientExtensionId = "ExtensionId";
  static const ClientExtensionIsAvailable = "IsAvailable";
  static const ClientExtensionIsMandatory = "IsMandatory";
  static const ClientExtensionIsEnabledByDefault = "IsEnabledByDefault";
  static const ClientExtensionProvidedTo = "ProvidedTo";
  static const ClientExtensionType = "Type";
  static const ClientExtensionScope = "Scope";
  static const ClientExtensionMarketplaceAssetID = "MarketplaceAssetId";
  static const ClientExtensionMarketplaceContentMarket =
      "MarketplaceContentMarket";
  static const ClientExtensionAppStatus = "AppStatus";
  static const ClientExtensionEtoken = "Etoken";
  static const ClientExtensionInstalledDateTime = "InstalledDateTime";
  static const IsTruncated = "IsTruncated";
  static const IsJunk = "IsJunk";
  static const MoveItem = "MoveItem";

  // xsi attributes
  static const Nil = "nil";
  static const Type = "type";
}
