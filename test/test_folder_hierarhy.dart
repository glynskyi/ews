import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Enumerations/SyncFolderItemsScope.dart';
import 'package:ews/Enumerations/WellKnownFolderName.dart';
import 'package:ews/Sync/ChangeCollection.dart';
import 'package:ews/Sync/FolderChange.dart';
import 'package:ews/Sync/ItemChange.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  test('syncs folder hierarhy', () async {
    final service = prepareExchangeService();
    ChangeCollection<FolderChange> fcc = await service.SyncFolderHierarchy(
        new FolderId.fromWellKnownFolder(WellKnownFolderName.Root), PropertySet.IdOnly, "");
    print(fcc.syncState);
  });

  test('syncs folder items', () async {
    final service = prepareExchangeService();
    ChangeCollection<ItemChange> icc = await service.SyncFolderItems(
        new FolderId.fromWellKnownFolder(WellKnownFolderName.Inbox),
        PropertySet.FirstClassProperties,
        null,
        512,
        SyncFolderItemsScope.NormalItems,
        null);
  });
}
