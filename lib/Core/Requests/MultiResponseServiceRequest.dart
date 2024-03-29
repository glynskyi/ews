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
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/SimpleServiceRequestBase.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/Responses/ServiceResponseCollection.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/ServiceResult.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceResponseException.dart';
import 'package:ews/Exceptions/ServiceXmlDeserializationException.dart';

import '../EwsUtilities.dart';

/// <summary>
/// Represents a service request that can have multiple responses.
/// </summary>
/// <typeparam name="TResponse">The type of the response.</typeparam>
abstract class MultiResponseServiceRequest<TResponse extends ServiceResponse>
    extends SimpleServiceRequestBase {
  /* private */ ServiceErrorHandling? errorHandlingMode;

  /// <summary>
  /// Parses the response.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>Service response collection.</returns>
  @override
  Future<Object> ParseResponse(EwsServiceXmlReader reader) async {
    ServiceResponseCollection<TResponse> serviceResponses =
        new ServiceResponseCollection<TResponse>();

    await reader.ReadStartElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.ResponseMessages);

    for (int i = 0; i < this.GetExpectedResponseMessageCount(); i++) {
      // Read ahead to see if we've reached the end of the response messages early.
      await reader.Read();
      if (reader.IsEndElementWithNamespace(
          XmlNamespace.Messages, XmlElementNames.ResponseMessages)) {
        break;
      }

      TResponse response = this.CreateServiceResponse(reader.Service, i);

      await response.LoadFromXml(
          reader, this.GetResponseMessageXmlElementName());

      // Add the response to the list after it has been deserialized because the response
      // list updates an overall result as individual responses are added to it.
      serviceResponses.Add(response);
    }

    // If there's a general error in batch processing,
    // the server will return a single response message containing the error
    // (for example, if the SavedItemFolderId is bogus in a batch CreateItem
    // call). In this case, throw a ServiceResponseException. Otherwise this
    // is an unexpected server error.
    if (serviceResponses.Count < this.GetExpectedResponseMessageCount()) {
      if ((serviceResponses.Count == 1) &&
          (serviceResponses[0].Result == ServiceResult.Error)) {
        throw new ServiceResponseException(serviceResponses[0]);
      } else {
        throw new ServiceXmlDeserializationException("""string.Format(
                                    Strings.TooFewServiceReponsesReturned,
                                    this.GetResponseMessageXmlElementName(),
                                    this.GetExpectedResponseMessageCount(),
                                    serviceResponses.Count)""");
      }
    }

    await reader.ReadEndElementIfNecessary(
        XmlNamespace.Messages, XmlElementNames.ResponseMessages);

    return serviceResponses;
  }

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  TResponse CreateServiceResponse(ExchangeService service, int responseIndex);

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  String GetResponseMessageXmlElementName();

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
  int GetExpectedResponseMessageCount();

  /// <summary>
  /// Initializes a new instance of the <see cref="MultiResponseServiceRequest&lt;TResponse&gt;"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  MultiResponseServiceRequest(
      ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service) {
    this.errorHandlingMode = errorHandlingMode;
  }

  /// <summary>
  /// Executes this request.
  /// </summary>
  /// <returns>Service response collection.</returns>
  Future<ServiceResponseCollection<TResponse>> Execute() async {
    ServiceResponseCollection<TResponse> serviceResponses =
        (await this.InternalExecute()) as ServiceResponseCollection<TResponse>;

    if (this.ErrorHandlingMode == ServiceErrorHandling.ThrowOnError) {
      EwsUtilities.Assert(
          serviceResponses.Count == 1,
          "MultiResponseServiceRequest.Execute",
          "ServiceErrorHandling.ThrowOnError error handling is only valid for singleton request");

      serviceResponses[0].ThrowIfNecessary();
    }

    return serviceResponses;
  }

  /// <summary>
  /// Ends executing this async request.
  /// </summary>
  /// <param name="asyncResult">The async result</param>
  /// <returns>Service response collection.</returns>
//        ServiceResponseCollection<TResponse> EndExecute(IAsyncResult asyncResult)
//        {
//            ServiceResponseCollection<TResponse> serviceResponses = (ServiceResponseCollection<TResponse>)this.EndInternalExecute(asyncResult);
//
//            if (this.ErrorHandlingMode == ServiceErrorHandling.ThrowOnError)
//            {
////                EwsUtilities.Assert(
////                    serviceResponses.Count == 1,
////                    "MultiResponseServiceRequest.Execute",
////                    "ServiceErrorHandling.ThrowOnError error handling is only valid for singleton request");
//
//                serviceResponses[0].ThrowIfNecessary();
//            }
//
//            return serviceResponses;
//        }

  /// <summary>
  /// Gets a value indicating how errors should be handled.
  /// </summary>
  ServiceErrorHandling? get ErrorHandlingMode => this.errorHandlingMode;
}
