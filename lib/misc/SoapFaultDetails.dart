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
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ServiceError.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents SoapFault details.
/// </summary>
class SoapFaultDetails {
  /* private */ String faultCode;

  /* private */
  String faultString;

  /* private */
  String faultActor;

  /// <summary>
  /// Response code returned by EWS requests.
  /// Default to InternalServerError.
  /// </summary>
  /* private */
  ServiceError responseCode = ServiceError.ErrorInternalServerError;

  /// <summary>
  /// Message text of the error.
  /// </summary>
  /* private */
  String message;

  /// <summary>
  /// This is returned by Availability requests.
  /// </summary>
  /* private */
  ServiceError errorCode = ServiceError.NoError;

  /// <summary>
  /// This is returned by UM requests. It's the name of the exception that was raised.
  /// </summary>
  /* private */
  String exceptionType;

  /// <summary>
  /// When a schema validation error is returned, this is the line number in the request where the error occurred.
  /// </summary>
  /* private */
  int lineNumber;

  /// <summary>
  /// When a schema validation error is returned, this is the offset into the line of the request where the error occurred.
  /// </summary>
  /* private */
  int positionWithinLine;

  /// <summary>
  /// Dictionary of key/value pairs from the MessageXml node in the fault. Usually empty but there are
  /// a few cases where SOAP faults may include MessageXml details (e.g. CASOverBudgetException includes
  /// BackoffTime value).
  /// </summary>
  /* private */
  Map<String, String> errorDetails = {};

  /// <summary>
  /// Initializes a new instance of the <see cref="SoapFaultDetails"/> class.
  /// </summary>
  /* private */
  SoapFaultDetails() {}

  /// <summary>
  /// Parses the soap:Fault content.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="soapNamespace">The SOAP namespace to use.</param>
  /// <returns>SOAP fault details.</returns>
  static SoapFaultDetails Parse(
      EwsXmlReader reader, XmlNamespace soapNamespace) {
    SoapFaultDetails soapFaultDetails = new SoapFaultDetails();

    do {
      reader.Read();
      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.SOAPFaultCodeElementName:
            soapFaultDetails.FaultCode = reader.ReadElementValue<String>();
            break;

          case XmlElementNames.SOAPFaultStringElementName:
            soapFaultDetails.FaultString = reader.ReadElementValue<String>();
            break;

          case XmlElementNames.SOAPFaultActorElementName:
            soapFaultDetails.FaultActor = reader.ReadElementValue<String>();
            break;

          case XmlElementNames.SOAPDetailElementName:
            soapFaultDetails.ParseDetailNode(reader);
            break;

          default:
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        soapNamespace, XmlElementNames.SOAPFaultElementName));

    return soapFaultDetails;
  }

  /// <summary>
  /// Parses the detail node.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /* private */
  void ParseDetailNode(EwsXmlReader reader) {
    do {
      reader.Read();
      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.EwsResponseCodeElementName:
            try {
              this.ResponseCode = reader.ReadElementValue<ServiceError>();
            } catch (ArgumentError) {
              // ServiceError couldn't be mapped to enum value, treat as an ISE
              this.ResponseCode = ServiceError.ErrorInternalServerError;
            }

            break;

          case XmlElementNames.EwsMessageElementName:
            this.Message = reader.ReadElementValue<String>();
            break;

          case XmlElementNames.EwsLineElementName:
            this.LineNumber = reader.ReadElementValue<int>();
            break;

          case XmlElementNames.EwsPositionElementName:
            this.PositionWithinLine = reader.ReadElementValue<int>();
            break;

          case XmlElementNames.EwsErrorCodeElementName:
            try {
              this.ErrorCode = reader.ReadElementValue<ServiceError>();
            } catch (ArgumentError) {
              // ServiceError couldn't be mapped to enum value, treat as an ISE
              this.ErrorCode = ServiceError.ErrorInternalServerError;
            }

            break;

          case XmlElementNames.EwsExceptionTypeElementName:
            this.ExceptionType = reader.ReadElementValue<String>();
            break;

          case XmlElementNames.MessageXml:
            this.ParseMessageXml(reader);
            break;

          default:
            // Ignore any other details
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.NotSpecified, XmlElementNames.SOAPDetailElementName));
  }

  /// <summary>
  /// Parses the message XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /* private */
  void ParseMessageXml(EwsXmlReader reader) {
    // E12 and E14 return the MessageXml element in different
    // namespaces (types namespace for E12, errors namespace in E14). To
    // avoid this problem, the parser will match the namespace from the
    // start and end elements.
    XmlNamespace elementNS =
        EwsUtilities.GetNamespaceFromUri(reader.NamespaceUri);

    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if (reader.IsStartElement() && !reader.IsEmptyElement) {
          switch (reader.LocalName) {
            case XmlElementNames.Value:
              this.errorDetails[
                      reader.ReadAttributeValue(XmlAttributeNames.Name)] =
                  reader.ReadElementValue<String>();
              break;

            default:
              break;
          }
        }
      } while (!reader.IsEndElementWithNamespace(
          elementNS, XmlElementNames.MessageXml));
    }
  }

  /// <summary>
  /// Gets or sets the SOAP fault code.
  /// </summary>
  /// <value>The SOAP fault code.</value>
  String get FaultCode => this.faultCode;

  set FaultCode(String value) {
    this.faultCode = value;
  }

  /// <summary>
  /// Gets or sets the SOAP fault string.
  /// </summary>
  /// <value>The fault string.</value>
  String get FaultString => this.faultString;

  set FaultString(String value) {
    this.faultString = value;
  }

  /// <summary>
  /// Gets or sets the SOAP fault actor.
  /// </summary>
  /// <value>The fault actor.</value>
  String get FaultActor => this.faultActor;

  set FaultActor(String value) {
    this.faultActor = value;
  }

  /// <summary>
  /// Gets or sets the response code.
  /// </summary>
  /// <value>The response code.</value>
  ServiceError get ResponseCode => this.responseCode;

  set ResponseCode(ServiceError value) {
    this.responseCode = value;
  }

  /// <summary>
  /// Gets or sets the message.
  /// </summary>
  /// <value>The message.</value>
  String get Message => this.message;

  set Message(String value) {
    this.message = value;
  }

  /// <summary>
  /// Gets or sets the error code.
  /// </summary>
  /// <value>The error code.</value>
  ServiceError get ErrorCode => this.errorCode;

  set ErrorCode(ServiceError value) {
    this.errorCode = value;
  }

  /// <summary>
  /// Gets or sets the type of the exception.
  /// </summary>
  /// <value>The type of the exception.</value>
  String get ExceptionType => this.exceptionType;

  set ExceptionType(String value) {
    this.exceptionType = value;
  }

  /// <summary>
  /// Gets or sets the line number.
  /// </summary>
  /// <value>The line number.</value>
  int get LineNumber => this.lineNumber;

  set LineNumber(int value) {
    this.lineNumber = value;
  }

  /// <summary>
  /// Gets or sets the position within line.
  /// </summary>
  /// <value>The position within line.</value>
  int get PositionWithinLine => this.positionWithinLine;

  set PositionWithinLine(int value) {
    this.positionWithinLine = value;
  }

  /// <summary>
  /// Gets or sets the error details dictionary.
  /// </summary>
  /// <value>The error details dictionary.</value>
  Map<String, String> get ErrorDetails => this.errorDetails;

  set ErrorDetails(Map<String, String> value) {
    this.errorDetails = value;
  }
}
