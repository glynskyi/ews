import 'dart:async';

import 'package:ews/Notifications/FolderEvent.dart';
import 'package:ews/Notifications/ItemEvent.dart';
import 'package:ews/Notifications/NotificationEvent.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  ExchangeService? service;
  Completer<Iterable<NotificationEvent>>? completer;
  StreamingSubscriptionConnection? connection;

  setUpAll(() async {
    service = prepareExchangeService(primaryUserCredential);
  });

  setUp(() async {
    print("!!!!!!!!!!!!!!!!!!!!!!!! setUp");
    completer = Completer<Iterable<NotificationEvent>>();
    final subscription = await service!.SubscribeToStreamingNotifications([
      FolderId.fromWellKnownFolder(WellKnownFolderName.Notes)
    ], [
      EventType.Created,
      EventType.Modified,
      EventType.Deleted,
    ]);
    await Future.delayed(const Duration(seconds: 3));
    connection = new StreamingSubscriptionConnection(service!, 30)
      ..AddSubscription(subscription)
      ..OnNotificationEvent.add((sender, args) {
        print("OnNotificationEvent(${args.Events}, ${args.Subscription})");
        completer?.complete(args.Events);
      })
      ..OnDisconnect.add((sender, args) {
        print("OnDisconnect(${args.Exception})");
      });
    await connection!.Open();
  });

  tearDown(() async {
    print("!!!!!!!!!!!!!!!!!!!!!!!! tearDown");
    await connection?.Close();
    connection = null;
    completer = null;
    print("!!!!!!!! tearDown");
  });

  test('observes item creation', () async {
    // act
    final message = EmailMessage(service!);
    message.Subject = "Test Subscription";
    await message.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);

    // assert
    final notificationEvents = await completer!.future;
    expect(
        notificationEvents,
        contains(predicate((event) =>
            event is FolderEvent && event.EventType == EventType.Modified)));
    expect(
        notificationEvents,
        contains(predicate((event) =>
            event is ItemEvent && event.EventType == EventType.Created)));
  });

  test('observes item updating', () async {
    // act
    final message = EmailMessage(service!);
    message.Subject = "Test Subscription";
    await message.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);
    message.Subject = "Test Subscription 2";
    await message.Update(ConflictResolutionMode.AlwaysOverwrite);

    // assert
    final notificationEvents = await completer!.future;
    expect(
        notificationEvents,
        contains(predicate((event) =>
            event is FolderEvent && event.EventType == EventType.Modified)));
    expect(
        notificationEvents,
        contains(predicate((event) =>
            event is ItemEvent && event.EventType == EventType.Created)));
    expect(
        notificationEvents,
        contains(predicate((event) =>
            event is ItemEvent && event.EventType == EventType.Modified)));
  });

  test('observes item deleting', () async {
    // act
    final message = EmailMessage(service!);
    message.Subject = "Test Subscription";
    await message.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);
    await message.Delete(DeleteMode.HardDelete);

    // assert
    final notificationEvents = await completer!.future;
    expect(
        notificationEvents,
        contains(predicate((event) =>
            event is FolderEvent && event.EventType == EventType.Modified)));
    expect(
        notificationEvents,
        contains(predicate((event) =>
            event is ItemEvent && event.EventType == EventType.Created)));
    expect(
        notificationEvents,
        contains(predicate((event) =>
            event is ItemEvent && event.EventType == EventType.Deleted)));
  });
}
