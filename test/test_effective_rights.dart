import 'package:ews/ews.dart';
import 'package:test/test.dart';
import 'package:uuid_enhanced/uuid.dart';

import '_shared.dart';

main() {
  test('gets the item effective rights', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);
    final sourceMessage = EmailMessage(exchangeService);
    sourceMessage.Subject = Uuid.randomUuid().toString();

    await sourceMessage.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);

    final propertySet = PropertySet(BasePropertySet.FirstClassProperties, [
      ItemSchema.Subject,
      ItemSchema.EffectiveRights,
    ]);
    final message =
        await exchangeService.BindToItemGeneric<EmailMessage>(sourceMessage.Id, propertySet);
    
    expect(message.EffectiveRights, contains(EffectiveRights.Delete));
    expect(message.EffectiveRights, isNot(contains(EffectiveRights.CreateHierarchy)));
  });
}
