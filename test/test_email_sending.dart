import 'dart:convert';
import 'dart:typed_data';

import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

void main() {
  test("sends an email with an attachment", () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);
    final message = EmailMessage(exchangeService)
      ..Subject = 'test message'
      ..Body = MessageBody.withText('line1\nline2\n\nBye', BodyType.Text)
      ..ToRecipients.Add(EmailAddress(smtpAddress: "test@test.com"));
    final fileContent = Uint8List.fromList(utf8.encode("Hello world"));
    message.Attachments.AddFileAttachmentWithContent(
        'filename.txt', fileContent);
    await message.Save();
    await Future.delayed(Duration(seconds: 5));
    final draftMessage = await EmailMessage.Bind(
        exchangeService, message.Id, PropertySet.FirstClassProperties);
    await draftMessage.Send();
  });
}
