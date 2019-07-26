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
/// Defines the containment mode for Contains search filters.
/// </summary>
enum ContainmentMode {
  /// <summary>
  /// The comparison is between the full String and the constant. The property value and the supplied constant are precisely the same.
  /// </summary>
  FullString,

  /// <summary>
  /// The comparison is between the String prefix and the constant.
  /// </summary>
  Prefixed,

  /// <summary>
  /// The comparison is between a subString of the String and the constant.
  /// </summary>
  Substring,

  /// <summary>
  /// The comparison is between a prefix on individual words in the String and the constant.
  /// </summary>
  PrefixOnWords,

  /// <summary>
  /// The comparison is between an exact phrase in the String and the constant.
  /// </summary>
  ExactPhrase
}
