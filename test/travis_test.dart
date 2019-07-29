import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

void main() {
  test('travis', () async {
    final service = prepareExchangeService();
    await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.Notes);
  });
}
