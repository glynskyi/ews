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

//    /// <content>
//    /// Contains nested type SearchFilter.PropertyBasedFilter.
//    /// </content>
// abstract class SearchFilter
//    {
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/Search/Filters/SearchFilter.dart';
import 'package:ews/misc/OutParam.dart';

/// <summary>
/// Represents a search filter where an item or folder property is involved.
/// </summary>
abstract class PropertyBasedFilter extends SearchFilter {
  /* private */ PropertyDefinitionBase? propertyDefinition;

  /// <summary>
  /// Initializes a new instance of the <see cref="PropertyBasedFilter"/> class.
  /// </summary>
  PropertyBasedFilter() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="PropertyBasedFilter"/> class.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  PropertyBasedFilter.withProperty(PropertyDefinitionBase propertyDefinition)
      : super() {
    this.propertyDefinition = propertyDefinition;
  }

  /// <summary>
  /// Validate instance.
  /// </summary>
  @override
  void InternalValidate() {
    if (this.propertyDefinition == null) {
      throw new ServiceValidationException(
          "Strings.PropertyDefinitionPropertyMustBeSet");
    }
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    OutParam<PropertyDefinitionBase> outParam =
        new OutParam<PropertyDefinitionBase>();
    outParam.param = this.propertyDefinition;

    return PropertyDefinitionBase.TryLoadFromXml(reader, outParam);
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    this.PropertyDefinition!.WriteToXml(writer);
  }

  /// <summary>
  /// Gets or sets the definition of the property that is involved in the search filter. Property definitions are
  /// available as static members from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)
  /// </summary>
  PropertyDefinitionBase? get PropertyDefinition => this.propertyDefinition;

  set PropertyDefinition(PropertyDefinitionBase? value) {
    this.propertyDefinition = value;
  }
}
//    }
