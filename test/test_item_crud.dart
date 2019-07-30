import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.MonthlyPattern.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';
import 'package:timezone/standalone.dart';

import '_shared.dart';

main() {
  test('creates task', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);

    await initializeTimeZone();
//    final kiev = getLocation('Europe/Kiev');
    final date = new DateTime(2014, 11, 17);


    Task taskItem = new Task(exchangeService);
    taskItem.Subject = "Monthly Review";
    taskItem.Body = MessageBody.withText("Monthly Review from 11th to 20th");
    taskItem.StartDate = new DateTime(2012, 04, 11, 10, 00, 00);
    taskItem.DueDate = new DateTime(2012, 04, 20, 10, 00, 00);
//    taskItem.Recurrence = MonthlyPattern.withStartDateAndIntervalAndDayOfMonth(TZDateTime(2012, 04, 11, 10, 0, 0), 1, 11);
//    taskItem.Recurrence.StartDate = DateTime(2012, 04, 11, 10, 0, 0);
    taskItem.Recurrence.NumberOfOccurrences = 5;

    await taskItem.SaveWithWellKnownFolderName(WellKnownFolderName.Tasks);

//    await Future.delayed(Duration(seconds: 10));
  });
}