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

import 'dart:async';
import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';

import 'package:ews/Attributes/EwsEnumAttribute.dart';
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/ServiceObjects/ServiceObjectInfo.dart';
import 'package:ews/Enumerations/AffectedTaskOccurrence.dart';
import 'package:ews/Enumerations/AppointmentType.dart';
import 'package:ews/Enumerations/BodyType.dart';
import 'package:ews/Enumerations/ComparisonMode.dart';
import 'package:ews/Enumerations/ConflictResolutionMode.dart';
import 'package:ews/Enumerations/ContainmentMode.dart';
import 'package:ews/Enumerations/ConversationQueryTraversal.dart';
import 'package:ews/Enumerations/DefaultExtendedPropertySet.dart';
import 'package:ews/Enumerations/DeleteMode.dart';
import 'package:ews/Enumerations/EmailAddressKey.dart';
import 'package:ews/Enumerations/Enumerations.dart';
import 'package:ews/Enumerations/EventType.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/FileAsMapping.dart';
import 'package:ews/Enumerations/FolderPermissionLevel.dart';
import 'package:ews/Enumerations/FolderPermissionReadAccess.dart';
import 'package:ews/Enumerations/FolderTraversal.dart';
import 'package:ews/Enumerations/Importance.dart';
import 'package:ews/Enumerations/ItemFlagStatus.dart';
import 'package:ews/Enumerations/ItemTraversal.dart';
import 'package:ews/Enumerations/MailboxSearchLocation.dart';
import 'package:ews/Enumerations/MailboxType.dart';
import 'package:ews/Enumerations/MapiPropertyType.dart';
import 'package:ews/Enumerations/MeetingRequestsDeliveryScope.dart';
import 'package:ews/Enumerations/MessageDisposition.dart';
import 'package:ews/Enumerations/OffsetBasePoint.dart';
import 'package:ews/Enumerations/PermissionScope.dart';
import 'package:ews/Enumerations/ResponseType.dart';
import 'package:ews/Enumerations/RuleProperty.dart';
import 'package:ews/Enumerations/SendCancellationsMode.dart';
import 'package:ews/Enumerations/SendInvitationsMode.dart';
import 'package:ews/Enumerations/Sensitivity.dart';
import 'package:ews/Enumerations/ServiceError.dart';
import 'package:ews/Enumerations/ServiceResult.dart';
import 'package:ews/Enumerations/StandardUser.dart';
import 'package:ews/Enumerations/SyncFolderItemsScope.dart';
import 'package:ews/Enumerations/TaskStatus.dart';
import 'package:ews/Enumerations/UserSettingName.dart';
import 'package:ews/Enumerations/ViewFilter.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';
import 'package:ews/Interfaces/ISelfValidate.dart';
import 'package:ews/Xml/XmlWriter.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:ews/misc/Std/EnumToString.dart';
import 'package:ews/misc/Std/MemoryStream.dart';
import 'package:ews/misc/StringUtils.dart';
import 'package:ews/misc/TimeSpan.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart';

typedef R Converter<T,R>(T);

/// <summary>
    /// EWS utilities
    /// </summary>
    class EwsUtilities
    {
        /// <summary>
        /// Map from XML element names to ServiceObject type and constructors.
        /// </summary>
      static LazyMember<ServiceObjectInfo> serviceObjectInfo = new LazyMember<ServiceObjectInfo>(
            ()
            {
                return new ServiceObjectInfo();
            });
//
        /// <summary>
        /// Version of API binary.
        /// </summary>
        static const BuildVersion = "dart/0.0.1";


       static final RegExp PATTERN_TIME_SPAN = RegExp("-P");
       static final RegExp PATTERN_YEAR = RegExp("(\\d+)Y");
       static final RegExp PATTERN_MONTH = RegExp("(\\d+)M");
       static final RegExp PATTERN_DAY = RegExp("(\\d+)D");
       static final RegExp PATTERN_HOUR = RegExp("(\\d+)H");
       static final RegExp PATTERN_MINUTES = RegExp("(\\d+)M");
       static final RegExp PATTERN_SECONDS = RegExp("(\\d+)S");
       static final RegExp PATTERN_MILLISECONDS = RegExp("(\\d+)S");

       static LazyMember<Map<Type, Map<dynamic, ExchangeVersion>>> _requiredServerVersion = new LazyMember(() => {
         ViewFilter: {
           ViewFilter.All: ExchangeVersion.Exchange2013,
           ViewFilter.Flagged: ExchangeVersion.Exchange2013,
           ViewFilter.HasAttachment: ExchangeVersion.Exchange2013,
           ViewFilter.ToOrCcMe: ExchangeVersion.Exchange2013,
           ViewFilter.Unread: ExchangeVersion.Exchange2013,
           ViewFilter.TaskActive: ExchangeVersion.Exchange2013,
           ViewFilter.TaskOverdue: ExchangeVersion.Exchange2013,
           ViewFilter.TaskCompleted: ExchangeVersion.Exchange2013,
           ViewFilter.Suggestions: ExchangeVersion.Exchange2013,
           ViewFilter.SuggestionsRespond: ExchangeVersion.Exchange2013,
           ViewFilter.SuggestionsDelete: ExchangeVersion.Exchange2013,
         },
         MailboxSearchLocation: {
           MailboxSearchLocation.PrimaryOnly:ExchangeVersion.Exchange2013,
           MailboxSearchLocation.ArchiveOnly:ExchangeVersion.Exchange2013,
           MailboxSearchLocation.All:ExchangeVersion.Exchange2013,
         },
         EventType: {
           EventType.FreeBusyChanged: ExchangeVersion.Exchange2010_SP1
         },
         MeetingRequestsDeliveryScope: {
           MeetingRequestsDeliveryScope.NoForward: ExchangeVersion.Exchange2010_SP1
         },
         FileAsMapping: {
           FileAsMapping.DisplayName: ExchangeVersion.Exchange2010,
           FileAsMapping.GivenName: ExchangeVersion.Exchange2010,
           FileAsMapping.SurnameGivenNameMiddleSuffix: ExchangeVersion.Exchange2010,
           FileAsMapping.Surname: ExchangeVersion.Exchange2010,
           FileAsMapping.Empty: ExchangeVersion.Exchange2010,
         },
         WellKnownFolderName: {
           WellKnownFolderName.PublicFoldersRoot: ExchangeVersion.Exchange2007_SP1,
           WellKnownFolderName.RecoverableItemsRoot: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.RecoverableItemsDeletions: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.RecoverableItemsVersions: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.RecoverableItemsPurges: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.RecoverableItemsDiscoveryHolds: ExchangeVersion.Exchange2013_SP1,
           WellKnownFolderName.ArchiveRoot: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.ArchiveInbox: ExchangeVersion.Exchange2013_SP1,
           WellKnownFolderName.ArchiveMsgFolderRoot: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.ArchiveDeletedItems: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.ArchiveRecoverableItemsRoot: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.ArchiveRecoverableItemsDeletions: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.ArchiveRecoverableItemsVersions: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.ArchiveRecoverableItemsPurges: ExchangeVersion.Exchange2010_SP1,
           WellKnownFolderName.ArchiveRecoverableItemsDiscoveryHolds: ExchangeVersion.Exchange2013_SP1,
           WellKnownFolderName.SyncIssues: ExchangeVersion.Exchange2013,
           WellKnownFolderName.Conflicts: ExchangeVersion.Exchange2013,
           WellKnownFolderName.LocalFailures: ExchangeVersion.Exchange2013,
           WellKnownFolderName.ServerFailures: ExchangeVersion.Exchange2013,
           WellKnownFolderName.RecipientCache: ExchangeVersion.Exchange2013,
           WellKnownFolderName.QuickContacts: ExchangeVersion.Exchange2013,
           WellKnownFolderName.ConversationHistory: ExchangeVersion.Exchange2013,
           WellKnownFolderName.AdminAuditLogs: ExchangeVersion.Exchange2013,
           WellKnownFolderName.ToDoSearch: ExchangeVersion.Exchange2013,
           WellKnownFolderName.MyContacts: ExchangeVersion.Exchange2013,
           WellKnownFolderName.Directory: ExchangeVersion.Exchange2013_SP1,
           WellKnownFolderName.IMContactList: ExchangeVersion.Exchange2013,
           WellKnownFolderName.PeopleConnect: ExchangeVersion.Exchange2013,
           WellKnownFolderName.Favorites: ExchangeVersion.Exchange2013,
         },
         ConversationQueryTraversal: {
           ConversationQueryTraversal.Shallow: ExchangeVersion.Exchange2013,
           ConversationQueryTraversal.Deep: ExchangeVersion.Exchange2013,
         }
       });


//        private static LazyMember<string> buildVersion = new LazyMember<string>(
//            delegate()
//            {
//                try
//                {
//                    FileVersionInfo fileInfo = FileVersionInfo.GetVersionInfo(Assembly.GetExecutingAssembly().Location);
//                    return fileInfo.FileVersion;
//                }
//                catch
//                {
//                    // OM:2026839 When run in an environment with partial trust, fetching the build version blows up.
//                    // Just return a hardcoded value on failure.
//                    return "0.0";
//                }
//            });
//
//        /// <summary>
//        /// Dictionary of enum type to ExchangeVersion maps.
//        /// </summary>
//        private static LazyMember<Dictionary<Type, Dictionary<Enum, ExchangeVersion>>> enumVersionDictionaries = new LazyMember<Dictionary<Type, Dictionary<Enum, ExchangeVersion>>>(
//            () => new Dictionary<Type, Dictionary<Enum, ExchangeVersion>>()
//            {
//                { typeof(WellKnownFolderName), BuildEnumDict(typeof(WellKnownFolderName)) },
//                { typeof(ItemTraversal), BuildEnumDict(typeof(ItemTraversal)) },
//                { typeof(ConversationQueryTraversal), BuildEnumDict(typeof(ConversationQueryTraversal)) },
//                { typeof(FileAsMapping), BuildEnumDict(typeof(FileAsMapping)) },
//                { typeof(EventType), BuildEnumDict(typeof(EventType)) },
//                { typeof(MeetingRequestsDeliveryScope), BuildEnumDict(typeof(MeetingRequestsDeliveryScope)) },
//                { typeof(ViewFilter), BuildEnumDict(typeof(ViewFilter)) },
//            });
//
//        /// <summary>
//        /// Dictionary of enum type to schema-name-to-enum-value maps.
//        /// </summary>
//        private static LazyMember<Dictionary<Type, Dictionary<string, Enum>>> schemaToEnumDictionaries = new LazyMember<Dictionary<Type, Dictionary<string, Enum>>>(
//            () => new Dictionary<Type, Dictionary<string, Enum>>
//            {
//                { typeof(EventType), BuildSchemaToEnumDict(typeof(EventType)) },
//                { typeof(MailboxType), BuildSchemaToEnumDict(typeof(MailboxType)) },
//                { typeof(FileAsMapping), BuildSchemaToEnumDict(typeof(FileAsMapping)) },
//                { typeof(RuleProperty), BuildSchemaToEnumDict(typeof(RuleProperty)) },
//                { typeof(WellKnownFolderName), BuildSchemaToEnumDict(typeof(WellKnownFolderName)) },
//            });
//
//        /// <summary>
//        /// Dictionary of enum type to enum-value-to-schema-name maps.
//        /// </summary>
//        private static LazyMember<Dictionary<Type, Dictionary<Enum, string>>> enumToSchemaDictionaries = new LazyMember<Dictionary<Type, Dictionary<Enum, string>>>(
//            () => new Dictionary<Type, Dictionary<Enum, string>>
//            {
//                { typeof(EventType), BuildEnumToSchemaDict(typeof(EventType)) },
//                { typeof(MailboxType), BuildEnumToSchemaDict(typeof(MailboxType)) },
//                { typeof(FileAsMapping), BuildEnumToSchemaDict(typeof(FileAsMapping)) },
//                { typeof(RuleProperty), BuildEnumToSchemaDict(typeof(RuleProperty)) },
//                { typeof(WellKnownFolderName), BuildEnumToSchemaDict(typeof(WellKnownFolderName)) },
//            });
//
//        /// <summary>
//        /// Dictionary to map from special CLR type names to their "short" names.
//        /// </summary>
//        private static LazyMember<Dictionary<string, string>> typeNameToShortNameMap = new LazyMember<Dictionary<string, string>>(
//            () => new Dictionary<string, string>
//            {
//                { "Boolean", "bool" },
//                { "Int16", "short" },
//                { "Int32", "int" },
//                { "String", "string" }
//            });
//        #endregion
//
//        #region Constants
//
//        internal const string XSFalse = "false";
//        internal const string XSTrue = "true";
//
      static const String EwsTypesNamespacePrefix = "t";
    static const String EwsMessagesNamespacePrefix = "m";
      static const String EwsErrorsNamespacePrefix = "e";
      static const String EwsSoapNamespacePrefix = "soap";
      static const String EwsXmlSchemaInstanceNamespacePrefix = "xsi";
      static const String PassportSoapFaultNamespacePrefix = "psf";
      static const String WSTrustFebruary2005NamespacePrefix = "wst";
      static const String WSAddressingNamespacePrefix = "wsa";
      static const String AutodiscoverSoapNamespacePrefix = "a";
      static const String WSSecurityUtilityNamespacePrefix = "wsu";
      static const String WSSecuritySecExtNamespacePrefix = "wsse";

      static const String EwsTypesNamespace = "http://schemas.microsoft.com/exchange/services/2006/types";
      static const String EwsMessagesNamespace = "http://schemas.microsoft.com/exchange/services/2006/messages";
      static const String EwsErrorsNamespace = "http://schemas.microsoft.com/exchange/services/2006/errors";
      static const String EwsSoapNamespace = "http://schemas.xmlsoap.org/soap/envelope/";
      static const String EwsSoap12Namespace = "http://www.w3.org/2003/05/soap-envelope";
      static const String EwsXmlSchemaInstanceNamespace = "http://www.w3.org/2001/XMLSchema-instance";
      static const String PassportSoapFaultNamespace = "http://schemas.microsoft.com/Passport/SoapServices/SOAPFault";
      static const String WSTrustFebruary2005Namespace = "http://schemas.xmlsoap.org/ws/2005/02/trust";
      static const String WSAddressingNamespace = "http://www.w3.org/2005/08/addressing"; // "http://schemas.xmlsoap.org/ws/2004/08/addressing";
      static const String AutodiscoverSoapNamespace = "http://schemas.microsoft.com/exchange/2010/Autodiscover";
      static const String WSSecurityUtilityNamespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
      static const String WSSecuritySecExtNamespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
//
//        /// <summary>
//        /// Regular expression for legal domain names.
//        /// </summary>
//        internal const string DomainRegex = "^[-a-zA-Z0-9_.]+$";
//        #endregion
//
//        /// <summary>
//        /// Asserts that the specified condition if true.
//        /// </summary>
//        /// <param name="condition">Assertion.</param>
//        /// <param name="caller">The caller.</param>
//        /// <param name="message">The message to use if assertion fails.</param>
//        static void Assert(
//            bool condition,
//            String caller,
//            String message)
//        {
//            Debug.Assert(
//                condition,
//                string.Format("[{0}] {1}", caller, message));
//        }

        /// <summary>
        /// Gets the namespace prefix from an XmlNamespace enum value.
        /// </summary>
        /// <param name="xmlNamespace">The XML namespace.</param>
        /// <returns>Namespace prefix string.</returns>
        static String GetNamespacePrefix(XmlNamespace xmlNamespace)
        {
            switch (xmlNamespace)
            {
                case XmlNamespace.Types:
                    return EwsTypesNamespacePrefix;
                case XmlNamespace.Messages:
                    return EwsMessagesNamespacePrefix;
                case XmlNamespace.Errors:
                    return EwsErrorsNamespacePrefix;
                case XmlNamespace.Soap:
                case XmlNamespace.Soap12:
                    return EwsSoapNamespacePrefix;
                case XmlNamespace.XmlSchemaInstance:
                    return EwsXmlSchemaInstanceNamespacePrefix;
                case XmlNamespace.PassportSoapFault:
                    return PassportSoapFaultNamespacePrefix;
                case XmlNamespace.WSTrustFebruary2005:
                    return WSTrustFebruary2005NamespacePrefix;
                case XmlNamespace.WSAddressing:
                    return WSAddressingNamespacePrefix;
                case XmlNamespace.Autodiscover:
                    return AutodiscoverSoapNamespacePrefix;
                default:
                    return "";
            }
        }

        /// <summary>
        /// Gets the namespace URI from an XmlNamespace enum value.
        /// </summary>
        /// <param name="xmlNamespace">The XML namespace.</param>
        /// <returns>Uri as string</returns>
        static String GetNamespaceUri(XmlNamespace xmlNamespace)
        {
            switch (xmlNamespace)
            {
                case XmlNamespace.Types:
                    return EwsTypesNamespace;
                case XmlNamespace.Messages:
                    return EwsMessagesNamespace;
                case XmlNamespace.Errors:
                    return EwsErrorsNamespace;
                case XmlNamespace.Soap:
                    return EwsSoapNamespace;
                case XmlNamespace.Soap12:
                    return EwsSoap12Namespace;
                case XmlNamespace.XmlSchemaInstance:
                    return EwsXmlSchemaInstanceNamespace;
                case XmlNamespace.PassportSoapFault:
                    return PassportSoapFaultNamespace;
                case XmlNamespace.WSTrustFebruary2005:
                    return WSTrustFebruary2005Namespace;
                case XmlNamespace.WSAddressing:
                    return WSAddressingNamespace;
                case XmlNamespace.Autodiscover:
                    return AutodiscoverSoapNamespace;
                default:
                    return "";
            }
        }

//        /// <summary>
//        /// Gets the XmlNamespace enum value from a namespace Uri.
//        /// </summary>
//        /// <param name="namespaceUri">XML namespace Uri.</param>
//        /// <returns>XmlNamespace enum value.</returns>
//        internal static XmlNamespace GetNamespaceFromUri(string namespaceUri)
//        {
//            switch (namespaceUri)
//            {
//                case EwsErrorsNamespace:
//                    return XmlNamespace.Errors;
//                case EwsTypesNamespace:
//                    return XmlNamespace.Types;
//                case EwsMessagesNamespace:
//                    return XmlNamespace.Messages;
//                case EwsSoapNamespace:
//                    return XmlNamespace.Soap;
//                case EwsSoap12Namespace:
//                    return XmlNamespace.Soap12;
//                case EwsXmlSchemaInstanceNamespace:
//                    return XmlNamespace.XmlSchemaInstance;
//                case PassportSoapFaultNamespace:
//                    return XmlNamespace.PassportSoapFault;
//                case WSTrustFebruary2005Namespace:
//                    return XmlNamespace.WSTrustFebruary2005;
//                case WSAddressingNamespace:
//                    return XmlNamespace.WSAddressing;
//                default:
//                    return XmlNamespace.NotSpecified;
//            }
//        }
//
//        /// <summary>
//        /// Creates EWS object based on XML element name.
//        /// </summary>
//        /// <typeparam name="TServiceObject">The type of the service object.</typeparam>
//        /// <param name="service">The service.</param>
//        /// <param name="xmlElementName">Name of the XML element.</param>
//        /// <returns>Service object.</returns>
//        internal static TServiceObject CreateEwsObjectFromXmlElementName<TServiceObject>(ExchangeService service, string xmlElementName)
//            where TServiceObject : ServiceObject
//        {
//            Type itemClass;
//
//            if (EwsUtilities.serviceObjectInfo.Member.XmlElementNameToServiceObjectClassMap.TryGetValue(xmlElementName, out itemClass))
//            {
//                CreateServiceObjectWithServiceParam creationDelegate;
//
//                if (EwsUtilities.serviceObjectInfo.Member.ServiceObjectConstructorsWithServiceParam.TryGetValue(itemClass, out creationDelegate))
//                {
//                    return (TServiceObject)creationDelegate(service);
//                }
//                else
//                {
//                    throw new ArgumentError(Strings.NoAppropriateConstructorForItemClass);
//                }
//            }
//            else
//            {
//                return default(TServiceObject);
//            }
//        }
//
//        /// <summary>
//        /// Creates Item from Item class.
//        /// </summary>
//        /// <param name="itemAttachment">The item attachment.</param>
//        /// <param name="itemClass">The item class.</param>
//        /// <param name="isNew">If true, item attachment is new.</param>
//        /// <returns>New Item.</returns>
//        internal static Item CreateItemFromItemClass(
//            ItemAttachment itemAttachment,
//            Type itemClass,
//            bool isNew)
//        {
//            CreateServiceObjectWithAttachmentParam creationDelegate;
//
//            if (EwsUtilities.serviceObjectInfo.Member.ServiceObjectConstructorsWithAttachmentParam.TryGetValue(itemClass, out creationDelegate))
//            {
//                return (Item)creationDelegate(itemAttachment, isNew);
//            }
//            else
//            {
//                throw new ArgumentError(Strings.NoAppropriateConstructorForItemClass);
//            }
//        }
//
//        /// <summary>
//        /// Creates Item based on XML element name.
//        /// </summary>
//        /// <param name="itemAttachment">The item attachment.</param>
//        /// <param name="xmlElementName">Name of the XML element.</param>
//        /// <returns>New Item.</returns>
//        internal static Item CreateItemFromXmlElementName(ItemAttachment itemAttachment, string xmlElementName)
//        {
//            Type itemClass;
//
//            if (EwsUtilities.serviceObjectInfo.Member.XmlElementNameToServiceObjectClassMap.TryGetValue(xmlElementName, out itemClass))
//            {
//                return CreateItemFromItemClass(itemAttachment, itemClass, false);
//            }
//            else
//            {
//                return null;
//            }
//        }
//
//        /// <summary>
//        /// Gets the expected item type based on the local name.
//        /// </summary>
//        /// <param name="xmlElementName"></param>
//        /// <returns></returns>
//        internal static Type GetItemTypeFromXmlElementName(string xmlElementName)
//        {
//            Type itemClass = null;
//            EwsUtilities.serviceObjectInfo.Member.XmlElementNameToServiceObjectClassMap.TryGetValue(xmlElementName, out itemClass);
//            return itemClass;
//        }
//
//        /// <summary>
//        /// Finds the first item of type TItem (not a descendant type) in the specified collection.
//        /// </summary>
//        /// <typeparam name="TItem">The type of the item to find.</typeparam>
//        /// <param name="items">The collection.</param>
//        /// <returns>A TItem instance or null if no instance of TItem could be found.</returns>
//        internal static TItem FindFirstItemOfType<TItem>(Iterable<Item> items)
//            where TItem : Item
//        {
//            Type itemType = typeof(TItem);
//
//            for (Item item in items)
//            {
//                // We're looking for an exact class match here.
//                if (item.GetType() == itemType)
//                {
//                    return (TItem)item;
//                }
//            }
//
//            return null;
//        }
//
//        #region Tracing routines
//
//        /// <summary>
//        /// Write trace start element.
//        /// </summary>
//        /// <param name="writer">The writer to write the start element to.</param>
//        /// <param name="traceTag">The trace tag.</param>
//        /// <param name="includeVersion">If true, include build version attribute.</param>
//        [System.Diagnostics.CodeAnalysis.SuppressMessage("Exchange.Usage", "EX0009:DoNotUseDateTimeNowOrFromFileTime", Justification = "Client API")]
//        private static void WriteTraceStartElement(
//            XmlWriter writer,
//            string traceTag,
//            bool includeVersion)
//        {
//            writer.WriteStartElement("Trace");
//            writer.WriteAttributeString("Tag", traceTag);
//            writer.WriteAttributeString("Tid", Thread.CurrentThread.ManagedThreadId.ToString());
//            writer.WriteAttributeString("Time", DateTime.UtcNow.ToString("u", DateTimeFormatInfo.InvariantInfo));
//
//            if (includeVersion)
//            {
//                writer.WriteAttributeString("Version", EwsUtilities.BuildVersion);
//            }
//        }

        /// <summary>
        /// Format log message.
        /// </summary>
        /// <param name="entryKind">Kind of the entry.</param>
        /// <param name="logEntry">The log entry.</param>
        /// <returns>XML log entry as a string.</returns>
        static String FormatLogMessage(String entryKind, String logEntry)
        {
          //todo("correct FormatLogMessage");
          print("correct FormatLogMessage");

          return "$entryKind => $logEntry";
//            StringBuffer sb = new StringBuffer();
//            using (StringWriter writer = new StringWriter(sb))
//            {
//                using (XmlTextWriter xmlWriter = new XmlTextWriter(writer))
//                {
//                    xmlWriter.Formatting = Formatting.Indented;
//
//                    EwsUtilities.WriteTraceStartElement(xmlWriter, entryKind, false);
//
//                    xmlWriter.WriteWhitespace(Environment.NewLine);
//                    xmlWriter.WriteValue(logEntry);
//                    xmlWriter.WriteWhitespace(Environment.NewLine);
//
//                    xmlWriter.WriteEndElement(); // Trace
//                    xmlWriter.WriteWhitespace(Environment.NewLine);
//                }
//            }
//            return sb.ToString();
        }
//
//        /// <summary>
//        /// Format the HTTP headers.
//        /// </summary>
//        /// <param name="sb">StringBuilder.</param>
//        /// <param name="headers">The HTTP headers.</param>
//        private static void FormatHttpHeaders(StringBuilder sb, WebHeaderCollection headers)
//        {
//            for (string key in headers.Keys)
//            {
//                sb.Append(
//                    string.Format(
//                        "{0}: {1}\n",
//                        key,
//                        headers[key]));
//            }
//        }

        /// <summary>
        /// Format request HTTP headers.
        /// </summary>
        /// <param name="request">The HTTP request.</param>
        static String FormatHttpRequestHeaders(IEwsHttpWebRequest request)
        {
           StringBuffer sb = new StringBuffer();
            sb.write("${request.Method} ${request.RequestUri.path} HTTP/1.1\n");
            EwsUtilities.FormatHttpHeadersWithBuffer(sb, request.Headers);
            sb.write("\n");

            return sb.toString();
        }
//
//        /// <summary>
//        /// Format response HTTP headers.
//        /// </summary>
//        /// <param name="response">The HTTP response.</param>
//        internal static string FormatHttpResponseHeaders(IEwsHttpWebResponse response)
//        {
//            StringBuilder sb = new StringBuilder();
//            sb.Append(
//                string.Format(
//                    "HTTP/{0} {1} {2}\n",
//                    response.ProtocolVersion,
//                    (int)response.StatusCode,
//                    response.StatusDescription));
//
//            sb.Append(EwsUtilities.FormatHttpHeaders(response.Headers));
//            sb.Append("\n");
//            return sb.ToString();
//        }
//
//        /// <summary>
//        /// Format request HTTP headers.
//        /// </summary>
//        /// <param name="request">The HTTP request.</param>
//        internal static string FormatHttpRequestHeaders(HttpWebRequest request)
//        {
//            StringBuilder sb = new StringBuilder();
//            sb.Append(
//                string.Format(
//                    "{0} {1} HTTP/{2}\n",
//                    request.Method.ToUpperInvariant(),
//                    request.RequestUri.AbsolutePath,
//                    request.ProtocolVersion));
//
//            sb.Append(EwsUtilities.FormatHttpHeaders(request.Headers));
//            sb.Append("\n");
//            return sb.ToString();
//        }
//
        /// <summary>
        /// Formats HTTP headers.
        /// </summary>
        /// <param name="headers">The headers.</param>
        /// <returns>Headers as a string</returns>
        static String FormatHttpHeaders(WebHeaderCollection headers)
        {
            StringBuffer sb = new StringBuffer();
            for (String key in headers.AllKeys)
            {
                sb.write(
                        "$key: ${headers[key]}\n");
            }
            return sb.toString();
        }

        /// <summary>
        /// Format XML content in a MemoryStream for message.
        /// </summary>
        /// <param name="entryKind">Kind of the entry.</param>
        /// <param name="memoryStream">The memory stream.</param>
        /// <returns>XML log entry as a string.</returns>
        static String FormatLogMessageWithXmlContent(String entryKind, MemoryStream memoryStream)
        {
          // todo("improve FormatLogMessageWithXmlContent")
          print(".. improve FormatLogMessageWithXmlContent");
          return utf8.decode(memoryStream.AllElements);
//            StringBuffer sb = new StringBuffer();
//            XmlReaderSettings settings = new XmlReaderSettings();
//            settings.ConformanceLevel = ConformanceLevel.Fragment;
//            settings.IgnoreComments = true;
//            settings.IgnoreWhitespace = true;
//            settings.CloseInput = false;
//
//            // Remember the current location in the MemoryStream.
//            long lastPosition = memoryStream.Position;
//
//            // Rewind the position since we want to format the entire contents.
//            memoryStream.Position = 0;
//
//            try
//            {
//                using (XmlReader reader = XmlReader.Create(memoryStream, settings))
//                {
//                    using (StringWriter writer = new StringWriter(sb))
//                    {
//                        using (XmlTextWriter xmlWriter = new XmlTextWriter(writer))
//                        {
//                            xmlWriter.Formatting = Formatting.Indented;
//
//                            EwsUtilities.WriteTraceStartElement(xmlWriter, entryKind, true);
//
//                            while (!reader.EOF)
//                            {
//                                xmlWriter.WriteNode(reader, true);
//                            }
//
//                            xmlWriter.WriteEndElement(); // Trace
//                            xmlWriter.WriteWhitespace(Environment.NewLine);
//                        }
//                    }
//                }
//            }
//            catch (XmlException)
//            {
//                // We tried to format the content as "pretty" XML. Apparently the content is
//                // not well-formed XML or isn't XML at all. Fallback and treat it as plain text.
//                sb.Length = 0;
//                memoryStream.Position = 0;
//                sb.Append(Encoding.UTF8.GetString(memoryStream.GetBuffer(), 0, (int)memoryStream.Length));
//            }
//
//            // Restore Position in the stream.
//            memoryStream.Position = lastPosition;
//
//            return sb.ToString();
        }
//
//        #endregion
//
//        #region Stream routines
//
        /// <summary>
        /// Copies source stream to target.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <param name="target">The target.</param>
        static Future<void> CopyStream(Stream<List<int>> source, StreamConsumer<List<int>> target) async
        {
          await source.pipe(target);
//            // See if this is a MemoryStream -- we can use WriteTo.
//            MemoryStream memContentStream = source as MemoryStream;
//            if (memContentStream != null)
//            {
//                memContentStream.WriteTo(target);
//            }
//            else
//            {
//                // Otherwise, copy data through a buffer
//                Uint8List buffer = new byte[4096];
//                int bufferSize = buffer.Length;
//                int bytesRead = source.Read(buffer, 0, bufferSize);
//                while (bytesRead > 0)
//                {
//                    target.Write(buffer, 0, bytesRead);
//                    bytesRead = source.Read(buffer, 0, bufferSize);
//                }
//            }
        }
//
//        #endregion
//
//        /// <summary>
//        /// Gets the build version.
//        /// </summary>
//        /// <value>The build version.</value>
//        internal static string BuildVersion
//        {
//            get { return EwsUtilities.buildVersion.Member; }
//        }
//
//        #region Conversion routines
//
//        /// <summary>
//        /// Convert bool to XML Schema bool.
//        /// </summary>
//        /// <param name="value">Bool value.</param>
//        /// <returns>String representing bool value in XML Schema.</returns>
//        internal static string BoolToXSBool(bool value)
//        {
//            return value ? EwsUtilities.XSTrue : EwsUtilities.XSFalse;
//        }
//
//        /// <summary>
//        /// Parses an enum value list.
//        /// </summary>
//        /// <typeparam name="T">Type of value.</typeparam>
//        /// <param name="list">The list.</param>
//        /// <param name="value">The value.</param>
//        /// <param name="separators">The separators.</param>
//        internal static void ParseEnumValueList<T>(
//            IList<T> list,
//            string value,
//            params char[] separators)
//            where T : struct
//        {
//            EwsUtilities.Assert(
//                typeof(T).IsEnum,
//                "EwsUtilities.ParseEnumValueList",
//                "T is not an enum type.");
//
//            if (StringUtils.IsNullOrEmpty(value))
//            {
//                return;
//            }
//
//            string[] enumValues = value.Split(separators);
//
//            for (string enumValue in enumValues)
//            {
//                list.Add((T)Enum.Parse(typeof(T), enumValue, false));
//            }
//        }
//
//        /// <summary>
//        /// Converts an enum to a string, using the mapping dictionaries if appropriate.
//        /// </summary>
//        /// <param name="value">The enum value to be serialized</param>
//        /// <returns>String representation of enum to be used in the protocol</returns>
//        internal static string SerializeEnum(Enum value)
//        {
//            Dictionary<Enum, string> enumToStringDict;
//            string strValue;
//            if (enumToSchemaDictionaries.Member.TryGetValue(value.GetType(), out enumToStringDict) &&
//                enumToStringDict.TryGetValue(value, out strValue))
//            {
//                return strValue;
//            }
//            else
//            {
//                return value.ToString();
//            }
//        }
//

      static Map<Type, Converter<String, Object>> possibleEnumsConverter = {
          ServiceResult: (stringValue) => EnumToString.fromString(ServiceResult.values, stringValue),
          ServiceError: (stringValue) => EnumToString.fromString(ServiceError.values, stringValue),
          MapiPropertyType: (stringValue) => EnumToString.fromString(MapiPropertyType.values, stringValue),
          Sensitivity: (stringValue) => EnumToString.fromString(Sensitivity.values, stringValue),
          Importance: (stringValue) => EnumToString.fromString(Importance.values, stringValue),
          ItemFlagStatus: (stringValue) => EnumToString.fromString(ItemFlagStatus.values, stringValue),
          MeetingResponseType: (stringValue) => EnumToString.fromString(MeetingResponseType.values, stringValue),
          AppointmentType: (stringValue) => EnumToString.fromString(AppointmentType.values, stringValue),
          MailboxType: (stringValue) => EnumToString.fromString(MailboxType.values, stringValue),
          TaskStatus: (stringValue) => EnumToString.fromString(TaskStatus.values, stringValue),
          BodyType: (stringValue) => EnumToString.fromString(BodyType.values, stringValue),
          StandardUser: (stringValue) => EnumToString.fromString(StandardUser.values, stringValue),
          PermissionScope: (stringValue) => EnumToString.fromString(PermissionScope.values, stringValue),
          FolderPermissionReadAccess: (stringValue) => EnumToString.fromString(FolderPermissionReadAccess.values, stringValue),
          FolderPermissionLevel: (stringValue) => EnumToString.fromString(FolderPermissionLevel.values, stringValue),
          EmailAddressKey: (stringValue) => EnumToString.fromString(EmailAddressKey.values, stringValue),
          PhoneNumberKey: (stringValue) => EnumToString.fromString(PhoneNumberKey.values, stringValue),
          PhysicalAddressKey: (stringValue) => EnumToString.fromString(PhysicalAddressKey.values, stringValue),
          AutodiscoverErrorCode: (stringValue) => EnumToString.fromString(AutodiscoverErrorCode.values, stringValue),
          UserSettingName: (stringValue) => EnumToString.fromString(UserSettingName.values, stringValue),
      };

        static const Map<Type, Map<Object, String>> ewsEnumDictionaries = {
          EventType: {
            EventType.Status: "StatusEvent",
            EventType.NewMail: "NewMailEvent",
            EventType.Deleted: "DeletedEvent",
            EventType.Modified: "ModifiedEvent",
            EventType.Moved: "MovedEvent",
            EventType.Copied: "CopiedEvent",
            EventType.Created: "CreatedEvent",
            EventType.FreeBusyChanged: "FreeBusyChangedEvent",
          }
        };

      static final serializedEnumDictionaries = [
        FolderTraversal,
        OffsetBasePoint,
        DefaultExtendedPropertySet,
        MapiPropertyType,
        SyncFolderItemsScope,
        ItemTraversal,
        MessageDisposition,
        BodyType,
        TaskStatus,
        DeleteMode,
        AffectedTaskOccurrence,
        ConflictResolutionMode,
        FolderPermissionLevel,
        SendInvitationsMode,
        SendCancellationsMode,
        ContainmentMode,
        ComparisonMode,
        EmailAddressKey,
        PhoneNumberKey,
        PhysicalAddressKey,
        UserSettingName,
        ExchangeVersion
      ];


        /// <summary>
        /// Parses specified value based on type.
        /// </summary>
        /// <typeparam name="T">Type of value.</typeparam>
        /// <param name="value">The value.</param>
        /// <returns>Value of type T.</returns>
        static T Parse<T>(String value)
        {
          if (possibleEnumsConverter.containsKey(T)) {
            return possibleEnumsConverter[T](value) as T;
          } else if (T == int) {
            return int.parse(value) as T;
          } else if (T == double) {
            return double.parse(value) as T;
          } else if (T == String) {
            return value as T;
          } else if (T == bool) {
            return (value.toLowerCase() == "true") as T;
          } else {
            throw NotImplementedException("Parse<$T>($value)");
          }
//          //todo("implement Parse<T>")
//          print("implement Parse<T where ${T.runtimeType}>");
//            if (typeof(T).IsEnum)
//            {
//                Dictionary<string, Enum> stringToEnumDict;
//                Enum enumValue;
//                if (schemaToEnumDictionaries.Member.TryGetValue(typeof(T), out stringToEnumDict) &&
//                    stringToEnumDict.TryGetValue(value, out enumValue))
//                {
//                    // This double-casting is ugly, but necessary. By this point, we know that T is an Enum
//                    // (same as returned by the dictionary), but the compiler can't prove it. Thus, the
//                    // up-cast before we can down-cast.
//                    return (T)((object)enumValue);
//                }
//                else
//                {
//                    return (T)Enum.Parse(typeof(T), value, false);
//                }
//            }
//            else
//            {
//                return (T)Convert.ChangeType(value, typeof(T), CultureInfo.InvariantCulture);
//            }
        }

//        /// <summary>
//        /// Tries to parses the specified value to the specified type.
//        /// </summary>
//        /// <typeparam name="T">The type into which to cast the provided value.</typeparam>
//        /// <param name="value">The value to parse.</param>
//        /// <param name="result">The value cast to the specified type, if TryParse succeeds. Otherwise, the value of result is indeterminate.</param>
//        /// <returns>True if value could be parsed; otherwise, false.</returns>
//        internal static bool TryParse<T>(string value, out T result)
//        {
//            try
//            {
//                result = EwsUtilities.Parse<T>(value);
//
//                return true;
//            }
//            //// Catch all exceptions here, we're not interested in the reason why TryParse failed.
//            catch (Exception)
//            {
//                result = default(T);
//
//                return false;
//            }
//        }
//
//        /// <summary>
//        /// Converts the specified date and time from one time zone to another.
//        /// </summary>
//        /// <param name="dateTime">The date time to convert.</param>
//        /// <param name="sourceTimeZone">The source time zone.</param>
//        /// <param name="destinationTimeZone">The destination time zone.</param>
//        /// <returns>A DateTime that holds the converted</returns>
//        internal static DateTime ConvertTime(
//            DateTime dateTime,
//            TimeZoneInfo sourceTimeZone,
//            TimeZoneInfo destinationTimeZone)
//        {
//            try
//            {
//                return TimeZoneInfo.ConvertTime(
//                    dateTime,
//                    sourceTimeZone,
//                    destinationTimeZone);
//            }
//            catch (ArgumentError e)
//            {
//                throw new TimeZoneConversionException(
//                    string.Format(
//                        Strings.CannotConvertBetweenTimeZones,
//                        EwsUtilities.DateTimeToXSDateTime(dateTime),
//                        sourceTimeZone.DisplayName,
//                        destinationTimeZone.DisplayName),
//                    e);
//            }
//        }
//
//        /// <summary>
//        /// Reads the string as date time, assuming it is unbiased (e.g. 2009/01/01T08:00)
//        /// and scoped to service's time zone.
//        /// </summary>
//        /// <param name="dateString">The date string.</param>
//        /// <param name="service">The service.</param>
//        /// <returns>The string's value as a DateTime object.</returns>
//        internal static DateTime ParseAsUnbiasedDatetimescopedToServicetimeZone(string dateString, ExchangeService service)
//        {
//            // Convert the element's value to a DateTime with no adjustment.
//            DateTime tempDate = DateTime.Parse(dateString, CultureInfo.InvariantCulture);
//
//            // Set the kind according to the service's time zone
//            if (service.TimeZone == TimeZoneInfo.Utc)
//            {
//                return new DateTime(tempDate.Ticks, DateTimeKind.Utc);
//            }
//            else if (EwsUtilities.IsLocalTimeZone(service.TimeZone))
//            {
//                return new DateTime(tempDate.Ticks, DateTimeKind.Local);
//            }
//            else
//            {
//                return new DateTime(tempDate.Ticks, DateTimeKind.Unspecified);
//            }
//        }
//
//        /// <summary>
//        /// Determines whether the specified time zone is the same as the system's local time zone.
//        /// </summary>
//        /// <param name="timeZone">The time zone to check.</param>
//        /// <returns>
//        ///     <c>true</c> if the specified time zone is the same as the system's local time zone; otherwise, <c>false</c>.
//        /// </returns>
//        internal static bool IsLocalTimeZone(TimeZoneInfo timeZone)
//        {
//            return (TimeZoneInfo.Local == timeZone) || (TimeZoneInfo.Local.Id == timeZone.Id && TimeZoneInfo.Local.HasSameRules(timeZone));
//        }
//
//        /// <summary>
//        /// Convert DateTime to XML Schema date.
//        /// </summary>
//        /// <param name="date">The date to be converted.</param>
//        /// <returns>String representation of DateTime.</returns>
//        internal static string DateTimeToXSDate(DateTime date)
//        {
//            // Depending on the current culture, DateTime formatter will
//            // translate dates from one culture to another (e.g. Gregorian to Lunar).  The server
//            // however, considers all dates to be in Gregorian, so using the InvariantCulture will
//            // ensure this.
//            string format;
//
//            switch (date.Kind)
//            {
//                case DateTimeKind.Utc:
//                    format = "yyyy-MM-ddZ";
//                    break;
//                case DateTimeKind.Unspecified:
//                    format = "yyyy-MM-dd";
//                    break;
//                default: // DateTimeKind.Local is remaining
//                    format = "yyyy-MM-ddzzz";
//                    break;
//            }
//
//            return date.ToString(format, CultureInfo.InvariantCulture);
//        }
//
//        /// <summary>
//        /// Dates the DateTime into an XML schema date time.
//        /// </summary>
//        /// <param name="dateTime">The date time.</param>
//        /// <returns>String representation of DateTime.</returns>
//        internal static string DateTimeToXSDateTime(DateTime dateTime)
//        {
//            string format = "yyyy-MM-ddTHH:mm:ss.fff";
//
//            switch (dateTime.Kind)
//            {
//                case DateTimeKind.Utc:
//                    format += "Z";
//                    break;
//                case DateTimeKind.Local:
//                    format += "zzz";
//                    break;
//                default:
//                    break;
//            }
//
//            // Depending on the current culture, DateTime formatter will replace ':' with
//            // the DateTimeFormatInfo.TimeSeparator property which may not be ':'. Force the proper string
//            // to be used by using the InvariantCulture.
//            return dateTime.ToString(format, CultureInfo.InvariantCulture);
//        }
//
//        /// <summary>
//        /// Convert EWS DayOfTheWeek enum to System.DayOfWeek.
//        /// </summary>
//        /// <param name="dayOfTheWeek">The day of the week.</param>
//        /// <returns>System.DayOfWeek value.</returns>
//        internal static DayOfWeek EwsToSystemDayOfWeek(DayOfTheWeek dayOfTheWeek)
//        {
//            if (dayOfTheWeek == DayOfTheWeek.Day ||
//                dayOfTheWeek == DayOfTheWeek.Weekday ||
//                dayOfTheWeek == DayOfTheWeek.WeekendDay)
//            {
//                throw new ArgumentError(
//                    string.Format("Cannot convert {0} to System.DayOfWeek enum value", dayOfTheWeek),
//                    "dayOfTheWeek");
//            }
//            else
//            {
//                return (DayOfWeek)dayOfTheWeek;
//            }
//        }
//
//        /// <summary>
//        /// Convert System.DayOfWeek type to EWS DayOfTheWeek.
//        /// </summary>
//        /// <param name="dayOfWeek">The dayOfWeek.</param>
//        /// <returns>EWS DayOfWeek value</returns>
//        internal static DayOfTheWeek SystemToEwsDayOfTheWeek(DayOfWeek dayOfWeek)
//        {
//            return (DayOfTheWeek)dayOfWeek;
//        }
//
//        /// <summary>
//        /// Takes a System.TimeSpan structure and converts it into an
//        /// xs:duration string as defined by the W3 Consortiums Recommendation
//        /// "XML Schema Part 2: Datatypes Second Edition",
//        /// http://www.w3.org/TR/xmlschema-2/#duration
//        /// </summary>
//        /// <param name="timeSpan">TimeSpan structure to convert</param>
//        /// <returns>xs:duration formatted string</returns>
//        internal static string TimeSpanToXSDuration(TimeSpan timeSpan)
//        {
//            // Optional '-' offset
//            string offsetStr = (timeSpan.TotalSeconds < 0) ? "-" : "";
//
//            // The TimeSpan structure does not have a Year or Month
//            // property, therefore we wouldn't be able to return an xs:duration
//            // string from a TimeSpan that included the nY or nM components.
//            return String.Format(
//                "{0}P{1}DT{2}H{3}M{4}S",
//                offsetStr,
//                Math.Abs(timeSpan.Days),
//                Math.Abs(timeSpan.Hours),
//                Math.Abs(timeSpan.Minutes),
//                Math.Abs(timeSpan.Seconds) + "." + Math.Abs(timeSpan.Milliseconds));
//        }
//
//        /// <summary>
//        /// Takes an xs:duration string as defined by the W3 Consortiums
//        /// Recommendation "XML Schema Part 2: Datatypes Second Edition",
//        /// http://www.w3.org/TR/xmlschema-2/#duration, and converts it
//        /// into a System.TimeSpan structure
//        /// </summary>
//        /// <remarks>
//        /// This method uses the following approximations:
//        ///     1 year = 365 days
//        ///     1 month = 30 days
//        /// Additionally, it only allows for four decimal points of
//        /// seconds precision.
//        /// </remarks>
//        /// <param name="xsDuration">xs:duration string to convert</param>
//        /// <returns>System.TimeSpan structure</returns>
//        internal static TimeSpan XSDurationToTimeSpan(string xsDuration)
//        {
//            Regex timeSpanParser = new Regex(
//                "(?<pos>-)?" +
//                "P" +
//                "((?<year>[0-9]+)Y)?" +
//                "((?<month>[0-9]+)M)?" +
//                "((?<day>[0-9]+)D)?" +
//                "(T" +
//                "((?<hour>[0-9]+)H)?" +
//                "((?<minute>[0-9]+)M)?" +
//                "((?<seconds>[0-9]+)(\\.(?<precision>[0-9]+))?S)?)?");
//
//            Match m = timeSpanParser.Match(xsDuration);
//            if (!m.Success)
//            {
//                throw new ArgumentError(Strings.XsDurationCouldNotBeParsed);
//            }
//            string token = m.Result("${pos}");
//            bool negative = false;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                negative = true;
//            }
//
//            // Year
//            token = m.Result("${year}");
//            int year = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                year = Int32.Parse(token);
//            }
//
//            // Month
//            token = m.Result("${month}");
//            int month = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                month = Int32.Parse(token);
//            }
//
//            // Day
//            token = m.Result("${day}");
//            int day = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                day = Int32.Parse(token);
//            }
//
//            // Hour
//            token = m.Result("${hour}");
//            int hour = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                hour = Int32.Parse(token);
//            }
//
//            // Minute
//            token = m.Result("${minute}");
//            int minute = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                minute = Int32.Parse(token);
//            }
//
//            // Seconds
//            token = m.Result("${seconds}");
//            int seconds = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                seconds = Int32.Parse(token);
//            }
//
//            int milliseconds = 0;
//            token = m.Result("${precision}");
//
//            // Only allowed 4 digits of precision
//            if (token.Length > 4)
//            {
//                token = token.Substring(0, 4);
//            }
//
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                milliseconds = Int32.Parse(token);
//            }
//
//            // Apply conversions of year and months to days.
//            // Year = 365 days
//            // Month = 30 days
//            day = day + (year * 365) + (month * 30);
//            TimeSpan retval = new TimeSpan(day, hour, minute, seconds, milliseconds);
//
//            if (negative)
//            {
//                retval = -retval;
//            }
//
//            return retval;
//        }
//
//        /// <summary>
//        /// Converts the specified time span to its XSD representation.
//        /// </summary>
//        /// <param name="timeSpan">The time span.</param>
//        /// <returns>The XSD representation of the specified time span.</returns>
//        public static string TimeSpanToXSTime(TimeSpan timeSpan)
//        {
//            return string.Format(
//                "{0:00}:{1:00}:{2:00}",
//                timeSpan.Hours,
//                timeSpan.Minutes,
//                timeSpan.Seconds);
//        }
//
//        #endregion
//
//        #region Type Name utilities
//        /// <summary>
//        /// Gets the printable name of a CLR type.
//        /// </summary>
//        /// <param name="type">The type.</param>
//        /// <returns>Printable name.</returns>
//        public static string GetPrintableTypeName(Type type)
//        {
//            if (type.IsGenericType)
//            {
//                // Convert generic type to printable form (e.g. List<Item>)
//                string genericPrefix = type.Name.Substring(0, type.Name.IndexOf('`'));
//                StringBuilder nameBuilder = new StringBuilder(genericPrefix);
//
//                // Note: building array of generic parameters is done recursively. Each parameter could be any type.
//                string[] genericArgs = type.GetGenericArguments().ToList<Type>().ConvertAll<string>(t => GetPrintableTypeName(t)).ToArray<string>();
//
//                nameBuilder.Append("<");
//                nameBuilder.Append(string.Join(",", genericArgs));
//                nameBuilder.Append(">");
//                return nameBuilder.ToString();
//            }
//            else if (type.IsArray)
//            {
//                // Convert array type to printable form.
//                string arrayPrefix = type.Name.Substring(0, type.Name.IndexOf('['));
//                StringBuilder nameBuilder = new StringBuilder(EwsUtilities.GetSimplifiedTypeName(arrayPrefix));
//                for (int rank = 0; rank < type.GetArrayRank(); rank++)
//                {
//                    nameBuilder.Append("[]");
//                }
//                return nameBuilder.ToString();
//            }
//            else
//            {
//                return EwsUtilities.GetSimplifiedTypeName(type.Name);
//            }
//        }
//
//        /// <summary>
//        /// Gets the printable name of a simple CLR type.
//        /// </summary>
//        /// <param name="typeName">The type name.</param>
//        /// <returns>Printable name.</returns>
//        private static string GetSimplifiedTypeName(string typeName)
//        {
//            // If type has a shortname (e.g. int for Int32) map to the short name.
//            string name;
//            return typeNameToShortNameMap.Member.TryGetValue(typeName, out name) ? name : typeName;
//        }
//
//        #endregion
//
//        #region EmailAddress parsing
//
//        /// <summary>
//        /// Gets the domain name from an email address.
//        /// </summary>
//        /// <param name="emailAddress">The email address.</param>
//        /// <returns>Domain name.</returns>
//        internal static string DomainFromEmailAddress(string emailAddress)
//        {
//            string[] emailAddressParts = emailAddress.Split('@');
//
//            if (emailAddressParts.Length != 2 || StringUtils.IsNullOrEmpty(emailAddressParts[1]))
//            {
//                throw new FormatException(Strings.InvalidEmailAddress);
//            }
//
//            return emailAddressParts[1];
//        }
//
//        #endregion
//
//        #region Method parameters validation routines
//
        /// <summary>
        /// Validates parameter (and allows null value).
        /// </summary>
        /// <param name="param">The param.</param>
        /// <param name="paramName">Name of the param.</param>
        static void ValidateParamAllowNull(Object param, String paramName)
        {

            if (param is ISelfValidate)
            {
              try
                {
                  param.Validate();
                }
                on ServiceValidationException catch( e)
                {
                    throw new ArgumentError("""
                        Strings.ValidationFailed,
                        paramName,
                        e""");
                }
            }


            if (param is ServiceObject)
            {
              if (param.IsNew)
                {
                    throw new ArgumentError("Strings.ObjectDoesNotHaveId, paramName");
                }
            }
        }

//        /// <summary>
//        /// Validates parameter (null value not allowed).
//        /// </summary>
//        /// <param name="param">The param.</param>
//        /// <param name="paramName">Name of the param.</param>
//        internal static void ValidateParam(object param, string paramName)
//        {
//            bool isValid;
//
//            string strParam = param as string;
//            if (strParam != null)
//            {
//                isValid = !StringUtils.IsNullOrEmpty(strParam);
//            }
//            else
//            {
//                isValid = param != null;
//            }
//
//            if (!isValid)
//            {
//                throw new ArgumentNullException(paramName);
//            }
//
//            ValidateParamAllowNull(param, paramName);
//        }

        /// <summary>
        /// Validates parameter collection.
        /// </summary>
        /// <param name="collection">The collection.</param>
        /// <param name="paramName">Name of the param.</param>
        static void ValidateParamCollection(Iterable collection, String paramName)
        {
            ValidateParam(collection, paramName);

            int count = 0;

            for (Object obj in collection)
            {
                try
                {
                    ValidateParam(obj, "collection[$count]");
                }
                on ArgumentError catch (e)
                {
                    throw new ArgumentError("""
                        string.Format("The element at position {0} is invalid", count),
                        paramName,
                        e""");
                }

                count++;
            }

            if (count == 0)
            {
                throw new ArgumentError("Strings.CollectionIsEmpty, paramName");
            }
        }
//
//        /// <summary>
//        /// Validates string parameter to be non-empty string (null value allowed).
//        /// </summary>
//        /// <param name="param">The string parameter.</param>
//        /// <param name="paramName">Name of the parameter.</param>
//        internal static void ValidateNonBlankStringParamAllowNull(string param, string paramName)
//        {
//            if (param != null)
//            {
//                // Non-empty string has at least one character which is *not* a whitespace character
//                if (param.Length == param.CountMatchingChars((c) => Char.IsWhiteSpace(c)))
//                {
//                    throw new ArgumentError(Strings.ArgumentIsBlankString, paramName);
//                }
//            }
//        }
//
//        /// <summary>
//        /// Validates string parameter to be non-empty string (null value not allowed).
//        /// </summary>
//        /// <param name="param">The string parameter.</param>
//        /// <param name="paramName">Name of the parameter.</param>
//        internal static void ValidateNonBlankStringParam(string param, string paramName)
//        {
//            if (param == null)
//            {
//                throw new ArgumentNullException(paramName);
//            }
//
//            ValidateNonBlankStringParamAllowNull(param, paramName);
//        }
//
//        /// <summary>
//        /// Validates the enum value against the request version.
//        /// </summary>
//        /// <param name="enumValue">The enum value.</param>
//        /// <param name="requestVersion">The request version.</param>
//        /// <exception cref="ServiceVersionException">Raised if this enum value requires a later version of Exchange.</exception>
//        internal static void ValidateEnumVersionValue(Enum enumValue, ExchangeVersion requestVersion)
//        {
//            Type enumType = enumValue.GetType();
//            Dictionary<Enum, ExchangeVersion> enumVersionDict = enumVersionDictionaries.Member[enumType];
//            ExchangeVersion enumVersion = enumVersionDict[enumValue];
//            if (requestVersion < enumVersion)
//            {
//                throw new ServiceVersionException(
//                    string.Format(
//                                  Strings.EnumValueIncompatibleWithRequestVersion,
//                                  enumValue.ToString(),
//                                  enumType.Name,
//                                  enumVersion));
//            }
//        }

        /// <summary>
        /// Validates service object version against the request version.
        /// </summary>
        /// <param name="serviceObject">The service object.</param>
        /// <param name="requestVersion">The request version.</param>
        /// <exception cref="ServiceVersionException">Raised if this service object type requires a later version of Exchange.</exception>
        static void ValidateServiceObjectVersion(ServiceObject serviceObject, ExchangeVersion requestVersion)
        {
            ExchangeVersion minimumRequiredServerVersion = serviceObject.GetMinimumRequiredServerVersion();

            if (requestVersion.index < minimumRequiredServerVersion.index)
            {
                throw new ServiceVersionException(
                    """string.Format(
                    Strings.ObjectTypeIncompatibleWithRequestVersion,
                    serviceObject.GetType().Name,
                    minimumRequiredServerVersion)""");
            }
        }

//
//        /// <summary>
//        /// Validates class version against the request version.
//        /// </summary>
//        /// <param name="service">The Exchange service.</param>
//        /// <param name="minimumServerVersion">The minimum server version that supports the method.</param>
//        /// <param name="className">Name of the class.</param>
//        internal static void ValidateClassVersion(
//            ExchangeService service,
//            ExchangeVersion minimumServerVersion,
//            string className)
//        {
//            if (service.RequestedServerVersion < minimumServerVersion)
//            {
//                throw new ServiceVersionException(
//                    string.Format(
//                    Strings.ClassIncompatibleWithRequestVersion,
//                    className,
//                    minimumServerVersion));
//            }
//        }
//
//        /// <summary>
//        /// Validates domain name (null value allowed)
//        /// </summary>
//        /// <param name="domainName">Domain name.</param>
//        /// <param name="paramName">Parameter name.</param>
//        internal static void ValidateDomainNameAllowNull(string domainName, string paramName)
//        {
//            if (domainName != null)
//            {
//                Regex regex = new Regex(DomainRegex);
//
//                if (!regex.IsMatch(domainName))
//                {
//                    throw new ArgumentError(string.Format(Strings.InvalidDomainName, domainName), paramName);
//                }
//            }
//        }
//
//        /// <summary>
//        /// Gets version for enum member.
//        /// </summary>
//        /// <param name="enumType">Type of the enum.</param>
//        /// <param name="enumName">The enum name.</param>
//        /// <returns>Exchange version in which the enum value was first defined.</returns>
//        private static ExchangeVersion GetEnumVersion(Type enumType, string enumName)
//        {
//            MemberInfo[] memberInfo = enumType.GetMember(enumName);
//            EwsUtilities.Assert(
//                                (memberInfo != null) && (memberInfo.Length > 0),
//                                "EwsUtilities.GetEnumVersion",
//                                "Enum member " + enumName + " not found in " + enumType);
//
//            object[] attrs = memberInfo[0].GetCustomAttributes(typeof(RequiredServerVersionAttribute), false);
//            if (attrs != null && attrs.Length > 0)
//            {
//                return ((RequiredServerVersionAttribute)attrs[0]).Version;
//            }
//            else
//            {
//                return ExchangeVersion.Exchange2007_SP1;
//            }
//        }
//
//        /// <summary>
//        /// Builds the enum to version mapping dictionary.
//        /// </summary>
//        /// <param name="enumType">Type of the enum.</param>
//        /// <returns>Dictionary of enum values to versions.</returns>
//        private static Dictionary<Enum, ExchangeVersion> BuildEnumDict(Type enumType)
//        {
//            Dictionary<Enum, ExchangeVersion> dict = new Dictionary<Enum, ExchangeVersion>();
//            string[] names = Enum.GetNames(enumType);
//            for (string name in names)
//            {
//                Enum value = (Enum)Enum.Parse(enumType, name, false);
//                ExchangeVersion version = GetEnumVersion(enumType, name);
//                dict.Add(value, version);
//            }
//            return dict;
//        }

        /// <summary>
        /// Gets the schema name for enum member.
        /// </summary>
        /// <param name="enumType">Type of the enum.</param>
        /// <param name="enumName">The enum name.</param>
        /// <returns>The name for the enum used in the protocol, or null if it is the same as the enum's toString().</returns>
        static String GetEnumSchemaName(Type enumType, Object enumValue)
        {
          final ewsEnumAttribute = {
            MailboxType : {
              MailboxType.PublicGroup: EwsEnumAttribute("PublicDL")
            },
            MailboxType : {
              MailboxType.ContactGroup: EwsEnumAttribute("PrivateDL")
            }
          };

          if (ewsEnumAttribute.containsKey(enumType) && ewsEnumAttribute[enumType].containsKey(enumValue)) {
            return ewsEnumAttribute[enumType][enumValue].schemaName;
          } else {
            return null;
          }

//            MemberInfo[] memberInfo = enumType.GetMember(enumName);
//            EwsUtilities.Assert(
//                                (memberInfo != null) && (memberInfo.Length > 0),
//                                "EwsUtilities.GetEnumSchemaName",
//                                "Enum member " + enumName + " not found in " + enumType);
//
//            object[] attrs = memberInfo[0].GetCustomAttributes(typeof(EwsEnumAttribute), false);
//            if (attrs != null && attrs.Length > 0)
//            {
//                return ((EwsEnumAttribute)attrs[0]).SchemaName;
//            }
//            else
//            {
//                return null;
//            }
        }
//
//        /// <summary>
//        /// Builds the schema to enum mapping dictionary.
//        /// </summary>
//        /// <param name="enumType">Type of the enum.</param>
//        /// <returns>The mapping from enum to schema name</returns>
//        private static Dictionary<string, Enum> BuildSchemaToEnumDict(Type enumType)
//        {
//            Dictionary<string, Enum> dict = new Dictionary<string, Enum>();
//            string[] names = Enum.GetNames(enumType);
//            for (string name in names)
//            {
//                Enum value = (Enum)Enum.Parse(enumType, name, false);
//                string schemaName = EwsUtilities.GetEnumSchemaName(enumType, name);
//
//                if (!StringUtils.IsNullOrEmpty(schemaName))
//                {
//                    dict.Add(schemaName, value);
//                }
//            }
//            return dict;
//        }
//
//        /// <summary>
//        /// Builds the enum to schema mapping dictionary.
//        /// </summary>
//        /// <param name="enumType">Type of the enum.</param>
//        /// <returns>The mapping from enum to schema name</returns>
//        private static Dictionary<Enum, string> BuildEnumToSchemaDict(Type enumType)
//        {
//            Dictionary<Enum, string> dict = new Dictionary<Enum, string>();
//            string[] names = Enum.GetNames(enumType);
//            for (string name in names)
//            {
//                Enum value = (Enum)Enum.Parse(enumType, name, false);
//                string schemaName = EwsUtilities.GetEnumSchemaName(enumType, name);
//
//                if (!StringUtils.IsNullOrEmpty(schemaName))
//                {
//                    dict.Add(value, schemaName);
//                }
//            }
//            return dict;
//        }
//        #endregion
//
//        #region Iterable utility methods
//
//        /// <summary>
//        /// Gets the enumerated object count.
//        /// </summary>
//        /// <param name="objects">The objects.</param>
//        /// <returns>Count of objects in Iterable.</returns>
//        internal static int GetEnumeratedObjectCount(Iterable objects)
//        {
//            int count = 0;
//
//            for (object obj in objects)
//            {
//                count++;
//            }
//
//            return count;
//        }
//
//        /// <summary>
//        /// Gets enumerated object at index.
//        /// </summary>
//        /// <param name="objects">The objects.</param>
//        /// <param name="index">The index.</param>
//        /// <returns>Object at index.</returns>
//        internal static object GetEnumeratedObjectAt(Iterable objects, int index)
//        {
//            int count = 0;
//
//            for (object obj in objects)
//            {
//                if (count == index)
//                {
//                    return obj;
//                }
//
//                count++;
//            }
//
//            throw new ArgumentOutOfRangeException("index", Strings.IterableDoesNotContainThatManyObject);
//        }
//
//        #endregion
//
//        #region Extension methods
//        /// <summary>
//        /// Count characters in string that match a condition.
//        /// </summary>
//        /// <param name="str">The string.</param>
//        /// <param name="charPredicate">Predicate to evaluate for each character in the string.</param>
//        /// <returns>Count of characters that match condition expressed by predicate.</returns>
//        internal static int CountMatchingChars(this string str, Predicate<char> charPredicate)
//        {
//            int count = 0;
//            for (char ch in str)
//            {
//                if (charPredicate(ch))
//                {
//                    count++;
//                }
//            }
//
//            return count;
//        }
//
//        /// <summary>
//        /// Determines whether every element in the collection matches the conditions defined by the specified predicate.
//        /// </summary>
//        /// <typeparam name="T">Entry type.</typeparam>
//        /// <param name="collection">The collection.</param>
//        /// <param name="predicate">Predicate that defines the conditions to check against the elements.</param>
//        /// <returns>True if every element in the collection matches the conditions defined by the specified predicate; otherwise, false.</returns>
//        internal static bool TrueForAll<T>(this Iterable<T> collection, Predicate<T> predicate)
//        {
//            for (T entry in collection)
//            {
//                if (!predicate(entry))
//                {
//                    return false;
//                }
//            }
//
//            return true;
//        }
//
//        /// <summary>
//        /// Call an action for each member of a collection.
//        /// </summary>
//        /// <param name="collection">The collection.</param>
//        /// <param name="action">The action to apply.</param>
//        /// <typeparam name="T">Collection element type.</typeparam>
//        internal static void ForEach<T>(this Iterable<T> collection, Action<T> action)
//        {
//            for (T entry in collection)
//            {
//                action(entry);
//            }
//        }
//        #endregion
//    }
//
//
//
//
//
//
//
//
//
//
//
//
//
//    /// <summary>
//    /// EWS utilities
//    /// </summary>
//    static class EwsUtilities
//    {
//        #region /* private */ members
//
//        /// <summary>
//        /// Map from XML element names to ServiceObject type and constructors.
//        /// </summary>
//        /* private */ static LazyMember<ServiceObjectInfo> serviceObjectInfo = new LazyMember<ServiceObjectInfo>(
//            delegate()
//            {
//                return new ServiceObjectInfo();
//            });
//
//        /// <summary>
//        /// Version of API binary.
//        /// </summary>
//        /* private */ static LazyMember<string> buildVersion = new LazyMember<string>(
//            delegate()
//            {
//                try
//                {
//                    FileVersionInfo fileInfo = FileVersionInfo.GetVersionInfo(Assembly.GetExecutingAssembly().Location);
//                    return fileInfo.FileVersion;
//                }
//                catch
//                {
//                    // OM:2026839 When run in an environment with partial trust, fetching the build version blows up.
//                    // Just return a hardcoded value on failure.
//                    return "0.0";
//                }
//            });
//
//        /// <summary>
//        /// Dictionary of enum type to ExchangeVersion maps.
//        /// </summary>
//        /* private */ static LazyMember<Map<Type, Map<Enum, ExchangeVersion>>> enumVersionDictionaries = new LazyMember<Map<Type, Map<Enum, ExchangeVersion>>>(
//            () => new Map<Type, Map<Enum, ExchangeVersion>>()
//            {
//                { typeof(WellKnownFolderName), BuildEnumDict(typeof(WellKnownFolderName)) },
//                { typeof(ItemTraversal), BuildEnumDict(typeof(ItemTraversal)) },
//                { typeof(ConversationQueryTraversal), BuildEnumDict(typeof(ConversationQueryTraversal)) },
//                { typeof(FileAsMapping), BuildEnumDict(typeof(FileAsMapping)) },
//                { typeof(EventType), BuildEnumDict(typeof(EventType)) },
//                { typeof(MeetingRequestsDeliveryScope), BuildEnumDict(typeof(MeetingRequestsDeliveryScope)) },
//                { typeof(ViewFilter), BuildEnumDict(typeof(ViewFilter)) },
//            });
//
//        /// <summary>
//        /// Dictionary of enum type to schema-name-to-enum-value maps.
//        /// </summary>
//        /* private */ static LazyMember<Map<Type, Map<string, Enum>>> schemaToEnumDictionaries = new LazyMember<Map<Type, Map<string, Enum>>>(
//            () => new Map<Type, Map<string, Enum>>
//            {
//                { typeof(EventType), BuildSchemaToEnumDict(typeof(EventType)) },
//                { typeof(MailboxType), BuildSchemaToEnumDict(typeof(MailboxType)) },
//                { typeof(FileAsMapping), BuildSchemaToEnumDict(typeof(FileAsMapping)) },
//                { typeof(RuleProperty), BuildSchemaToEnumDict(typeof(RuleProperty)) },
//                { typeof(WellKnownFolderName), BuildSchemaToEnumDict(typeof(WellKnownFolderName)) },
//            });

        /// <summary>
        /// Dictionary of enum type to enum-value-to-schema-name maps.
        /// </summary>
        /* private */ static LazyMember<Map<Type, Map<Object, String>>> enumToSchemaDictionaries = new LazyMember<Map<Type, Map<Object, String>>>(
            () =>
            {
                 EventType:  BuildEnumToSchemaDict(EventType, EventType.values),
                 MailboxType: BuildEnumToSchemaDict(MailboxType, MailboxType.values),
                 FileAsMapping: BuildEnumToSchemaDict(FileAsMapping, FileAsMapping.values),
                 RuleProperty: BuildEnumToSchemaDict(RuleProperty, RuleProperty.values),
                 WellKnownFolderName: BuildEnumToSchemaDict(WellKnownFolderName, WellKnownFolderName.values),
            });

//        /// <summary>
//        /// Dictionary to map from special CLR type names to their "short" names.
//        /// </summary>
//        /* private */ static LazyMember<Map<string, string>> typeNameToShortNameMap = new LazyMember<Map<string, string>>(
//            () => new Map<string, string>
//            {
//                { "Boolean", "bool" },
//                { "Int16", "short" },
//                { "Int32", "int" },
//                { "String", "string" }
//            );
//        #endregion
//
//        #region Constants
//
        static const String XSFalse = "false";
        static const String XSTrue = "true";
//
//        const String EwsTypesNamespacePrefix = "t";
//        const String EwsMessagesNamespacePrefix = "m";
//        const String EwsErrorsNamespacePrefix = "e";
//        const String EwsSoapNamespacePrefix = "soap";
//        const String EwsXmlSchemaInstanceNamespacePrefix = "xsi";
//        const String PassportSoapFaultNamespacePrefix = "psf";
//        const String WSTrustFebruary2005NamespacePrefix = "wst";
//        const String WSAddressingNamespacePrefix = "wsa";
//        const String AutodiscoverSoapNamespacePrefix = "a";
//        const String WSSecurityUtilityNamespacePrefix = "wsu";
//        const String WSSecuritySecExtNamespacePrefix = "wsse";
//
//        const String EwsTypesNamespace = "http://schemas.microsoft.com/exchange/services/2006/types";
//        const String EwsMessagesNamespace = "http://schemas.microsoft.com/exchange/services/2006/messages";
//        const String EwsErrorsNamespace = "http://schemas.microsoft.com/exchange/services/2006/errors";
//        const String EwsSoapNamespace = "http://schemas.xmlsoap.org/soap/envelope/";
//        const String EwsSoap12Namespace = "http://www.w3.org/2003/05/soap-envelope";
//        const String EwsXmlSchemaInstanceNamespace = "http://www.w3.org/2001/XMLSchema-instance";
//        const String PassportSoapFaultNamespace = "http://schemas.microsoft.com/Passport/SoapServices/SOAPFault";
//        const String WSTrustFebruary2005Namespace = "http://schemas.xmlsoap.org/ws/2005/02/trust";
//        const String WSAddressingNamespace = "http://www.w3.org/2005/08/addressing"; // "http://schemas.xmlsoap.org/ws/2004/08/addressing";
//        const String AutodiscoverSoapNamespace = "http://schemas.microsoft.com/exchange/2010/Autodiscover";
//        const String WSSecurityUtilityNamespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
//        const String WSSecuritySecExtNamespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";

        /// <summary>
        /// Regular expression for legal domain names.
        /// </summary>
        static const String DomainRegex = "^[-a-zA-Z0-9_.]+\$";
//        #endregion

        /// <summary>
        /// Asserts that the specified condition if true.
        /// </summary>
        /// <param name="condition">Assertion.</param>
        /// <param name="caller">The caller.</param>
        /// <param name="message">The message to use if assertion fails.</param>
        static void Assert(
            bool condition,
            String caller,
            String message)
        {
            assert(
                condition,
                "[$caller] $message");
        }

//        /// <summary>
//        /// Gets the namespace prefix from an XmlNamespace enum value.
//        /// </summary>
//        /// <param name="xmlNamespace">The XML namespace.</param>
//        /// <returns>Namespace prefix string.</returns>
//        static String GetNamespacePrefix(XmlNamespace xmlNamespace)
//        {
//            switch (xmlNamespace)
//            {
//                case XmlNamespace.Types:
//                    return EwsTypesNamespacePrefix;
//                case XmlNamespace.Messages:
//                    return EwsMessagesNamespacePrefix;
//                case XmlNamespace.Errors:
//                    return EwsErrorsNamespacePrefix;
//                case XmlNamespace.Soap:
//                case XmlNamespace.Soap12:
//                    return EwsSoapNamespacePrefix;
//                case XmlNamespace.XmlSchemaInstance:
//                    return EwsXmlSchemaInstanceNamespacePrefix;
//                case XmlNamespace.PassportSoapFault:
//                    return PassportSoapFaultNamespacePrefix;
//                case XmlNamespace.WSTrustFebruary2005:
//                    return WSTrustFebruary2005NamespacePrefix;
//                case XmlNamespace.WSAddressing:
//                    return WSAddressingNamespacePrefix;
//                case XmlNamespace.Autodiscover:
//                    return AutodiscoverSoapNamespacePrefix;
//                default:
//                    return "";
//            }
//        }
//
//        /// <summary>
//        /// Gets the namespace URI from an XmlNamespace enum value.
//        /// </summary>
//        /// <param name="xmlNamespace">The XML namespace.</param>
//        /// <returns>Uri as string</returns>
//        static String GetNamespaceUri(XmlNamespace xmlNamespace)
//        {
//            switch (xmlNamespace)
//            {
//                case XmlNamespace.Types:
//                    return EwsTypesNamespace;
//                case XmlNamespace.Messages:
//                    return EwsMessagesNamespace;
//                case XmlNamespace.Errors:
//                    return EwsErrorsNamespace;
//                case XmlNamespace.Soap:
//                    return EwsSoapNamespace;
//                case XmlNamespace.Soap12:
//                    return EwsSoap12Namespace;
//                case XmlNamespace.XmlSchemaInstance:
//                    return EwsXmlSchemaInstanceNamespace;
//                case XmlNamespace.PassportSoapFault:
//                    return PassportSoapFaultNamespace;
//                case XmlNamespace.WSTrustFebruary2005:
//                    return WSTrustFebruary2005Namespace;
//                case XmlNamespace.WSAddressing:
//                    return WSAddressingNamespace;
//                case XmlNamespace.Autodiscover:
//                    return AutodiscoverSoapNamespace;
//                default:
//                    return "";
//            }
//        }

        /// <summary>
        /// Gets the XmlNamespace enum value from a namespace Uri.
        /// </summary>
        /// <param name="namespaceUri">XML namespace Uri.</param>
        /// <returns>XmlNamespace enum value.</returns>
        static XmlNamespace GetNamespaceFromUri(String namespaceUri)
        {
            switch (namespaceUri)
            {
                case EwsErrorsNamespace:
                    return XmlNamespace.Errors;
                case EwsTypesNamespace:
                    return XmlNamespace.Types;
                case EwsMessagesNamespace:
                    return XmlNamespace.Messages;
                case EwsSoapNamespace:
                    return XmlNamespace.Soap;
                case EwsSoap12Namespace:
                    return XmlNamespace.Soap12;
                case EwsXmlSchemaInstanceNamespace:
                    return XmlNamespace.XmlSchemaInstance;
                case PassportSoapFaultNamespace:
                    return XmlNamespace.PassportSoapFault;
                case WSTrustFebruary2005Namespace:
                    return XmlNamespace.WSTrustFebruary2005;
                case WSAddressingNamespace:
                    return XmlNamespace.WSAddressing;
                default:
                    return XmlNamespace.NotSpecified;
            }
        }

        /// <summary>
        /// Creates EWS object based on XML element name.
        /// </summary>
        /// <typeparam name="TServiceObject">The type of the service object.</typeparam>
        /// <param name="service">The service.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        /// <returns>Service object.</returns>
        static TServiceObject CreateEwsObjectFromXmlElementName<TServiceObject extends ServiceObject>(ExchangeService service, String xmlElementName)
        {
          // todo("implement CreateEwsObjectFromXmlElementName");
//          print("CreateEwsObjectFromXmlElementName($xmlElementName);");

            if (EwsUtilities.serviceObjectInfo.Member.XmlElementNameToServiceObjectClassMap.containsKey(xmlElementName))
            {
              Type itemClass = EwsUtilities.serviceObjectInfo.Member.XmlElementNameToServiceObjectClassMap[xmlElementName];

                if (EwsUtilities.serviceObjectInfo.Member.ServiceObjectConstructorsWithServiceParam.containsKey(itemClass))
                {
                  CreateServiceObjectWithServiceParam creationDelegate = EwsUtilities.serviceObjectInfo.Member.ServiceObjectConstructorsWithServiceParam[itemClass];
                    return creationDelegate(service);
                }
                else
                {
                    throw new ArgumentError("Strings.NoAppropriateConstructorForItemClass");
                }
            }
            else
            {
              throw StateError("Can't instantiate $TServiceObject");
//                return default(TServiceObject);
            }
        }

        /// <summary>
        /// Creates Item from Item class.
        /// </summary>
        /// <param name="itemAttachment">The item attachment.</param>
        /// <param name="itemClass">The item class.</param>
        /// <param name="isNew">If true, item attachment is new.</param>
        /// <returns>New Item.</returns>
        static Item CreateItemFromItemClass(
            ItemAttachment itemAttachment,
            Type itemClass,
            bool isNew)
        {

            if (EwsUtilities.serviceObjectInfo.Member.ServiceObjectConstructorsWithAttachmentParam.containsKey(itemClass))
            {
              CreateServiceObjectWithAttachmentParam creationDelegate = EwsUtilities.serviceObjectInfo.Member.ServiceObjectConstructorsWithAttachmentParam[itemClass];
              return creationDelegate(itemAttachment, isNew);
            }
            else
            {
                throw new ArgumentError("Strings.NoAppropriateConstructorForItemClass");
            }
        }

        /// <summary>
        /// Creates Item based on XML element name.
        /// </summary>
        /// <param name="itemAttachment">The item attachment.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        /// <returns>New Item.</returns>
        static Item CreateItemFromXmlElementName(ItemAttachment itemAttachment, String xmlElementName)
        {
            if (EwsUtilities.serviceObjectInfo.Member.XmlElementNameToServiceObjectClassMap.containsKey(xmlElementName))
            {
                Type itemClass = EwsUtilities.serviceObjectInfo.Member.XmlElementNameToServiceObjectClassMap[xmlElementName];
                return CreateItemFromItemClass(itemAttachment, itemClass, false);
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// Gets the expected item type based on the local name.
        /// </summary>
        /// <param name="xmlElementName"></param>
        /// <returns></returns>
        static Type GetItemTypeFromXmlElementName(String xmlElementName)
        {
            return EwsUtilities.serviceObjectInfo.Member.XmlElementNameToServiceObjectClassMap[xmlElementName];
        }

        /// <summary>
        /// Finds the first item of type TItem (not a descendant type) in the specified collection.
        /// </summary>
        /// <typeparam name="TItem">The type of the item to find.</typeparam>
        /// <param name="items">The collection.</param>
        /// <returns>A TItem instance or null if no instance of TItem could be found.</returns>
        static TItem FindFirstItemOfType<TItem extends Item>(Iterable<Item> items)
        {
            for (Item item in items)
            {
                // We're looking for an exact class match here.
                if (item.runtimeType == TItem)
                {
                    return item;
                }
            }

            return null;
        }

//        #region Tracing routines

        /// <summary>
        /// Write trace start element.
        /// </summary>
        /// <param name="writer">The writer to write the start element to.</param>
        /// <param name="traceTag">The trace tag.</param>
        /// <param name="includeVersion">If true, include build version attribute.</param>
//        [System.Diagnostics.CodeAnalysis.SuppressMessage("Exchange.Usage", "EX0009:DoNotUseDateTimeNowOrFromFileTime", Justification = "Client API")]
        /* private */ static void WriteTraceStartElement(
            XmlWriter writer,
            String traceTag,
            bool includeVersion)
        {
            writer.WriteStartElement(localName: "Trace");
            writer.WriteAttributeString(localName: "Tag", value: traceTag);
            // todo("add the Thread Id info")
//            writer.WriteAttributeString(localName: "Tid", value: Thread.CurrentThread.ManagedThreadId.ToString());
            writer.WriteAttributeString(localName: "Time", value: DateTime.now().toIso8601String());

            if (includeVersion)
            {
                writer.WriteAttributeString(localName: "Version", value: EwsUtilities.BuildVersion);
            }
        }
//
//        /// <summary>
//        /// Format log message.
//        /// </summary>
//        /// <param name="entryKind">Kind of the entry.</param>
//        /// <param name="logEntry">The log entry.</param>
//        /// <returns>XML log entry as a string.</returns>
//        static String FormatLogMessage(String entryKind, String logEntry)
//        {
//            StringBuilder sb = new StringBuilder();
//
//            {
//
//                {
//                    xmlWriter.Formatting = Formatting.Indented;
//
//                    EwsUtilities.WriteTraceStartElement(xmlWriter, entryKind, false);
//
//                    xmlWriter.WriteWhitespace(Environment.NewLine);
//                    xmlWriter.WriteValue(logEntry);
//                    xmlWriter.WriteWhitespace(Environment.NewLine);
//
//                    xmlWriter.WriteEndElement(); // Trace
//                    xmlWriter.WriteWhitespace(Environment.NewLine);
//                }
//            }
//            return sb.ToString();
//        }
//
//        /// <summary>
//        /// Format the HTTP headers.
//        /// </summary>
//        /// <param name="sb">StringBuilder.</param>
//        /// <param name="headers">The HTTP headers.</param>
        /* private */ static void FormatHttpHeadersWithBuffer(StringBuffer sb, WebHeaderCollection headers)
        {
            for (String key in headers.AllKeys)
            {
                sb.write(
                    "$key: ${headers[key]}\n");
            }
        }
//
//        /// <summary>
//        /// Format request HTTP headers.
//        /// </summary>
//        /// <param name="request">The HTTP request.</param>
//        static String FormatHttpRequestHeaders(IEwsHttpWebRequest request)
//        {
//            StringBuilder sb = new StringBuilder();
//            sb.Append(string.Format("{0} {1} HTTP/1.1\n", request.Method, request.RequestUri.AbsolutePath));
//            EwsUtilities.FormatHttpHeaders(sb, request.Headers);
//            sb.Append("\n");
//
//            return sb.ToString();
//        }

        /// <summary>
        /// Format response HTTP headers.
        /// </summary>
        /// <param name="response">The HTTP response.</param>
        static String FormatHttpResponseHeaders(IEwsHttpWebResponse response)
        {
            StringBuffer sb = new StringBuffer();
            sb.write("HTTP/? ${response.StatusCode} ${response.StatusDescription}\n");

            sb.write(EwsUtilities.FormatHttpHeaders(response.Headers));
            sb.write("\n");
            return sb.toString();
        }

//        /// <summary>
//        /// Format request HTTP headers.
//        /// </summary>
//        /// <param name="request">The HTTP request.</param>
//        static String FormatHttpRequestHeaders(HttpWebRequest request)
//        {
//            StringBuilder sb = new StringBuilder();
//            sb.Append(
//                string.Format(
//                    "{0} {1} HTTP/{2}\n",
//                    request.Method.ToUpperInvariant(),
//                    request.RequestUri.AbsolutePath,
//                    request.ProtocolVersion));
//
//            sb.Append(EwsUtilities.FormatHttpHeaders(request.Headers));
//            sb.Append("\n");
//            return sb.ToString();
//        }
//
//        /// <summary>
//        /// Formats HTTP headers.
//        /// </summary>
//        /// <param name="headers">The headers.</param>
//        /// <returns>Headers as a string</returns>
//        /* private */ static String FormatHttpHeaders(WebHeaderCollection headers)
//        {
//            StringBuilder sb = new StringBuilder();
//            for (String key in headers.Keys)
//            {
//                sb.Append(
//                    string.Format(
//                        "{0}: {1}\n",
//                        key,
//                        headers[key]));
//            }
//            return sb.ToString();
//        }
//
//        /// <summary>
//        /// Format XML content in a MemoryStream for message.
//        /// </summary>
//        /// <param name="entryKind">Kind of the entry.</param>
//        /// <param name="memoryStream">The memory stream.</param>
//        /// <returns>XML log entry as a string.</returns>
//        static String FormatLogMessageWithXmlContent(String entryKind, MemoryStream memoryStream)
//        {
//            StringBuilder sb = new StringBuilder();
//            XmlReaderSettings settings = new XmlReaderSettings();
//            settings.ConformanceLevel = ConformanceLevel.Fragment;
//            settings.IgnoreComments = true;
//            settings.IgnoreWhitespace = true;
//            settings.CloseInput = false;
//
//            // Remember the current location in the MemoryStream.
//            long lastPosition = memoryStream.Position;
//
//            // Rewind the position since we want to format the entire contents.
//            memoryStream.Position = 0;
//
//            try
//            {
//
//                {
//
//                    {
//
//                        {
//                            xmlWriter.Formatting = Formatting.Indented;
//
//                            EwsUtilities.WriteTraceStartElement(xmlWriter, entryKind, true);
//
//                            while (!reader.EOF)
//                            {
//                                xmlWriter.WriteNode(reader, true);
//                            }
//
//                            xmlWriter.WriteEndElement(); // Trace
//                            xmlWriter.WriteWhitespace(Environment.NewLine);
//                        }
//                    }
//                }
//            }
//            catch (XmlException)
//            {
//                // We tried to format the content as "pretty" XML. Apparently the content is
//                // not well-formed XML or isn't XML at all. Fallback and treat it as plain text.
//                sb.Length = 0;
//                memoryStream.Position = 0;
//                sb.Append(Encoding.UTF8.GetString(memoryStream.GetBuffer(), 0, (int)memoryStream.Length));
//            }
//
//            // Restore Position in the stream.
//            memoryStream.Position = lastPosition;
//
//            return sb.ToString();
//        }
//
//        #endregion
//
//        #region Stream routines
//
//        /// <summary>
//        /// Copies source stream to target.
//        /// </summary>
//        /// <param name="source">The source.</param>
//        /// <param name="target">The target.</param>
//        static void CopyStream(Stream source, Stream target)
//        {
//            // See if this is a MemoryStream -- we can use WriteTo.
//            MemoryStream memContentStream = source as MemoryStream;
//            if (memContentStream != null)
//            {
//                memContentStream.WriteTo(target);
//            }
//            else
//            {
//                // Otherwise, copy data through a buffer
//                Uint8List buffer = new byte[4096];
//                int bufferSize = buffer.Length;
//                int bytesRead = source.Read(buffer, 0, bufferSize);
//                while (bytesRead > 0)
//                {
//                    target.Write(buffer, 0, bytesRead);
//                    bytesRead = source.Read(buffer, 0, bufferSize);
//                }
//            }
//        }
//
//        #endregion
//
//        /// <summary>
//        /// Gets the build version.
//        /// </summary>
//        /// <value>The build version.</value>
//        static String BuildVersion
//        {
//            get { return EwsUtilities.buildVersion.Member; }
//        }
//
//        #region Conversion routines

        /// <summary>
        /// Convert bool to XML Schema bool.
        /// </summary>
        /// <param name="value">Bool value.</param>
        /// <returns>String representing bool value in XML Schema.</returns>
        static String BoolToXSBool(bool value)
        {
            return value ? EwsUtilities.XSTrue : EwsUtilities.XSFalse;
        }
//
//        /// <summary>
//        /// Parses an enum value list.
//        /// </summary>
//        /// <typeparam name="T">Type of value.</typeparam>
//        /// <param name="list">The list.</param>
//        /// <param name="value">The value.</param>
//        /// <param name="separators">The separators.</param>
//        static void ParseEnumValueList<T>(
//            IList<T> list,
//            String value,
//            params char[] separators)
//            where T : struct
//        {
//            EwsUtilities.Assert(
//                typeof(T).IsEnum,
//                "EwsUtilities.ParseEnumValueList",
//                "T is not an enum type.");
//
//            if (StringUtils.IsNullOrEmpty(value))
//            {
//                return;
//            }
//
//            string[] enumValues = value.Split(separators);
//
//            for (String enumValue in enumValues)
//            {
//                list.Add((T)Enum.Parse(typeof(T), enumValue, false));
//            }
//        }
//
//        /// <summary>

        /// </summary>
        /// <param name="value">The enum value to be serialized</param>
        /// <returns>String representation of enum to be used in the protocol</returns>
        static bool TrySerializeEnum(Object enumValue, OutParam<String> resultOutParam)
        {
//            Map<Object, String> enumToStringDict;
//            String strValue;
//            if (enumToSchemaDictionaries.Member.containsKey(enumValue.runtimeType))
////                enumToStringDict.TryGetValue(value, out strValue))
//            {
//              throw NotImplementedException("TrySerializeEnum($enumValue)");
////                return strValue;
//            }
//            else
//            {
              if (ewsEnumDictionaries.containsKey(enumValue.runtimeType)) {
                resultOutParam.param = ewsEnumDictionaries[enumValue.runtimeType][enumValue];
                return true;
              }
              else if (serializedEnumDictionaries.contains(enumValue.runtimeType)) {
                resultOutParam.param = EnumToString.parse(enumValue);
                return true;
              } else {
                return false;
              }
//            }
        }

//        /// <summary>
//        /// Parses specified value based on type.
//        /// </summary>
//        /// <typeparam name="T">Type of value.</typeparam>
//        /// <param name="value">The value.</param>
//        /// <returns>Value of type T.</returns>
//        static T Parse<T>(String value)
//        {
//            if (typeof(T).IsEnum)
//            {
//                Map<string, Enum> stringToEnumDict;
//                Enum enumValue;
//                if (schemaToEnumDictionaries.Member.TryGetValue(typeof(T), out stringToEnumDict) &&
//                    stringToEnumDict.TryGetValue(value, out enumValue))
//                {
//                    // This double-casting is ugly, but necessary. By this point, we know that T is an Enum
//                    // (same as returned by the dictionary), but the compiler can't prove it. Thus, the
//                    // up-cast before we can down-cast.
//                    return (T)((object)enumValue);
//                }
//                else
//                {
//                    return (T)Enum.Parse(typeof(T), value, false);
//                }
//            }
//            else
//            {
//                return (T)Convert.ChangeType(value, typeof(T), CultureInfo.InvariantCulture);
//            }
//        }

        /// <summary>
        /// Tries to parses the specified value to the specified type.
        /// </summary>
        /// <typeparam name="T">The type into which to cast the provided value.</typeparam>
        /// <param name="value">The value to parse.</param>
        /// <param name="result">The value cast to the specified type, if TryParse succeeds. Otherwise, the value of result is indeterminate.</param>
        /// <returns>True if value could be parsed; otherwise, false.</returns>
        static bool TryParse<T>(String value, OutParam<T> resultOutParam)
        {
            try
            {
                resultOutParam.param = EwsUtilities.Parse<T>(value);

                return true;
            }
            //// Catch all exceptions here, we're not interested in the reason why TryParse failed.
            catch (Exception)
            {
              // todo("check here")
                resultOutParam.param = null;

                return false;
            }
        }

        /// <summary>
        /// Converts the specified date and time from one time zone to another.
        /// </summary>
        /// <param name="dateTime">The date time to convert.</param>
        /// <param name="sourceTimeZone">The source time zone.</param>
        /// <param name="destinationTimeZone">The destination time zone.</param>
        /// <returns>A DateTime that holds the converted</returns>
        static DateTime ConvertTime(
            DateTime dateTime,
            TimeZone sourceTimeZone,
            TimeZone destinationTimeZone)
        {
          // todo : fix timezones
          print("!!! using unsafe ConvertTime");
          return dateTime;
//            try
//            {
//                return TimeZoneInfo.ConvertTime(
//                    dateTime,
//                    sourceTimeZone,
//                    destinationTimeZone);
//            }
//            catch (ArgumentError e)
//            {
//                throw new TimeZoneConversionException(
//                    string.Format(
//                        Strings.CannotConvertBetweenTimeZones,
//                        EwsUtilities.DateTimeToXSDateTime(dateTime),
//                        sourceTimeZone.DisplayName,
//                        destinationTimeZone.DisplayName),
//                    e);
//            }
        }
//
//        /// <summary>
//        /// Reads the String as date time, assuming it is unbiased (e.g. 2009/01/01T08:00)
//        /// and scoped to service's time zone.
//        /// </summary>
//        /// <param name="dateString">The date string.</param>
//        /// <param name="service">The service.</param>
//        /// <returns>The string's value as a DateTime object.</returns>
//        static DateTime ParseAsUnbiasedDatetimescopedToServicetimeZone(String dateString, ExchangeService service)
//        {
//            // Convert the element's value to a DateTime with no adjustment.
//            DateTime tempDate = DateTime.Parse(dateString, CultureInfo.InvariantCulture);
//
//            // Set the kind according to the service's time zone
//            if (service.TimeZone == TimeZoneInfo.Utc)
//            {
//                return new DateTime(tempDate.Ticks, DateTimeKind.Utc);
//            }
//            else if (EwsUtilities.IsLocalTimeZone(service.TimeZone))
//            {
//                return new DateTime(tempDate.Ticks, DateTimeKind.Local);
//            }
//            else
//            {
//                return new DateTime(tempDate.Ticks, DateTimeKind.Unspecified);
//            }
//        }
//
//        /// <summary>
//        /// Determines whether the specified time zone is the same as the system's local time zone.
//        /// </summary>
//        /// <param name="timeZone">The time zone to check.</param>
//        /// <returns>
//        ///     <c>true</c> if the specified time zone is the same as the system's local time zone; otherwise, <c>false</c>.
//        /// </returns>
//        static bool IsLocalTimeZone(TimeZoneInfo timeZone)
//        {
//            return (TimeZoneInfo.Local == timeZone) || (TimeZoneInfo.Local.Id == timeZone.Id && TimeZoneInfo.Local.HasSameRules(timeZone));
//        }

        /// <summary>
        /// Convert DateTime to XML Schema date.
        /// </summary>
        /// <param name="date">The date to be converted.</param>
        /// <returns>String representation of DateTime.</returns>
        static String DateTimeToXSDate(DateTime date)
        {
          // TODO : check validity of DateTimeToXSDate
          print(".. using unsafe DateTimeToXSDate");
//          if (date.isUtc) {
            return DateFormat("yyyy-MM-dd'Z'").format(date);
//          } else {
//            return DateFormat("yyyy-MM-ddzzz").format(date);
//          }

            // Depending on the current culture, DateTime formatter will
            // translate dates from one culture to another (e.g. Gregorian to Lunar).  The server
            // ensure this.
//            String format;
//
//            switch (date.Kind)
//            {
//                case DateTimeKind.Utc:
//                    format = "yyyy-MM-ddZ";
//                    break;
//                case DateTimeKind.Unspecified:
//                    format = "yyyy-MM-dd";
//                    break;
//                default: // DateTimeKind.Local is remaining
//                    format = "yyyy-MM-ddzzz";
//                    break;
//            }
//
//            return date.ToString(format, CultureInfo.InvariantCulture);
        }

        /// <summary>
        /// Dates the DateTime into an XML schema date time.
        /// </summary>
        /// <param name="dateTime">The date time.</param>
        /// <returns>String representation of DateTime.</returns>
        static String DateTimeToXSDateTime(DateTime dateTime)
        {
          // TODO : fix DateTimeToXSDateTime
          print(".. used incorret DateTimeToXSDateTime");

            String format = "yyyy-MM-ddTHH:mm:ss.000";
            var formatter = new DateFormat(format);
            return formatter.format(dateTime);

//            switch (dateTime.Kind)
//            {
//                case DateTimeKind.Utc:
//                    format += "Z";
//                    break;
//                case DateTimeKind.Local:
//                    format += "zzz";
//                    break;
//                default:
//                    break;
//            }
//
//            // Depending on the current culture, DateTime formatter will replace ':' with
//            // the DateTimeFormatInfo.TimeSeparator property which may not be ':'. Force the proper string
//
//            return dateTime.ToString(format, CultureInfo.InvariantCulture);
        }
//
//        /// <summary>
//        /// Convert EWS DayOfTheWeek enum to System.DayOfWeek.
//        /// </summary>
//        /// <param name="dayOfTheWeek">The day of the week.</param>
//        /// <returns>System.DayOfWeek value.</returns>
//        static DayOfWeek EwsToSystemDayOfWeek(DayOfTheWeek dayOfTheWeek)
//        {
//            if (dayOfTheWeek == DayOfTheWeek.Day ||
//                dayOfTheWeek == DayOfTheWeek.Weekday ||
//                dayOfTheWeek == DayOfTheWeek.WeekendDay)
//            {
//                throw new ArgumentError(
//                    string.Format("Cannot convert {0} to System.DayOfWeek enum value", dayOfTheWeek),
//                    "dayOfTheWeek");
//            }
//            else
//            {
//                return (DayOfWeek)dayOfTheWeek;
//            }
//        }
//
//        /// <summary>
//        /// Convert System.DayOfWeek type to EWS DayOfTheWeek.
//        /// </summary>
//        /// <param name="dayOfWeek">The dayOfWeek.</param>
//        /// <returns>EWS DayOfWeek value</returns>
//        static DayOfTheWeek SystemToEwsDayOfTheWeek(DayOfWeek dayOfWeek)
//        {
//            return (DayOfTheWeek)dayOfWeek;
//        }

        /// <summary>
        /// Takes a System.TimeSpan structure and converts it into an
        /// xs:duration String as defined by the W3 Consortiums Recommendation
        /// "XML Schema Part 2: Datatypes Second Edition",
        /// http://www.w3.org/TR/xmlschema-2/#duration
        /// </summary>
        /// <param name="timeSpan">TimeSpan structure to convert</param>
        /// <returns>xs:duration formatted string</returns>
        static String TimeSpanToXSDuration(TimeSpan timeSpan)
        {
            // Optional '-' offset
            String offsetStr = (timeSpan.TotalSeconds < 0) ? "-" : "";

            // The TimeSpan structure does not have a Year or Month
            // property, therefore we wouldn't be able to return an xs:duration
            // String from a TimeSpan that included the nY or nM components.
            return
                "${offsetStr}P${timeSpan.Days.abs}DT${timeSpan.Hours.abs}H${timeSpan.Minutes.abs}M${timeSpan.Seconds.abs}.${timeSpan.Milliseconds.abs}S";
        }



        /// <summary>
        /// Takes an xs:duration String as defined by the W3 Consortiums
        /// Recommendation "XML Schema Part 2: Datatypes Second Edition",
        /// http://www.w3.org/TR/xmlschema-2/#duration, and converts it
        /// into a System.TimeSpan structure
        /// </summary>
        /// <remarks>
        /// This method uses the following approximations:
        ///     1 year = 365 days
        ///     1 month = 30 days
        /// Additionally, it only allows for four decimal points of
        /// seconds precision.
        /// </remarks>
        /// <param name="xsDuration">xs:duration String to convert</param>
        /// <returns>System.TimeSpan structure</returns>
        static TimeSpan XSDurationToTimeSpan(String xsDuration)
        {
          String xsDateDuration = xsDuration.contains("T")
              ? xsDuration.split("T").first
              : xsDuration;

          String xsTimeDuration = xsDuration.split("T").length > 1
              ?  xsDuration.split("T")[1]
              : "";

          RegExpMatch m = PATTERN_TIME_SPAN.firstMatch(xsDateDuration);
          bool negative = false;

          if (m != null) {
            negative = true;
          }


          // Year
          m = PATTERN_YEAR.firstMatch(xsDateDuration);

          int year = 0;
          if (m != null) {
            year = int.parse(m.group(0).substring(0,
                m.group(0).indexOf("Y")));
          }

          // Month
          m = PATTERN_MONTH.firstMatch(xsDateDuration);

          int month = 0;
          if (m != null) {
            month = int.parse(m.group(0).substring(0,
                m.group(0).indexOf("M")));
          }

          // Day
          m = PATTERN_DAY.firstMatch(xsDateDuration);

          int day = 0;
          if (m != null) {
            day = int.parse(m.group(0).substring(0,
                m.group(0).indexOf("D")));
          }

          // Hour
          m = PATTERN_HOUR.firstMatch(xsTimeDuration);

          int hour = 0;
          if (m != null) {
            hour = int.parse(m.group(0).substring(0,
                m.group(0).indexOf("H")));
          }

          // Minute
          m = PATTERN_MINUTES.firstMatch(xsTimeDuration);

          int minute = 0;
          if (m != null) {
            minute = int.parse(m.group(0).substring(0,
                m.group(0).indexOf("M")));
          }

          // Seconds
          m = PATTERN_SECONDS.firstMatch(xsTimeDuration);

          int seconds = 0;
          if (m != null) {
            seconds = int.parse(m.group(0).substring(0,
                m.group(0).indexOf(".")));
          }

          int milliseconds = 0;
//          m = PATTERN_MILLISECONDS.firstMatch(xsDuration);
//
//          if (m != null) {
//            // Only allowed 4 digits of precision
//            if (m.group(0).length > 5) {
//              milliseconds = int.parse(m.group(0).substring(0, 4));
//            } else {
//              seconds = int.parse(m.group(0).substring(0,
//                  m.group(0).indexOf("S")));
//            }
//          }

          // Apply conversions of year and months to days.
          // Year = 365 days
          // Month = 30 days
          day = day + (year * 365) + (month * 30);
          // TimeSpan retval = new TimeSpan(day, hour, minute, seconds,
          // milliseconds);
          int retval = (((((((day * 24) + hour) * 60) + minute) * 60) +
              seconds) * 1000) + milliseconds;
          if (negative) {
            retval = -retval;
          }
          return new TimeSpan(retval);
//          RegExp timeSpanParser = new RegExp(
//                "(?<pos>-)?" +
//                "P" +
//                "((?<year>[0-9]+)Y)?" +
//                "((?<month>[0-9]+)M)?" +
//                "((?<day>[0-9]+)D)?" +
//                "(T" +
//                "((?<hour>[0-9]+)H)?" +
//                "((?<minute>[0-9]+)M)?" +
//                "((?<seconds>[0-9]+)(\\.(?<precision>[0-9]+))?S)?)?");
//
//            Match m = timeSpanParser.Match(xsDuration);
//            if (!m.Success)
//            {
//                throw new ArgumentError(Strings.XsDurationCouldNotBeParsed);
//            }
//            String token = m.Result("${pos}");
//            bool negative = false;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                negative = true;
//            }
//
//            // Year
//            token = m.Result("${year}");
//            int year = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                year = Int32.Parse(token);
//            }
//
//            // Month
//            token = m.Result("${month}");
//            int month = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                month = Int32.Parse(token);
//            }
//
//            // Day
//            token = m.Result("${day}");
//            int day = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                day = Int32.Parse(token);
//            }
//
//            // Hour
//            token = m.Result("${hour}");
//            int hour = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                hour = Int32.Parse(token);
//            }
//
//            // Minute
//            token = m.Result("${minute}");
//            int minute = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                minute = Int32.Parse(token);
//            }
//
//            // Seconds
//            token = m.Result("${seconds}");
//            int seconds = 0;
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                seconds = Int32.Parse(token);
//            }
//
//            int milliseconds = 0;
//            token = m.Result("${precision}");
//
//            // Only allowed 4 digits of precision
//            if (token.Length > 4)
//            {
//                token = token.Substring(0, 4);
//            }
//
//            if (!StringUtils.IsNullOrEmpty(token))
//            {
//                milliseconds = Int32.Parse(token);
//            }
//
//            // Apply conversions of year and months to days.
//            // Year = 365 days
//            // Month = 30 days
//            day = day + (year * 365) + (month * 30);
//            TimeSpan retval = new TimeSpan(day, hour, minute, seconds, milliseconds);
//
//            if (negative)
//            {
//                retval = -retval;
//            }
//
//            return retval;
        }

//        /// <summary>
//        /// Converts the specified time span to its XSD representation.
//        /// </summary>
//        /// <param name="timeSpan">The time span.</param>
//        /// <returns>The XSD representation of the specified time span.</returns>
// static String TimeSpanToXSTime(TimeSpan timeSpan)
//        {
//            return string.Format(
//                "{0:00}:{1:00}:{2:00}",
//                timeSpan.Hours,
//                timeSpan.Minutes,
//                timeSpan.Seconds);
//        }
//
//        #endregion
//
//        #region Type Name utilities
//        /// <summary>
//        /// Gets the printable name of a CLR type.
//        /// </summary>
//        /// <param name="type">The type.</param>
//        /// <returns>Printable name.</returns>
// static String GetPrintableTypeName(Type type)
//        {
//            if (type.IsGenericType)
//            {
//                // Convert generic type to printable form (e.g. List<Item>)
//                String genericPrefix = type.Name.Substring(0, type.Name.IndexOf('`'));
//                StringBuilder nameBuilder = new StringBuilder(genericPrefix);
//
//                // Note: building array of generic parameters is done recursively. Each parameter could be any type.
//                string[] genericArgs = type.GetGenericArguments().ToList<Type>().ConvertAll<string>(t => GetPrintableTypeName(t)).ToArray<string>();
//
//                nameBuilder.Append("<");
//                nameBuilder.Append(string.Join(",", genericArgs));
//                nameBuilder.Append(">");
//                return nameBuilder.ToString();
//            }
//            else if (type.IsArray)
//            {
//                // Convert array type to printable form.
//                String arrayPrefix = type.Name.Substring(0, type.Name.IndexOf('['));
//                StringBuilder nameBuilder = new StringBuilder(EwsUtilities.GetSimplifiedTypeName(arrayPrefix));
//                for (int rank = 0; rank < type.GetArrayRank(); rank++)
//                {
//                    nameBuilder.Append("[]");
//                }
//                return nameBuilder.ToString();
//            }
//            else
//            {
//                return EwsUtilities.GetSimplifiedTypeName(type.Name);
//            }
//        }
//
//        /// <summary>
//        /// Gets the printable name of a simple CLR type.
//        /// </summary>
//        /// <param name="typeName">The type name.</param>
//        /// <returns>Printable name.</returns>
//        /* private */ static String GetSimplifiedTypeName(String typeName)
//        {
//            // If type has a shortname (e.g. int for Int32) map to the short name.
//            String name;
//            return typeNameToShortNameMap.Member.TryGetValue(typeName, out name) ? name : typeName;
//        }
//
//        #endregion
//
//        #region EmailAddress parsing

        /// <summary>
        /// Gets the domain name from an email address.
        /// </summary>
        /// <param name="emailAddress">The email address.</param>
        /// <returns>Domain name.</returns>
        static String DomainFromEmailAddress(String emailAddress)
        {
            List<String> emailAddressParts = emailAddress.split('@');

            if (emailAddressParts.length != 2 || StringUtils.IsNullOrEmpty(emailAddressParts[1]))
            {
                throw new FormatException("Strings.InvalidEmailAddress");
            }

            return emailAddressParts[1];
        }

//        #endregion
//
//        #region Method parameters validation routines
//
//        /// <summary>
//        /// Validates parameter (and allows null value).
//        /// </summary>
//        /// <param name="param">The param.</param>
//        /// <param name="paramName">Name of the param.</param>
//        static void ValidateParamAllowNull(object param, String paramName)
//        {
//            ISelfValidate selfValidate = param as ISelfValidate;
//
//            if (selfValidate != null)
//            {
//                try
//                {
//                    selfValidate.Validate();
//                }
//                catch (ServiceValidationException e)
//                {
//                    throw new ArgumentError(
//                        Strings.ValidationFailed,
//                        paramName,
//                        e);
//                }
//            }
//
//            ServiceObject ewsObject = param as ServiceObject;
//
//            if (ewsObject != null)
//            {
//                if (ewsObject.IsNew)
//                {
//                    throw new ArgumentError(Strings.ObjectDoesNotHaveId, paramName);
//                }
//            }
//        }

        /// <summary>
        /// Validates parameter (null value not allowed).
        /// </summary>
        /// <param name="param">The param.</param>
        /// <param name="paramName">Name of the param.</param>
        static void ValidateParam(Object param, String paramName)
        {
            bool isValid;

            if (param is String)
            {
                isValid = !StringUtils.IsNullOrEmpty(param);
            }
            else
            {
                isValid = param != null;
            }

            if (!isValid)
            {
                throw new ArgumentError.notNull(paramName);
            }

            ValidateParamAllowNull(param, paramName);
        }

        /// <summary>
        /// Validates parameter collection.
        /// </summary>
        /// <param name="collection">The collection.</param>
        /// <param name="paramName">Name of the param.</param>
//        static void ValidateParamCollection(Iterable collection, String paramName)
//        {
//            ValidateParam(collection, paramName);
//
//            int count = 0;
//
//            for (Object obj in collection)
//            {
//                try
//                {
//                    ValidateParam(obj, """string.Format("collection[{0}]", count)""");
//                }
//                on ArgumentError catch( e)
//                {
//                    throw new ArgumentError("""
//                        string.Format("The element at position {0} is invalid", count),
//                        paramName,
//                        e""");
//                }
//
//                count++;
//            }
//
//            if (count == 0)
//            {
//                throw new ArgumentError(""""Strings.CollectionIsEmpty", paramName""");
//            }
//        }

//        /// <summary>
//        /// Validates String parameter to be non-empty String (null value allowed).
//        /// </summary>
//        /// <param name="param">The String parameter.</param>
//        /// <param name="paramName">Name of the parameter.</param>
        static void ValidateNonBlankStringParamAllowNull(String param, String paramName)
        {
            if (param != null)
            {
              if (param.trim().isEmpty) {
                throw new ArgumentError("Strings.ArgumentIsBlankString, paramName");
              }
//                // Non-empty String has at least one character which is *not* a whitespace character
//                if (param.length == param.contains((c) => Char.IsWhiteSpace(c)))
//                {
//                    throw new ArgumentError(Strings.ArgumentIsBlankString, paramName);
//                }
            }
        }

        /// <summary>
        /// Validates String parameter to be non-empty String (null value not allowed).
        /// </summary>
        /// <param name="param">The String parameter.</param>
        /// <param name="paramName">Name of the parameter.</param>
        static void ValidateNonBlankStringParam(String param, String paramName)
        {
            if (param == null)
            {
                throw new prefix0.ArgumentError.notNull(paramName);
            }

            ValidateNonBlankStringParamAllowNull(param, paramName);
        }

        /// <summary>
        /// Validates the enum value against the request version.
        /// </summary>
        /// <param name="enumValue">The enum value.</param>
        /// <param name="requestVersion">The request version.</param>
        /// <exception cref="ServiceVersionException">Raised if this enum value requires a later version of Exchange.</exception>
        static void ValidateEnumVersionValue(Object enumValue, ExchangeVersion requestVersion)
        {
          // todo : implement ValidateEnumVersionValue
          print("!! unsafe ValidateEnumVersionValue");
//            Type enumType = enumValue.GetType();
//            Map<Enum, ExchangeVersion> enumVersionDict = enumVersionDictionaries.Member[enumType];
//            ExchangeVersion enumVersion = enumVersionDict[enumValue];
//            if (requestVersion < enumVersion)
//            {
//                throw new ServiceVersionException(
//                    string.Format(
//                                  Strings.EnumValueIncompatibleWithRequestVersion,
//                                  enumValue.ToString(),
//                                  enumType.Name,
//                                  enumVersion));
//            }
        }

//        /// <summary>
//        /// Validates service object version against the request version.
//        /// </summary>
//        /// <param name="serviceObject">The service object.</param>
//        /// <param name="requestVersion">The request version.</param>
//        /// <exception cref="ServiceVersionException">Raised if this service object type requires a later version of Exchange.</exception>
//        static void ValidateServiceObjectVersion(ServiceObject serviceObject, ExchangeVersion requestVersion)
//        {
//            ExchangeVersion minimumRequiredServerVersion = serviceObject.GetMinimumRequiredServerVersion();
//
//            if (requestVersion < minimumRequiredServerVersion)
//            {
//                throw new ServiceVersionException(
//                    string.Format(
//                    Strings.ObjectTypeIncompatibleWithRequestVersion,
//                    serviceObject.GetType().Name,
//                    minimumRequiredServerVersion));
//            }
//        }

        /// <summary>
        /// Validates property version against the request version.
        /// </summary>
        /// <param name="service">The Exchange service.</param>
        /// <param name="minimumServerVersion">The minimum server version that supports the property.</param>
        /// <param name="propertyName">Name of the property.</param>
        static void ValidatePropertyVersion(
            ExchangeService service,
            ExchangeVersion minimumServerVersion,
            String propertyName)
        {
            if (service.RequestedServerVersion.index < minimumServerVersion.index)
            {
                throw new ServiceVersionException(
                    """string.Format(
                    Strings.PropertyIncompatibleWithRequestVersion,
                    propertyName,
                    minimumServerVersion)""");
            }
        }

        /// <summary>
        /// Validates method version against the request version.
        /// </summary>
        /// <param name="service">The Exchange service.</param>
        /// <param name="minimumServerVersion">The minimum server version that supports the method.</param>
        /// <param name="methodName">Name of the method.</param>
        static void ValidateMethodVersion(
            ExchangeService service,
            ExchangeVersion minimumServerVersion,
            String methodName)
        {
            if (service.RequestedServerVersion.index < minimumServerVersion.index)
            {
                throw new ServiceVersionException(
                    """string.Format(
                    Strings.MethodIncompatibleWithRequestVersion,
                    methodName,
                    minimumServerVersion)""");
            }
        }

        /// <summary>
        /// Validates class version against the request version.
        /// </summary>
        /// <param name="service">The Exchange service.</param>
        /// <param name="minimumServerVersion">The minimum server version that supports the method.</param>
        /// <param name="className">Name of the class.</param>
        static void ValidateClassVersion(
            ExchangeService service,
            ExchangeVersion minimumServerVersion,
            String className)
        {
            if (service.RequestedServerVersion.index < minimumServerVersion.index)
            {
                throw new ServiceVersionException(
                    """string.Format(
                    Strings.ClassIncompatibleWithRequestVersion,
                    className,
                    minimumServerVersion)""");
            }
        }

        /// <summary>
        /// Validates domain name (null value allowed)
        /// </summary>
        /// <param name="domainName">Domain name.</param>
        /// <param name="paramName">Parameter name.</param>
        static void ValidateDomainNameAllowNull(String domainName, String paramName)
        {
            if (domainName != null)
            {
                RegExp regex = new RegExp(DomainRegex);

                if (!regex.hasMatch(domainName))
                {
                    throw new ArgumentError.value(domainName, paramName, "string.Format(Strings.InvalidDomainName, $domainName)");
                }
            }
        }

//        /// <summary>
//        /// Gets version for enum member.
//        /// </summary>
//        /// <param name="enumType">Type of the enum.</param>
//        /// <param name="enumName">The enum name.</param>
//        /// <returns>Exchange version in which the enum value was first defined.</returns>
//        /* private */ static ExchangeVersion GetEnumVersion(Type enumType, String enumName)
//        {
//            MemberInfo[] memberInfo = enumType.GetMember(enumName);
//            EwsUtilities.Assert(
//                                (memberInfo != null) && (memberInfo.Length > 0),
//                                "EwsUtilities.GetEnumVersion",
//                                "Enum member " + enumName + " not found in " + enumType);
//
//            object[] attrs = memberInfo[0].GetCustomAttributes(typeof(RequiredServerVersionAttribute), false);
//            if (attrs != null && attrs.Length > 0)
//            {
//                return ((RequiredServerVersionAttribute)attrs[0]).Version;
//            }
//            else
//            {
//                return ExchangeVersion.Exchange2007_SP1;
//            }
//        }
//
//        /// <summary>
//        /// Builds the enum to version mapping dictionary.
//        /// </summary>
//        /// <param name="enumType">Type of the enum.</param>
//        /// <returns>Dictionary of enum values to versions.</returns>
//        /* private */ static Map<Enum, ExchangeVersion> BuildEnumDict(Type enumType)
//        {
//            Map<Enum, ExchangeVersion> dict = new Map<Enum, ExchangeVersion>();
//            string[] names = Enum.GetNames(enumType);
//            for (String name in names)
//            {
//                Enum value = (Enum)Enum.Parse(enumType, name, false);
//                ExchangeVersion version = GetEnumVersion(enumType, name);
//                dict.Add(value, version);
//            }
//            return dict;
//        }
//
//        /// <summary>
//        /// Gets the schema name for enum member.
//        /// </summary>
//        /// <param name="enumType">Type of the enum.</param>
//        /// <param name="enumName">The enum name.</param>
//        /// <returns>The name for the enum used in the protocol, or null if it is the same as the enum's toString().</returns>
//        /* private */ static String GetEnumSchemaName(Type enumType, String enumName)
//        {
//            MemberInfo[] memberInfo = enumType.GetMember(enumName);
//            EwsUtilities.Assert(
//                                (memberInfo != null) && (memberInfo.Length > 0),
//                                "EwsUtilities.GetEnumSchemaName",
//                                "Enum member " + enumName + " not found in " + enumType);
//
//            object[] attrs = memberInfo[0].GetCustomAttributes(typeof(EwsEnumAttribute), false);
//            if (attrs != null && attrs.Length > 0)
//            {
//                return ((EwsEnumAttribute)attrs[0]).SchemaName;
//            }
//            else
//            {
//                return null;
//            }
//        }
//
//        /// <summary>
//        /// Builds the schema to enum mapping dictionary.
//        /// </summary>
//        /// <param name="enumType">Type of the enum.</param>
//        /// <returns>The mapping from enum to schema name</returns>
//        /* private */ static Map<string, Enum> BuildSchemaToEnumDict(Type enumType)
//        {
//            Map<string, Enum> dict = new Map<string, Enum>();
//            string[] names = Enum.GetNames(enumType);
//            for (String name in names)
//            {
//                Enum value = (Enum)Enum.Parse(enumType, name, false);
//                String schemaName = EwsUtilities.GetEnumSchemaName(enumType, name);
//
//                if (!StringUtils.IsNullOrEmpty(schemaName))
//                {
//                    dict.Add(schemaName, value);
//                }
//            }
//            return dict;
//        }

        /// <summary>
        /// Builds the enum to schema mapping dictionary.
        /// </summary>
        /// <param name="enumType">Type of the enum.</param>
        /// <returns>The mapping from enum to schema name</returns>
        /* private */ static Map<Object, String> BuildEnumToSchemaDict(Type enumType, List<Object> enumValues)
        {
            Map<Object, String> dict = new Map<Object, String>();
            enumValues.forEach((enumValue) {
              dict[enumValue] = GetEnumSchemaName(enumType, enumValue);
            });
//            string[] names = Enum.GetNames(enumType);
//            for (String name in names)
//            {
//                Enum value = (Enum)Enum.Parse(enumType, name, false);
//                String schemaName = EwsUtilities.GetEnumSchemaName(enumType, name);
//
//                if (!StringUtils.IsNullOrEmpty(schemaName))
//                {
//                    dict.Add(value, schemaName);
//                }
//            }
            return dict;
        }
//        #endregion
//
//        #region Iterable utility methods

        /// <summary>
        /// Gets the enumerated object count.
        /// </summary>
        /// <param name="objects">The objects.</param>
        /// <returns>Count of objects in Iterable.</returns>
        static int GetEnumeratedObjectCount(Iterable objects)
        {
            int count = 0;

            for (Object obj in objects)
            {
                count++;
            }

            return count;
        }

        /// <summary>
        /// Gets enumerated object at index.
        /// </summary>
        /// <param name="objects">The objects.</param>
        /// <param name="index">The index.</param>
        /// <returns>Object at index.</returns>
        static Object GetEnumeratedObjectAt(Iterable objects, int index)
        {
            int count = 0;

            for (Object obj in objects)
            {
                if (count == index)
                {
                    return obj;
                }

                count++;
            }

            throw new RangeError.range(index, 0, count, "index", "Strings.IterableDoesNotContainThatManyObject");
        }
//
//        #endregion
//
//        #region Extension methods
//        /// <summary>
//        /// Count characters in String that match a condition.
//        /// </summary>
//        /// <param name="str">The string.</param>
//        /// <param name="charPredicate">Predicate to evaluate for each character in the string.</param>
//        /// <returns>Count of characters that match condition expressed by predicate.</returns>
//        static int CountMatchingChars(this String str, Predicate<char> charPredicate)
//        {
//            int count = 0;
//            for (char ch in str)
//            {
//                if (charPredicate(ch))
//                {
//                    count++;
//                }
//            }
//
//            return count;
//        }
//
//        /// <summary>
//        /// Determines whether every element in the collection matches the conditions defined by the specified predicate.
//        /// </summary>
//        /// <typeparam name="T">Entry type.</typeparam>
//        /// <param name="collection">The collection.</param>
//        /// <param name="predicate">Predicate that defines the conditions to check against the elements.</param>
//        /// <returns>True if every element in the collection matches the conditions defined by the specified predicate; otherwise, false.</returns>
//        static bool TrueForAll<T>(this Iterable<T> collection, Predicate<T> predicate)
//        {
//            for (T entry in collection)
//            {
//                if (!predicate(entry))
//                {
//                    return false;
//                }
//            }
//
//            return true;
//        }
//
//        /// <summary>
//        /// Call an action for each member of a collection.
//        /// </summary>
//        /// <param name="collection">The collection.</param>
//        /// <param name="action">The action to apply.</param>
//        /// <typeparam name="T">Collection element type.</typeparam>
//        static void ForEach<T>(this Iterable<T> collection, Action<T> action)
//        {
//            for (T entry in collection)
//            {
//                action(entry);
//            }
//        }
//        #endregion
//    }
}