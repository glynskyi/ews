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

import 'package:ews/ComplexProperties/ServiceId.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart' as core;
import 'package:ews/Enumerations/ChangeType.dart' as enumerations;

/// <summary>
/// Represents a change as returned by a synchronization operation.
/// </summary>
//    [EditorBrowsable(EditorBrowsableState.Never)]
abstract class Change {
  /// <summary>
  /// The type of change.
  /// </summary>
  /* private */ enumerations.ChangeType changeType;

  /// <summary>
  /// The service object the change applies to.
  /// </summary>
  /* private */
  core.ServiceObject serviceObject;

  /// <summary>
  /// The Id of the service object the change applies to.
  /// </summary>
  /* private */
  ServiceId id;

  /// <summary>
  /// Initializes a new instance of Change.
  /// </summary>
  Change() {}

  /// <summary>
  /// Creates an Id of the appropriate class.
  /// </summary>
  /// <returns>A ServiceId.</returns>
  ServiceId CreateId();

  /// <summary>
  /// Gets the type of the change.
  /// </summary>
  enumerations.ChangeType get ChangeType => this.changeType;

  set ChangeType(enumerations.ChangeType value) {
    this.changeType = value;
  }

  /// <summary>
  /// Gets or sets the service object the change applies to.
  /// </summary>
  core.ServiceObject get ServiceObject => this.serviceObject;

  set ServiceObject(core.ServiceObject value) {
    this.serviceObject = value;
  }

  /// <summary>
  /// Gets or sets the Id of the service object the change applies to.
  /// </summary>
  ServiceId get Id => this.ServiceObject != null ? this.ServiceObject.GetId() : this.id;

  set Id(ServiceId value) {
    this.id = value;
  }
}
