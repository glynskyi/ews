/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

import 'package:ews/Attributes/ServiceObjectDefinitionAttribute.dart';
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/ComplexProperties/Recurrence/Patterns/Recurrence.dart'
    as complex;
import 'package:ews/ComplexProperties/StringList.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/TaskSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AffectedTaskOccurrence.dart';
import 'package:ews/Enumerations/ConflictResolutionMode.dart';
import 'package:ews/Enumerations/DeleteMode.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/MessageDisposition.dart';
import 'package:ews/Enumerations/TaskDelegationState.dart';
import 'package:ews/Enumerations/TaskMode.dart';
import 'package:ews/Enumerations/TaskStatus.dart';

/// <summary>
/// Represents a Task item. Properties available on tasks are defined in the TaskSchema class.
/// </summary>
//    [Attachable]
//    [ServiceObjectDefinition(XmlElementNames.Task)]
class Task extends Item {
  /// <summary>
  /// Initializes an unsaved local instance of <see cref="Task"/>. To bind to an existing task, use Task.Bind() instead.
  /// </summary>
  /// <param name="service">The ExchangeService instance to which this task is bound.</param>
  Task(ExchangeService service) : super(service);

  /// <summary>
  /// Initializes a new instance of the <see cref="Task"/> class.
  /// </summary>
  /// <param name="parentAttachment">The parent attachment.</param>
  Task.withAttachment(ItemAttachment parentAttachment)
      : super.withAttachment(parentAttachment);

  /// <summary>
  /// Binds to an existing task and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the task.</param>
  /// <param name="id">The Id of the task to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>A Task instance representing the task corresponding to the specified Id.</returns>
  static Future<Task> BindWithPropertySet(
      ExchangeService service, ItemId? id, PropertySet propertySet) {
    return service.BindToItemGeneric<Task>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing task and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the task.</param>
  /// <param name="id">The Id of the task to bind to.</param>
  /// <returns>A Task instance representing the task corresponding to the specified Id.</returns>
  static Future<Task> BindWithItemId(ExchangeService service, ItemId? id) {
    return Task.BindWithPropertySet(
        service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return TaskSchema.Instance;
  }

  /// <summary>
  /// Gets the minimum required server version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// Gets a value indicating whether a time zone SOAP header should be emitted in a CreateItem
  /// or UpdateItem request so this item can be property saved or updated.
  /// </summary>
  /// <param name="isUpdateOperation">Indicates whether the operation being petrformed is an update operation.</param>
  /// <returns>
  ///     <c>true</c> if a time zone SOAP header should be emitted; otherwise, <c>false</c>.
  /// </returns>
  @override
  bool GetIsTimeZoneHeaderRequired(bool isUpdateOperation) {
    return true;
  }

  /// <summary>
  /// Deletes the current occurrence of a recurring task. After the current occurrence isdeleted,
  /// the task represents the next occurrence. Developers should call Load to retrieve the new property
  /// values of the task. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="deleteMode">The deletion mode.</param>
  void DeleteCurrentOccurrence(DeleteMode deleteMode) {
    this.InternalDelete(
        deleteMode, null, AffectedTaskOccurrence.SpecifiedOccurrenceOnly);
  }

  /// <summary>
  /// Applies the local changes that have been made to this task. Calling this method results in at least one call to EWS.
  /// Mutliple calls to EWS might be made if attachments have been added or removed.
  /// </summary>
  /// <param name="conflictResolutionMode">Specifies how conflicts should be resolved.</param>
  /// <returns>
  /// A Task object representing the completed occurrence if the task is recurring and the update marks it as completed; or
  /// a Task object representing the current occurrence if the task is recurring and the uypdate changed its recurrence
  /// pattern; or null in every other case.
  /// </returns>
  Future<Task?> Update(ConflictResolutionMode conflictResolutionMode,
      [bool suppressReadReceipts = false]) async {
    Item? item = await this.InternalUpdate(null /* parentFolder */,
        conflictResolutionMode, MessageDisposition.SaveOnly, null);
    return item as Task?;
  }

  /// <summary>
  /// Gets or sets the actual amount of time that is spent on the task.
  /// </summary>
  int? get ActualWork => this.PropertyBag[TaskSchema.ActualWork] as int?;

  set ActualWork(int? value) => this.PropertyBag[TaskSchema.ActualWork] = value;

  /// <summary>
  /// Gets the date and time the task was assigned.
  /// </summary>
  DateTime? get AssignedTime =>
      this.PropertyBag[TaskSchema.AssignedTime] as DateTime?;

  /// <summary>
  /// Gets or sets the billing information of the task.
  /// </summary>
  String? get BillingInformation =>
      this.PropertyBag[TaskSchema.BillingInformation] as String?;

  set BillingInformation(String? value) =>
      this.PropertyBag[TaskSchema.BillingInformation] = value;

  /// <summary>
  /// Gets the number of times the task has changed since it was created.
  /// </summary>
  int? get ChangeCount => this.PropertyBag[TaskSchema.ChangeCount] as int?;

  /// <summary>
  /// Gets or sets a list of companies associated with the task.
  /// </summary>
  StringList get Companies =>
      this.PropertyBag[TaskSchema.Companies] as StringList;

  set Companies(StringList value) =>
      this.PropertyBag[TaskSchema.Companies] = value;

  /// <summary>
  /// Gets or sets the date and time on which the task was completed.
  /// </summary>
  DateTime? get CompleteDate =>
      this.PropertyBag[TaskSchema.CompleteDate] as DateTime?;

  set CompleteDate(DateTime? value) =>
      this.PropertyBag[TaskSchema.CompleteDate] = value;

  /// <summary>
  /// Gets or sets a list of contacts associated with the task.
  /// </summary>
  StringList get Contacts =>
      this.PropertyBag[TaskSchema.Contacts] as StringList;

  set Contacts(StringList value) =>
      this.PropertyBag[TaskSchema.Contacts] = value;

  /// <summary>
  /// Gets the current delegation state of the task.
  /// </summary>
  TaskDelegationState? get DelegationState =>
      this.PropertyBag[TaskSchema.DelegationState] as TaskDelegationState?;

  /// <summary>
  /// Gets the name of the delegator of this task.
  /// </summary>
  String? get Delegator => this.PropertyBag[TaskSchema.Delegator] as String?;

  /// <summary>
  /// Gets or sets the date and time on which the task is due.
  /// </summary>
  DateTime? get DueDate => this.PropertyBag[TaskSchema.DueDate] as DateTime?;

  set DueDate(DateTime? value) => this.PropertyBag[TaskSchema.DueDate] = value;

  /// <summary>
  /// Gets a value indicating the mode of the task.
  /// </summary>
  TaskMode? get Mode => this.PropertyBag[TaskSchema.Mode] as TaskMode?;

  /// <summary>
  ///  Gets a value indicating whether the task is complete.
  /// </summary>
  bool? get IsComplete => this.PropertyBag[TaskSchema.IsComplete] as bool?;

  /// <summary>
  /// Gets a value indicating whether the task is recurring.
  /// </summary>
  bool? get IsRecurring => this.PropertyBag[TaskSchema.IsRecurring] as bool?;

  /// <summary>
  /// Gets a value indicating whether the task is a team task.
  /// </summary>
  bool? get IsTeamTask => this.PropertyBag[TaskSchema.IsTeamTask] as bool?;

  /// <summary>
  /// Gets or sets the mileage of the task.
  /// </summary>
  String? get Mileage => this.PropertyBag[TaskSchema.Mileage] as String?;

  set Mileage(String? value) => this.PropertyBag[TaskSchema.Mileage] = value;

  /// <summary>
  /// Gets the name of the owner of the task.
  /// </summary>
  String? get Owner => this.PropertyBag[TaskSchema.Owner] as String?;

  /// <summary>
  /// Gets or sets the completeion percentage of the task. PercentComplete must be between 0 and 100.
  /// </summary>
  double? get PercentComplete =>
      this.PropertyBag[TaskSchema.PercentComplete] as double?;

  set PercentComplete(double? value) =>
      this.PropertyBag[TaskSchema.PercentComplete] = value;

  /// <summary>
  /// Gets or sets the recurrence pattern for this task. Available recurrence pattern classes include
  /// Recurrence.DailyPattern, Recurrence.MonthlyPattern and Recurrence.YearlyPattern.
  /// </summary>
  complex.Recurrence? get Recurrence =>
      this.PropertyBag[TaskSchema.Recurrence] as complex.Recurrence?;

  set Recurrence(complex.Recurrence? value) =>
      this.PropertyBag[TaskSchema.Recurrence] = value;

  /// <summary>
  /// Gets or sets the date and time on which the task starts.
  /// </summary>
  DateTime? get StartDate =>
      this.PropertyBag[TaskSchema.StartDate] as DateTime?;

  set StartDate(DateTime? value) =>
      this.PropertyBag[TaskSchema.StartDate] = value;

  /// <summary>
  /// Gets or sets the status of the task.
  /// </summary>
  TaskStatus? get Status => this.PropertyBag[TaskSchema.Status] as TaskStatus?;

  set Status(TaskStatus? value) => this.PropertyBag[TaskSchema.Status] = value;

  /// <summary>
  /// Gets a String representing the status of the task, localized according to the PreferredCulture
  /// property of the ExchangeService object the task is bound to.
  /// </summary>
  String? get StatusDescription =>
      this.PropertyBag[TaskSchema.StatusDescription] as String?;

  /// <summary>
  /// Gets or sets the total amount of work spent on the task.
  /// </summary>
  int? get TotalWork => this.PropertyBag[TaskSchema.TotalWork] as int?;

  set TotalWork(int? value) => this.PropertyBag[TaskSchema.TotalWork] = value;

  /// <summary>
  /// Gets the default setting for how to treat affected task occurrences on Delete.
  /// </summary>
  /// <value>AffectedTaskOccurrence.AllOccurrences: All affected Task occurrences will be deleted.</value>
  @override
  AffectedTaskOccurrence get DefaultAffectedTaskOccurrences =>
      AffectedTaskOccurrence.AllOccurrences;

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(XmlElementNames.Task);
  }
}
