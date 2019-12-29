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

/// <summary>
/// Represents an error that occurs when a service operation fails locally (e.g. validation error).
/// </summary>
//    [Serializable]
class ServiceLocalException implements Exception {
  final String message;

  /// <summary>
  /// ServiceLocalException Constructor.
  /// </summary>
  /// <param name="message">Error message text.</param>
  ServiceLocalException([this.message = ""]) : super();

  @override
  String toString() {
    return 'ServiceLocalException{message: $message}';
  }

  /// <summary>
  /// ServiceLocalException Constructor.
  /// </summary>
  /// <param name="message">Error message text.</param>
  /// <param name="innerException">Inner exception.</param>
//  ServiceLocalException(String message, Exception innerException)
//      : super(message, innerException);

  /// <summary>
  /// Initializes a new instance of the <see cref="T:Microsoft.Exchange.WebServices.Data.ServiceLocalException"/> class with serialized data.
  /// </summary>
  /// <param name="info">The object that holds the serialized object data.</param>
  /// <param name="context">The contextual information about the source or destination.</param>
// ServiceLocalException(SerializationInfo info, StreamingContext context) : super(info, context);
}
