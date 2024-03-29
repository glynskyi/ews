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

import 'dart:async';
import 'dart:typed_data';

import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Exceptions/NotSupportedException.dart';
import 'package:ews/misc/Std/MemoryStream.dart';

/// <summary>
/// A stream that traces everything it returns from its Read() call.
/// That trace may be retrieved at the end of the stream.
/// </summary>
class HangingTraceStream extends Stream<List<int>> {
  /* private */ late Stream<List<int>> underlyingStream;
  // /* private */ late StreamQueue<List<int>> underlyingStream;
  /* private */ late ExchangeService service;
  /* private */ MemoryStream? responseCopy;

  /// <summary>
  /// Initializes a new instance of the <see cref="HangingTraceStream"/> class.
  /// </summary>
  /// <param name="stream">The stream.</param>
  /// <param name="service">The service.</param>
  HangingTraceStream(Stream<List<int>> stream, ExchangeService service) {
    this.underlyingStream = stream;
    // this.underlyingStream = StreamQueue(stream);
    this.service = service;
  }

  /// <summary>
  /// Gets a value indicating whether the current stream supports reading.
  /// </summary>
  /// <returns>true</returns>
  @override
  bool get CanRead => true;

  /// <summary>
  /// Gets a value indicating whether the current stream supports seeking.
  /// </summary>
  /// <returns>false</returns>
  @override
  bool get CanSeek => false;

  /// <summary>
  /// Gets a value indicating whether the current stream supports writing.
  /// </summary>
  /// <returns>false</returns>
  @override
  bool get CanWrite => false;

  /// <summary>
  /// When overridden in a derived class, clears all buffers for this stream and causes any buffered data to be written to the underlying device.
  /// </summary>
  /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
  @override
  void Flush() {
    // no-op
  }

  /// <summary>
  /// Gets the length in bytes of the stream.
  /// </summary>
  /// <returns>A long value representing the length of the stream in bytes.</returns>
  /// <exception cref="T:System.NotSupportedException">This class does not support seeking. </exception>
  @override
  int get Length => throw new NotSupportedException();

  /// <summary>
  /// Gets or sets the position within the current stream.
  /// </summary>
  /// <value></value>
  /// <returns>The current position within the stream.</returns>
  /// <exception cref="T:System.NotSupportedException">The stream does not support seeking. </exception>
  @override
  int get Position => throw new NotSupportedException();

  /// <summary>
  /// When overridden in a derived class, reads a sequence of bytes from the current stream and advances the position within the stream by the number of bytes read.
  /// </summary>
  /// <param name="buffer">An array of bytes. When this method returns, the buffer contains the specified byte array with the values between <paramref name="offset"/> and (<paramref name="offset"/> + <paramref name="count"/> - 1) replaced by the bytes read from the current source.</param>
  /// <param name="offset">The zero-based byte offset in <paramref name="buffer"/> at which to begin storing the data read from the current stream.</param>
  /// <param name="count">The maximum number of bytes to be read from the current stream.</param>
  /// <returns>
  /// The total number of bytes read into the buffer. This can be less than the number of bytes requested if that many bytes are not currently available, or zero (0) if the end of the stream has been reached.
  /// </returns>
  /// <exception cref="T:System.ArgumentError">The sum of <paramref name="offset"/> and <paramref name="count"/> is larger than the buffer length. </exception>
  /// <exception cref="T:System.ArgumentNullException">
  ///     <paramref name="buffer"/> is null. </exception>
  /// <exception cref="T:System.ArgumentOutOfRangeException">
  ///     <paramref name="offset"/> or <paramref name="count"/> is negative. </exception>
  /// <exception cref="T:System.IO.IOException">An I/O error occurs. </exception>
  /// <exception cref="T:System.NotSupportedException">The stream does not support reading. </exception>
  /// <exception cref="T:System.ObjectDisposedException">Methods were called after the stream was closed. </exception>
  // @override
  // Future<int> Read(Uint8List buffer, int offset, int count) async {
  //   List<List<int>> buffer = await this.underlyingStream.take(
  //       count); // int retVal = this.underlyingStream.Read(buffer, offset, count);
  //   List<int> flatterBuffer = buffer.expand((it) => it).toList(growable: false);
  //   int retVal = flatterBuffer.length;
  //
  //   if (HangingServiceRequestBase.LogAllWireBytes) {
  //     String readString = utf8.decode(flatterBuffer);
  //     String logMessage =
  //         "HangingTraceStream ID [${this.hashCode}] returned ${retVal} bytes. Bytes returned: [${readString}]";
  //
  //     this.service.TraceMessage(TraceFlags.DebugMessage, logMessage);
  //   }
  //
  //   if (this.responseCopy != null) {
  //     this
  //         .responseCopy!
  //         .Write(Uint8List.fromList(flatterBuffer), offset, retVal);
  //   }
  //
  //   return retVal;
  // }

  /// <summary>
  /// Sets the position within the current stream.
  /// </summary>
  /// <param name="offset">A byte offset relative to the <paramref name="origin"/> parameter.</param>
  /// <param name="origin">A value of type <see cref="T:System.IO.SeekOrigin"/> indicating the reference point used to obtain the new position.</param>
  /// <returns>
  /// The new position within the current stream.
  /// </returns>
  /// <exception cref="T:System.NotSupportedException">The stream does not support seeking. </exception>
// @override
//  int Seek(int offset, SeekOrigin origin)
//         {
//             throw new NotSupportedException();
//         }

  /// <summary>
  /// Sets the length of the current stream.
  /// </summary>
  /// <param name="value">The desired length of the current stream in bytes.</param>
  /// <exception cref="T:System.NotSupportedException">The stream does not support both writing and seeking, such as if the stream is constructed from a pipe or console output. </exception>
// @override
//  void SetLength(long value)
//         {
//             throw new NotSupportedException();
//         }

  /// <summary>
  /// Writes a sequence of bytes to the current stream and advances the current position within this stream by the number of bytes written.
  /// </summary>
  /// <param name="buffer">An array of bytes. This method copies <paramref name="count"/> bytes from <paramref name="buffer"/> to the current stream.</param>
  /// <param name="offset">The zero-based byte offset in <paramref name="buffer"/> at which to begin copying bytes to the current stream.</param>
  /// <param name="count">The number of bytes to be written to the current stream.</param>
  /// <exception cref="T:System.NotSupportedException">The stream does not support writing. </exception>
  @override
  void Write(Uint8List buffer, int offset, int count) {
    throw new NotSupportedException();
  }

  /// <summary>
  /// Sets the response copy.
  /// </summary>
  /// <param name="responseCopy">A copy of the response.</param>
  /// <returns>A copy of the response.</returns>
  void SetResponseCopy(MemoryStream responseCopy) {
    this.responseCopy = responseCopy;
  }

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return underlyingStream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    // throw UnimplementedError("listen");
    // return Stream.fromIterable(elements).listen(onData,
    //     onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
