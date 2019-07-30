import 'package:ews/ComplexProperties/ExtendedProperty.dart';
import 'package:ews/Enumerations/TaskStatus.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

ExtendedPropertyDefinition AssigneeName = ExtendedPropertyDefinition.withDefaultPropertySetAndName(
    DefaultExtendedPropertySet.Common, "item:meetings:assigneeName", MapiPropertyType.String);

ExtendedPropertyDefinition AssigneeMail = ExtendedPropertyDefinition.withDefaultPropertySetAndName(
    DefaultExtendedPropertySet.Common, "item:meetings:assigneeMail", MapiPropertyType.String);

void main() {
//  test('retrieves extended property', () async {
//    final service = prepareExchangeService();
//    final propertySet = new PropertySet.fromPropertyDefinitions(
//        [ItemSchema.Subject, TaskSchema.IsComplete, TaskSchema.Status, AssigneeName, AssigneeMail]);
//
//    final taskId = ItemId.withUniqueId(
//        "AAMkADEyMjk2ODExLTdjNjgtNDcwMC05NGU1LWI3NTRjZThjNTU2YwBGAAAAAABG3JLstQsPSroAqjQDUP4eBwAYuAMWMjDURoE+aeutn9QqAAKisrjEAAAYuAMWMjDURoE+aeutn9QqAAKiswMnAAA=");
//    Task task = await Task.BindWithPropertySet(service, taskId, propertySet);
//    ExtendedProperty assigneeNameProperty = task.ExtendedProperties.firstWhere(
//        (prop) => ExtendedPropertyDefinition.IsEqualTo(prop.PropertyDefinition, AssigneeName));
//    ExtendedProperty assigneeMailProperty = task.ExtendedProperties.firstWhere(
//        (prop) => ExtendedPropertyDefinition.IsEqualTo(prop.PropertyDefinition, AssigneeMail));
//    print("${assigneeNameProperty.Value} -- ${assigneeMailProperty.Value}");
//  });

  test('creates task with extended properties', () async {
    final service = prepareExchangeService(primaryUserCredential);
    Task task = Task(service);
    task.Subject = "New Task #0";
    task.Status = TaskStatus.NotStarted;
    task.SetExtendedProperty(AssigneeName, "mail@domain.com");
    task.SetExtendedProperty(AssigneeMail, "FirstName LastName");
    await task.Save();
  });
}
