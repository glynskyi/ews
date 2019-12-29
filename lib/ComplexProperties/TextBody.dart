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

import 'package:ews/ComplexProperties/MessageBody.dart';
import 'package:ews/Enumerations/BodyType.dart' as enumerations;

/// <summary>
/// Represents the body of a message.
/// </summary>
class TextBody extends MessageBody {
  /// <summary>
  /// Initializes a new instance of the <see cref="TextBody"/> class.
  /// </summary>
  TextBody() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="TextBody"/> class.
  /// </summary>
  /// <param name="text">The text of the message body.</param>
  TextBody.withText(String text)
      : super.withText(text, enumerations.BodyType.Text) {}

  /// <summary>
  /// Defines an implicit conversation between a String and TextBody.
  /// </summary>
  /// <param name="textBody">The String to convert to TextBody, assumed to be HTML.</param>
  /// <returns>A TextBody initialized with the specified string.</returns>
// static implicit operator TextBody(String textBody)
//        {
//            return new TextBody(textBody);
//        }
}
