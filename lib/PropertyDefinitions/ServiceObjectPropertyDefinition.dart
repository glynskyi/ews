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
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents a property definition for a service object.
/// </summary>
abstract class ServiceObjectPropertyDefinition extends PropertyDefinitionBase {
  String _uri;

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.FieldURI;
  }

  /// <summary>
  /// Gets the minimum Exchange version that supports this property.
  /// </summary>
  /// <value>The version.</value>
  @override
  ExchangeVersion get Version => ExchangeVersion.Exchange2007_SP1;

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    writer.WriteAttributeValue(XmlAttributeNames.FieldURI, this.Uri);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceObjectPropertyDefinition"/> class.
  /// </summary>
  ServiceObjectPropertyDefinition() : super();

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceObjectPropertyDefinition"/> class.
  /// </summary>
  /// <param name="uri">The URI.</param>
  ServiceObjectPropertyDefinition.withUri(String uri) : super() {
    EwsUtilities.Assert(!StringUtils.IsNullOrEmpty(uri), "ServiceObjectPropertyDefinition.ctor",
        "uri is null or empty");
    this._uri = uri;
  }

  /// <summary>
  /// Gets the URI of the property definition.
  /// </summary>
  String get Uri => this._uri;
}
