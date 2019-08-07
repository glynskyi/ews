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
/// Defines the legacy free/busy status associated with an appointment.
/// </summary>
enum LegacyFreeBusyStatus {
  /// <summary>
  /// The time slot associated with the appointment appears as free.
  /// </summary>
  Free,

  /// <summary>
  /// The time slot associated with the appointment appears as tentative.
  /// </summary>
  Tentative,

  /// <summary>
  /// The time slot associated with the appointment appears as busy.
  /// </summary>
  Busy,

  /// <summary>
  /// The time slot associated with the appointment appears as Out of Office.
  /// </summary>
  OOF,

  /// <summary>
  /// The time slot associated with the appointment appears as working else where.
  /// </summary>
  WorkingElsewhere,

  /// <summary>
  /// No free/busy status is associated with the appointment.
  /// </summary>
  NoData
}
