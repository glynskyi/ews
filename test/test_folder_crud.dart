import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

void main() {
  test('gets well known folders', () async {
    final service = prepareExchangeService(primaryUserCredential);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Notes);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Tasks);
    await Folder.BindWithWellKnownFolder(
        service, WellKnownFolderName.MsgFolderRoot);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Inbox);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Calendar);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Contacts);
  });

  test('creates a folder with unique name', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final folder = new Folder(service);
    folder.DisplayName = "test-${randomString()}";
    await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);

    await folder.Delete(DeleteMode.HardDelete);
  });

  test('creates a folder with duplicate name', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final duplicateName = "test-${randomString()}";
    final firstFolder = new Folder(service);
    firstFolder.DisplayName = duplicateName;
    await firstFolder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);

    final secondFolder = new Folder(service);
    secondFolder.DisplayName = duplicateName;

    dynamic expectedException = null;
    try {
      await secondFolder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);
    } on ServiceResponseException catch (e) {
      expectedException = e;
    }
    expect(expectedException, TypeMatcher<ServiceResponseException>());

    await firstFolder.Delete(DeleteMode.HardDelete);
  });

  test('searchs folder', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final view = new FolderView.withPageSize(100);
    view.PropertySet = new PropertySet.fromPropertySet(BasePropertySet.IdOnly);
    view.PropertySet!.Add(FolderSchema.DisplayName);
    SearchFilter searchFilter =
        new IsGreaterThan.withPropertyAndValue(FolderSchema.TotalCount, 0);
    view.Traversal = FolderTraversal.Deep;
    FindFoldersResults findFolderResults =
        await service.FindFoldersWithWellKnownFolder(
            WellKnownFolderName.MsgFolderRoot, searchFilter, view);
    findFolderResults.forEach((folder) {
      expect(folder.DisplayName, isNotNull);
    });
  });

  test('searches folder with extended property', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final meetingsFolderProperty =
        ExtendedPropertyDefinition.withDefaultPropertySetAndName(
            DefaultExtendedPropertySet.Common,
            "folder:meetingRoot",
            MapiPropertyType.Boolean);

    final view = new FolderView.withPageSize(100);
    view.PropertySet =
        new PropertySet.fromPropertyDefinitions([meetingsFolderProperty]);
    view.PropertySet!.Add(FolderSchema.DisplayName);
    SearchFilter searchFilter =
        new IsEqualTo.withPropertyAndValue(FolderSchema.TotalCount, 0);
    view.Traversal = FolderTraversal.Deep;
    FindFoldersResults findFolderResults =
        await service.FindFoldersWithWellKnownFolder(
            WellKnownFolderName.MsgFolderRoot, searchFilter, view);
    findFolderResults.forEach((folder) {
      expect(folder.DisplayName, isNotNull);
    });
  });

  test('empties folder with sub folder', () async {
    final service = prepareExchangeService(
        primaryUserCredential, ExchangeVersion.Exchange2013);
    final duplicateName = "test-${randomString()}";
    final folder = new Folder(service);
    folder.DisplayName = duplicateName;
    await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);

    await service.EmptyFolder(folder.Id, DeleteMode.HardDelete, true);
  });
}
