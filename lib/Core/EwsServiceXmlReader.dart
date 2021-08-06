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

import 'package:ews/Core/ExchangeServiceBase.dart';
import 'package:ews/Core/Responses/IGetObjectInstanceDelegate.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Xml/XmlReader.dart';

import 'EwsXmlReader.dart';
import 'ExchangeService.dart';
import 'PropertySet.dart';

/// <summary>
/// XML reader.
/// </summary>
class EwsServiceXmlReader extends EwsXmlReader {
  ExchangeServiceBase _service;

  /// <summary>
  /// Initializes a new instance of the <see cref="EwsServiceXmlReader"/> class.
  /// </summary>
  /// <param name="stream">The stream.</param>
  /// <param name="service">The service.</param>
  EwsServiceXmlReader(XmlReader xmlReader, this._service) : super(xmlReader);

  static Future<EwsServiceXmlReader> Create(
      Stream<List<int>> stream, ExchangeServiceBase service) async {
    final xmlReader = await XmlReader.Create(stream);
    return EwsServiceXmlReader(xmlReader, service);
  }

  /// <summary>
  /// Converts the specified String into a DateTime objects.
  /// </summary>
  /// <param name="dateTimeString">The date time String to convert.</param>
  /// <returns>A DateTime representing the converted string.</returns>
  DateTime? _ConvertStringToDateTime(String? dateTimeString) {
    return this
        .Service
        .ConvertUniversalDateTimeStringToLocalDateTime(dateTimeString);
  }

  /// <summary>
  /// Converts the specified String into a unspecified Date object, ignoring offset.
  /// </summary>
  /// <param name="dateTimeString">The date time String to convert.</param>
  /// <returns>A DateTime representing the converted string.</returns>
  DateTime? _ConvertStringToUnspecifiedDate(String? dateTimeString) {
    return this.Service.ConvertStartDateToUnspecifiedDateTime(dateTimeString);
  }

  /// <summary>
  /// Reads the element value as date time.
  /// </summary>
  /// <returns>Element value.</returns>
  Future<DateTime?> ReadElementValueAsDateTime() async {
    return this._ConvertStringToDateTime(await this.ReadElementValue<String>());
  }

  /// <summary>
  /// Reads the element value as unspecified date.
  /// </summary>
  /// <returns>Element value.</returns>
  Future<DateTime?> ReadElementValueAsUnspecifiedDate() async {
    return this
        ._ConvertStringToUnspecifiedDate(await this.ReadElementValue<String>());
  }

  /// <summary>
  /// Reads the element value as date time, assuming it is unbiased (e.g. 2009/01/01T08:00)
  /// and scoped to service's time zone.
  /// </summary>
  /// <returns>The element's value as a DateTime object.</returns>
// DateTime ReadElementValueAsUnbiasedDateTimeScopedToServiceTimeZone()
//        {
//            String elementValue = this.ReadElementValue<String>();
//            return EwsUtilities.ParseAsUnbiasedDatetimescopedToServicetimeZone(elementValue, this.Service);
//        }

  /// <summary>
  /// Reads the element value as date time.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">Name of the local.</param>
  /// <returns>Element value.</returns>
// DateTime ReadElementValueAsDateTime(XmlNamespace xmlNamespace, String localName)
//        {
//            return this.ConvertStringToDateTime(this.ReadElementValueWithNamespace(xmlNamespace, localName));
//        }

  /// <summary>
  /// Reads the service objects collection from XML.
  /// </summary>
  /// <typeparam name="TServiceObject">The type of the service object.</typeparam>
  /// <param name="collectionXmlNamespace">Namespace of the collection XML element.</param>
  /// <param name="collectionXmlElementName">Name of the collection XML element.</param>
  /// <param name="getObjectInstanceDelegate">The get object instance delegate.</param>
  /// <param name="clearPropertyBag">if set to <c>true</c> [clear property bag].</param>
  /// <param name="requestedPropertySet">The requested property set.</param>
  /// <param name="summaryPropertiesOnly">if set to <c>true</c> [summary properties only].</param>
  /// <returns>List of service objects.</returns>
  Future<List<TServiceObject>> ReadServiceObjectsCollectionFromXmlWithNamespace<
          TServiceObject extends ServiceObject>(
      XmlNamespace collectionXmlNamespace,
      String collectionXmlElementName,
      IGetObjectInstanceDelegate<TServiceObject> getObjectInstanceDelegate,
      bool clearPropertyBag,
      PropertySet? requestedPropertySet,
      bool summaryPropertiesOnly) async {
    List<TServiceObject> serviceObjects = <TServiceObject>[];
    TServiceObject? serviceObject = null;

    if (!this.IsStartElementWithNamespace(
        collectionXmlNamespace, collectionXmlElementName)) {
      await this.ReadStartElementWithNamespace(
          collectionXmlNamespace, collectionXmlElementName);
    }

    if (!this.IsEmptyElement) {
      do {
        await this.Read();

        if (this.IsStartElement()) {
          serviceObject =
              getObjectInstanceDelegate(this.Service, this.LocalName);

          if (serviceObject == null) {
            await this.SkipCurrentElement();
          } else {
            if (this.LocalName != serviceObject.GetXmlElementName()) {
              throw new ServiceLocalException(
                  "The type of the object in the store (${this.LocalName}) does not match that of the local object (${serviceObject.GetXmlElementName()}).");
            }

            await serviceObject.LoadFromXmlWithPropertySet(this,
                clearPropertyBag, requestedPropertySet, summaryPropertiesOnly);

            serviceObjects.add(serviceObject);
          }
        }
      } while (!this.IsEndElementWithNamespace(
          collectionXmlNamespace, collectionXmlElementName));
    }

    return serviceObjects;
  }

  /// <summary>
  /// Reads the service objects collection from XML.
  /// </summary>
  /// <typeparam name="TServiceObject">The type of the service object.</typeparam>
  /// <param name="collectionXmlElementName">Name of the collection XML element.</param>
  /// <param name="getObjectInstanceDelegate">The get object instance delegate.</param>
  /// <param name="clearPropertyBag">if set to <c>true</c> [clear property bag].</param>
  /// <param name="requestedPropertySet">The requested property set.</param>
  /// <param name="summaryPropertiesOnly">if set to <c>true</c> [summary properties only].</param>
  /// <returns>List of service objects.</returns>
  Future<List<TServiceObject>>
      ReadServiceObjectsCollectionFromXml<TServiceObject extends ServiceObject>(
          String collectionXmlElementName,
          IGetObjectInstanceDelegate<TServiceObject> getObjectInstanceDelegate,
          bool clearPropertyBag,
          PropertySet? requestedPropertySet,
          bool summaryPropertiesOnly) async {
    return this
        .ReadServiceObjectsCollectionFromXmlWithNamespace<TServiceObject>(
            XmlNamespace.Messages,
            collectionXmlElementName,
            getObjectInstanceDelegate,
            clearPropertyBag,
            requestedPropertySet,
            summaryPropertiesOnly);
  }

  /// <summary>
  /// Gets the service.
  /// </summary>
  /// <value>The service.</value>
  ExchangeService get Service => this._service as ExchangeService;
}
