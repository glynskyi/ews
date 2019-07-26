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

import 'package:ews/Interfaces/ITraceListener.dart';

/// <summary>
/// EwsTraceListener logs request/responses to a text writer.
/// </summary>
class EwsTraceListener implements ITraceListener {
//        /* private */ TextWriter writer;

  /// <summary>
  /// Initializes a new instance of the <see cref="EwsTraceListener"/> class.
  /// Uses Console.Out as output.
  /// </summary>
  EwsTraceListener();

//            : this(Console.Out)
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="EwsTraceListener"/> class.
  /// </summary>
  /// <param name="writer">The writer.</param>
//        EwsTraceListener(TextWriter writer)
//        {
//            this.writer = writer;
//        }

  /// <summary>
  /// Handles a trace message
  /// </summary>
  /// <param name="traceType">Type of trace message.</param>
  /// <param name="traceMessage">The trace message.</param>
  void Trace(String traceType, String traceMessage) {
    _printWrapped(traceMessage);
//            this.writer.Write(traceMessage);
  }

  void _printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
