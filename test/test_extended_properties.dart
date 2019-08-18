import 'package:ews/Enumerations/TaskStatus.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

ExtendedPropertyDefinition AssigneeName = ExtendedPropertyDefinition.withDefaultPropertySetAndName(
    DefaultExtendedPropertySet.Common, "item:meetings:assigneeName", MapiPropertyType.String);

ExtendedPropertyDefinition AssigneeMail = ExtendedPropertyDefinition.withDefaultPropertySetAndName(
    DefaultExtendedPropertySet.Common, "item:meetings:assigneeMail", MapiPropertyType.String);

void main() {
  test('creates task with extended properties', () async {
    final service = prepareExchangeService(primaryUserCredential);

    Task task = Task(service);
    task.Subject = "New Task #0";
    task.Status = TaskStatus.NotStarted;
    task.SetExtendedProperty(AssigneeName, "mail@domain.com");
    task.SetExtendedProperty(AssigneeMail, "FirstName LastName");
    await task.Save();

    await task.Delete(DeleteMode.HardDelete);
  });

  test('updates task with extended properties', () async {
    final service = prepareExchangeService(primaryUserCredential);
    Task task = Task(service);
    task.Subject = "New Task #0";
    task.Status = TaskStatus.NotStarted;
    await task.Save();

    Task updatedTask = await Task.BindWithItemId(service, task.Id);
    updatedTask.SetExtendedProperty(AssigneeName, "mail@domain.com");
    updatedTask.SetExtendedProperty(AssigneeMail, "FirstName LastName");
    await updatedTask.Update(ConflictResolutionMode.AlwaysOverwrite);

    await updatedTask.Delete(DeleteMode.HardDelete);
  });
}
