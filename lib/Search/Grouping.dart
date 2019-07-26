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

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AggregateType.dart' as enumerations;
import 'package:ews/Enumerations/SortDirection.dart' as enumerations;
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Interfaces/ISelfValidate.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';

/// <summary>
/// Represents grouping options in item search operations.
/// </summary>
class Grouping extends ISelfValidate {
  /* private */
  enumerations.SortDirection sortDirection =
      enumerations.SortDirection.Ascending;

  /* private */
  PropertyDefinitionBase groupOn;

  /* private */
  PropertyDefinitionBase aggregateOn;

  /* private */
  enumerations.AggregateType aggregateType;

  /// <summary>
  /// Validates this grouping.
  /// </summary>
  /* private */
  void InternalValidate() {
    EwsUtilities.ValidateParam(this.GroupOn, "GroupOn");
    EwsUtilities.ValidateParam(this.AggregateOn, "AggregateOn");
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="Grouping"/> class.
  /// </summary>
  Grouping() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="Grouping"/> class.
  /// </summary>
  /// <param name="groupOn">The property to group on.</param>
  /// <param name="sortDirection">The sort direction.</param>
  /// <param name="aggregateOn">The property to aggregate on.</param>
  /// <param name="aggregateType">The type of aggregate to calculate.</param>
  Grouping.withSettings(
      PropertyDefinitionBase groupOn,
      enumerations.SortDirection sortDirection,
      PropertyDefinitionBase aggregateOn,
      enumerations.AggregateType aggregateType)
      : super() {
    EwsUtilities.ValidateParam(groupOn, "groupOn");
    EwsUtilities.ValidateParam(aggregateOn, "aggregateOn");

    this.groupOn = groupOn;
    this.sortDirection = sortDirection;
    this.aggregateOn = aggregateOn;
    this.aggregateType = aggregateType;
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.GroupBy);
    writer.WriteAttributeValue(XmlAttributeNames.Order, this.SortDirection);

    this.GroupOn.WriteToXml(writer);

    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.AggregateOn);
    writer.WriteAttributeValue(XmlAttributeNames.Aggregate, this.AggregateType);

    this.AggregateOn.WriteToXml(writer);

    writer.WriteEndElement(); // AggregateOn

    writer.WriteEndElement(); // GroupBy
  }

  /// <summary>
  /// Gets or sets the sort direction.
  /// </summary>
  enumerations.SortDirection get SortDirection => this.sortDirection;

  set Sort(enumerations.SortDirection value) => this.sortDirection = value;

  /// <summary>
  /// Gets or sets the property to group on.
  /// </summary>
  PropertyDefinitionBase get GroupOn => this.groupOn;

  set GroupOn(PropertyDefinitionBase value) => this.groupOn = value;

  /// <summary>
  /// Gets or sets the property to aggregate on.
  /// </summary>
  PropertyDefinitionBase get AggregateOn => this.aggregateOn;

  set AggregateOn(PropertyDefinitionBase value) => this.aggregateOn = value;

  /// <summary>
  /// Gets or sets the types of aggregate to calculate.
  /// </summary>
  enumerations.AggregateType get AggregateType => this.aggregateType;

  set AggregateType(enumerations.AggregateType value) =>
      this.aggregateType = value;

  /// <summary>
  /// Implements ISelfValidate.Validate. Validates this grouping.
  /// </summary>
  void Validate() {
    this.InternalValidate();
  }
}
