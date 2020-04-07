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

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/PropertyDefinitions/ExtendedPropertyDefinition.dart';
import 'package:ews/misc/MapiTypeConverter.dart';

import 'StringList.dart';

/// <summary>
/// Represents an extended property.
/// </summary>
class ExtendedProperty extends ComplexProperty {
  ExtendedPropertyDefinition _propertyDefinition;

  Object _value;

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedProperty"/> class.
  /// </summary>
  ExtendedProperty() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="ExtendedProperty"/> class.
  /// </summary>
  /// <param name="propertyDefinition">The definition of the extended property.</param>
  ExtendedProperty.withDefinition(this._propertyDefinition) {
    EwsUtilities.ValidateParam(_propertyDefinition, "propertyDefinition");
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.ExtendedFieldURI:
        this._propertyDefinition = new ExtendedPropertyDefinition();
        this._propertyDefinition.LoadFromXml(reader);
        return true;
      case XmlElementNames.Value:
        EwsUtilities.Assert(
            this.PropertyDefinition != null,
            "ExtendedProperty.TryReadElementFromXml",
            "PropertyDefintion is missing");

        String stringValue = reader.ReadElementValue<String>();
        this._value = MapiTypeConverter.ConvertToValueWithStringValue(
            this.PropertyDefinition.MapiType, stringValue);
        return true;
      case XmlElementNames.Values:
        EwsUtilities.Assert(
            this.PropertyDefinition != null,
            "ExtendedProperty.TryReadElementFromXml",
            "PropertyDefintion is missing");

        StringList stringList =
            new StringList.fromElementName(XmlElementNames.Value);
        stringList.LoadFromXml(reader, reader.LocalName);
        this._value = MapiTypeConverter.ConvertToValue(
            this.PropertyDefinition.MapiType, stringList);
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    this.PropertyDefinition.WriteToXml(writer);

    if (MapiTypeConverter.IsArrayType(this.PropertyDefinition.MapiType)) {
      List array = this.Value as List;
      writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Values);
      for (int index = 0; index < array.length; index++) {
        writer.WriteElementValueWithNamespace(
            XmlNamespace.Types,
            XmlElementNames.Value,
            MapiTypeConverter.ConvertToString(
                this.PropertyDefinition.MapiType, array[index]));
      }
      writer.WriteEndElement();
    } else {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types,
          XmlElementNames.Value,
          MapiTypeConverter.ConvertToString(
              this.PropertyDefinition.MapiType, this.Value));
    }
  }

  /// <summary>
  /// Gets the definition of the extended property.
  /// </summary>
  ExtendedPropertyDefinition get PropertyDefinition => this._propertyDefinition;

  /// <summary>
  /// Gets or sets the value of the extended property.
  /// </summary>
  Object get Value => this._value;

  set Value(Object value) {
    EwsUtilities.ValidateParam(value, "value");
    final mapiValue =
        MapiTypeConverter.ChangeType(this.PropertyDefinition.MapiType, value);
    if (this.CanSetFieldValue(this._value, mapiValue)) {
      this._value = mapiValue;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets the String value.
  /// </summary>
  /// <returns>Value as string.</returns>
  String _GetStringValue() {
    if (MapiTypeConverter.IsArrayType(this.PropertyDefinition.MapiType)) {
      List array = this.Value as List;
      if (array == null) {
        return "";
      } else {
        StringBuffer sb = new StringBuffer();
        sb.write("[");
        for (int index = 0; index <= array.length; index++) {
          sb.write(MapiTypeConverter.ConvertToString(
              this.PropertyDefinition.MapiType, array[index]));
          sb.write(",");
        }
        sb.write("]");

        return sb.toString();
      }
    } else {
      return MapiTypeConverter.ConvertToString(
          this.PropertyDefinition.MapiType, this.Value);
    }
  }

  /// <summary>
  /// Determines whether the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <param name="obj">The <see cref="T:System.Object"/> to compare with the current <see cref="T:System.Object"/>.</param>
  /// <returns>
  /// true if the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>; otherwise, false.
  /// </returns>
  /// <exception cref="T:System.NullReferenceException">The <paramref name="obj"/> parameter is null.</exception>
  @override
  bool operator ==(obj) {
    ExtendedProperty other = obj is ExtendedProperty ? obj : null;
    if ((other != null) &&
        other.PropertyDefinition == this.PropertyDefinition) {
      return this._GetStringValue() == other._GetStringValue();
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    final part1 = (this.PropertyDefinition != null)
        ? this.PropertyDefinition.GetPrintableName()
        : "";
    final part2 = this._GetStringValue();
    return (part1 + part2).hashCode;
  }
}
