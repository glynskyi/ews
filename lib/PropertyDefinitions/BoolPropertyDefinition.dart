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
import 'package:ews/PropertyDefinitions/GenericPropertyDefinition.dart';

/// <summary>
/// Represents Boolean property definition
/// </summary>
class BoolPropertyDefinition extends GenericPropertyDefinition<bool> {
  /// <summary>
  /// Initializes a new instance of the <see cref="BoolPropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="version">The version.</param>
  BoolPropertyDefinition(
      String xmlElementName, String uri, ExchangeVersion version)
      : super.withUri(xmlElementName, uri, version) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="BoolPropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  BoolPropertyDefinition.withUriAndFlags(String xmlElementName, String uri,
      List<PropertyDefinitionFlags> flags, ExchangeVersion version)
      : super.withUriAndFlags(xmlElementName, uri, flags, version) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="BoolPropertyDefinition"/> class.
  /// </summary>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <param name="uri">The URI.</param>
  /// <param name="flags">The flags.</param>
  /// <param name="version">The version.</param>
  /// <param name="isNullable">Indicates that this property definition is for a nullable property.</param>
  BoolPropertyDefinition.withFlagsAndNullable(
      String xmlElementName,
      String uri,
      List<PropertyDefinitionFlags> flags,
      ExchangeVersion version,
      bool isNullable)
      : super.withFlagsAndNullable(
            xmlElementName, uri, flags, version, isNullable) {}

  /// <summary>
  /// Convert instance to string.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>String representation of Boolean property.</returns>
  @override
  String toStringWithObject(Object value) {
    return EwsUtilities.BoolToXSBool(value as bool);
  }
}
