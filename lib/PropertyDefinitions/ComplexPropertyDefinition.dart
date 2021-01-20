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

import 'dart:core';
import 'dart:core' as core;

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Interfaces/IOwnedProperty.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinitionBase.dart';
import 'package:ews/PropertyDefinitions/ICreateComplexPropertyDelegate.dart';

/// <summary>
/// Delegate used to create instances of ComplexProperty
/// </summary>
/// <typeparam name="TComplexProperty">Type of complex property.</typeparam>
//    delegate TComplexProperty CreateComplexPropertyDelegate<TComplexProperty>()
//        where TComplexProperty : ComplexProperty;

/// <summary>
/// Represents base complex property type.
/// </summary>
/// <typeparam name="TComplexProperty">The type of the complex property.</typeparam>
class ComplexPropertyDefinition<TComplexProperty extends ComplexProperty>
    extends ComplexPropertyDefinitionBase //        where TComplexProperty : ComplexProperty
{
  /* private */
  late ICreateComplexPropertyDelegate<TComplexProperty> propertyCreationDelegate;

  /// <summary>
  /// Initializes a new instance of the <see cref="ComplexPropertyDefinition&lt;TComplexProperty&gt;"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  /// <param name="propertyCreationDelegate">Delegate used to create instances of ComplexProperty.</param>
  ComplexPropertyDefinition.withFlags(
      String xmlElementName,
      List<PropertyDefinitionFlags> flags,
      ExchangeVersion version,
      ICreateComplexPropertyDelegate<TComplexProperty> propertyCreationDelegate)
      : super.withFlags(xmlElementName, flags, version) {
    EwsUtilities.Assert(
        propertyCreationDelegate != null,
        "ComplexPropertyDefinition ctor",
        "CreateComplexPropertyDelegate cannot be null");

    this.propertyCreationDelegate = propertyCreationDelegate;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ComplexPropertyDefinition&lt;TComplexProperty&gt;"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="version">The version.</param>
  /// <param name="propertyCreationDelegate">Delegate used to create instances of ComplexProperty.</param>
  ComplexPropertyDefinition.withUri(
      String xmlElementName,
      String uri,
      ExchangeVersion version,
      ICreateComplexPropertyDelegate<TComplexProperty> propertyCreationDelegate)
      : super.withUri(xmlElementName, uri, version) {
    this.propertyCreationDelegate = propertyCreationDelegate;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ComplexPropertyDefinition&lt;TComplexProperty&gt;"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  /// <param name="propertyCreationDelegate">Delegate used to create instances of ComplexProperty.</param>
  ComplexPropertyDefinition.withUriAndFlags(
      String xmlElementName,
      String uri,
      List<PropertyDefinitionFlags> flags,
      ExchangeVersion version,
      ICreateComplexPropertyDelegate<TComplexProperty> propertyCreationDelegate)
      : super.withUriAndFlags(xmlElementName, uri, flags, version) {
    this.propertyCreationDelegate = propertyCreationDelegate;
  }

  /// <summary>
  /// Creates the property instance.
  /// </summary>
  /// <param name="owner">The owner.</param>
  /// <returns>ComplexProperty instance.</returns>
  @override
  ComplexProperty CreatePropertyInstance(ServiceObject? owner) {
    TComplexProperty complexProperty = this.propertyCreationDelegate();

    if (complexProperty is IOwnedProperty) {
      IOwnedProperty ownedProperty = complexProperty as IOwnedProperty;
      ownedProperty.Owner = owner;
    }

    return complexProperty;
  }

  /// <summary>
  /// Gets the property type.
  /// </summary>
  @override
  core.Type get Type => TComplexProperty;
}
