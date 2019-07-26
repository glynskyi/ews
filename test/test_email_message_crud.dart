import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Search/ItemView.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

void main() {
  test('gets notes folder', () async {
    final service = prepareExchangeService();
    final notesFolderId = FolderId.fromWellKnownFolder(WellKnownFolderName.Notes);
    ItemView itemView = ItemView.withPageSize(1);
    itemView.propertySet = PropertySet.idOnly();
    final response = await service.FindItemsGeneric<EmailMessage>(
        [notesFolderId], null, null, itemView, null, ServiceErrorHandling.ThrowOnError);
    List<EmailMessage> results = response[0].Results.toList();
    final propertySet = PropertySet.fromPropertyDefinitions([ItemSchema.Body]);
    for (final emailMessage in results) {
      await emailMessage.LoadWithPropertySet(propertySet);
      print(emailMessage.Body.Text);
    }
  });
}
