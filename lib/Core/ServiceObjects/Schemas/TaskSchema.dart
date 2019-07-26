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

import 'package:ews/ComplexProperties/StringList.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/TaskMode.dart';
import 'package:ews/Enumerations/TaskStatus.dart';
import 'package:ews/PropertyDefinitions/BoolPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/DateTimePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/DoublePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IntPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/RecurrencePropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/StringPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/TaskDelegationStatePropertyDefinition.dart';

/// <summary>
/// Field URIs for tasks.
/// </summary>
/* private */
class TaskSchemaFieldUris {
  static const String ActualWork = "task:ActualWork";
  static const String AssignedTime = "task:AssignedTime";
  static const String BillingInformation = "task:BillingInformation";
  static const String ChangeCount = "task:ChangeCount";
  static const String Companies = "task:Companies";
  static const String CompleteDate = "task:CompleteDate";
  static const String Contacts = "task:Contacts";
  static const String DelegationState = "task:DelegationState";
  static const String Delegator = "task:Delegator";
  static const String DueDate = "task:DueDate";
  static const String IsAssignmentEditable = "task:IsAssignmentEditable";
  static const String IsComplete = "task:IsComplete";
  static const String IsRecurring = "task:IsRecurring";
  static const String IsTeamTask = "task:IsTeamTask";
  static const String Mileage = "task:Mileage";
  static const String Owner = "task:Owner";
  static const String PercentComplete = "task:PercentComplete";
  static const String Recurrence = "task:Recurrence";
  static const String StartDate = "task:StartDate";
  static const String Status = "task:Status";
  static const String StatusDescription = "task:StatusDescription";
  static const String TotalWork = "task:TotalWork";
}

/// <summary>
/// Represents the schema for task items.
/// </summary>
//    [Schema]
class TaskSchema extends ItemSchema {
  /// <summary>
  /// Defines the ActualWork property.
  /// </summary>
//        // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition ActualWork =
      new IntPropertyDefinition.withFlagsAndNullable(
          XmlElementNames.ActualWork,
          TaskSchemaFieldUris.ActualWork,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1,
          true); // isNullable

  /// <summary>
  /// Defines the AssignedTime property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition AssignedTime =
      new DateTimePropertyDefinition.withUriAndFlagsANdNullable(
          XmlElementNames.AssignedTime,
          TaskSchemaFieldUris.AssignedTime,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2007_SP1,
          true); // isNullable

  /// <summary>
  /// Defines the BillingInformation property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition BillingInformation = new StringPropertyDefinition(
      XmlElementNames.BillingInformation,
      TaskSchemaFieldUris.BillingInformation,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the ChangeCount property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition ChangeCount = new IntPropertyDefinition.withUriAndFlags(
      XmlElementNames.ChangeCount,
      TaskSchemaFieldUris.ChangeCount,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Companies property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Companies =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.Companies,
          TaskSchemaFieldUris.Companies,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the CompleteDate property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition CompleteDate =
      new DateTimePropertyDefinition.withUriAndFlagsANdNullable(
          XmlElementNames.CompleteDate,
          TaskSchemaFieldUris.CompleteDate,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1,
          true); // isNullable

  /// <summary>
  /// Defines the Contacts property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Contacts =
      new ComplexPropertyDefinition<StringList>.withUriAndFlags(
          XmlElementNames.Contacts,
          TaskSchemaFieldUris.Contacts,
          [
            PropertyDefinitionFlags.AutoInstantiateOnRead,
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1, () {
    return new StringList();
  });

  /// <summary>
  /// Defines the DelegationState property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition DelegationState =
      new TaskDelegationStatePropertyDefinition(
          XmlElementNames.DelegationState,
          TaskSchemaFieldUris.DelegationState,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Delegator property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Delegator = new StringPropertyDefinition(
      XmlElementNames.Delegator,
      TaskSchemaFieldUris.Delegator,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the DueDate property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition DueDate =
      new DateTimePropertyDefinition.withUriAndFlagsANdNullable(
          XmlElementNames.DueDate,
          TaskSchemaFieldUris.DueDate,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1,
          true); // isNullable

  // TODO : This is the worst possible name for that property

  /// <summary>
  /// Defines the Mode property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Mode =
      new GenericPropertyDefinition<TaskMode>.withUriAndFlags(
          XmlElementNames.IsAssignmentEditable,
          TaskSchemaFieldUris.IsAssignmentEditable,
          [PropertyDefinitionFlags.CanFind],
          ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsComplete property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition IsComplete = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsComplete,
      TaskSchemaFieldUris.IsComplete,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsRecurring property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition IsRecurring = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsRecurring,
      TaskSchemaFieldUris.IsRecurring,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the IsTeamTask property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition IsTeamTask = new BoolPropertyDefinition.withUriAndFlags(
      XmlElementNames.IsTeamTask,
      TaskSchemaFieldUris.IsTeamTask,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Mileage property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Mileage = new StringPropertyDefinition(
      XmlElementNames.Mileage,
      TaskSchemaFieldUris.Mileage,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Owner property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Owner = new StringPropertyDefinition(
      XmlElementNames.Owner,
      TaskSchemaFieldUris.Owner,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the PercentComplete property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition PercentComplete = new DoublePropertyDefinition(
      XmlElementNames.PercentComplete,
      TaskSchemaFieldUris.PercentComplete,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanFind
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the Recurrence property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Recurrence = new RecurrencePropertyDefinition(
      XmlElementNames.Recurrence,
      TaskSchemaFieldUris.Recurrence,
      [
        PropertyDefinitionFlags.CanSet,
        PropertyDefinitionFlags.CanUpdate,
        PropertyDefinitionFlags.CanDelete
      ],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the StartDate property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition StartDate =
      new DateTimePropertyDefinition.withUriAndFlagsANdNullable(
          XmlElementNames.StartDate,
          TaskSchemaFieldUris.StartDate,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1,
          true); // isNullable

  /// <summary>
  /// Defines the Status property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition Status =
      new GenericPropertyDefinition<TaskStatus>.withUriAndFlags(
          XmlElementNames.Status,
          TaskSchemaFieldUris.Status,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the StatusDescription property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition StatusDescription = new StringPropertyDefinition(
      XmlElementNames.StatusDescription,
      TaskSchemaFieldUris.StatusDescription,
      [PropertyDefinitionFlags.CanFind],
      ExchangeVersion.Exchange2007_SP1);

  /// <summary>
  /// Defines the TotalWork property.
  /// </summary>
  // [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
  static PropertyDefinition TotalWork =
      new IntPropertyDefinition.withFlagsAndNullable(
          XmlElementNames.TotalWork,
          TaskSchemaFieldUris.TotalWork,
          [
            PropertyDefinitionFlags.CanSet,
            PropertyDefinitionFlags.CanUpdate,
            PropertyDefinitionFlags.CanDelete,
            PropertyDefinitionFlags.CanFind
          ],
          ExchangeVersion.Exchange2007_SP1,
          true); // isNullable

  // This must be declared after the property definitions
  static TaskSchema Instance = new TaskSchema();

  /// <summary>
  /// Registers properties.
  /// </summary>
  /// <remarks>
  /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
  /// </remarks>
  @override
  void RegisterProperties() {
    super.RegisterProperties();

    this.RegisterProperty(ActualWork);
    this.RegisterProperty(AssignedTime);
    this.RegisterProperty(BillingInformation);
    this.RegisterProperty(ChangeCount);
    this.RegisterProperty(Companies);
    this.RegisterProperty(CompleteDate);
    this.RegisterProperty(Contacts);
    this.RegisterProperty(DelegationState);
    this.RegisterProperty(Delegator);
    this.RegisterProperty(DueDate);
    this.RegisterProperty(Mode);
    this.RegisterProperty(IsComplete);
    this.RegisterProperty(IsRecurring);
    this.RegisterProperty(IsTeamTask);
    this.RegisterProperty(Mileage);
    this.RegisterProperty(Owner);
    this.RegisterProperty(PercentComplete);
    this.RegisterProperty(Recurrence);
    this.RegisterProperty(StartDate);
    this.RegisterProperty(Status);
    this.RegisterProperty(StatusDescription);
    this.RegisterProperty(TotalWork);
  }

//        /// <summary>
//        /// Initializes a new instance of the <see cref="TaskSchema"/> class.
//        /// </summary>
//        TaskSchema(): super()
//        {
//        }
}
