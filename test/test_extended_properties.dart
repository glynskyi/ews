import 'package:ews/Enumerations/TaskStatus.dart';
import 'package:ews/ews.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:test/test.dart';

import '_shared.dart';

ExtendedPropertyDefinition AssigneeName =
    ExtendedPropertyDefinition.withDefaultPropertySetAndName(
  DefaultExtendedPropertySet.Common,
  "item:meetings:assigneeName",
  MapiPropertyType.String,
);

ExtendedPropertyDefinition IsAssigned =
    ExtendedPropertyDefinition.withDefaultPropertySetAndName(
  DefaultExtendedPropertySet.Common,
  "item:meetings:isAssigned",
  MapiPropertyType.Boolean,
);

ExtendedPropertyDefinition AssigneeAge =
    ExtendedPropertyDefinition.withDefaultPropertySetAndName(
  DefaultExtendedPropertySet.Common,
  "item:meetings:AssigneeAge",
  MapiPropertyType.Integer,
);

void main() {
  test('creates task with extended properties', () async {
    final service = prepareExchangeService(primaryUserCredential);

    Task sourceTask = Task(service);
    sourceTask.Subject = "New Task #0";
    sourceTask.Status = TaskStatus.NotStarted;
    sourceTask.SetExtendedProperty(AssigneeName, "mail@domain.com");
    sourceTask.SetExtendedProperty(IsAssigned, true);
    sourceTask.SetExtendedProperty(AssigneeAge, 42);
    await sourceTask.Save();

    final task = await Task.BindWithPropertySet(
        service,
        sourceTask.Id,
        PropertySet.fromPropertyDefinitions(
            [AssigneeName, IsAssigned, AssigneeAge]));

    final assigneeName = OutParam<String>();
    final isAssigned = OutParam<bool>();
    final assigneeAge = OutParam<int>();

    task.ExtendedProperties.TryGetValue<String>(AssigneeName, assigneeName);
    task.ExtendedProperties.TryGetValue<bool>(IsAssigned, isAssigned);
    task.ExtendedProperties.TryGetValue<int>(AssigneeAge, assigneeAge);

    expect("mail@domain.com", assigneeName.param);
    expect(true, isAssigned.param);
    expect(42, assigneeAge.param);

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
    updatedTask.SetExtendedProperty(IsAssigned, true);
    await updatedTask.Update(ConflictResolutionMode.AlwaysOverwrite);

    await updatedTask.Delete(DeleteMode.HardDelete);
  });
}
