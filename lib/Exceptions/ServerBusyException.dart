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
import 'package:ews/Exceptions/ServiceResponseException.dart';

/// <summary>
/// Represents a server busy exception found in a service response.
/// </summary>
class ServerBusyException extends ServiceResponseException {
  static const String BackOffMillisecondsKey = "BackOffMilliseconds";
  int _backOffMilliseconds;

  /// <summary>
  /// Initializes a new instance of the <see cref="ServerBusyException"/> class.
  /// </summary>
  /// <param name="response">The ServiceResponse when service operation failed remotely.</param>
  ServerBusyException(ServiceResponse response) : super(response) {
    if (response.ErrorDetails != null &&
        response.ErrorDetails.containsKey(
            ServerBusyException.BackOffMillisecondsKey)) {
      _backOffMilliseconds = int.tryParse(
          response.ErrorDetails[ServerBusyException.BackOffMillisecondsKey]);
    }
  }

  @override
  String toString() {
    return 'ServerBusyException{_backOffMilliseconds: $_backOffMilliseconds, message: $message}';
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="T:Microsoft.Exchange.WebServices.Data.ServerBusyException"/> class with serialized data.
  /// </summary>
  /// <param name="info">The object that holds the serialized object data.</param>
  /// <param name="context">The contextual information about the source or destination.</param>
//		protected ServerBusyException(SerializationInfo info, StreamingContext context)
//			: super(info, context)
//		{
//			this.backOffMilliseconds = info.GetInt32("BackOffMilliseconds");
//		}

  /// <summary>Sets the <see cref="T:System.Runtime.Serialization.SerializationInfo" /> object with the parameter name and additional exception information.</summary>
  /// <param name="info">The object that holds the serialized object data. </param>
  /// <param name="context">The contextual information about the source or destination. </param>
  /// <exception cref="T:System.ArgumentNullException">The <paramref name="info" /> object is a null reference (Nothing in Visual Basic). </exception>
//@override
// void GetObjectData(SerializationInfo info, StreamingContext context)
//		{
//			EwsUtilities.Assert(info != null, "ServerBusyException.GetObjectData", "info is null");
//
//			base.GetObjectData(info, context);
//
//			info.AddValue("BackOffMilliseconds", this.backOffMilliseconds);
//		}

  /// <summary>
  /// Suggested number of milliseconds to wait before attempting a request again. If zero,
  /// there is no suggested backoff time.
  /// </summary>
  int get BackOffMilliseconds => this._backOffMilliseconds;
}
