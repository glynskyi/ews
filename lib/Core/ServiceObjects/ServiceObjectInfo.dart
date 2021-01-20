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

import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/ServiceObjects/Folders/CalendarFolder.dart';
import 'package:ews/Core/ServiceObjects/Folders/ContactsFolder.dart';
import 'package:ews/Core/ServiceObjects/Folders/Folder.dart';
import 'package:ews/Core/ServiceObjects/Folders/SearchFolder.dart';
import 'package:ews/Core/ServiceObjects/Folders/TasksFolder.dart';
import 'package:ews/Core/ServiceObjects/Items/Appointment.dart';
import 'package:ews/Core/ServiceObjects/Items/Contact.dart';
import 'package:ews/Core/ServiceObjects/Items/ContactGroup.dart';
import 'package:ews/Core/ServiceObjects/Items/EmailMessage.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/Items/MeetingCancellation.dart';
import 'package:ews/Core/ServiceObjects/Items/MeetingMessage.dart';
import 'package:ews/Core/ServiceObjects/Items/MeetingRequest.dart';
import 'package:ews/Core/ServiceObjects/Items/MeetingResponse.dart';
import 'package:ews/Core/ServiceObjects/Items/Task.dart';
import 'package:ews/Core/XmlElementNames.dart';

typedef Object CreateServiceObjectWithServiceParam(ExchangeService? srv);

typedef Object CreateServiceObjectWithAttachmentParam(ItemAttachment itemAttachment, bool isNew);

/// <summary>
/// ServiceObjectInfo contains metadata on how to map from an element name to a ServiceObject type
/// as well as how to map from a ServiceObject type to appropriate constructors.
/// </summary>
class ServiceObjectInfo {
  Map<String, Type> _xmlElementNameToServiceObjectClassMap = {};
  Map<Type, CreateServiceObjectWithServiceParam> _serviceObjectConstructorsWithServiceParam = {};
  Map<Type, CreateServiceObjectWithAttachmentParam> _serviceObjectConstructorsWithAttachmentParam =
      {};

  /// <summary>
  /// Default constructor
  /// </summary>
  ServiceObjectInfo() {
    this._InitializeServiceObjectClassMap();
  }

  /// <summary>
  /// Initializes the service object class map.
  /// </summary>
  /// <remarks>
  /// If you add a new ServiceObject subclass that can be returned by the Server, add the type
  /// to the class map as well as associated delegate(s) to call the constructor(s).
  /// </remarks>
  void _InitializeServiceObjectClassMap() {
    // TODO("restore types for service object infos map")
    // Appointment
    this.AddServiceObjectType(XmlElementNames.CalendarItem, Appointment, (ExchangeService? srv) {
      return new Appointment(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new Appointment.withAttachment(itemAttachment, isNew);
    });

    // CalendarFolder
    this.AddServiceObjectType(XmlElementNames.CalendarFolder, CalendarFolder,
        (ExchangeService? srv) {
      return new CalendarFolder(srv!);
    }, null);

    // Contact
    this.AddServiceObjectType(XmlElementNames.Contact, Contact, (ExchangeService? srv) {
      return new Contact(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new Contact.withAttachment(itemAttachment);
    });

    // ContactsFolder
    this.AddServiceObjectType(XmlElementNames.ContactsFolder, ContactsFolder,
        (ExchangeService? srv) {
      return new ContactsFolder(srv!);
    }, null);

    // ContactGroup
    this.AddServiceObjectType(XmlElementNames.DistributionList, ContactGroup,
        (ExchangeService? srv) {
      return new ContactGroup(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new ContactGroup.withAttachment(itemAttachment);
    });

    // Conversation
//            this.AddServiceObjectType(
//                XmlElementNames.Conversation,
//                typeof(Conversation),
//                delegate(ExchangeService srv) { return new Conversation(srv); },
//                null);

    // EmailMessage
    this.AddServiceObjectType(XmlElementNames.Message, EmailMessage, (ExchangeService? srv) {
      return new EmailMessage(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new EmailMessage.withAttachment(itemAttachment);
    });

    // Folder
    this.AddServiceObjectType(XmlElementNames.Folder, Folder, (ExchangeService? srv) {
      return new Folder(srv!);
    }, null);

    // Item
    this.AddServiceObjectType(XmlElementNames.Item, Item, (ExchangeService? srv) {
      return new Item(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new Item.withAttachment(itemAttachment);
    });

    // MeetingCancellation
    this.AddServiceObjectType(XmlElementNames.MeetingCancellation, MeetingCancellation,
        (ExchangeService? srv) {
      return new MeetingCancellation(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new MeetingCancellation.withAttachment(itemAttachment);
    });

    // MeetingMessage
    this.AddServiceObjectType(XmlElementNames.MeetingMessage, MeetingMessage,
        (ExchangeService? srv) {
      return new MeetingMessage(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new MeetingMessage.withAttachment(itemAttachment);
    });

    // MeetingRequest
    this.AddServiceObjectType(XmlElementNames.MeetingRequest, MeetingRequest,
        (ExchangeService? srv) {
      return new MeetingRequest(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new MeetingRequest.withAttachment(itemAttachment);
    });

    // MeetingResponse
    this.AddServiceObjectType(XmlElementNames.MeetingResponse, MeetingResponse,
        (ExchangeService? srv) {
      return new MeetingResponse(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new MeetingResponse.withAttachment(itemAttachment);
    });

    // Persona
//            this.AddServiceObjectType(
//                XmlElementNames.Persona,
//                typeof(Persona),
//                delegate(ExchangeService srv) { return new Persona(srv); },
//                null);

    // PostItem
//            this.AddServiceObjectType(
//                XmlElementNames.PostItem,
//                typeof(PostItem),
//                delegate(ExchangeService srv) { return new PostItem(srv); },
//                delegate(ItemAttachment itemAttachment, bool isNew) { return new PostItem(itemAttachment); });

    // SearchFolder
    this.AddServiceObjectType(XmlElementNames.SearchFolder, SearchFolder, (ExchangeService? srv) {
      return new SearchFolder(srv!);
    }, null);

    // Task
    this.AddServiceObjectType(XmlElementNames.Task, Task, (ExchangeService? srv) {
      return new Task(srv!);
    }, (ItemAttachment itemAttachment, bool isNew) {
      return new Task.withAttachment(itemAttachment);
    });

    // TasksFolder
    this.AddServiceObjectType(XmlElementNames.TasksFolder, TasksFolder, (ExchangeService? srv) {
      return new TasksFolder(srv!);
    }, null);
  }

  /// <summary>
  /// Adds specified type of service object to map.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="type">The ServiceObject type.</param>
  /// <param name="createServiceObjectWithServiceParam">Delegate to create service object with service param.</param>
  /// <param name="createServiceObjectWithAttachmentParam">Delegate to create service object with attachment param.</param>
  /* private */
  void AddServiceObjectType(
      String xmlElementName,
      Type type,
      CreateServiceObjectWithServiceParam createServiceObjectWithServiceParam,
      CreateServiceObjectWithAttachmentParam? createServiceObjectWithAttachmentParam) {
    this._xmlElementNameToServiceObjectClassMap[xmlElementName] = type;
    this._serviceObjectConstructorsWithServiceParam[type] = createServiceObjectWithServiceParam;
    if (createServiceObjectWithAttachmentParam != null) {
      this._serviceObjectConstructorsWithAttachmentParam[type] =
          createServiceObjectWithAttachmentParam;
    }
  }

  /// <summary>
  /// Return Dictionary that maps from element name to ServiceObject Type.
  /// </summary>
  Map<String, Type> get XmlElementNameToServiceObjectClassMap =>
      this._xmlElementNameToServiceObjectClassMap;

  /// <summary>
  /// Return Dictionary that maps from ServiceObject Type to CreateServiceObjectWithServiceParam delegate with ExchangeService parameter.
  /// </summary>
  Map<Type, CreateServiceObjectWithServiceParam> get ServiceObjectConstructorsWithServiceParam =>
      this._serviceObjectConstructorsWithServiceParam;

  /// <summary>
  /// Return Dictionary that maps from ServiceObject Type to CreateServiceObjectWithAttachmentParam delegate with ItemAttachment parameter.
  /// </summary>
  Map<Type, CreateServiceObjectWithAttachmentParam>
      get ServiceObjectConstructorsWithAttachmentParam =>
          this._serviceObjectConstructorsWithAttachmentParam;
}
