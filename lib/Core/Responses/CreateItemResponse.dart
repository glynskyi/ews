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

import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Responses/CreateItemResponseBase.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Enumerations/ServiceResult.dart';

/// <summary>
/// Represents the response to an individual item creation operation.
/// </summary>
class CreateItemResponse extends CreateItemResponseBase {
  /* private */ Item? item;

  /// <summary>
  /// Gets Item instance.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="xmlElementName">Name of the XML element.</param>
  /// <returns>Item.</returns>
  @override
  Item GetObjectInstance(ExchangeService? service, String xmlElementName) {
    return this.item!;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="CreateItemResponse"/> class.
  /// </summary>
  /// <param name="item">The item.</param>
  CreateItemResponse(Item item) : super() {
    this.item = item;
  }

  /// <summary>
  /// Clears the change log of the created folder if the creation succeeded.
  /// </summary>
  @override
  void Loaded() {
    if (this.Result == ServiceResult.Success) {
      this.item!.ClearChangeLog();
    }
  }
}
