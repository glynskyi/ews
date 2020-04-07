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
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ServiceError.dart';
import 'package:ews/Enumerations/ServiceResult.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceResponseException.dart';
import 'package:ews/PropertyDefinitions/ExtendedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/IndexedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/misc/SoapFaultDetails.dart';

/// <summary>
/// Represents the standard response to an Exchange Web Services operation.
/// </summary>
//    [Serializable]
class ServiceResponse {
  ServiceResult _result;
  ServiceError _errorCode;
  String _errorMessage;
  Map<String, String> _errorDetails = {};
  List<PropertyDefinitionBase> _errorProperties = [];

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceResponse"/> class.
  /// </summary>
  ServiceResponse();

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceResponse"/> class.
  /// </summary>
  /// <param name="soapFaultDetails">The SOAP fault details.</param>
  ServiceResponse.withSoapFault(SoapFaultDetails soapFaultDetails) {
    this._result = ServiceResult.Error;
    this._errorCode = soapFaultDetails.ResponseCode;
    this._errorMessage = soapFaultDetails.FaultString;
    this._errorDetails = soapFaultDetails.ErrorDetails;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceResponse"/> class.
  /// This is intended to be used by unit tests to create a fake service error response
  /// </summary>
  /// <param name="responseCode">Response code</param>
  /// <param name="errorMessage">Detailed error message</param>
  ServiceResponse.withError(ServiceError responseCode, String errorMessage) {
    this._result = ServiceResult.Error;
    this._errorCode = responseCode;
    this._errorMessage = errorMessage;
    this._errorDetails = null;
  }

  /// <summary>
  /// Loads response from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  void LoadFromXml(EwsServiceXmlReader reader, String xmlElementName) {
    if (!reader.IsStartElementWithNamespace(
        XmlNamespace.Messages, xmlElementName)) {
      reader.ReadStartElementWithNamespace(
          XmlNamespace.Messages, xmlElementName);
    }

    this._result = reader.ReadAttributeValue<ServiceResult>(
        XmlAttributeNames.ResponseClass);

    if (this._result == ServiceResult.Success ||
        this._result == ServiceResult.Warning) {
      if (this._result == ServiceResult.Warning) {
        this._errorMessage = reader.ReadElementValueWithNamespace(
            XmlNamespace.Messages, XmlElementNames.MessageText);
      }

      this._errorCode = reader.ReadElementValueWithNamespace<ServiceError>(
          XmlNamespace.Messages, XmlElementNames.ResponseCode);

      if (this._result == ServiceResult.Warning) {
        reader.ReadElementValueWithNamespace<int>(
            XmlNamespace.Messages, XmlElementNames.DescriptiveLinkKey);
      }

      // If batch processing stopped, EWS returns an empty element. Skip over it.
      if (this.BatchProcessingStopped) {
        do {
          reader.Read();
        } while (!reader.IsEndElementWithNamespace(
            XmlNamespace.Messages, xmlElementName));
      } else {
        this.ReadElementsFromXml(reader);

        reader.ReadEndElementIfNecessary(XmlNamespace.Messages, xmlElementName);
      }
    } else {
      this._errorMessage = reader.ReadElementValueWithNamespace(
          XmlNamespace.Messages, XmlElementNames.MessageText);
      this._errorCode = reader.ReadElementValueWithNamespace<ServiceError>(
          XmlNamespace.Messages, XmlElementNames.ResponseCode);
      reader.ReadElementValueWithNamespace<int>(
          XmlNamespace.Messages, XmlElementNames.DescriptiveLinkKey);

      while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Messages, xmlElementName)) {
        reader.Read();

        if (reader.IsStartElement()) {
          if (!this.LoadExtraErrorDetailsFromXml(reader, reader.LocalName)) {
            reader.SkipCurrentElement();
          }
        }
      }
    }

    this.MapErrorCodeToErrorMessage();

    this.Loaded();
  }

  /// <summary>
  /// Parses the message XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /* private */
  void ParseMessageXml(EwsServiceXmlReader reader) {
    do {
      reader.Read();

      if (reader.IsStartElement()) {
        switch (reader.LocalName) {
          case XmlElementNames.Value:
            this._errorDetails[
                    reader.ReadAttributeValue(XmlAttributeNames.Name)] =
                reader.ReadElementValue<String>();
            break;

          case XmlElementNames.FieldURI:
            this._errorProperties.add(
                ServiceObjectSchema.FindPropertyDefinition(
                    reader.ReadAttributeValue(XmlAttributeNames.FieldURI)));
            break;

          case XmlElementNames.IndexedFieldURI:
            this._errorProperties.add(new IndexedPropertyDefinition(
                reader.ReadAttributeValue(XmlAttributeNames.FieldURI),
                reader.ReadAttributeValue(XmlAttributeNames.FieldIndex)));
            break;

          case XmlElementNames.ExtendedFieldURI:
            ExtendedPropertyDefinition extendedPropDef =
                new ExtendedPropertyDefinition();
            extendedPropDef.LoadFromXml(reader);
            this._errorProperties.add(extendedPropDef);
            break;

          default:
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.MessageXml));
  }

  /// <summary>
  /// Called when the response has been loaded from XML.
  /// </summary>
  void Loaded() {}

  /// <summary>
  /// Called after the response has been loaded from XML in order to map error codes to "better" error messages.
  /// </summary>
  void MapErrorCodeToErrorMessage() {
    // Use a better error message when an item cannot be updated because its changeKey is old.
    if (this.ErrorCode == ServiceError.ErrorIrresolvableConflict) {
      this.ErrorMessage = "Strings.ItemIsOutOfDate";
    }
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void ReadElementsFromXml(EwsServiceXmlReader reader) {}

  /// <summary>
  /// Reads the headers from a HTTP response
  /// </summary>
  /// <param name="responseHeaders">a collection of response headers</param>
//        void ReadHeader(WebHeaderCollection responseHeaders)
//        {
//        }

  /// <summary>
  /// Loads extra error details from XML
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlElementName">The current element name of the extra error details.</param>
  /// <returns>True if the expected extra details is loaded;
  /// False if the element name does not match the expected element. </returns>
  bool LoadExtraErrorDetailsFromXml(
      EwsServiceXmlReader reader, String xmlElementName) {
    if (reader.IsStartElementWithNamespace(
            XmlNamespace.Messages, XmlElementNames.MessageXml) &&
        !reader.IsEmptyElement) {
      this.ParseMessageXml(reader);

      return true;
    } else {
      return false;
    }
  }

  /// <summary>
  /// Throws a ServiceResponseException if this response has its Result property set to Error.
  /// </summary>
  void ThrowIfNecessary() {
    this.InternalThrowIfNecessary();
  }

  /// <summary>
  /// method that throws a ServiceResponseException if this response has its Result property set to Error.
  /// </summary>
  void InternalThrowIfNecessary() {
    if (this.Result == ServiceResult.Error) {
      throw new ServiceResponseException(this);
    }
  }

  /// <summary>
  /// Gets a value indicating whether a batch request stopped processing before the end.
  /// </summary>
  bool get BatchProcessingStopped =>
      (this._result == ServiceResult.Warning) &&
      (this._errorCode == ServiceError.ErrorBatchProcessingStopped);

  /// <summary>
  /// Gets the result associated with this response.
  /// </summary>
  ServiceResult get Result => this._result;

  /// <summary>
  /// Gets the error code associated with this response.
  /// </summary>
  ServiceError get ErrorCode => this._errorCode;

  /// <summary>
  /// Gets a detailed error message associated with the response. If Result is set to Success, ErrorMessage returns null.
  /// ErrorMessage is localized according to the PreferredCulture property of the ExchangeService object that
  /// was used to call the method that generated the response.
  /// </summary>
  String get ErrorMessage => this._errorMessage;

  set ErrorMessage(String value) {
    this._errorMessage = value;
  }

  /// <summary>
  /// Gets error details associated with the response. If Result is set to Success, ErrorDetailsDictionary returns null.
  /// Error details will only available for some error codes. For example, when error code is ErrorRecurrenceHasNoOccurrence,
  /// the ErrorDetailsDictionary will contain keys for EffectiveStartDate and EffectiveEndDate.
  /// </summary>
  /// <value>The error details dictionary.</value>
  Map<String, String> get ErrorDetails => this._errorDetails;

  /// <summary>
  /// Gets information about property errors associated with the response. If Result is set to Success, ErrorProperties returns null.
  /// ErrorProperties is only available for some error codes. For example, when the error code is ErrorInvalidPropertyForOperation,
  /// ErrorProperties will contain the definition of the property that was invalid for the request.
  /// </summary>
  /// <value>The error properties list.</value>
  List<PropertyDefinitionBase> get ErrorProperties => this._errorProperties;
}
