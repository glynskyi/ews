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

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/Search/Filters/SearchFilter.PropertyBasedFilter.dart';
import 'package:ews/misc/OutParam.dart';

//    /// <content>
//    /// Contains nested type SearchFilter.RelationalFilter.
//    /// </content>
// abstract partial class SearchFilter
//    {

/// <summary>
/// Represents the base class for relational filters (for example, IsEqualTo, IsGreaterThan or IsLessThanOrEqualTo).
/// </summary>
abstract class RelationalFilter extends PropertyBasedFilter {
  PropertyDefinitionBase _otherPropertyDefinition;

  Object _value;

  /// <summary>
  /// Initializes a new instance of the <see cref="RelationalFilter"/> class.
  /// </summary>
  RelationalFilter() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="RelationalFilter"/> class.
  /// </summary>
  /// <param name="propertyDefinition">The definition of the property that is being compared. Property definitions are available as static members from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)</param>
  /// <param name="otherPropertyDefinition">The definition of the property to compare with. Property definitions are available as static members from schema classes (for example, EmailMessageSchema, AppointmentSchema, etc.)</param>
  RelationalFilter.withPropertyAndProperty(
      PropertyDefinitionBase propertyDefinition, PropertyDefinitionBase otherPropertyDefinition)
      : super.withProperty(propertyDefinition) {
    this._otherPropertyDefinition = otherPropertyDefinition;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="RelationalFilter"/> class.
  /// </summary>
  /// <param name="propertyDefinition">The definition of the property that is being compared. Property definitions are available as static members from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)</param>
  /// <param name="value">The value to compare with.</param>
  RelationalFilter.withPropertyAndValue(PropertyDefinitionBase propertyDefinition, Object value)
      : super.withProperty(propertyDefinition) {
    this._value = value;
  }

  /// <summary>
  /// Validate instance.
  /// </summary>
  @override
  void InternalValidate() {
    super.InternalValidate();

    if (this._otherPropertyDefinition == null && this._value == null) {
      throw new ServiceValidationException("Strings.EqualityComparisonFilterIsInvalid");
    } else if (_value != null) {
      // All common value types (String, Int32, DateTime, ...) implement IConvertible.
      // Value types that don't implement IConvertible must implement ISearchStringProvider
      // in order to be used in a search filter.
      // todo fix IConvertible validation
      print(".. not implemented IConvertible");
//             if (!((value is IConvertible) ||
//                 (value is ISearchStringProvider))) {
//                 throw new ServiceValidationException(
//                     "string.Format(Strings.SearchFilterComparisonValueTypeIsNotSupported, value.GetType().Name)");
//             }
    }
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    bool result = super.TryReadElementFromXml(reader);

    if (!result) {
      if (reader.LocalName == XmlElementNames.FieldURIOrConstant) {
        reader.Read();
        reader.EnsureCurrentNodeIsStartElement();

        if (reader.IsStartElementWithNamespace(XmlNamespace.Types, XmlElementNames.Constant)) {
          this._value = reader.ReadAttributeValue(XmlAttributeNames.Value);

          result = true;
        } else {
          OutParam<PropertyDefinitionBase> outParam = new OutParam<PropertyDefinitionBase>();
          outParam.param = this._otherPropertyDefinition;

          result = PropertyDefinitionBase.TryLoadFromXml(reader, outParam);
        }
      }
    }

    return result;
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    super.WriteElementsToXml(writer);

    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.FieldURIOrConstant);

    if (this.Value != null) {
      writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Constant);
      writer.WriteAttributeValue(
          XmlAttributeNames.Value, this.Value, true /* alwaysWriteEmptyString */);
      writer.WriteEndElement(); // Constant
    } else {
      this.OtherPropertyDefinition.WriteToXml(writer);
    }

    writer.WriteEndElement(); // FieldURIOrConstant
  }

  /// <summary>
  /// Gets or sets the definition of the property to compare with. Property definitions are available as static members
  /// from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)
  /// The OtherPropertyDefinition and Value properties are mutually exclusive; setting one resets the other to null.
  /// </summary>
  PropertyDefinitionBase get OtherPropertyDefinition => this._otherPropertyDefinition;

  set OtherPropertyDefinition(PropertyDefinitionBase value) {
    this._otherPropertyDefinition = OtherPropertyDefinition;
    this._value = null;
  }

  /// <summary>
  /// Gets or sets the value to compare with. The Value and OtherPropertyDefinition properties
  /// are mutually exclusive; setting one resets the other to null.
  /// </summary>
  Object get Value => this._value;

  set Value(Object value) {
    this._value = value;
    this._otherPropertyDefinition = null;
  }
}
//    }
