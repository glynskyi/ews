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

/// <summary>
/// Represents Exchange server information.
/// </summary>
class ExchangeServerInfo {
  int _majorVersion;

  int _minorVersion;

  int _majorBuildNumber;

  int _minorBuildNumber;

  String _versionString;

  /// <summary>
  /// Default constructor
  /// </summary>
  ExchangeServerInfo();

  /// <summary>
  /// Parse current element to extract server information
  /// </summary>
  /// <param name="reader">EwsServiceXmlReader</param>
  /// <returns>ExchangeServerInfo</returns>
  static ExchangeServerInfo Parse(EwsServiceXmlReader reader) {
    EwsUtilities.Assert(reader.HasAttributes, "ExchangeServerVersion.Parse",
        "Current element doesn't have attributes");

    ExchangeServerInfo info = new ExchangeServerInfo();
    info.MajorVersion = reader.ReadAttributeValue<int>("MajorVersion");
    info.MinorVersion = reader.ReadAttributeValue<int>("MinorVersion");
    info.MajorBuildNumber = reader.ReadAttributeValue<int>("MajorBuildNumber");
    info.MinorBuildNumber = reader.ReadAttributeValue<int>("MinorBuildNumber");
    info.VersionString = reader.ReadAttributeValue("Version");
    return info;
  }

  /// <summary>
  /// Gets the Major Exchange server version number
  /// </summary>
  int get MajorVersion => this._majorVersion;

  set MajorVersion(int value) {
    this._majorVersion = value;
  }

  /// <summary>
  /// Gets the Minor Exchange server version number
  /// </summary>
  int get MinorVersion => this._minorVersion;

  set MinorVersion(int value) {
    this._minorVersion = value;
  }

  /// <summary>
  /// Gets the Major Exchange server build number
  /// </summary>
  int get MajorBuildNumber => this._majorBuildNumber;

  set MajorBuildNumber(int value) {
    this._majorBuildNumber = value;
  }

  /// <summary>
  /// Gets the Minor Exchange server build number
  /// </summary>
  int get MinorBuildNumber => this._minorBuildNumber;

  set MinorBuildNumber(int value) {
    this._minorBuildNumber = value;
  }

  /// <summary>
  /// Gets the Exchange server version String (e.g. "Exchange2010")
  /// </summary>
  /// <remarks>
  /// The version is a String rather than an enum since its possible for the client to
  /// be connected to a later server for which there would be no appropriate enum value.
  /// </remarks>
  String get VersionString => this._versionString;

  set VersionString(String value) {
    this._versionString = value;
  }

  /// <summary>
  /// Override toString() method
  /// </summary>
  /// <returns>Canonical ExchangeService version string</returns>
  @override
  String toString() =>
      "$MajorVersion.$MinorVersion.$MajorBuildNumber.$MinorBuildNumber";
}
