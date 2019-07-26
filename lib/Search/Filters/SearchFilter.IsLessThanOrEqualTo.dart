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
//    /// Contains nested type SearchFilter.IsLessThanOrEqualTo.
//    /// </content>
// abstract partial class SearchFilter
//    {
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/Search/Filters/SearchFilter.RelationalFilter.dart';

/// <summary>
/// Represents a search filter that checks if a property is less than or equal to a given value or other property.
/// </summary>
class IsLessThanOrEqualTo extends RelationalFilter {
  /// <summary>
  /// Initializes a new instance of the <see cref="IsLessThanOrEqualTo"/> class.
  /// </summary>
  IsLessThanOrEqualTo() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="IsLessThanOrEqualTo"/> class.
  /// </summary>
  /// <param name="propertyDefinition">The definition of the property that is being compared. Property definitions are available as static members from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)</param>
  /// <param name="otherPropertyDefinition">The definition of the property to compare with. Property definitions are available on schema classes (EmailMessageSchema, AppointmentSchema, etc.)</param>
  IsLessThanOrEqualTo.withPropertyAndProperty(
      PropertyDefinitionBase propertyDefinition, PropertyDefinitionBase otherPropertyDefinition)
      : super.withPropertyAndProperty(propertyDefinition, otherPropertyDefinition) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="IsLessThanOrEqualTo"/> class.
  /// </summary>
  /// <param name="propertyDefinition">The definition of the property that is being compared. Property definitions are available as static members from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)</param>
  /// <param name="value">The value to compare the property with.</param>
  IsLessThanOrEqualTo.withPropertyAndValue(PropertyDefinitionBase propertyDefinition, Object value)
      : super.withPropertyAndValue(propertyDefinition, value) {}

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.IsLessThanOrEqualTo;
  }
}
//    }
