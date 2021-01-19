import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  test('reads shared folder as reviewer', () async {
    final primaryExchangeService =
        prepareExchangeService(primaryUserCredential);
    final secondExchangeService =
        prepareExchangeService(secondaryUserCredential);

    FolderPermission reviewerPermission = new FolderPermission.withSmtpAddress(
        secondaryUserCredential.user, FolderPermissionLevel.Reviewer);

    final primaryFolder = Folder(primaryExchangeService);
    primaryFolder.DisplayName = randomString().toString();
    primaryFolder.Permissions.Add(reviewerPermission);
    await primaryFolder.Save(
        FolderId.fromWellKnownFolder(WellKnownFolderName.Notes));

    await Folder.Bind(secondExchangeService, primaryFolder.Id);

    await primaryFolder.Delete(DeleteMode.HardDelete);
  });

  test('reads shared folder as unknown', () async {
    final primaryExchangeService =
        prepareExchangeService(primaryUserCredential);
    final secondExchangeService =
        prepareExchangeService(secondaryUserCredential);

    final primaryFolder = Folder(primaryExchangeService);
    primaryFolder.DisplayName = randomString().toString();
    await primaryFolder.Save(
        FolderId.fromWellKnownFolder(WellKnownFolderName.Notes));

    expect(Folder.Bind(secondExchangeService, primaryFolder.Id),
        throwsA(const TypeMatcher<ServiceResponseException>()));

    await primaryFolder.Delete(DeleteMode.HardDelete);
  });
}
