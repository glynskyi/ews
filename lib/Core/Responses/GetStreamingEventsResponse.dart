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
import 'package:ews/Core/Requests/HangingServiceRequestBase.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Notifications/GetStreamingEventsResults.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/Std/EnumToString.dart';

/// <summary>
/// Enumeration of ConnectionStatus that can be returned by the server.
/// </summary>
/* private */
enum ConnectionStatus {
  /// <summary>
  /// Simple heartbeat
  /// </summary>
  OK,

  /// <summary>
  /// Server is closing the connection.
  /// </summary>
  Closed
}

/// <summary>
/// Represents the response to a subscription event retrieval operation.
/// </summary>
class GetStreamingEventsResponse extends ServiceResponse {
  GetStreamingEventsResults _results = new GetStreamingEventsResults();

  HangingServiceRequestBase _request;

  /// <summary>
  /// Initializes a new instance of the <see cref="GetStreamingEventsResponse"/> class.
  /// </summary>
  /// <param name="request">Request to disconnect when we get a close message.</param>
  GetStreamingEventsResponse(HangingServiceRequestBase request) : super() {
    this.ErrorSubscriptionIds = new List<String>();
    this._request = request;
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    super.ReadElementsFromXml(reader);

    reader.Read();

    if (reader.LocalName == XmlElementNames.Notifications) {
      this._results.LoadFromXml(reader);
    } else if (reader.LocalName == XmlElementNames.ConnectionStatus) {
      String connectionStatus = reader.ReadElementValueWithNamespace(
          XmlNamespace.Messages, XmlElementNames.ConnectionStatus);

      if (EnumToString.parse(ConnectionStatus.Closed) == connectionStatus) {
        this._request.DisconnectWithException(
            HangingRequestDisconnectReason.Clean, null);
      }
    }
  }

  /// <summary>
  /// Loads extra error details from XML
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="xmlElementName">The current element name of the extra error details.</param>
  /// <returns>
  /// True if the expected extra details is loaded;
  /// False if the element name does not match the expected element.
  /// </returns>
  @override
  bool LoadExtraErrorDetailsFromXml(
      EwsServiceXmlReader reader, String xmlElementName) {
    bool baseReturnVal =
        super.LoadExtraErrorDetailsFromXml(reader, xmlElementName);

    if (reader.IsStartElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.ErrorSubscriptionIds)) {
      do {
        reader.Read();

        if (reader.NodeType == XmlNodeType.Element &&
            reader.LocalName == XmlElementNames.SubscriptionId) {
          this.ErrorSubscriptionIds.add(reader.ReadElementValueWithNamespace(
              XmlNamespace.Messages, XmlElementNames.SubscriptionId));
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Messages, XmlElementNames.ErrorSubscriptionIds));

      return true;
    } else {
      return baseReturnVal;
    }
  }

  /// <summary>
  /// Gets event results from subscription.
  /// </summary>
  GetStreamingEventsResults get Results => this._results;

  /// <summary>
  /// Gets the error subscription ids.
  /// </summary>
  /// <value>The error subscription ids.</value>
  List<String> ErrorSubscriptionIds;
}
