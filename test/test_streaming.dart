import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  test('streaming', () async {
    final service = prepareExchangeService();
    final subscription = await service.SubscribeToStreamingNotifications(
        [ FolderId.fromWellKnownFolder(WellKnownFolderName.Inbox) ],
        [EventType.NewMail,
        EventType.Created,
        EventType.Deleted,
        EventType.Modified,
        EventType.Moved,
        EventType.Copied,
        EventType.FreeBusyChanged]);
    StreamingSubscriptionConnection connection = new StreamingSubscriptionConnection(service, 30);
    connection.AddSubscription(subscription);
//    connection.OnNotificationEvent += OnNotificationEvent;
//    connection.OnDisconnect += OnDisconnect;
    connection.Open();
  });
}