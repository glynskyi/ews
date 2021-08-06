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
import 'dart:io';

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/ServiceRequestBase.dart';
import 'package:ews/Enumerations/TraceFlags.dart';
import 'package:ews/Exceptions/ServiceRequestException.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:ews/misc/Std/MemoryStream.dart';

/// <summary>
/// Represents an abstract, simple request-response service request.
/// </summary>
abstract class SimpleServiceRequestBase extends ServiceRequestBase {
  /// <summary>
  /// Initializes a new instance of the <see cref="SimpleServiceRequestBase"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  SimpleServiceRequestBase(ExchangeService service) : super(service);

  /// <summary>
  /// Executes this request.
  /// </summary>
  /// <returns>Service response.</returns>
  Future<Object> InternalExecute() async {
    final requestOut = OutParam<IEwsHttpWebRequest>();
    IEwsHttpWebResponse response =
        await this.ValidateAndEmitRequest(requestOut);

    Object responseObject = await this._ReadResponse(response);

    return responseObject;
  }

  /// <summary>
  /// Ends executing this async request.
  /// </summary>
  /// <param name="asyncResult">The async result</param>
  /// <returns>Service response object.</returns>
//        Object EndInternalExecute(IAsyncResult asyncResult)
//        {
//            // We have done enough validation before
//            AsyncRequestResult asyncRequestResult = (AsyncRequestResult)asyncResult;
//
//            IEwsHttpWebResponse response = this.EndGetEwsHttpWebResponse(asyncRequestResult.WebRequest, asyncRequestResult.WebAsyncResult);
//            return this.ReadResponse(response);
//        }

  /// <summary>
  /// Begins executing this async request.
  /// </summary>
  /// <param name="callback">The AsyncCallback delegate.</param>
  /// <param name="state">An object that contains state information for this request.</param>
  /// <returns>An IAsyncResult that references the asynchronous request.</returns>
//        IAsyncResult BeginExecute(AsyncCallback callback, object state)
//        {
//            this.Validate();
//
//            IEwsHttpWebRequest request = this.BuildEwsHttpWebRequest();
//
//            WebAsyncCallStateAnchor wrappedState = new WebAsyncCallStateAnchor(this, request, callback /* user callback */, state /* user state */);
//
//            // BeginGetResponse() does not throw interesting exceptions
//            IAsyncResult webAsyncResult = request.BeginGetResponse(SimpleServiceRequestBase.WebRequestAsyncCallback, wrappedState);
//
//            return new AsyncRequestResult(this, request, webAsyncResult, state /* user state */);
//        }

  /// <summary>
  /// Async callback method for HttpWebRequest async requests.
  /// </summary>
  /// <param name="webAsyncResult">An IAsyncResult that references the asynchronous request.</param>
//        /* private */ static void WebRequestAsyncCallback(IAsyncResult webAsyncResult)
//        {
//            WebAsyncCallStateAnchor wrappedState = webAsyncResult.AsyncState as WebAsyncCallStateAnchor;
//
//            if (wrappedState != null && wrappedState.AsyncCallback != null)
//            {
//                AsyncRequestResult asyncRequestResult = new AsyncRequestResult(
//                    wrappedState.ServiceRequest,
//                    wrappedState.WebRequest,
//                    webAsyncResult, /* web async result */
//                    wrappedState.AsyncState /* user state */);
//
//                // Call user's call back
//                wrappedState.AsyncCallback(asyncRequestResult);
//            }
//        }

  /// <summary>
  /// Reads the response with error handling
  /// </summary>
  /// <param name="response">The response.</param>
  /// <returns>Service response.</returns>
  Future<Object> _ReadResponse(IEwsHttpWebResponse response) async {
    Object serviceResponse;

    try {
      this.Service.ProcessHttpResponseHeaders(
          TraceFlags.EwsResponseHttpHeaders, response);

      // If tracing is enabled, we read the entire response into a MemoryStream so that we
      // can pass it along to the ITraceListener. Then we parse the response from the
      // MemoryStream.
      if (this.Service.IsTraceEnabledFor(TraceFlags.EwsResponse)) {
        final memoryStream = new MemoryStream();
        {
          Stream<List<int>> serviceResponseStream =
              ServiceRequestBase.GetResponseStream(response);

          // Copy response to in-memory stream and reset position to start.
          await EwsUtilities.CopyStream(serviceResponseStream, memoryStream);
          memoryStream.Position = 0;

          //serviceResponseStream.Close();

          this.TraceResponseXml(response, memoryStream);

          serviceResponse =
              this._ReadResponseXml(memoryStream, response.Headers);
        }
        await memoryStream.close();
      } else {
        Stream<List<int>> responseStream =
            ServiceRequestBase.GetResponseStream(response);

        serviceResponse =
            this._ReadResponseXml(responseStream, response.Headers);

        // responseStream.Close();
      }
    } on WebException catch (ex, stacktrace) {
      if (ex.Response != null) {
        IEwsHttpWebResponse exceptionResponse =
            this.Service.HttpWebRequestFactory.CreateExceptionResponse(ex);
        this.Service.ProcessHttpResponseHeaders(
            TraceFlags.EwsResponseHttpHeaders, exceptionResponse);
      }

      throw new ServiceRequestException(
          "ServiceRequestFailed(${ex.message})", ex, stacktrace);
    } on IOException catch (ex, stacktrace) {
      // Wrap exception.
      throw new ServiceRequestException(
          "ServiceRequestFailed($ex)", ex, stacktrace);
    } finally {
      if (response != null) {
        response.Close();
      }
    }

    return serviceResponse;
  }

  /// <summary>
  /// Reads the response XML.
  /// </summary>
  /// <param name="responseStream">The response stream.</param>
  /// <param name="responseHeaders">The HTTP response headers</param>
  /// <returns></returns>
  Future<Object> _ReadResponseXml(Stream<List<int>> responseStream,
      [WebHeaderCollection? responseHeaders = null]) async {
    Object serviceResponse;
    EwsServiceXmlReader ewsXmlReader =
        await EwsServiceXmlReader.Create(responseStream, this.Service);
    serviceResponse =
        this.ReadResponseWithHeaders(ewsXmlReader, responseHeaders);
    return serviceResponse;
  }
}
