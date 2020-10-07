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

import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Enumerations/ServiceError.dart';
import 'package:ews/Exceptions/ServiceRemoteException.dart';

/// <summary>
/// Represents a remote service exception that has a single response.
/// </summary>
//    [Serializable]
class ServiceResponseException extends ServiceRemoteException {
  /// <summary>
  /// Error details Value keys
  /// </summary>
  static const String _ExceptionClassKey = "ExceptionClass";

  static const String _ExceptionMessageKey = "ExceptionMessage";

  static const String _StackTraceKey = "StackTrace";

  /// <summary>
  /// ServiceResponse when service operation failed remotely.
  /// </summary>
  final ServiceResponse _response;

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceResponseException"/> class.
  /// </summary>
  /// <param name="response">The ServiceResponse when service operation failed remotely.</param>
  ServiceResponseException(this._response);

  @override
  String toString() {
    return 'ServiceResponseException{_response: $_response}';
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="T:Microsoft.Exchange.WebServices.Data.ServiceResponseException"/> class with serialized data.
  /// </summary>
  /// <param name="info">The object that holds the serialized object data.</param>
  /// <param name="context">The contextual information about the source or destination.</param>
//		protected ServiceResponseException(SerializationInfo info, StreamingContext context)
//			: super(info, context)
//		{
//			this.response = (ServiceResponse)info.GetValue("Response", typeof(ServiceResponse));
//		}

  /// <summary>Sets the <see cref="T:System.Runtime.Serialization.SerializationInfo" /> object with the parameter name and additional exception information.</summary>
  /// <param name="info">The object that holds the serialized object data. </param>
  /// <param name="context">The contextual information about the source or destination. </param>
  /// <exception cref="T:System.ArgumentNullException">The <paramref name="info" /> object is a null reference (Nothing in Visual Basic). </exception>
//@override
// void GetObjectData(SerializationInfo info, StreamingContext context)
//		{
////			EwsUtilities.Assert(info != null, "ServiceResponseException.GetObjectData", "info is null");
//
//			super.GetObjectData(info, context);
//
//			info.AddValue("Response", this.response, typeof(ServiceResponse));
//		}

  /// <summary>
  /// Gets the ServiceResponse for the exception.
  /// </summary>
  ServiceResponse get Response => this._response;

  /// <summary>
  /// Gets the service error code.
  /// </summary>
  ServiceError get ErrorCode => this._response.ErrorCode;

  /// <summary>
  /// Gets a message that describes the current exception.
  /// </summary>
  /// <returns>The error message that explains the reason for the exception.</returns>
  @override
  String get Message {
    // Special case for Server Error. If the server returned
    // stack trace information, include it in the exception message.
    if (this.Response.ErrorCode == ServiceError.ErrorInternalServerError) {
      if (this.Response.ErrorDetails.containsKey(_ExceptionClassKey) &&
          this.Response.ErrorDetails.containsKey(_ExceptionMessageKey) &&
          this.Response.ErrorDetails.containsKey(_StackTraceKey)) {
        String exceptionClass = this.Response.ErrorDetails[_ExceptionClassKey];
        String exceptionMessage =
            this.Response.ErrorDetails[_ExceptionMessageKey];
        String stackTrace = this.Response.ErrorDetails[_StackTraceKey];

//                        return StringUtils.Format(
//                            Strings.ServerErrorAndStackTraceDetails,
//                            this.Response.ErrorMessage,
//                            exceptionClass,
//                            exceptionMessage,
//                            stackTrace);
        return "${this._response.ErrorMessage} -- Server Error: $exceptionClass: $exceptionMessage $stackTrace";
      }
    }

    return this.Response.ErrorMessage;
  }
}
