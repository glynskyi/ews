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

import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/TaskDelegationState.dart';
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';

/// <summary>
/// Represents a task delegation property definition.
/// </summary>
class TaskDelegationStatePropertyDefinition
    extends GenericPropertyDefinition<TaskDelegationState> {
  /* private */
  static const String NoMatch = "NoMatch";

  /* private */
  static const String OwnNew = "OwnNew";

  /* private */
  static const String Owned = "Owned";

  /* private */
  static const String Accepted = "Accepted";

  /// <summary>
  /// Initializes a new instance of the <see cref="TaskDelegationStatePropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  TaskDelegationStatePropertyDefinition(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUriAndFlags(xmlElementName, uri, flags, version);

  /// <summary>
  /// Parses the specified value.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>TaskDelegationState value.</returns>
  @override
  Object Parse(String value) {
    switch (value) {
      case NoMatch:
        return TaskDelegationState.NoDelegation;
      case OwnNew:
        return TaskDelegationState.Unknown;
      case Owned:
        return TaskDelegationState.Accepted;
      case Accepted:
        return TaskDelegationState.Declined;
      default:
        EwsUtilities.Assert(
            false,
            "TaskDelegationStatePropertyDefinition.Parse",
            """string.Format("TaskDelegationStatePropertyDefinition.Parse(): value {0} cannot be handled.", value)""");
        return null; // To keep the compiler happy
    }
  }

  /// <summary>
  /// Convert instance to string.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>TaskDelegationState value.</returns>
  @override
  String toStringWithObject(Object value) {
    TaskDelegationState taskDelegationState = value;

    switch (taskDelegationState) {
      case TaskDelegationState.NoDelegation:
        return NoMatch;
      case TaskDelegationState.Unknown:
        return OwnNew;
      case TaskDelegationState.Accepted:
        return Owned;
      case TaskDelegationState.Declined:
        return Accepted;
      default:
        EwsUtilities.Assert(
            false,
            "TaskDelegationStatePropertyDefinition.ToString",
            "Invalid TaskDelegationState value.");
        return null; // To keep the compiler happy
    }
  }
}
