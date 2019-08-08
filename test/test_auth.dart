import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

void main() {
  test('uses the wrong credentials', () async {
    final service = prepareExchangeService(wrongUserCredential);

    expect(Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Notes),
        throwsA(const TypeMatcher<ServiceRequestException>()));
  });
}
