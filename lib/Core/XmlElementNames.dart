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

/// <summary>
/// XML element names.
/// </summary>
class XmlElementNames {
  static const AllProperties = "AllProperties";
  static const ParentFolderIds = "ParentFolderIds";
  static const DistinguishedFolderId = "DistinguishedFolderId";
  static const ItemId = "ItemId";
  static const ItemIds = "ItemIds";
  static const FolderId = "FolderId";
  static const FolderIds = "FolderIds";
  static const SourceId = "SourceId";
  static const OccurrenceItemId = "OccurrenceItemId";
  static const RecurringMasterItemId = "RecurringMasterItemId";
  static const ItemShape = "ItemShape";
  static const FolderShape = "FolderShape";
  static const BaseShape = "BaseShape";
  static const IndexedPageItemView = "IndexedPageItemView";
  static const IndexedPageFolderView = "IndexedPageFolderView";
  static const FractionalPageItemView = "FractionalPageItemView";
  static const FractionalPageFolderView = "FractionalPageFolderView";
  static const SeekToConditionPageItemView = "SeekToConditionPageItemView";
  static const ResponseCode = "ResponseCode";
  static const RootFolder = "RootFolder";
  static const Folder = "Folder";
  static const ContactsFolder = "ContactsFolder";
  static const TasksFolder = "TasksFolder";
  static const SearchFolder = "SearchFolder";
  static const Folders = "Folders";
  static const Item = "Item";
  static const Items = "Items";
  static const Message = "Message";
  static const Mailbox = "Mailbox";
  static const Body = "Body";
  static const From = "From";
  static const Sender = "Sender";
  static const Name = "Name";
  static const Address = "Address";
  static const EmailAddress = "EmailAddress";
  static const RoutingType = "RoutingType";
  static const MailboxType = "MailboxType";
  static const ToRecipients = "ToRecipients";
  static const CcRecipients = "CcRecipients";
  static const BccRecipients = "BccRecipients";
  static const ReplyTo = "ReplyTo";
  static const ConversationTopic = "ConversationTopic";
  static const ConversationIndex = "ConversationIndex";
  static const IsDeliveryReceiptRequested = "IsDeliveryReceiptRequested";
  static const IsRead = "IsRead";
  static const IsReadReceiptRequested = "IsReadReceiptRequested";
  static const IsResponseRequested = "IsResponseRequested";
  static const InternetMessageId = "InternetMessageId";
  static const References = "References";
  static const ParentItemId = "ParentItemId";
  static const ParentFolderId = "ParentFolderId";
  static const ChildFolderCount = "ChildFolderCount";
  static const DisplayName = "DisplayName";
  static const TotalCount = "TotalCount";
  static const ItemClass = "ItemClass";
  static const FolderClass = "FolderClass";
  static const Subject = "Subject";
  static const MimeContent = "MimeContent";
  static const MimeContentUTF8 = "MimeContentUTF8";
  static const Sensitivity = "Sensitivity";
  static const Attachments = "Attachments";
  static const DateTimeReceived = "DateTimeReceived";
  static const Size = "Size";
  static const Categories = "Categories";
  static const Importance = "Importance";
  static const InReplyTo = "InReplyTo";
  static const IsSubmitted = "IsSubmitted";
  static const IsAssociated = "IsAssociated";
  static const IsDraft = "IsDraft";
  static const IsFromMe = "IsFromMe";
  static const IsHidden = "IsHidden";
  static const IsQuickContact = "IsQuickContact";
  static const IsResend = "IsResend";
  static const IsUnmodified = "IsUnmodified";
  static const IsWritable = "IsWritable";
  static const InternetMessageHeader = "InternetMessageHeader";
  static const InternetMessageHeaders = "InternetMessageHeaders";
  static const DateTimeSent = "DateTimeSent";
  static const DateTimeCreated = "DateTimeCreated";
  static const ResponseObjects = "ResponseObjects";
  static const ReminderDueBy = "ReminderDueBy";
  static const ReminderIsSet = "ReminderIsSet";
  static const ReminderMinutesBeforeStart = "ReminderMinutesBeforeStart";
  static const DisplayCc = "DisplayCc";
  static const DisplayTo = "DisplayTo";
  static const HasAttachments = "HasAttachments";
  static const ExtendedProperty = "ExtendedProperty";
  static const Culture = "Culture";
  static const FileAttachment = "FileAttachment";
  static const ItemAttachment = "ItemAttachment";
  static const ReferenceAttachment = "ReferenceAttachment";
  static const AttachLongPathName = "AttachLongPathName";
  static const ProviderType = "ProviderType";
  static const ProviderEndpointUrl = "ProviderEndpointUrl";
  static const AttachmentThumbnailUrl = "AttachmentThumbnailUrl";
  static const AttachmentPreviewUrl = "AttachmentPreviewUrl";
  static const PermissionType = "PermissionType";
  static const AttachmentIsFolder = "AttachmentIsFolder";
  static const AttachmentIds = "AttachmentIds";
  static const AttachmentId = "AttachmentId";
  static const ContentType = "ContentType";
  static const ContentLocation = "ContentLocation";
  static const ContentId = "ContentId";
  static const Content = "Content";
  static const SavedItemFolderId = "SavedItemFolderId";
  static const MessageText = "MessageText";
  static const DescriptiveLinkKey = "DescriptiveLinkKey";
  static const ItemChange = "ItemChange";
  static const ItemChanges = "ItemChanges";
  static const FolderChange = "FolderChange";
  static const FolderChanges = "FolderChanges";
  static const Updates = "Updates";
  static const AppendToItemField = "AppendToItemField";
  static const SetItemField = "SetItemField";
  static const DeleteItemField = "DeleteItemField";
  static const SetFolderField = "SetFolderField";
  static const DeleteFolderField = "DeleteFolderField";
  static const FieldURI = "FieldURI";
  static const RootItemId = "RootItemId";
  static const ReferenceItemId = "ReferenceItemId";
  static const NewBodyContent = "NewBodyContent";
  static const ReplyToItem = "ReplyToItem";
  static const ReplyAllToItem = "ReplyAllToItem";
  static const ForwardItem = "ForwardItem";
  static const AcceptItem = "AcceptItem";
  static const TentativelyAcceptItem = "TentativelyAcceptItem";
  static const DeclineItem = "DeclineItem";
  static const CancelCalendarItem = "CancelCalendarItem";
  static const RemoveItem = "RemoveItem";
  static const SuppressReadReceipt = "SuppressReadReceipt";
  static const SuppressReadReceipts = "SuppressReadReceipts";
  static const String = "String";
  static const Start = "Start";
  static const End = "End";
  static const ProposedStart = "ProposedStart";
  static const ProposedEnd = "ProposedEnd";
  static const OriginalStart = "OriginalStart";
  static const IsAllDayEvent = "IsAllDayEvent";
  static const LegacyFreeBusyStatus = "LegacyFreeBusyStatus";
  static const Location = "Location";
  static const When = "When";
  static const IsMeeting = "IsMeeting";
  static const IsCancelled = "IsCancelled";
  static const IsRecurring = "IsRecurring";
  static const MeetingRequestWasSent = "MeetingRequestWasSent";
  static const CalendarItemType = "CalendarItemType";
  static const MyResponseType = "MyResponseType";
  static const Organizer = "Organizer";
  static const RequiredAttendees = "RequiredAttendees";
  static const OptionalAttendees = "OptionalAttendees";
  static const Resources = "Resources";
  static const ConflictingMeetingCount = "ConflictingMeetingCount";
  static const AdjacentMeetingCount = "AdjacentMeetingCount";
  static const ConflictingMeetings = "ConflictingMeetings";
  static const AdjacentMeetings = "AdjacentMeetings";
  static const Duration = "Duration";
  static const TimeZone = "TimeZone";
  static const AppointmentReplyTime = "AppointmentReplyTime";
  static const AppointmentSequenceNumber = "AppointmentSequenceNumber";
  static const AppointmentState = "AppointmentState";
  static const Recurrence = "Recurrence";
  static const FirstOccurrence = "FirstOccurrence";
  static const LastOccurrence = "LastOccurrence";
  static const ModifiedOccurrences = "ModifiedOccurrences";
  static const DeletedOccurrences = "DeletedOccurrences";
  static const MeetingTimeZone = "MeetingTimeZone";
  static const ConferenceType = "ConferenceType";
  static const AllowNewTimeProposal = "AllowNewTimeProposal";
  static const IsOnlineMeeting = "IsOnlineMeeting";
  static const MeetingWorkspaceUrl = "MeetingWorkspaceUrl";
  static const NetShowUrl = "NetShowUrl";
  static const JoinOnlineMeetingUrl = "JoinOnlineMeetingUrl";
  static const OnlineMeetingSettings = "OnlineMeetingSettings";
  static const LobbyBypass = "LobbyBypass";
  static const AccessLevel = "AccessLevel";
  static const Presenters = "Presenters";
  static const CalendarItem = "CalendarItem";
  static const CalendarFolder = "CalendarFolder";
  static const Attendee = "Attendee";
  static const ResponseType = "ResponseType";
  static const LastResponseTime = "LastResponseTime";
  static const Occurrence = "Occurrence";
  static const DeletedOccurrence = "DeletedOccurrence";
  static const RelativeYearlyRecurrence = "RelativeYearlyRecurrence";
  static const AbsoluteYearlyRecurrence = "AbsoluteYearlyRecurrence";
  static const RelativeMonthlyRecurrence = "RelativeMonthlyRecurrence";
  static const AbsoluteMonthlyRecurrence = "AbsoluteMonthlyRecurrence";
  static const WeeklyRecurrence = "WeeklyRecurrence";
  static const DailyRecurrence = "DailyRecurrence";
  static const DailyRegeneration = "DailyRegeneration";
  static const WeeklyRegeneration = "WeeklyRegeneration";
  static const MonthlyRegeneration = "MonthlyRegeneration";
  static const YearlyRegeneration = "YearlyRegeneration";
  static const NoEndRecurrence = "NoEndRecurrence";
  static const EndDateRecurrence = "EndDateRecurrence";
  static const NumberedRecurrence = "NumberedRecurrence";
  static const Interval = "Interval";
  static const DayOfMonth = "DayOfMonth";
  static const DayOfWeek = "DayOfWeek";
  static const DaysOfWeek = "DaysOfWeek";
  static const DayOfWeekIndex = "DayOfWeekIndex";
  static const Month = "Month";
  static const StartDate = "StartDate";
  static const EndDate = "EndDate";
  static const StartTime = "StartTime";
  static const EndTime = "EndTime";
  static const NumberOfOccurrences = "NumberOfOccurrences";
  static const AssociatedCalendarItemId = "AssociatedCalendarItemId";
  static const IsDelegated = "IsDelegated";
  static const IsOutOfDate = "IsOutOfDate";
  static const HasBeenProcessed = "HasBeenProcessed";
  static const IsOrganizer = "IsOrganizer";
  static const MeetingMessage = "MeetingMessage";
  static const FileAs = "FileAs";
  static const FileAsMapping = "FileAsMapping";
  static const GivenName = "GivenName";
  static const Initials = "Initials";
  static const MiddleName = "MiddleName";
  static const NickName = "Nickname";
  static const CompleteName = "CompleteName";
  static const CompanyName = "CompanyName";
  static const EmailAddresses = "EmailAddresses";
  static const PhysicalAddresses = "PhysicalAddresses";
  static const PhoneNumbers = "PhoneNumbers";
  static const PhoneNumber = "PhoneNumber";
  static const AssistantName = "AssistantName";
  static const Birthday = "Birthday";
  static const BusinessHomePage = "BusinessHomePage";
  static const Children = "Children";
  static const Companies = "Companies";
  static const ContactSource = "ContactSource";
  static const Department = "Department";
  static const Generation = "Generation";
  static const ImAddresses = "ImAddresses";
  static const ImAddress = "ImAddress";
  static const JobTitle = "JobTitle";
  static const Manager = "Manager";
  static const Mileage = "Mileage";
  static const OfficeLocation = "OfficeLocation";
  static const PostalAddressIndex = "PostalAddressIndex";
  static const Profession = "Profession";
  static const SpouseName = "SpouseName";
  static const Surname = "Surname";
  static const WeddingAnniversary = "WeddingAnniversary";
  static const HasPicture = "HasPicture";
  static const Title = "Title";
  static const FirstName = "FirstName";
  static const LastName = "LastName";
  static const Suffix = "Suffix";
  static const FullName = "FullName";
  static const YomiFirstName = "YomiFirstName";
  static const YomiLastName = "YomiLastName";
  static const Contact = "Contact";
  static const Entry = "Entry";
  static const Street = "Street";
  static const City = "City";
  static const State = "State";
  static const SharePointSiteUrl = "SharePointSiteUrl";
  static const Country = "Country";
  static const CountryOrRegion = "CountryOrRegion";
  static const PostalCode = "PostalCode";
  static const PostOfficeBox = "PostOfficeBox";
  static const Members = "Members";
  static const Member = "Member";
  static const AdditionalProperties = "AdditionalProperties";
  static const ExtendedFieldURI = "ExtendedFieldURI";
  static const Value = "Value";
  static const Values = "Values";
  static const ToFolderId = "ToFolderId";
  static const ActualWork = "ActualWork";
  static const AssignedTime = "AssignedTime";
  static const BillingInformation = "BillingInformation";
  static const ChangeCount = "ChangeCount";
  static const CompleteDate = "CompleteDate";
  static const Contacts = "Contacts";
  static const DelegationState = "DelegationState";
  static const Delegator = "Delegator";
  static const DueDate = "DueDate";
  static const IsAssignmentEditable = "IsAssignmentEditable";
  static const IsComplete = "IsComplete";
  static const IsTeamTask = "IsTeamTask";
  static const Owner = "Owner";
  static const PercentComplete = "PercentComplete";
  static const Status = "Status";
  static const StatusDescription = "StatusDescription";
  static const TotalWork = "TotalWork";
  static const Task = "Task";
  static const MailboxCulture = "MailboxCulture";
  static const MeetingRequestType = "MeetingRequestType";
  static const IntendedFreeBusyStatus = "IntendedFreeBusyStatus";
  static const MeetingRequest = "MeetingRequest";
  static const MeetingResponse = "MeetingResponse";
  static const MeetingCancellation = "MeetingCancellation";
  static const ChangeHighlights = "ChangeHighlights";
  static const HasLocationChanged = "HasLocationChanged";
  static const HasStartTimeChanged = "HasStartTimeChanged";
  static const HasEndTimeChanged = "HasEndTimeChanged";
  static const BaseOffset = "BaseOffset";
  static const Offset = "Offset";
  static const Standard = "Standard";
  static const Daylight = "Daylight";
  static const Time = "Time";
  static const AbsoluteDate = "AbsoluteDate";
  static const UnresolvedEntry = "UnresolvedEntry";
  static const ResolutionSet = "ResolutionSet";
  static const Resolution = "Resolution";
  static const DistributionList = "DistributionList";
  static const DLExpansion = "DLExpansion";
  static const IndexedFieldURI = "IndexedFieldURI";
  static const PullSubscriptionRequest = "PullSubscriptionRequest";
  static const PushSubscriptionRequest = "PushSubscriptionRequest";
  static const StreamingSubscriptionRequest = "StreamingSubscriptionRequest";
  static const EventTypes = "EventTypes";
  static const EventType = "EventType";
  static const Timeout = "Timeout";
  static const Watermark = "Watermark";
  static const SubscriptionId = "SubscriptionId";
  static const SubscriptionIds = "SubscriptionIds";
  static const StatusFrequency = "StatusFrequency";
  static const URL = "URL";
  static const CallerData = "CallerData";
  static const Notification = "Notification";
  static const Notifications = "Notifications";
  static const PreviousWatermark = "PreviousWatermark";
  static const MoreEvents = "MoreEvents";
  static const TimeStamp = "TimeStamp";
  static const UnreadCount = "UnreadCount";
  static const OldParentFolderId = "OldParentFolderId";
  static const CopiedEvent = "CopiedEvent";
  static const CreatedEvent = "CreatedEvent";
  static const DeletedEvent = "DeletedEvent";
  static const ModifiedEvent = "ModifiedEvent";
  static const MovedEvent = "MovedEvent";
  static const NewMailEvent = "NewMailEvent";
  static const StatusEvent = "StatusEvent";
  static const FreeBusyChangedEvent = "FreeBusyChangedEvent";
  static const ExchangeImpersonation = "ExchangeImpersonation";
  static const ConnectingSID = "ConnectingSID";
  static const OpenAsAdminOrSystemService = "OpenAsAdminOrSystemService";
  static const LogonType = "LogonType";
  static const BudgetType = "BudgetType";
  static const ManagementRole = "ManagementRole";
  static const UserRoles = "UserRoles";
  static const ApplicationRoles = "ApplicationRoles";
  static const Role = "Role";
  static const SyncFolderId = "SyncFolderId";
  static const SyncScope = "SyncScope";
  static const SyncState = "SyncState";
  static const Ignore = "Ignore";
  static const MaxChangesReturned = "MaxChangesReturned";
  static const Changes = "Changes";
  static const IncludesLastItemInRange = "IncludesLastItemInRange";
  static const IncludesLastFolderInRange = "IncludesLastFolderInRange";
  static const Create = "Create";
  static const Update = "Update";
  static const Delete = "Delete";
  static const ReadFlagChange = "ReadFlagChange";
  static const SearchParameters = "SearchParameters";
  static const SoftDeleted = "SoftDeleted";
  static const Shallow = "Shallow";
  static const Associated = "Associated";
  static const BaseFolderId = "BaseFolderId";
  static const BaseFolderIds = "BaseFolderIds";
  static const SortOrder = "SortOrder";
  static const FieldOrder = "FieldOrder";
  static const CanDelete = "CanDelete";
  static const CanRenameOrMove = "CanRenameOrMove";
  static const MustDisplayComment = "MustDisplayComment";
  static const HasQuota = "HasQuota";
  static const IsManagedFoldersRoot = "IsManagedFoldersRoot";
  static const ManagedFolderId = "ManagedFolderId";
  static const Comment = "Comment";
  static const StorageQuota = "StorageQuota";
  static const FolderSize = "FolderSize";
  static const HomePage = "HomePage";
  static const ManagedFolderInformation = "ManagedFolderInformation";
  static const CalendarView = "CalendarView";
  static const PostedTime = "PostedTime";
  static const PostItem = "PostItem";
  static const RequestVersion = "RequestVersion";
  static const RequestServerVersion = "RequestServerVersion";
  static const PostReplyItem = "PostReplyItem";
  static const CreateAssociated = "CreateAssociated";
  static const CreateContents = "CreateContents";
  static const CreateHierarchy = "CreateHierarchy";
  static const Modify = "Modify";
  static const Read = "Read";
  static const EffectiveRights = "EffectiveRights";
  static const LastModifiedName = "LastModifiedName";
  static const LastModifiedTime = "LastModifiedTime";
  static const ConversationId = "ConversationId";
  static const UniqueBody = "UniqueBody";
  static const BodyType = "BodyType";
  static const NormalizedBodyType = "NormalizedBodyType";
  static const UniqueBodyType = "UniqueBodyType";
  static const AttachmentShape = "AttachmentShape";
  static const UserId = "UserId";
  static const UserIds = "UserIds";
  static const CanCreateItems = "CanCreateItems";
  static const CanCreateSubFolders = "CanCreateSubFolders";
  static const IsFolderOwner = "IsFolderOwner";
  static const IsFolderVisible = "IsFolderVisible";
  static const IsFolderContact = "IsFolderContact";
  static const EditItems = "EditItems";
  static const DeleteItems = "DeleteItems";
  static const ReadItems = "ReadItems";
  static const PermissionLevel = "PermissionLevel";
  static const CalendarPermissionLevel = "CalendarPermissionLevel";
  static const SID = "SID";
  static const PrimarySmtpAddress = "PrimarySmtpAddress";
  static const DistinguishedUser = "DistinguishedUser";
  static const PermissionSet = "PermissionSet";
  static const Permissions = "Permissions";
  static const Permission = "Permission";
  static const CalendarPermissions = "CalendarPermissions";
  static const CalendarPermission = "CalendarPermission";
  static const GroupBy = "GroupBy";
  static const AggregateOn = "AggregateOn";
  static const Groups = "Groups";
  static const GroupedItems = "GroupedItems";
  static const GroupIndex = "GroupIndex";
  static const ConflictResults = "ConflictResults";
  static const Count = "Count";
  static const OofSettings = "OofSettings";
  static const UserOofSettings = "UserOofSettings";
  static const OofState = "OofState";
  static const ExternalAudience = "ExternalAudience";
  static const AllowExternalOof = "AllowExternalOof";
  static const InternalReply = "InternalReply";
  static const ExternalReply = "ExternalReply";
  static const Bias = "Bias";
  static const DayOrder = "DayOrder";
  static const Year = "Year";
  static const StandardTime = "StandardTime";
  static const DaylightTime = "DaylightTime";
  static const MailboxData = "MailboxData";
  static const MailboxDataArray = "MailboxDataArray";
  static const Email = "Email";
  static const AttendeeType = "AttendeeType";
  static const ExcludeConflicts = "ExcludeConflicts";
  static const FreeBusyViewOptions = "FreeBusyViewOptions";
  static const SuggestionsViewOptions = "SuggestionsViewOptions";
  static const FreeBusyView = "FreeBusyView";
  static const TimeWindow = "TimeWindow";
  static const MergedFreeBusyIntervalInMinutes =
      "MergedFreeBusyIntervalInMinutes";
  static const RequestedView = "RequestedView";
  static const FreeBusyViewType = "FreeBusyViewType";
  static const CalendarEventArray = "CalendarEventArray";
  static const CalendarEvent = "CalendarEvent";
  static const BusyType = "BusyType";
  static const MergedFreeBusy = "MergedFreeBusy";
  static const WorkingHours = "WorkingHours";
  static const WorkingPeriodArray = "WorkingPeriodArray";
  static const WorkingPeriod = "WorkingPeriod";
  static const StartTimeInMinutes = "StartTimeInMinutes";
  static const EndTimeInMinutes = "EndTimeInMinutes";
  static const GoodThreshold = "GoodThreshold";
  static const MaximumResultsByDay = "MaximumResultsByDay";
  static const MaximumNonWorkHourResultsByDay =
      "MaximumNonWorkHourResultsByDay";
  static const MeetingDurationInMinutes = "MeetingDurationInMinutes";
  static const MinimumSuggestionQuality = "MinimumSuggestionQuality";
  static const DetailedSuggestionsWindow = "DetailedSuggestionsWindow";
  static const CurrentMeetingTime = "CurrentMeetingTime";
  static const GlobalObjectId = "GlobalObjectId";
  static const SuggestionDayResultArray = "SuggestionDayResultArray";
  static const SuggestionDayResult = "SuggestionDayResult";
  static const Date = "Date";
  static const DayQuality = "DayQuality";
  static const SuggestionArray = "SuggestionArray";
  static const Suggestion = "Suggestion";
  static const MeetingTime = "MeetingTime";
  static const IsWorkTime = "IsWorkTime";
  static const SuggestionQuality = "SuggestionQuality";
  static const AttendeeConflictDataArray = "AttendeeConflictDataArray";
  static const UnknownAttendeeConflictData = "UnknownAttendeeConflictData";
  static const TooBigGroupAttendeeConflictData =
      "TooBigGroupAttendeeConflictData";
  static const IndividualAttendeeConflictData =
      "IndividualAttendeeConflictData";
  static const GroupAttendeeConflictData = "GroupAttendeeConflictData";
  static const NumberOfMembers = "NumberOfMembers";
  static const NumberOfMembersAvailable = "NumberOfMembersAvailable";
  static const NumberOfMembersWithConflict = "NumberOfMembersWithConflict";
  static const NumberOfMembersWithNoData = "NumberOfMembersWithNoData";
  static const SourceIds = "SourceIds";
  static const AlternateId = "AlternateId";
  static const AlternatePublicFolderId = "AlternatePublicFolderId";
  static const AlternatePublicFolderItemId = "AlternatePublicFolderItemId";
  static const DelegatePermissions = "DelegatePermissions";
  static const ReceiveCopiesOfMeetingMessages =
      "ReceiveCopiesOfMeetingMessages";
  static const ViewPrivateItems = "ViewPrivateItems";
  static const CalendarFolderPermissionLevel = "CalendarFolderPermissionLevel";
  static const TasksFolderPermissionLevel = "TasksFolderPermissionLevel";
  static const InboxFolderPermissionLevel = "InboxFolderPermissionLevel";
  static const ContactsFolderPermissionLevel = "ContactsFolderPermissionLevel";
  static const NotesFolderPermissionLevel = "NotesFolderPermissionLevel";
  static const JournalFolderPermissionLevel = "JournalFolderPermissionLevel";
  static const DelegateUser = "DelegateUser";
  static const DelegateUsers = "DelegateUsers";
  static const DeliverMeetingRequests = "DeliverMeetingRequests";
  static const MessageXml = "MessageXml";
  static const UserConfiguration = "UserConfiguration";
  static const UserConfigurationName = "UserConfigurationName";
  static const UserConfigurationProperties = "UserConfigurationProperties";
  static const Dictionary = "Dictionary";
  static const DictionaryEntry = "DictionaryEntry";
  static const DictionaryKey = "DictionaryKey";
  static const DictionaryValue = "DictionaryValue";
  static const XmlData = "XmlData";
  static const BinaryData = "BinaryData";
  static const FilterHtmlContent = "FilterHtmlContent";
  static const ConvertHtmlCodePageToUTF8 = "ConvertHtmlCodePageToUTF8";
  static const UnknownEntries = "UnknownEntries";
  static const UnknownEntry = "UnknownEntry";
  static const PasswordExpirationDate = "PasswordExpirationDate";
  static const Flag = "Flag";
  static const PersonaPostalAddress = "PostalAddress";
  static const PostalAddressType = "Type";
  static const EnhancedLocation = "EnhancedLocation";
  static const LocationDisplayName = "DisplayName";
  static const LocationAnnotation = "Annotation";
  static const LocationSource = "LocationSource";
  static const LocationUri = "LocationUri";
  static const Latitude = "Latitude";
  static const Longitude = "Longitude";
  static const Accuracy = "Accuracy";
  static const Altitude = "Altitude";
  static const AltitudeAccuracy = "AltitudeAccuracy";
  static const FormattedAddress = "FormattedAddress";
  static const Guid = "Guid";
  static const PhoneCallId = "PhoneCallId";
  static const DialString = "DialString";
  static const PhoneCallInformation = "PhoneCallInformation";
  static const PhoneCallState = "PhoneCallState";
  static const ConnectionFailureCause = "ConnectionFailureCause";
  static const SIPResponseCode = "SIPResponseCode";
  static const SIPResponseText = "SIPResponseText";
  static const WebClientReadFormQueryString = "WebClientReadFormQueryString";
  static const WebClientEditFormQueryString = "WebClientEditFormQueryString";
  static const Ids = "Ids";
  static const Id = "Id";
  static const TimeZoneDefinitions = "TimeZoneDefinitions";
  static const TimeZoneDefinition = "TimeZoneDefinition";
  static const Periods = "Periods";
  static const Period = "Period";
  static const TransitionsGroups = "TransitionsGroups";
  static const TransitionsGroup = "TransitionsGroup";
  static const Transitions = "Transitions";
  static const Transition = "Transition";
  static const AbsoluteDateTransition = "AbsoluteDateTransition";
  static const RecurringDayTransition = "RecurringDayTransition";
  static const RecurringDateTransition = "RecurringDateTransition";
  static const DateTime = "DateTime";
  static const TimeOffset = "TimeOffset";
  static const Day = "Day";
  static const TimeZoneContext = "TimeZoneContext";
  static const StartTimeZone = "StartTimeZone";
  static const EndTimeZone = "EndTimeZone";
  static const ReceivedBy = "ReceivedBy";
  static const ReceivedRepresenting = "ReceivedRepresenting";
  static const Uid = "UID";
  static const RecurrenceId = "RecurrenceId";
  static const DateTimeStamp = "DateTimeStamp";
  static const IsInline = "IsInline";
  static const IsContactPhoto = "IsContactPhoto";
  static const QueryString = "QueryString";
  static const HighlightTerms = "HighlightTerms";
  static const HighlightTerm = "Term";
  static const HighlightTermScope = "Scope";
  static const HighlightTermValue = "Value";
  static const CalendarEventDetails = "CalendarEventDetails";
  static const ID = "ID";
  static const IsException = "IsException";
  static const IsReminderSet = "IsReminderSet";
  static const Is /* private */ = "Is/* private */";
  static const FirstDayOfWeek = "FirstDayOfWeek";
  static const Verb = "Verb";
  static const Parameter = "Parameter";
  static const ReturnValue = "ReturnValue";
  static const ReturnNewItemIds = "ReturnNewItemIds";
  static const DateTimePrecision = "DateTimePrecision";
  static const ConvertInlineImagesToDataUrls = "ConvertInlineImagesToDataUrls";
  static const InlineImageUrlTemplate = "InlineImageUrlTemplate";
  static const BlockExternalImages = "BlockExternalImages";
  static const AddBlankTargetToLinks = "AddBlankTargetToLinks";
  static const MaximumBodySize = "MaximumBodySize";
  static const StoreEntryId = "StoreEntryId";
  static const InstanceKey = "InstanceKey";
  static const NormalizedBody = "NormalizedBody";
  static const PolicyTag = "PolicyTag";
  static const ArchiveTag = "ArchiveTag";
  static const RetentionDate = "RetentionDate";
  static const DisableReason = "DisableReason";
  static const AppMarketplaceUrl = "AppMarketplaceUrl";
  static const TextBody = "TextBody";
  static const IconIndex = "IconIndex";
  static const GlobalIconIndex = "GlobalIconIndex";
  static const DraftItemIds = "DraftItemIds";
  static const HasIrm = "HasIrm";
  static const GlobalHasIrm = "GlobalHasIrm";
  static const ApprovalRequestData = "ApprovalRequestData";
  static const IsUndecidedApprovalRequest = "IsUndecidedApprovalRequest";
  static const ApprovalDecision = "ApprovalDecision";
  static const ApprovalDecisionMaker = "ApprovalDecisionMaker";
  static const ApprovalDecisionTime = "ApprovalDecisionTime";
  static const VotingOptionData = "VotingOptionData";
  static const VotingOptionDisplayName = "DisplayName";
  static const SendPrompt = "SendPrompt";
  static const VotingInformation = "VotingInformation";
  static const UserOptions = "UserOptions";
  static const VotingResponse = "VotingResponse";
  static const NumberOfDays = "NumberOfDays";
  static const AcceptanceState = "AcceptanceState";

  static const NlgEntityExtractionResult = "EntityExtractionResult";
  static const NlgAddresses = "Addresses";
  static const NlgAddress = "Address";
  static const NlgMeetingSuggestions = "MeetingSuggestions";
  static const NlgMeetingSuggestion = "MeetingSuggestion";
  static const NlgTaskSuggestions = "TaskSuggestions";
  static const NlgTaskSuggestion = "TaskSuggestion";
  static const NlgBusinessName = "BusinessName";
  static const NlgPeopleName = "PeopleName";
  static const NlgEmailAddresses = "EmailAddresses";
  static const NlgEmailAddress = "EmailAddress";
  static const NlgEmailPosition = "Position";
  static const NlgContacts = "Contacts";
  static const NlgContact = "Contact";
  static const NlgContactString = "ContactString";
  static const NlgUrls = "Urls";
  static const NlgUrl = "Url";
  static const NlgPhoneNumbers = "PhoneNumbers";
  static const NlgPhone = "Phone";
  static const NlgAttendees = "Attendees";
  static const NlgEmailUser = "EmailUser";
  static const NlgLocation = "Location";
  static const NlgSubject = "Subject";
  static const NlgMeetingString = "MeetingString";
  static const NlgStartTime = "StartTime";
  static const NlgEndTime = "EndTime";
  static const NlgTaskString = "TaskString";
  static const NlgAssignees = "Assignees";
  static const NlgPersonName = "PersonName";
  static const NlgOriginalPhoneString = "OriginalPhoneString";
  static const NlgPhoneString = "PhoneString";
  static const NlgType = "Type";
  static const NlgName = "Name";
  static const NlgUserId = "UserId";

  static const GetClientAccessToken = "GetClientAccessToken";
  static const GetClientAccessTokenResponse = "GetClientAccessTokenResponse";
  static const GetClientAccessTokenResponseMessage =
      "GetClientAccessTokenResponseMessage";
  static const TokenRequests = "TokenRequests";
  static const TokenRequest = "TokenRequest";
  static const TokenType = "TokenType";
  static const TokenValue = "TokenValue";
  static const TTL = "TTL";
  static const Tokens = "Tokens";

  static const MarkAsJunk = "MarkAsJunk";
  static const MarkAsJunkResponse = "MarkAsJunkResponse";
  static const MarkAsJunkResponseMessage = "MarkAsJunkResponseMessage";
  static const MovedItemId = "MovedItemId";

  static const CreationTime = "CreationTime";
  static const People = "People";
  static const Persona = "Persona";
  static const PersonaId = "PersonaId";
  static const PersonaShape = "PersonaShape";
  static const RelevanceScore = "RelevanceScore";
  static const TotalNumberOfPeopleInView = "TotalNumberOfPeopleInView";
  static const FirstMatchingRowIndex = "FirstMatchingRowIndex";
  static const FirstLoadedRowIndex = "FirstLoadedRowIndex";
  static const YomiCompanyName = "YomiCompanyName";
  static const Emails1 = "Emails1";
  static const Emails2 = "Emails2";
  static const Emails3 = "Emails3";
  static const HomeAddresses = "HomeAddresses";
  static const BusinessAddresses = "BusinessAddresses";
  static const OtherAddresses = "OtherAddresses";
  static const BusinessPhoneNumbers = "BusinessPhoneNumbers";
  static const BusinessPhoneNumbers2 = "BusinessPhoneNumbers2";
  static const AssistantPhoneNumbers = "AssistantPhoneNumbers";
  static const TTYTDDPhoneNumbers = "TTYTDDPhoneNumbers";
  static const HomePhones = "HomePhones";
  static const HomePhones2 = "HomePhones2";
  static const MobilePhones = "MobilePhones";
  static const MobilePhones2 = "MobilePhones2";
  static const CallbackPhones = "CallbackPhones";
  static const CarPhones = "CarPhones";
  static const HomeFaxes = "HomeFaxes";
  static const OrganizationMainPhones = "OrganizationMainPhones";
  static const OtherFaxes = "OtherFaxes";
  static const OtherTelephones = "OtherTelephones";
  static const OtherPhones2 = "OtherPhones2";
  static const Pagers = "Pagers";
  static const RadioPhones = "RadioPhones";
  static const TelexNumbers = "TelexNumbers";
  static const WorkFaxes = "WorkFaxes";
  static const FileAses = "FileAses";
  static const CompanyNames = "CompanyNames";
  static const DisplayNames = "DisplayNames";
  static const DisplayNamePrefixes = "DisplayNamePrefixes";
  static const GivenNames = "GivenNames";
  static const MiddleNames = "MiddleNames";
  static const Surnames = "Surnames";
  static const Generations = "Generations";
  static const Nicknames = "Nicknames";
  static const YomiCompanyNames = "YomiCompanyNames";
  static const YomiFirstNames = "YomiFirstNames";
  static const YomiLastNames = "YomiLastNames";
  static const Managers = "Managers";
  static const AssistantNames = "AssistantNames";
  static const Professions = "Professions";
  static const SpouseNames = "SpouseNames";
  static const Departments = "Departments";
  static const Titles = "Titles";
  static const ImAddresses2 = "ImAddresses2";
  static const ImAddresses3 = "ImAddresses3";
  static const DisplayNamePrefix = "DisplayNamePrefix";
  static const DisplayNameFirstLast = "DisplayNameFirstLast";
  static const DisplayNameLastFirst = "DisplayNameLastFirst";
  static const DisplayNameFirstLastHeader = "DisplayNameFirstLastHeader";
  static const DisplayNameLastFirstHeader = "DisplayNameLastFirstHeader";
  static const IsFavorite = "IsFavorite";
  static const Schools = "Schools";
  static const Hobbies = "Hobbies";
  static const Locations = "Locations";
  static const OfficeLocations = "OfficeLocations";
  static const BusinessHomePages = "BusinessHomePages";
  static const PersonalHomePages = "PersonalHomePages";
  static const ThirdPartyPhotoUrls = "ThirdPartyPhotoUrls";
  static const Attribution = "Attribution";
  static const Attributions = "Attributions";
  static const StringAttributedValue = "StringAttributedValue";
  static const DisplayNameFirstLastSortKey = "DisplayNameFirstLastSortKey";
  static const DisplayNameLastFirstSortKey = "DisplayNameLastFirstSortKey";
  static const CompanyNameSortKey = "CompanyNameSortKey";
  static const HomeCitySortKey = "HomeCitySortKey";
  static const WorkCitySortKey = "WorkCitySortKey";
  static const FileAsId = "FileAsId";
  static const FileAsIds = "FileAsIds";
  static const HomeCity = "HomeCity";
  static const WorkCity = "WorkCity";
  static const PersonaType = "PersonaType";
  static const Birthdays = "Birthdays";
  static const BirthdaysLocal = "BirthdaysLocal";
  static const WeddingAnniversaries = "WeddingAnniversaries";
  static const WeddingAnniversariesLocal = "WeddingAnniversariesLocal";
  static const OriginalDisplayName = "OriginalDisplayName";

  static const Person = "Person";
  static const Insights = "Insights";
  static const Insight = "Insight";
  static const InsightType = "InsightType";
  static const InsightSourceType = "InsightSourceType";
  static const InsightValue = "InsightValue";
  static const InsightSource = "InsightSource";
  static const UpdatedUtcTicks = "UpdatedUtcTicks";
  static const StringInsightValue = "StringInsightValue";
  static const ProfileInsightValue = "ProfileInsightValue";
  static const JobInsightValue = "JobInsightValue";
  static const OutOfOfficeInsightValue = "OutOfOfficeInsightValue";
  static const UserProfilePicture = "UserProfilePicture";
  static const EducationInsightValue = "EducationInsightValue";
  static const SkillInsightValue = "SkillInsightValue";
  static const MeetingInsightValue = "MeetingInsightValue";
  static const Attendees = "Attendees";
  static const EmailInsightValue = "EmailInsightValue";
  static const ThreadId = "ThreadId";
  static const LastEmailDateUtcTicks = "LastEmailDateUtcTicks";
  static const LastEmailSender = "LastEmailSender";
  static const EmailsCount = "EmailsCount";
  static const DelveDocument = "DelveDocument";
  static const CompanyInsightValue = "CompanyInsightValue";
  static const ArrayOfInsightValue = "ArrayOfInsightValue";
  static const InsightContent = "InsightContent";
  static const SingleValueInsightContent = "SingleValueInsightContent";
  static const MultiValueInsightContent = "MultiValueInsightContent";
  static const ArrayOfInsight = "ArrayOfInsight";
  static const PersonType = "PersonType";
  static const SatoriId = "SatoriId";
  static const DescriptionAttribution = "DescriptionAttribution";
  static const ImageUrl = "ImageUrl";
  static const ImageUrlAttribution = "ImageUrlAttribution";
  static const YearFound = "YearFound";
  static const FinanceSymbol = "FinanceSymbol";
  static const WebsiteUrl = "WebsiteUrl";
  static const Rank = "Rank";
  static const Author = "Author";
  static const Created = "Created";
  static const DefaultEncodingURL = "DefaultEncodingURL";
  static const FileType = "FileType";
  static const Data = "Data";
  static const ItemList = "ItemList";
  static const Avatar = "Avatar";
  static const JoinedUtcTicks = "JoinedUtcTicks";
  static const Company = "Company";
  static const StartUtcTicks = "StartUtcTicks";
  static const EndUtcTicks = "EndUtcTicks";
  static const Blob = "Blob";
  static const PhotoSize = "PhotoSize";
  static const Institute = "Institute";
  static const Degree = "Degree";
  static const Strength = "Strength";
  static const ComputedInsightValueProperty = "ComputedInsightValueProperty";
  static const ComputedInsightValue = "ComputedInsightValue";
  static const Properties = "Properties";
  static const Property = "Property";
  static const Key = "Key";
  static const SMSNumber = "SMSNumber";
  static const FacebookProfileLink = "FacebookProfileLink";
  static const LinkedInProfileLink = "LinkedInProfileLink";
  static const ProfessionalBiography = "ProfessionalBiography";
  static const TeamSize = "TeamSize";
  static const Hometown = "Hometown";
  static const CurrentLocation = "CurrentLocation";
  static const Office = "Office";
  static const Headline = "Headline";
  static const ManagementChain = "ManagementChain";
  static const Peers = "Peers";
  static const MutualConnections = "MutualConnections";
  static const MutualManager = "MutualManager";
  static const Skills = "Skills";
  static const JobInsight = "JobInsight";
  static const CurrentJob = "CurrentJob";
  static const CompanyProfile = "CompanyProfile";
  static const CompanyInsight = "CompanyInsight";
  static const Text = "Text";
  static const ImageType = "ImageType";
  static const DocumentId = "DocumentId";
  static const PreviewURL = "PreviewURL";
  static const LastEditor = "LastEditor";
  static const ProfilePicture = "ProfilePicture";

  static const Conversations = "Conversations";
  static const Conversation = "Conversation";
  static const UniqueRecipients = "UniqueRecipients";
  static const GlobalUniqueRecipients = "GlobalUniqueRecipients";
  static const UniqueUnreadSenders = "UniqueUnreadSenders";
  static const GlobalUniqueUnreadSenders = "GlobalUniqueUnreadSenders";
  static const UniqueSenders = "UniqueSenders";
  static const GlobalUniqueSenders = "GlobalUniqueSenders";
  static const LastDeliveryTime = "LastDeliveryTime";
  static const GlobalLastDeliveryTime = "GlobalLastDeliveryTime";
  static const GlobalCategories = "GlobalCategories";
  static const FlagStatus = "FlagStatus";
  static const GlobalFlagStatus = "GlobalFlagStatus";
  static const GlobalHasAttachments = "GlobalHasAttachments";
  static const MessageCount = "MessageCount";
  static const GlobalMessageCount = "GlobalMessageCount";
  static const GlobalUnreadCount = "GlobalUnreadCount";
  static const GlobalSize = "GlobalSize";
  static const ItemClasses = "ItemClasses";
  static const GlobalItemClasses = "GlobalItemClasses";
  static const GlobalImportance = "GlobalImportance";
  static const GlobalInferredImportance = "GlobalInferredImportance";
  static const GlobalItemIds = "GlobalItemIds";
  static const ChangeType = "ChangeType";
  static const ReadFlag = "ReadFlag";
  static const TotalConversationsInView = "TotalConversationsInView";
  static const IndexedOffset = "IndexedOffset";
  static const ConversationShape = "ConversationShape";
  static const MailboxScope = "MailboxScope";

  // ApplyConversationAction
  static const ApplyConversationAction = "ApplyConversationAction";
  static const ConversationActions = "ConversationActions";
  static const ConversationAction = "ConversationAction";
  static const ApplyConversationActionResponse =
      "ApplyConversationActionResponse";
  static const ApplyConversationActionResponseMessage =
      "ApplyConversationActionResponseMessage";
  static const EnableAlwaysDelete = "EnableAlwaysDelete";
  static const ProcessRightAway = "ProcessRightAway";
  static const DestinationFolderId = "DestinationFolderId";
  static const ContextFolderId = "ContextFolderId";
  static const ConversationLastSyncTime = "ConversationLastSyncTime";
  static const AlwaysCategorize = "AlwaysCategorize";
  static const AlwaysDelete = "AlwaysDelete";
  static const AlwaysMove = "AlwaysMove";
  static const Move = "Move";
  static const Copy = "Copy";
  static const SetReadState = "SetReadState";
  static const SetRetentionPolicy = "SetRetentionPolicy";
  static const DeleteType = "DeleteType";
  static const RetentionPolicyType = "RetentionPolicyType";
  static const RetentionPolicyTagId = "RetentionPolicyTagId";

  // GetConversationItems
  static const FoldersToIgnore = "FoldersToIgnore";
  static const ParentInternetMessageId = "ParentInternetMessageId";
  static const ConversationNode = "ConversationNode";
  static const ConversationNodes = "ConversationNodes";
  static const MaxItemsToReturn = "MaxItemsToReturn";

  static const SetTeamMailbox = "SetTeamMailbox";
  static const SetTeamMailboxResponse = "SetTeamMailboxResponse";
  static const UnpinTeamMailbox = "UnpinTeamMailbox";
  static const UnpinTeamMailboxResponse = "UnpinTeamMailboxResponse";

  static const RoomLists = "RoomLists";
  static const Rooms = "Rooms";
  static const Room = "Room";
  static const RoomList = "RoomList";
  static const RoomId = "Id";

  static const Autodiscover = "Autodiscover";
  static const BinarySecret = "BinarySecret";
  static const Response = "Response";
  static const User = "User";
  static const LegacyDN = "LegacyDN";
  static const DeploymentId = "DeploymentId";
  static const Account = "Account";
  static const AccountType = "AccountType";
  static const Action = "Action";
  static const To = "To";
  static const RedirectAddr = "RedirectAddr";
  static const RedirectUrl = "RedirectUrl";
  static const Protocol = "Protocol";
  static const Type = "Type";
  static const Server = "Server";
  static const OwnerSmtpAddress = "OwnerSmtpAddress";
  static const ServerDN = "ServerDN";
  static const ServerVersion = "ServerVersion";
  static const ServerVersionInfo = "ServerVersionInfo";
  static const AD = "AD";
  static const AuthPackage = "AuthPackage";
  static const MdbDN = "MdbDN";
  static const EWSUrl = "EwsUrl"; // Server side emits "Ews", not "EWS".
  static const EwsPartnerUrl = "EwsPartnerUrl";
  static const EmwsUrl = "EmwsUrl";
  static const ASUrl = "ASUrl";
  static const OOFUrl = "OOFUrl";
  static const UMUrl = "UMUrl";
  static const OABUrl = "OABUrl";
  static const Internal = "Internal";
  static const External = "External";
  static const OWAUrl = "OWAUrl";
  static const Error = "Error";
  static const ErrorCode = "ErrorCode";
  static const DebugData = "DebugData";
  static const Users = "Users";
  static const RequestedSettings = "RequestedSettings";
  static const Setting = "Setting";
  static const GetUserSettingsRequestMessage = "GetUserSettingsRequestMessage";
  static const RequestedServerVersion = "RequestedServerVersion";
  static const Request = "Request";
  static const RedirectTarget = "RedirectTarget";
  static const UserSettings = "UserSettings";
  static const UserSettingErrors = "UserSettingErrors";
  static const GetUserSettingsResponseMessage =
      "GetUserSettingsResponseMessage";
  static const ErrorMessage = "ErrorMessage";
  static const UserResponse = "UserResponse";
  static const UserResponses = "UserResponses";
  static const UserSettingError = "UserSettingError";
  static const Domain = "Domain";
  static const Domains = "Domains";
  static const DomainResponse = "DomainResponse";
  static const DomainResponses = "DomainResponses";
  static const DomainSetting = "DomainSetting";
  static const DomainSettings = "DomainSettings";
  static const DomainStringSetting = "DomainStringSetting";
  static const DomainSettingError = "DomainSettingError";
  static const DomainSettingErrors = "DomainSettingErrors";
  static const GetDomainSettingsRequestMessage =
      "GetDomainSettingsRequestMessage";
  static const GetDomainSettingsResponseMessage =
      "GetDomainSettingsResponseMessage";
  static const SettingName = "SettingName";
  static const UserSetting = "UserSetting";
  static const StringSetting = "StringSetting";
  static const WebClientUrlCollectionSetting = "WebClientUrlCollectionSetting";
  static const WebClientUrls = "WebClientUrls";
  static const WebClientUrl = "WebClientUrl";
  static const AuthenticationMethods = "AuthenticationMethods";
  static const Url = "Url";
  static const AlternateMailboxCollectionSetting =
      "AlternateMailboxCollectionSetting";
  static const AlternateMailboxes = "AlternateMailboxes";
  static const AlternateMailbox = "AlternateMailbox";
  static const ProtocolConnectionCollectionSetting =
      "ProtocolConnectionCollectionSetting";
  static const ProtocolConnections = "ProtocolConnections";
  static const ProtocolConnection = "ProtocolConnection";
  static const DocumentSharingLocationCollectionSetting =
      "DocumentSharingLocationCollectionSetting";
  static const DocumentSharingLocations = "DocumentSharingLocations";
  static const DocumentSharingLocation = "DocumentSharingLocation";
  static const ServiceUrl = "ServiceUrl";
  static const LocationUrl = "LocationUrl";
  static const SupportedFileExtensions = "SupportedFileExtensions";
  static const FileExtension = "FileExtension";
  static const ExternalAccessAllowed = "ExternalAccessAllowed";
  static const AnonymousAccessAllowed = "AnonymousAccessAllowed";
  static const CanModifyPermissions = "CanModifyPermissions";
  static const IsDefault = "IsDefault";
  static const EncryptionMethod = "EncryptionMethod";
  static const Hostname = "Hostname";
  static const Port = "Port";
  static const Version = "Version";
  static const MajorVersion = "MajorVersion";
  static const MinorVersion = "MinorVersion";
  static const MajorBuildNumber = "MajorBuildNumber";
  static const MinorBuildNumber = "MinorBuildNumber";
  static const RequestedVersion = "RequestedVersion";
  static const PublicFolderServer = "PublicFolderServer";
  static const Ssl = "SSL";
  static const SharingUrl = "SharingUrl";
  static const EcpUrl = "EcpUrl";
  static const EcpUrl_um = "EcpUrl-um";
  static const EcpUrl_aggr = "EcpUrl-aggr";
  static const EcpUrl_sms = "EcpUrl-sms";
  static const EcpUrl_mt = "EcpUrl-mt";
  static const EcpUrl_ret = "EcpUrl-ret";
  static const EcpUrl_publish = "EcpUrl-publish";
  static const EcpUrl_photo = "EcpUrl-photo";
  static const ExchangeRpcUrl = "ExchangeRpcUrl";
  static const EcpUrl_connect = "EcpUrl-connect";
  static const EcpUrl_tm = "EcpUrl-tm";
  static const EcpUrl_tmCreating = "EcpUrl-tmCreating";
  static const EcpUrl_tmEditing = "EcpUrl-tmEditing";
  static const EcpUrl_tmHiding = "EcpUrl-tmHiding";
  static const SiteMailboxCreationURL = "SiteMailboxCreationURL";
  static const EcpUrl_extinstall = "EcpUrl-extinstall";
  static const PartnerToken = "PartnerToken";
  static const PartnerTokenReference = "PartnerTokenReference";
  static const ServerExclusiveConnect = "ServerExclusiveConnect";
  static const AutoDiscoverSMTPAddress = "AutoDiscoverSMTPAddress";
  static const CertPrincipalName = "CertPrincipalName";
  static const GroupingInformation = "GroupingInformation";

  static const MailboxSmtpAddress = "MailboxSmtpAddress";
  static const RuleId = "RuleId";
  static const Priority = "Priority";
  static const IsEnabled = "IsEnabled";
  static const IsNotSupported = "IsNotSupported";
  static const IsInError = "IsInError";
  static const Conditions = "Conditions";
  static const Exceptions = "Exceptions";
  static const Actions = "Actions";
  static const InboxRules = "InboxRules";
  static const Rule = "Rule";
  static const OutlookRuleBlobExists = "OutlookRuleBlobExists";
  static const RemoveOutlookRuleBlob = "RemoveOutlookRuleBlob";
  static const ContainsBodyStrings = "ContainsBodyStrings";
  static const ContainsHeaderStrings = "ContainsHeaderStrings";
  static const ContainsRecipientStrings = "ContainsRecipientStrings";
  static const ContainsSenderStrings = "ContainsSenderStrings";
  static const ContainsSubjectOrBodyStrings = "ContainsSubjectOrBodyStrings";
  static const ContainsSubjectStrings = "ContainsSubjectStrings";
  static const FlaggedForAction = "FlaggedForAction";
  static const FromAddresses = "FromAddresses";
  static const FromConnectedAccounts = "FromConnectedAccounts";
  static const IsApprovalRequest = "IsApprovalRequest";
  static const IsAutomaticForward = "IsAutomaticForward";
  static const IsAutomaticReply = "IsAutomaticReply";
  static const IsEncrypted = "IsEncrypted";
  static const IsMeetingRequest = "IsMeetingRequest";
  static const IsMeetingResponse = "IsMeetingResponse";
  static const IsNDR = "IsNDR";
  static const IsPermissionControlled = "IsPermissionControlled";
  static const IsSigned = "IsSigned";
  static const IsVoicemail = "IsVoicemail";
  static const IsReadReceipt = "IsReadReceipt";
  static const MessageClassifications = "MessageClassifications";
  static const NotSentToMe = "NotSentToMe";
  static const SentCcMe = "SentCcMe";
  static const SentOnlyToMe = "SentOnlyToMe";
  static const SentToAddresses = "SentToAddresses";
  static const SentToMe = "SentToMe";
  static const SentToOrCcMe = "SentToOrCcMe";
  static const WithinDateRange = "WithinDateRange";
  static const WithinSizeRange = "WithinSizeRange";
  static const MinimumSize = "MinimumSize";
  static const MaximumSize = "MaximumSize";
  static const StartDateTime = "StartDateTime";
  static const EndDateTime = "EndDateTime";
  static const AssignCategories = "AssignCategories";
  static const CopyToFolder = "CopyToFolder";
  static const FlagMessage = "FlagMessage";
  static const ForwardAsAttachmentToRecipients =
      "ForwardAsAttachmentToRecipients";
  static const ForwardToRecipients = "ForwardToRecipients";
  static const MarkImportance = "MarkImportance";
  static const MarkAsRead = "MarkAsRead";
  static const MoveToFolder = "MoveToFolder";
  static const PermanentDelete = "PermanentDelete";
  static const RedirectToRecipients = "RedirectToRecipients";
  static const SendSMSAlertToRecipients = "SendSMSAlertToRecipients";
  static const ServerReplyWithMessage = "ServerReplyWithMessage";
  static const StopProcessingRules = "StopProcessingRules";
  static const CreateRuleOperation = "CreateRuleOperation";
  static const SetRuleOperation = "SetRuleOperation";
  static const DeleteRuleOperation = "DeleteRuleOperation";
  static const Operations = "Operations";
  static const RuleOperationErrors = "RuleOperationErrors";
  static const RuleOperationError = "RuleOperationError";
  static const OperationIndex = "OperationIndex";
  static const ValidationErrors = "ValidationErrors";
  static const FieldValue = "FieldValue";

  static const Not = "Not";
  static const Bitmask = "Bitmask";
  static const Constant = "Constant";
  static const Restriction = "Restriction";
  static const Condition = "Condition";
  static const Contains = "Contains";
  static const Excludes = "Excludes";
  static const Exists = "Exists";
  static const FieldURIOrConstant = "FieldURIOrConstant";
  static const And = "And";
  static const Or = "Or";
  static const IsEqualTo = "IsEqualTo";
  static const IsNotEqualTo = "IsNotEqualTo";
  static const IsGreaterThan = "IsGreaterThan";
  static const IsGreaterThanOrEqualTo = "IsGreaterThanOrEqualTo";
  static const IsLessThan = "IsLessThan";
  static const IsLessThanOrEqualTo = "IsLessThanOrEqualTo";

  static const PhoneticFullName = "PhoneticFullName";
  static const PhoneticFirstName = "PhoneticFirstName";
  static const PhoneticLastName = "PhoneticLastName";
  static const Alias = "Alias";
  static const Notes = "Notes";
  static const Photo = "Photo";
  static const UserSMIMECertificate = "UserSMIMECertificate";
  static const MSExchangeCertificate = "MSExchangeCertificate";
  static const DirectoryId = "DirectoryId";
  static const ManagerMailbox = "ManagerMailbox";
  static const DirectReports = "DirectReports";

  static const SizeRequested = "SizeRequested";
  static const HasChanged = "HasChanged";
  static const PictureData = "PictureData";

  static const ResponseMessage = "ResponseMessage";
  static const ResponseMessages = "ResponseMessages";

  // FindConversation
  static const FindConversation = "FindConversation";
  static const FindConversationResponse = "FindConversationResponse";
  static const FindConversationResponseMessage =
      "FindConversationResponseMessage";

  // GetConversationItems
  static const GetConversationItems = "GetConversationItems";
  static const GetConversationItemsResponse = "GetConversationItemsResponse";
  static const GetConversationItemsResponseMessage =
      "GetConversationItemsResponseMessage";

  // FindItem
  static const FindItem = "FindItem";
  static const FindItemResponse = "FindItemResponse";
  static const FindItemResponseMessage = "FindItemResponseMessage";

  // GetItem
  static const GetItem = "GetItem";
  static const GetItemResponse = "GetItemResponse";
  static const GetItemResponseMessage = "GetItemResponseMessage";

  // CreateItem
  static const CreateItem = "CreateItem";
  static const CreateItemResponse = "CreateItemResponse";
  static const CreateItemResponseMessage = "CreateItemResponseMessage";

  // SendItem
  static const SendItem = "SendItem";
  static const SendItemResponse = "SendItemResponse";
  static const SendItemResponseMessage = "SendItemResponseMessage";

  // DeleteItem
  static const DeleteItem = "DeleteItem";
  static const DeleteItemResponse = "DeleteItemResponse";
  static const DeleteItemResponseMessage = "DeleteItemResponseMessage";

  // UpdateItem
  static const UpdateItem = "UpdateItem";
  static const UpdateItemResponse = "UpdateItemResponse";
  static const UpdateItemResponseMessage = "UpdateItemResponseMessage";

  // CopyItem
  static const CopyItem = "CopyItem";
  static const CopyItemResponse = "CopyItemResponse";
  static const CopyItemResponseMessage = "CopyItemResponseMessage";

  // MoveItem
  static const MoveItem = "MoveItem";
  static const MoveItemResponse = "MoveItemResponse";
  static const MoveItemResponseMessage = "MoveItemResponseMessage";

  // ArchiveItem
  static const ArchiveItem = "ArchiveItem";
  static const ArchiveItemResponse = "ArchiveItemResponse";
  static const ArchiveItemResponseMessage = "ArchiveItemResponseMessage";
  static const ArchiveSourceFolderId = "ArchiveSourceFolderId";

  // FindFolder
  static const FindFolder = "FindFolder";
  static const FindFolderResponse = "FindFolderResponse";
  static const FindFolderResponseMessage = "FindFolderResponseMessage";

  // GetFolder
  static const GetFolder = "GetFolder";
  static const GetFolderResponse = "GetFolderResponse";
  static const GetFolderResponseMessage = "GetFolderResponseMessage";

  // CreateFolder
  static const CreateFolder = "CreateFolder";
  static const CreateFolderResponse = "CreateFolderResponse";
  static const CreateFolderResponseMessage = "CreateFolderResponseMessage";

  // DeleteFolder
  static const DeleteFolder = "DeleteFolder";
  static const DeleteFolderResponse = "DeleteFolderResponse";
  static const DeleteFolderResponseMessage = "DeleteFolderResponseMessage";

  // EmptyFolder
  static const EmptyFolder = "EmptyFolder";
  static const EmptyFolderResponse = "EmptyFolderResponse";
  static const EmptyFolderResponseMessage = "EmptyFolderResponseMessage";

  // UpdateFolder
  static const UpdateFolder = "UpdateFolder";
  static const UpdateFolderResponse = "UpdateFolderResponse";
  static const UpdateFolderResponseMessage = "UpdateFolderResponseMessage";

  // CopyFolder
  static const CopyFolder = "CopyFolder";
  static const CopyFolderResponse = "CopyFolderResponse";
  static const CopyFolderResponseMessage = "CopyFolderResponseMessage";

  // MoveFolder
  static const MoveFolder = "MoveFolder";
  static const MoveFolderResponse = "MoveFolderResponse";
  static const MoveFolderResponseMessage = "MoveFolderResponseMessage";

  // MarkAllItemsAsRead
  static const MarkAllItemsAsRead = "MarkAllItemsAsRead";
  static const MarkAllItemsAsReadResponse = "MarkAllItemsAsReadResponse";
  static const MarkAllItemsAsReadResponseMessage =
      "MarkAllItemsAsReadResponseMessage";

  // FindPeople
  static const FindPeople = "FindPeople";
  static const FindPeopleResponse = "FindPeopleResponse";
  static const FindPeopleResponseMessage = "FindPeopleResponseMessage";
  static const SearchPeopleSuggestionIndex = "SearchPeopleSuggestionIndex";
  static const SearchPeopleContext = "Context";
  static const SearchPeopleQuerySources = "QuerySources";
  static const FindPeopleTransactionId = "TransactionId";
  static const FindPeopleSources = "Sources";

  // GetPeopleInsights
  static const GetPeopleInsights = "GetPeopleInsights";
  static const GetPeopleInsightsResponse = "GetPeopleInsightsResponse";
  static const GetPeopleInsightsResponseMessage =
      "GetPeopleInsightsResponseMessage";

  // GetUserPhoto
  static const GetUserPhoto = "GetUserPhoto";
  static const GetUserPhotoResponse = "GetUserPhotoResponse";
  static const GetUserPhotoResponseMessage = "GetUserPhotoResponseMessage";

  // SetUserPhoto
  static const SetUserPhoto = "SetUserPhoto";
  static const SetUserPhotoResponse = "SetUserPhotoResponse";
  static const SetUserPhotoResponseMessage = "SetUserPhotoResponseMessage";

  // GetAttachment
  static const GetAttachment = "GetAttachment";
  static const GetAttachmentResponse = "GetAttachmentResponse";
  static const GetAttachmentResponseMessage = "GetAttachmentResponseMessage";

  // CreateAttachment
  static const CreateAttachment = "CreateAttachment";
  static const CreateAttachmentResponse = "CreateAttachmentResponse";
  static const CreateAttachmentResponseMessage =
      "CreateAttachmentResponseMessage";

  // DeleteAttachment
  static const DeleteAttachment = "DeleteAttachment";
  static const DeleteAttachmentResponse = "DeleteAttachmentResponse";
  static const DeleteAttachmentResponseMessage =
      "DeleteAttachmentResponseMessage";

  // ResolveNames
  static const ResolveNames = "ResolveNames";
  static const ResolveNamesResponse = "ResolveNamesResponse";
  static const ResolveNamesResponseMessage = "ResolveNamesResponseMessage";

  // ExpandDL
  static const ExpandDL = "ExpandDL";
  static const ExpandDLResponse = "ExpandDLResponse";
  static const ExpandDLResponseMessage = "ExpandDLResponseMessage";

  // Subscribe
  static const Subscribe = "Subscribe";
  static const SubscribeResponse = "SubscribeResponse";
  static const SubscribeResponseMessage = "SubscribeResponseMessage";
  static const SubscriptionRequest = "SubscriptionRequest";

  // Unsubscribe
  static const Unsubscribe = "Unsubscribe";
  static const UnsubscribeResponse = "UnsubscribeResponse";
  static const UnsubscribeResponseMessage = "UnsubscribeResponseMessage";

  // GetEvents
  static const GetEvents = "GetEvents";
  static const GetEventsResponse = "GetEventsResponse";
  static const GetEventsResponseMessage = "GetEventsResponseMessage";

  // GetStreamingEvents
  static const GetStreamingEvents = "GetStreamingEvents";
  static const GetStreamingEventsResponse = "GetStreamingEventsResponse";
  static const GetStreamingEventsResponseMessage =
      "GetStreamingEventsResponseMessage";
  static const ConnectionStatus = "ConnectionStatus";
  static const ErrorSubscriptionIds = "ErrorSubscriptionIds";
  static const ConnectionTimeout = "ConnectionTimeout";
  static const HeartbeatFrequency = "HeartbeatFrequency";

  // SyncFolderItems
  static const SyncFolderItems = "SyncFolderItems";
  static const SyncFolderItemsResponse = "SyncFolderItemsResponse";
  static const SyncFolderItemsResponseMessage =
      "SyncFolderItemsResponseMessage";

  // SyncFolderHierarchy
  static const SyncFolderHierarchy = "SyncFolderHierarchy";
  static const SyncFolderHierarchyResponse = "SyncFolderHierarchyResponse";
  static const SyncFolderHierarchyResponseMessage =
      "SyncFolderHierarchyResponseMessage";

  // GetUserOofSettings
  static const GetUserOofSettingsRequest = "GetUserOofSettingsRequest";
  static const GetUserOofSettingsResponse = "GetUserOofSettingsResponse";

  // SetUserOofSettings
  static const SetUserOofSettingsRequest = "SetUserOofSettingsRequest";
  static const SetUserOofSettingsResponse = "SetUserOofSettingsResponse";

  // GetUserAvailability
  static const GetUserAvailabilityRequest = "GetUserAvailabilityRequest";
  static const GetUserAvailabilityResponse = "GetUserAvailabilityResponse";
  static const FreeBusyResponseArray = "FreeBusyResponseArray";
  static const FreeBusyResponse = "FreeBusyResponse";
  static const SuggestionsResponse = "SuggestionsResponse";

  // GetRoomLists
  static const GetRoomListsRequest = "GetRoomLists";
  static const GetRoomListsResponse = "GetRoomListsResponse";

  // GetRooms
  static const GetRoomsRequest = "GetRooms";
  static const GetRoomsResponse = "GetRoomsResponse";

  // ConvertId
  static const ConvertId = "ConvertId";
  static const ConvertIdResponse = "ConvertIdResponse";
  static const ConvertIdResponseMessage = "ConvertIdResponseMessage";

  // AddDelegate
  static const AddDelegate = "AddDelegate";
  static const AddDelegateResponse = "AddDelegateResponse";
  static const DelegateUserResponseMessageType =
      "DelegateUserResponseMessageType";

  // RemoveDelegte
  static const RemoveDelegate = "RemoveDelegate";
  static const RemoveDelegateResponse = "RemoveDelegateResponse";

  // GetDelegate
  static const GetDelegate = "GetDelegate";
  static const GetDelegateResponse = "GetDelegateResponse";

  // UpdateDelegate
  static const UpdateDelegate = "UpdateDelegate";
  static const UpdateDelegateResponse = "UpdateDelegateResponse";

  // CreateUserConfiguration
  static const CreateUserConfiguration = "CreateUserConfiguration";
  static const CreateUserConfigurationResponse =
      "CreateUserConfigurationResponse";
  static const CreateUserConfigurationResponseMessage =
      "CreateUserConfigurationResponseMessage";

  // DeleteUserConfiguration
  static const DeleteUserConfiguration = "DeleteUserConfiguration";
  static const DeleteUserConfigurationResponse =
      "DeleteUserConfigurationResponse";
  static const DeleteUserConfigurationResponseMessage =
      "DeleteUserConfigurationResponseMessage";

  // GetUserConfiguration
  static const GetUserConfiguration = "GetUserConfiguration";
  static const GetUserConfigurationResponse = "GetUserConfigurationResponse";
  static const GetUserConfigurationResponseMessage =
      "GetUserConfigurationResponseMessage";

  // UpdateUserConfiguration
  static const UpdateUserConfiguration = "UpdateUserConfiguration";
  static const UpdateUserConfigurationResponse =
      "UpdateUserConfigurationResponse";
  static const UpdateUserConfigurationResponseMessage =
      "UpdateUserConfigurationResponseMessage";

  // PlayOnPhone
  static const PlayOnPhone = "PlayOnPhone";
  static const PlayOnPhoneResponse = "PlayOnPhoneResponse";

  // GetPhoneCallInformation
  static const GetPhoneCall = "GetPhoneCallInformation";
  static const GetPhoneCallResponse = "GetPhoneCallInformationResponse";

  // DisconnectCall
  static const DisconnectPhoneCall = "DisconnectPhoneCall";
  static const DisconnectPhoneCallResponse = "DisconnectPhoneCallResponse";

  // GetServerTimeZones
  static const GetServerTimeZones = "GetServerTimeZones";
  static const GetServerTimeZonesResponse = "GetServerTimeZonesResponse";
  static const GetServerTimeZonesResponseMessage =
      "GetServerTimeZonesResponseMessage";

  // GetInboxRules
  static const GetInboxRules = "GetInboxRules";
  static const GetInboxRulesResponse = "GetInboxRulesResponse";

  // UpdateInboxRules
  static const UpdateInboxRules = "UpdateInboxRules";
  static const UpdateInboxRulesResponse = "UpdateInboxRulesResponse";

  // ExecuteDiagnosticMethod
  static const ExecuteDiagnosticMethod = "ExecuteDiagnosticMethod";
  static const ExecuteDiagnosticMethodResponse =
      "ExecuteDiagnosticMethodResponse";
  static const ExecuteDiagnosticMethodResponseMEssage =
      "ExecuteDiagnosticMethodResponseMessage";

  //GetPasswordExpirationDate
  static const GetPasswordExpirationDateRequest = "GetPasswordExpirationDate";
  static const GetPasswordExpirationDateResponse =
      "GetPasswordExpirationDateResponse";

  // GetSearchableMailboxes
  static const GetSearchableMailboxes = "GetSearchableMailboxes";
  static const GetSearchableMailboxesResponse =
      "GetSearchableMailboxesResponse";

  // GetDiscoverySearchConfiguration
  static const GetDiscoverySearchConfiguration =
      "GetDiscoverySearchConfiguration";
  static const GetDiscoverySearchConfigurationResponse =
      "GetDiscoverySearchConfigurationResponse";

  // GetHoldOnMailboxes
  static const GetHoldOnMailboxes = "GetHoldOnMailboxes";
  static const GetHoldOnMailboxesResponse = "GetHoldOnMailboxesResponse";

  // SetHoldOnMailboxes
  static const SetHoldOnMailboxes = "SetHoldOnMailboxes";
  static const SetHoldOnMailboxesResponse = "SetHoldOnMailboxesResponse";

  // SearchMailboxes
  static const SearchMailboxes = "SearchMailboxes";
  static const SearchMailboxesResponse = "SearchMailboxesResponse";
  static const SearchMailboxesResponseMessage =
      "SearchMailboxesResponseMessage";

  // GetNonIndexableItemDetails
  static const GetNonIndexableItemDetails = "GetNonIndexableItemDetails";
  static const GetNonIndexableItemDetailsResponse =
      "GetNonIndexableItemDetailsResponse";

  // GetNonIndexableItemStatistics
  static const GetNonIndexableItemStatistics = "GetNonIndexableItemStatistics";
  static const GetNonIndexableItemStatisticsResponse =
      "GetNonIndexableItemStatisticsResponse";

  // eDiscovery
  static const SearchQueries = "SearchQueries";
  static const SearchQuery = "SearchQuery";
  static const MailboxQuery = "MailboxQuery";
  static const Query = "Query";
  static const MailboxSearchScopes = "MailboxSearchScopes";
  static const MailboxSearchScope = "MailboxSearchScope";
  static const SearchScope = "SearchScope";
  static const ResultType = "ResultType";
  static const SortBy = "SortBy";
  static const Order = "Order";
  static const Language = "Language";
  static const Deduplication = "Deduplication";
  static const PageSize = "PageSize";
  static const PageItemReference = "PageItemReference";
  static const PageDirection = "PageDirection";
  static const PreviewItemResponseShape = "PreviewItemResponseShape";
  static const ExtendedProperties = "ExtendedProperties";
  static const PageItemSize = "PageItemSize";
  static const PageItemCount = "PageItemCount";
  static const ItemCount = "ItemCount";
  static const KeywordStats = "KeywordStats";
  static const KeywordStat = "KeywordStat";
  static const Keyword = "Keyword";
  static const ItemHits = "ItemHits";
  static const SearchPreviewItem = "SearchPreviewItem";
  static const ChangeKey = "ChangeKey";
  static const ParentId = "ParentId";
  static const MailboxId = "MailboxId";
  static const UniqueHash = "UniqueHash";
  static const SortValue = "SortValue";
  static const OwaLink = "OwaLink";
  static const SmtpAddress = "SmtpAddress";
  static const CreatedTime = "CreatedTime";
  static const ReceivedTime = "ReceivedTime";
  static const SentTime = "SentTime";
  static const Preview = "Preview";
  static const HasAttachment = "HasAttachment";
  static const FailedMailboxes = "FailedMailboxes";
  static const FailedMailbox = "FailedMailbox";
  static const Token = "Token";
  static const Refiners = "Refiners";
  static const Refiner = "Refiner";
  static const MailboxStats = "MailboxStats";
  static const MailboxStat = "MailboxStat";
  static const HoldId = "HoldId";
  static const ActionType = "ActionType";
  static const Mailboxes = "Mailboxes";
  static const SearchFilter = "SearchFilter";
  static const ReferenceId = "ReferenceId";
  static const IsMembershipGroup = "IsMembershipGroup";
  static const ExpandGroupMembership = "ExpandGroupMembership";
  static const SearchableMailboxes = "SearchableMailboxes";
  static const SearchableMailbox = "SearchableMailbox";
  static const SearchMailboxesResult = "SearchMailboxesResult";
  static const MailboxHoldResult = "MailboxHoldResult";
  static const Statuses = "Statuses";
  static const MailboxHoldStatuses = "MailboxHoldStatuses";
  static const MailboxHoldStatus = "MailboxHoldStatus";
  static const AdditionalInfo = "AdditionalInfo";
  static const NonIndexableItemDetail = "NonIndexableItemDetail";
  static const NonIndexableItemStatistic = "NonIndexableItemStatistic";
  static const NonIndexableItemDetails = "NonIndexableItemDetails";
  static const NonIndexableItemStatistics = "NonIndexableItemStatistics";
  static const NonIndexableItemDetailsResult = "NonIndexableItemDetailsResult";
  static const SearchArchiveOnly = "SearchArchiveOnly";
  static const ErrorDescription = "ErrorDescription";
  static const IsPartiallyIndexed = "IsPartiallyIndexed";
  static const IsPermanentFailure = "IsPermanentFailure";
  static const AttemptCount = "AttemptCount";
  static const LastAttemptTime = "LastAttemptTime";
  static const SearchId = "SearchId";
  static const DiscoverySearchConfigurations = "DiscoverySearchConfigurations";
  static const DiscoverySearchConfiguration = "DiscoverySearchConfiguration";
  static const InPlaceHoldConfigurationOnly = "InPlaceHoldConfigurationOnly";
  static const InPlaceHoldIdentity = "InPlaceHoldIdentity";
  static const ItemHoldPeriod = "ItemHoldPeriod";
  static const ManagedByOrganization = "ManagedByOrganization";
  static const IsExternalMailbox = "IsExternalMailbox";
  static const ExternalEmailAddress = "ExternalEmailAddress";
  static const ExtendedAttributes = "ExtendedAttributes";
  static const ExtendedAttribute = "ExtendedAttribute";
  static const ExtendedAttributeName = "Name";
  static const ExtendedAttributeValue = "Value";
  static const SearchScopeType = "SearchScopeType";

  // GetAppManifests
  static const GetAppManifestsRequest = "GetAppManifests";
  static const GetAppManifestsResponse = "GetAppManifestsResponse";
  static const Manifests = "Manifests";
  static const Manifest = "Manifest";

  // GetAppManifests for TargetServerVersion > 2.5
  static const Apps = "Apps";
  static const App = "App";
  static const Metadata = "Metadata";
  static const ActionUrl = "ActionUrl";
  static const AppStatus = "AppStatus";
  static const EndNodeUrl = "EndNodeUrl";

  // GetClientExtension/SetClientExtension
  static const GetClientExtensionRequest = "GetClientExtension";
  static const ClientExtensionUserRequest = "UserParameters";
  static const ClientExtensionUserEnabled = "UserEnabledExtensions";
  static const ClientExtensionUserDisabled = "UserDisabledExtensions";
  static const ClientExtensionRequestedIds = "RequestedExtensionIds";
  static const ClientExtensionIsDebug = "IsDebug";
  static const ClientExtensionRawMasterTableXml = "RawMasterTableXml";
  static const GetClientExtensionResponse = "GetClientExtensionResponse";
  static const ClientExtensionSpecificUsers = "SpecificUsers";
  static const ClientExtensions = "ClientExtensions";
  static const ClientExtension = "ClientExtension";
  static const SetClientExtensionRequest = "SetClientExtension";
  static const SetClientExtensionActions = "Actions";
  static const SetClientExtensionAction = "Action";
  static const SetClientExtensionResponse = "SetClientExtensionResponse";
  static const SetClientExtensionResponseMessage =
      "SetClientExtensionResponseMessage";

  // GetOMEConfiguration/SetOMEConfiguration
  static const GetOMEConfigurationRequest = "GetOMEConfiguration";
  static const SetOMEConfigurationRequest = "SetOMEConfiguration";
  static const OMEConfigurationXml = "Xml";
  static const GetOMEConfigurationResponse = "GetOMEConfigurationResponse";
  static const SetOMEConfigurationResponse = "SetOMEConfigurationResponse";

  // InstallApp
  static const InstallAppRequest = "InstallApp";
  static const InstallAppResponse = "InstallAppResponse";
  static const MarketplaceAssetId = "MarketplaceAssetId";
  static const MarketplaceContentMarket = "MarketplaceContentMarket";
  static const SendWelcomeEmail = "SendWelcomeEmail";
  static const WasFirstInstall = "WasFirstInstall";

  // UninstallApp
  static const UninstallAppRequest = "UninstallApp";
  static const UninstallAppResponse = "UninstallAppResponse";

  // DisableApp
  static const DisableAppRequest = "DisableApp";
  static const DisableAppResponse = "DisableAppResponse";

  // RegisterConsent
  static const RegisterConsentRequest = "RegisterConsent";
  static const RegisterConsentResponse = "RegisterConsentResponse";

  // GetAppMarketplaceUrl
  static const GetAppMarketplaceUrlRequest = "GetAppMarketplaceUrl";
  static const GetAppMarketplaceUrlResponse = "GetAppMarketplaceUrlResponse";

  // GetUserRetentionPolicyTags
  static const GetUserRetentionPolicyTags = "GetUserRetentionPolicyTags";
  static const GetUserRetentionPolicyTagsResponse =
      "GetUserRetentionPolicyTagsResponse";

  // MRM
  static const RetentionPolicyTags = "RetentionPolicyTags";
  static const RetentionPolicyTag = "RetentionPolicyTag";
  static const RetentionId = "RetentionId";
  static const RetentionPeriod = "RetentionPeriod";
  static const RetentionAction = "RetentionAction";
  static const Description = "Description";
  static const IsVisible = "IsVisible";
  static const OptedInto = "OptedInto";
  static const IsArchive = "IsArchive";

  // Like
  static const Likers = "Likers";

  // GetUserUnifiedGroups
  static const GetUserUnifiedGroups = "GetUserUnifiedGroups";
  static const RequestedGroupsSets = "RequestedGroupsSets";
  static const RequestedUnifiedGroupsSetItem = "RequestedUnifiedGroupsSet";
  static const SortType = "SortType";
  static const FilterType = "FilterType";
  static const SortDirection = "SortDirection";
  static const GroupsLimit = "GroupsLimit";
  static const UserSmtpAddress = "UserSmtpAddress";

  static const GetUserUnifiedGroupsResponseMessage =
      "GetUserUnifiedGroupsResponseMessage";
  static const GroupsSets = "GroupsSets";
  static const UnifiedGroupsSet = "UnifiedGroupsSet";
  static const TotalGroups = "TotalGroups";
  static const GroupsTag = "Groups";
  static const UnifiedGroup = "UnifiedGroup";
  static const MailboxGuid = "MailboxGuid";
  static const LastVisitedTimeUtc = "LastVisitedTimeUtc";
  static const AccessType = "AccessType";
  static const ExternalDirectoryObjectId = "ExternalDirectoryObjectId";

  // GetUnifiedGroupUnseenCount
  static const GetUnifiedGroupUnseenCount = "GetUnifiedGroupUnseenCount";
  static const GroupIdentity = "GroupIdentity";
  static const GroupIdentityType = "IdentityType";
  static const GroupIdentityValue = "Value";

  static const GetUnifiedGroupUnseenCountResponseMessage =
      "GetUnifiedGroupUnseenCountResponseMessage";
  static const UnseenCount = "UnseenCount";

  // SetUnifiedGroupLastVisitedTimeRequest
  static const SetUnifiedGroupLastVisitedTime =
      "SetUnifiedGroupLastVisitedTime";
  static const SetUnifiedGroupLastVisitedTimeResponseMessage =
      "SetUnifiedGroupLastVisitedTimeResponseMessage";

  static const Hashtags = "Hashtags";

  static const Mentions = "Mentions";

  static const MentionedMe = "MentionedMe";

  static const SOAPEnvelopeElementName = "Envelope";
  static const SOAPHeaderElementName = "Header";
  static const SOAPBodyElementName = "Body";
  static const SOAPFaultElementName = "Fault";
  static const SOAPFaultCodeElementName = "faultcode";
  static const SOAPFaultStringElementName = "faultstring";
  static const SOAPFaultActorElementName = "faultactor";
  static const SOAPDetailElementName = "detail";
  static const EwsResponseCodeElementName = "ResponseCode";
  static const EwsMessageElementName = "Message";
  static const EwsLineElementName = "Line";
  static const EwsPositionElementName = "Position";
  static const EwsErrorCodeElementName =
      "ErrorCode"; // Generated by Availability
  static const EwsExceptionTypeElementName = "ExceptionType"; // Generated by UM
}
