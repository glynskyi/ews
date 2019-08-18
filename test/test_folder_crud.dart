import 'package:ews/ews.dart';
import 'package:test/test.dart';
import 'package:uuid_enhanced/uuid.dart';

import '_shared.dart';

void main() {
  test('gets well known folders', () async {
    final service = prepareExchangeService(primaryUserCredential);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Notes);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Tasks);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.MsgFolderRoot);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Inbox);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Calendar);
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Contacts);
  });

  test('creates a folder with unique name', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final folder = new Folder(service);
    folder.DisplayName = "test-${Uuid.randomUuid()}";
    await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);

    await folder.Delete(DeleteMode.HardDelete);
  });

  test('creates a folder with duplicate name', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final duplicateName = "test-${Uuid.randomUuid()}";
    final firstFolder = new Folder(service);
    firstFolder.DisplayName = duplicateName;
    await firstFolder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);

    final secondFolder = new Folder(service);
    secondFolder.DisplayName = duplicateName;
    expect(secondFolder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes),
        throwsA(TypeMatcher<ServiceResponseException>()));

    await firstFolder.Delete(DeleteMode.HardDelete);
  });

  test('searchs folder', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final view = new FolderView.withPageSize(100);
    view.PropertySet = new PropertySet.fromPropertySet(BasePropertySet.IdOnly);
    view.PropertySet.Add(FolderSchema.DisplayName);
    SearchFilter searchFilter = new IsGreaterThan.withPropertyAndValue(FolderSchema.TotalCount, 0);
    view.Traversal = FolderTraversal.Deep;
    FindFoldersResults findFolderResults = await service.FindFoldersWithWellKnownFolder(
        WellKnownFolderName.MsgFolderRoot, searchFilter, view);
    findFolderResults.forEach((folder) {
      print(folder.DisplayName);
    });
  });

  test('searches folder with extended property', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final meetingsFolderProperty = ExtendedPropertyDefinition.withDefaultPropertySetAndName(
        DefaultExtendedPropertySet.Common, "folder:meetingRoot", MapiPropertyType.Boolean);

    final view = new FolderView.withPageSize(100);
    view.PropertySet = new PropertySet.fromPropertyDefinitions([meetingsFolderProperty]);
    view.PropertySet.Add(FolderSchema.DisplayName);
    SearchFilter searchFilter = new IsEqualTo.withPropertyAndValue(FolderSchema.TotalCount, 0);
    view.Traversal = FolderTraversal.Deep;
    FindFoldersResults findFolderResults = await service.FindFoldersWithWellKnownFolder(
        WellKnownFolderName.MsgFolderRoot, searchFilter, view);
//    findFolderResults.forEach((folder) {
//      print(folder.DisplayName);
//      folder.ExtendedProperties.forEach((prop) {
//        print(".. ${prop.PropertyDefinition} ${prop.value}");
//      });
//    });
//
//    print(findFolderResults.MoreAvailable);
  });
}
