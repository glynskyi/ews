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
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Enumerations/ServiceError.dart';
import 'package:ews/misc/NameResolutionCollection.dart';

/// <summary>
/// Represents the response to a name resolution operation.
/// </summary>
class ResolveNamesResponse extends ServiceResponse {
  NameResolutionCollection _resolutions;

  /// <summary>
  /// Initializes a new instance of the <see cref="ResolveNamesResponse"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  ResolveNamesResponse(ExchangeService service) : super() {
    EwsUtilities.Assert(
        service != null, "ResolveNamesResponse.ctor", "service is null");

    this._resolutions = new NameResolutionCollection(service);
  }

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    super.ReadElementsFromXml(reader);

    this.Resolutions.LoadFromXml(reader);
  }

  /// <summary>
  /// Override base implementation so that API does not throw when name resolution fails to find a match.
  /// EWS returns an error in this case but the API will just return an empty NameResolutionCollection.
  /// </summary>
  @override
  void InternalThrowIfNecessary() {
    if (this.ErrorCode != ServiceError.ErrorNameResolutionNoResults) {
      super.InternalThrowIfNecessary();
    }
  }

  /// <summary>
  /// Gets a list of name resolution suggestions.
  /// </summary>
  NameResolutionCollection get Resolutions => this._resolutions;
}
