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

import 'package:ews/ComplexProperties/ComplexPropertyCollection.dart';
import 'package:ews/ComplexProperties/ExtendedProperty.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:ews/PropertyDefinitions/ExtendedPropertyDefinition.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// Represents a collection of extended properties.
/// </summary>
class ExtendedPropertyCollection
    extends ComplexPropertyCollection<
        ExtendedProperty> //, ICustomUpdateSerializer
    {
  /// <summary>
  /// Creates the complex property.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>Complex property instance.</returns>
  @override
  ExtendedProperty CreateComplexProperty(String xmlElementName) {
    return new ExtendedProperty();
  }

  /// <summary>
  /// Gets the name of the collection item XML element.
  /// </summary>
  /// <param name="complexProperty">The complex property.</param>
  /// <returns>XML element name.</returns>
  @override
  String GetCollectionItemXmlElementName(ExtendedProperty complexProperty) {
    // This method is unused in this class, so just return null.
    return null;
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="localElementName">Name of the local element.</param>
  @override
  void LoadFromXml(EwsServiceXmlReader reader, String localElementName) {
    ExtendedProperty extendedProperty = new ExtendedProperty();

    extendedProperty.LoadFromXml(reader, reader.LocalName);
    this.InternalAdd(extendedProperty);
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  @override
  void WriteToXml(EwsServiceXmlWriter writer, String xmlElementName) {
    for (ExtendedProperty extendedProperty in this) {
      extendedProperty.WriteToXml(writer, XmlElementNames.ExtendedProperty);
    }
  }

  /// <summary>
  /// Gets existing or adds new extended property.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <returns>ExtendedProperty.</returns>
  /* private */
  ExtendedProperty GetOrAddExtendedProperty(
      ExtendedPropertyDefinition propertyDefinition) {
    ExtendedProperty extendedProperty = null;
    OutParam<ExtendedProperty> extendedPropertyOut =
    new OutParam<ExtendedProperty>();
    if (!this.TryGetProperty(propertyDefinition, extendedPropertyOut)) {
      extendedProperty = new ExtendedProperty.withDefinition(propertyDefinition);
      this.InternalAdd(extendedProperty);
    } else {
      extendedProperty = extendedPropertyOut.param;
    }
    return extendedProperty;
  }

  /// <summary>
  /// Sets an extended property.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="value">The value.</param>
  void SetExtendedProperty(ExtendedPropertyDefinition propertyDefinition,
      Object value) {
    ExtendedProperty extendedProperty = this.GetOrAddExtendedProperty(
        propertyDefinition);
    extendedProperty.Value = value;
  }

  /// <summary>
  /// Removes a specific extended property definition from the collection.
  /// </summary>
  /// <param name="propertyDefinition">The definition of the extended property to remove.</param>
  /// <returns>True if the property matching the extended property definition was successfully removed from the collection, false otherwise.</returns>
  bool RemoveExtendedProperty(ExtendedPropertyDefinition propertyDefinition) {
    EwsUtilities.ValidateParam(propertyDefinition, "propertyDefinition");

    ExtendedProperty extendedProperty = null;
    OutParam<ExtendedProperty> extendedPropertyOut =
    new OutParam<ExtendedProperty>();
    if (this.TryGetProperty(propertyDefinition, extendedPropertyOut)) {
      extendedProperty = extendedPropertyOut.param;
      return this.InternalRemove(extendedProperty);
    }
    else {
      return false;
    }
  }

  /// <summary>
  /// Tries to get property.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="extendedProperty">The extended property.</param>
  /// <returns>True of property exists in collection.</returns>
  /* private */
  bool TryGetProperty(ExtendedPropertyDefinition propertyDefinition,  OutParam<ExtendedProperty> extendedPropertyOut)
  {
    bool found = false;
    extendedPropertyOut.param  = null;
    for (ExtendedProperty prop in this.Items) {
      if (prop.PropertyDefinition == propertyDefinition) {
        found = true;
        extendedPropertyOut.param  = prop;
        break;
      }
    }
    return found;
  }

  /// <summary>
  /// Tries to get property value.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="propertyValue">The property value.</param>
  /// <typeparam name="T">Type of expected property value.</typeparam>
  /// <returns>True if property exists in collection.</returns>
  bool TryGetValueGeneric<T>(ExtendedPropertyDefinition propertyDefinition, OutParam<T> propertyValueOut)
  {
    ExtendedProperty extendedProperty = null;
    OutParam<ExtendedProperty> extendedPropertyOut = new OutParam<ExtendedProperty>();
    if (this.TryGetProperty(propertyDefinition, extendedPropertyOut)) {
      extendedProperty = extendedPropertyOut.param;
      // todo ("implement runtimeType check")
//      if (T.runtimeType is propertyDefinition.Type) {
//        String errorMessage = String.format(
//            "Property definition type '%s' and type parameter '%s' aren't compatible.",
//            propertyDefinition.getType().getSimpleName(),
//            cls.getSimpleName());
//        throw new ArgumentError(errorMessage, "propertyDefinition");
//      }
      propertyValueOut.param = extendedProperty.Value;
    return true;
  } else {
    propertyValueOut.param = null;
    return false;
  }
//  ExtendedProperty extendedProperty;
//  if (this.TryGetProperty(propertyDefinition, out extendedProperty))
//  {
//  // Verify that the type parameter and property definition's type are compatible.
//  if (!typeof(T).IsAssignableFrom(propertyDefinition.Type))
//  {
//  String errorMessage = string.Format(
//  Strings.PropertyDefinitionTypeMismatch,
//  EwsUtilities.GetPrintableTypeName(propertyDefinition.Type),
//  EwsUtilities.GetPrintableTypeName(typeof(T)));
//  throw new ArgumentError(errorMessage, "propertyDefinition");
//  }
//
//  propertyValue = (T)extendedProperty.Value;
//  return true;
//  }
//  else
//  {
//  propertyValue = default(T);
//  return false;
//  }
  }

/// <summary>
/// Writes the update to XML.
/// </summary>
/// <param name="writer">The writer.</param>
/// <param name="ewsObject">The ews object.</param>
/// <param name="propertyDefinition">Property definition.</param>
/// <returns>
/// True if property generated serialization.
/// </returns>
//        bool ICustomUpdateSerializer.WriteSetUpdateToXml(
//            EwsServiceXmlWriter writer,
//            ServiceObject ewsObject,
//            PropertyDefinition propertyDefinition)
//        {
//            List<ExtendedProperty> propertiesToSet = new List<ExtendedProperty>();
//
//            propertiesToSet.AddRange(this.AddedItems);
//            propertiesToSet.AddRange(this.ModifiedItems);
//
//            for (ExtendedProperty extendedProperty in propertiesToSet)
//            {
//                writer.WriteStartElement(XmlNamespace.Types, ewsObject.GetSetFieldXmlElementName());
//                extendedProperty.PropertyDefinition.WriteToXml(writer);
//
//                writer.WriteStartElement(XmlNamespace.Types, ewsObject.GetXmlElementName());
//                extendedProperty.WriteToXml(writer, XmlElementNames.ExtendedProperty);
//                writer.WriteEndElement();
//
//                writer.WriteEndElement();
//            }
//
//            for (ExtendedProperty extendedProperty in this.RemovedItems)
//            {
//                writer.WriteStartElement(XmlNamespace.Types, ewsObject.GetDeleteFieldXmlElementName());
//                extendedProperty.PropertyDefinition.WriteToXml(writer);
//                writer.WriteEndElement();
//            }
//
//            return true;
//        }

/// <summary>
/// Writes the deletion update to XML.
/// </summary>
/// <param name="writer">The writer.</param>
/// <param name="ewsObject">The ews object.</param>
/// <returns>
/// True if property generated serialization.
/// </returns>
//        bool ICustomUpdateSerializer.WriteDeleteUpdateToXml(EwsServiceXmlWriter writer, ServiceObject ewsObject)
//        {
//            for (ExtendedProperty extendedProperty in this.Items)
//            {
//                writer.WriteStartElement(XmlNamespace.Types, ewsObject.GetDeleteFieldXmlElementName());
//                extendedProperty.PropertyDefinition.WriteToXml(writer);
//                writer.WriteEndElement();
//            }
//
//            return true;
//        }
}
