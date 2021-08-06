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
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/EventType.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Notifications/FolderEvent.dart';
import 'package:ews/Notifications/ItemEvent.dart';
import 'package:ews/Notifications/NotificationEvent.dart';

/// <summary>
/// Represents a collection of notification events.
/// </summary>
class GetEventsResults {
  /// <summary>
  /// Map XML element name to notification event type.
  /// </summary>
  /// <remarks>
  /// If you add a new notification event type, you'll need to add a new entry to the dictionary here.
  /// </remarks>
  static LazyMember<Map<String, EventType>> _xmlElementNameToEventTypeMap =
      new LazyMember<Map<String, EventType>>(() => {
            XmlElementNames.CopiedEvent: EventType.Copied,
            XmlElementNames.CreatedEvent: EventType.Created,
            XmlElementNames.DeletedEvent: EventType.Deleted,
            XmlElementNames.ModifiedEvent: EventType.Modified,
            XmlElementNames.MovedEvent: EventType.Moved,
            XmlElementNames.NewMailEvent: EventType.NewMail,
            XmlElementNames.StatusEvent: EventType.Status,
            XmlElementNames.FreeBusyChangedEvent: EventType.FreeBusyChanged
          });

  /// <summary>
  /// Gets the XML element name to event type mapping.
  /// </summary>
  /// <value>The XML element name to event type mapping.</value>
  static Map<String, EventType>? get XmlElementNameToEventTypeMap =>
      GetEventsResults._xmlElementNameToEventTypeMap.Member;

  /// <summary>
  /// Watermark in event.
  /// </summary>
  String? _newWatermark;

  /// <summary>
  /// Subscription id.
  /// </summary>
  String? _subscriptionId;

  /// <summary>
  /// Previous watermark.
  /// </summary>
  String? _previousWatermark;

  /// <summary>
  /// True if more events available for this subscription.
  /// </summary>
  bool? _moreEventsAvailable;

  /// <summary>
  /// Collection of notification events.
  /// </summary>
  List<NotificationEvent> _events = <NotificationEvent>[];

  /// <summary>
  /// Initializes a new instance of the <see cref="GetEventsResults"/> class.
  /// </summary>
  GetEventsResults() {}

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  Future<void> LoadFromXml(EwsServiceXmlReader reader) async {
    await reader.ReadStartElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.Notification);

    this._subscriptionId = await reader.ReadElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.SubscriptionId);
    this._previousWatermark = await reader.ReadElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.PreviousWatermark);
    this._moreEventsAvailable =
        await reader.ReadElementValueWithNamespace<bool>(
            XmlNamespace.Types, XmlElementNames.MoreEvents);

    do {
      await reader.Read();

      if (reader.IsStartElement()) {
        String eventElementName = reader.LocalName;

        if (_xmlElementNameToEventTypeMap.Member!
            .containsKey(eventElementName)) {
          EventType? eventType =
              _xmlElementNameToEventTypeMap.Member![eventElementName];
          this._newWatermark = await reader.ReadElementValueWithNamespace(
              XmlNamespace.Types, XmlElementNames.Watermark);

          if (eventType == EventType.Status) {
            // We don't need to return status events
            await reader.ReadEndElementIfNecessary(
                XmlNamespace.Types, eventElementName);
          } else {
            await this._LoadNotificationEventFromXml(
                reader, eventElementName, eventType);
          }
        } else {
          await reader.SkipCurrentElement();
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.Notification));
  }

  /// <summary>
  /// Loads a notification event from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="eventElementName">Name of the event XML element.</param>
  /// <param name="eventType">Type of the event.</param>
  Future<void> _LoadNotificationEventFromXml(EwsServiceXmlReader reader,
      String eventElementName, EventType? eventType) async {
    DateTime? timestamp = await reader.ReadElementValueWithNamespace<DateTime>(
        XmlNamespace.Types, XmlElementNames.TimeStamp);

    NotificationEvent notificationEvent;

    await reader.Read();

    if (reader.LocalName == XmlElementNames.FolderId) {
      notificationEvent = new FolderEvent(eventType, timestamp);
    } else {
      notificationEvent = new ItemEvent(eventType, timestamp);
    }

    await notificationEvent.LoadFromXml(reader, eventElementName);
    this._events.add(notificationEvent);
  }

  /// <summary>
  /// Gets the Id of the subscription the collection is associated with.
  /// </summary>
  String? get SubscriptionId => this._subscriptionId;

  /// <summary>
  /// Gets the subscription's previous watermark.
  /// </summary>
  String? get PreviousWatermark => this._previousWatermark;

  /// <summary>
  /// Gets the subscription's new watermark.
  /// </summary>
  String? get NewWatermark => this._newWatermark;

  /// <summary>
  /// Gets a value indicating whether more events are available on the Exchange server.
  /// </summary>
  bool? get MoreEventsAvailable => this._moreEventsAvailable;

  /// <summary>
  /// Gets the collection of folder events.
  /// </summary>
  /// <value>The folder events.</value>
  Iterable<FolderEvent> get FolderEvents =>
      this._events.where((event) => event is FolderEvent)
          as Iterable<FolderEvent>;

  /// <summary>
  /// Gets the collection of item events.
  /// </summary>
  /// <value>The item events.</value>
  Iterable<ItemEvent> get ItemEvents =>
      this._events.where((event) => event is ItemEvent) as Iterable<ItemEvent>;

  /// <summary>
  /// Gets the collection of all events.
  /// </summary>
  /// <value>The events.</value>
  List<NotificationEvent> get AllEvents => this._events;
}
