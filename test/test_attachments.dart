import 'dart:convert';

import 'package:ews/ews.dart';
import 'package:test/test.dart';
import 'package:uuid_enhanced/uuid.dart';

import '_shared.dart';

void main() {
  test('gets the attachment list', () async {
    final service = prepareExchangeService(primaryUserCredential);
    final messageSubject = "test-${Uuid.randomUuid()}";
    final attachmentSpan = "<span>${Uuid.randomUuid()}</span>";
    final attachmentContent = "<html><body>$attachmentSpan</body></html>";

    final message = EmailMessage(service);
    message.Subject = messageSubject;
    message.Attachments.AddFileAttachmentWithContent(
        "attachment.html", utf8.encode(attachmentContent));
    await message.Save();

    final testMessage = await EmailMessage.Bind(
        service,
        message.Id,
        PropertySet.fromPropertyDefinitions(
            [ItemSchema.Subject, ItemSchema.Attachments]));
    expect(testMessage.Subject, messageSubject);
    expect(testMessage.Attachments.Count, 1);

    final testAttachment = testMessage.Attachments.first as FileAttachment;
    await testAttachment.Load();
    final testContent = utf8.decode(testAttachment.Content);
    expect(testContent, contains(attachmentSpan));

    await message.Delete(DeleteMode.HardDelete);
  });
}
