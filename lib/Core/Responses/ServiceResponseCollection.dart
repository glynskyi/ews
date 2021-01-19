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

import 'dart:collection';

import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Enumerations/ServiceResult.dart';

/// <summary>
/// Represents a strogly typed list of service responses.
/// </summary>
/// <typeparam name="TResponse">The type of response stored in the list.</typeparam>
//    [Serializable]
class ServiceResponseCollection<TResponse extends ServiceResponse>
    with IterableMixin<TResponse>
    implements Iterable<TResponse> {
  List<TResponse> _responses = <TResponse>[];

  ServiceResult _overallResult = ServiceResult.Success;

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceResponseCollection&lt;TResponse&gt;"/> class.
  /// </summary>
  ServiceResponseCollection() {}

  /// <summary>
  /// Adds specified response.
  /// </summary>
  /// <param name="response">The response.</param>
  void Add(TResponse response) {
    EwsUtilities.Assert(
        response != null, "EwsResponseList.Add", "response is null");

    if (response.Result.index > this._overallResult.index) {
      this._overallResult = response.Result;
    }

    this._responses.add(response);
  }

  /// <summary>
  /// Gets the total number of responses in the list.
  /// </summary>
  int get Count => this._responses.length;

  /// <summary>
  /// Gets the response at the specified index.
  /// </summary>
  /// <param name="index">The zero-based index of the response to get.</param>
  /// <returns>The response at the specified index.</returns>
  operator [](int index) {
    if (index < 0 || index >= this.Count) {
      throw new RangeError.value(index, "index", "Strings.IndexIsOutOfRange");
    }

    return this._responses[index];
  }

  /// <summary>
  /// Gets a value indicating the overall result of the request that generated this response collection.
  /// If all of the responses have their Result property set to Success, OverallResult returns Success.
  /// If at least one response has its Result property set to Warning and all other responses have their Result
  /// property set to Success, OverallResult returns Warning. If at least one response has a its Result set to
  /// Error, OverallResult returns Error.
  /// </summary>
  ServiceResult get OverallResult => this._overallResult;

  /// <summary>
  /// Gets an enumerator that iterates through the elements of the collection.
  /// </summary>
  /// <returns>An IEnumerator for the collection.</returns>
  @override
  Iterator<TResponse> get iterator => this._responses.iterator;
}
