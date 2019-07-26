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
//    /// Contains nested type SearchFilter.Exists.
//    /// </content>
// abstract partial class SearchFilter
//    {
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/Search/Filters/SearchFilter.PropertyBasedFilter.dart';

/// <summary>
/// Represents a search filter checking if a field is set. Applications can use
/// ExistsFilter to define conditions such as "Field IS SET".
/// </summary>
class Exists extends PropertyBasedFilter {
  /// <summary>
  /// Initializes a new instance of the <see cref="Exists"/> class.
  /// </summary>
  Exists() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="Exists"/> class.
  /// </summary>
  /// <param name="propertyDefinition">The definition of the property to check the existence of. Property definitions are available as static members from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)</param>
  Exists.withProperty(PropertyDefinitionBase propertyDefinition)
      : super.withProperty(propertyDefinition) {}

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.Exists;
  }
}
//    }
