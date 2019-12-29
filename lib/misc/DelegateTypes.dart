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
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Xml/XmlWriter.dart';

/// <summary>
/// Defines a delegate that is used to allow applications to emit custom XML when SOAP requests are sent to Exchange.
/// </summary>
/// <param name="writer">The XmlWriter to use to emit the custom XML.</param>
typedef void CustomXmlSerializationDelegate(XmlWriter writer);

/// <summary>
/// Delegate method to handle capturing http response headers.
/// </summary>
/// <param name="responseHeaders">Http response headers.</param>
typedef void ResponseHeadersCapturedHandler(
    WebHeaderCollection responseHeaders);

/// <summary>
/// Defines a delegate used to notify that a service object has been modified.
/// </summary>
/// <param name="serviceObject">The service object that has been modified.</param>
typedef void ServiceObjectChangedDelegate(ServiceObject serviceObject);

/// <summary>
/// Indicates that a complex property changed.
/// </summary>
/// <param name="complexProperty">Complex property.</param>
typedef void ComplexPropertyChangedDelegate(ComplexProperty complexProperty);

/// <summary>
/// Indicates that a property bag changed.
/// </summary>
typedef void PropertyBagChangedDelegate();

/// <summary>
/// Used to produce an instance of a service object based on XML element name.
/// </summary>
/// <typeparam name="T">ServiceObject type.</typeparam>
/// <param name="service">Exchange service instance.</param>
/// <param name="xmlElementName">XML element name.</param>
/// <returns>Service object instance.</returns>
typedef T GetObjectInstanceDelegate<T extends ServiceObject>(
    ExchangeService service, String xmlElementName);
