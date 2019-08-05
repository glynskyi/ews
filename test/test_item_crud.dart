import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';
import 'package:timezone/standalone.dart';
import 'package:uuid_enhanced/uuid.dart';

import '_shared.dart';

main() {
  test('creates task', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);

    await initializeTimeZone();
    final kiev = getLocation('Europe/Kiev');

    Task taskItem = new Task(exchangeService);
    taskItem.Subject = "Monthly Review";
    taskItem.Body = MessageBody.withText("Monthly Review from 11th to 20th");
    taskItem.StartDate = new DateTime(2012, 04, 11, 10, 00, 00);
    taskItem.DueDate = new DateTime(2012, 04, 20, 10, 00, 00);
    taskItem.Recurrence = MonthlyPattern.withStartDateAndIntervalAndDayOfMonth(TZDateTime(kiev, 2012, 04, 11, 10, 0, 0), 1, 11);
    taskItem.Recurrence.StartDate = TZDateTime(kiev, 2012, 04, 11, 10, 0, 0);
    taskItem.Recurrence.NumberOfOccurrences = 5;

    await taskItem.SaveWithWellKnownFolderName(WellKnownFolderName.Tasks);
  });

  test('updates email message', () async {
    final updatedSubject = Uuid.randomUuid().toString();
    final exchangeService = prepareExchangeService(primaryUserCredential);
    final emailMessage = EmailMessage(exchangeService);
    emailMessage.Subject = Uuid.randomUuid().toString();
    await emailMessage.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);

    final updatedEmailMessage =
        await EmailMessage.Bind(exchangeService, emailMessage.Id, PropertySet.FirstClassProperties);
    updatedEmailMessage.Subject = updatedSubject;
    await updatedEmailMessage.Update(ConflictResolutionMode.AlwaysOverwrite);

    final foundEmailMessage =
        await EmailMessage.Bind(exchangeService, updatedEmailMessage.Id, PropertySet.FirstClassProperties);
    expect(foundEmailMessage.Subject, updatedSubject);
  });
}
