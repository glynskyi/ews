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

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/MultiResponseServiceRequest.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Enumerations/DeleteMode.dart' as enumerations;
import 'package:ews/Enumerations/ServiceErrorHandling.dart';

/// <summary>
/// Represents an abstract Delete request.
/// </summary>
/// <typeparam name="TResponse">The type of the response.</typeparam>
abstract class DeleteRequest<TResponse extends ServiceResponse>
    extends MultiResponseServiceRequest<TResponse> {
  /// <summary>
  /// Delete mode. Default is SoftDelete.
  /// </summary>
  enumerations.DeleteMode _deleteMode = enumerations.DeleteMode.SoftDelete;

  /// <summary>
  /// Initializes a new instance of the <see cref="DeleteRequest&lt;TResponse&gt;"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  DeleteRequest(ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode);

  /// <summary>
  /// Writes XML attributes.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    writer.WriteAttributeValue(XmlAttributeNames.DeleteType, this.DeleteMode);
  }

  /// <summary>
  /// Gets or sets the delete mode.
  /// </summary>
  /// <value>The delete mode.</value>
  enumerations.DeleteMode get DeleteMode => this._deleteMode;

  set DeleteMode(enumerations.DeleteMode value) {
    this._deleteMode = value;
  }
}
