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

import 'package:ews/ComplexProperties/ComplexProperty.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlAttributeNames.dart';

/// <summary>
/// Represents the Id of an Exchange object.
/// </summary>
abstract class ServiceId extends ComplexProperty {
  String? _changeKey;

  String? _uniqueId;

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceId"/> class.
  /// </summary>
  ServiceId() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="ServiceId"/> class.
  /// </summary>
  /// <param name="uniqueId">The unique id.</param>
  ServiceId.fromUniqueId(String uniqueId) : super() {
    EwsUtilities.ValidateParam(uniqueId, "uniqueId");

    this._uniqueId = uniqueId;
  }

  /// <summary>
  /// Reads attributes from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadAttributesFromXml(EwsServiceXmlReader reader) {
    this._uniqueId = reader.ReadAttributeValue(XmlAttributeNames.Id);
    this._changeKey = reader.ReadAttributeValue(XmlAttributeNames.ChangeKey);
  }

  /// <summary>
  /// Writes attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    writer.WriteAttributeValue(XmlAttributeNames.Id, this.UniqueId);
    writer.WriteAttributeValue(XmlAttributeNames.ChangeKey, this.ChangeKey);
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  String GetXmlElementName();

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXmlElemenetName(EwsServiceXmlWriter writer) {
    super.WriteToXml(writer, this.GetXmlElementName());
  }

  /// <summary>
  /// Assigns from existing id.
  /// </summary>
  /// <param name="source">The source.</param>
  void Assign(ServiceId source) {
    this._uniqueId = source.UniqueId;
    this._changeKey = source.ChangeKey;
  }

  /// <summary>
  /// True if this instance is valid, false otherthise.
  /// </summary>
  /// <value><c>true</c> if this instance is valid; otherwise, <c>false</c>.</value>
  bool get IsValid => this._uniqueId != null && this._uniqueId!.isNotEmpty;

  /// <summary>
  /// Gets the unique Id of the Exchange object.
  /// </summary>
  String? get UniqueId => this._uniqueId;

  set UniqueId(String? value) => this._uniqueId = value;

  /// <summary>
  /// Gets the change key associated with the Exchange object. The change key represents the
  /// the version of the associated item or folder.
  /// </summary>
  String? get ChangeKey => this._changeKey;

  set ChangeKey(String? value) => this._changeKey;

  /// <summary>
  /// Determines whether two ServiceId instances are equal (including ChangeKeys)
  /// </summary>
  /// <param name="other">The ServiceId to compare with the current ServiceId.</param>
  bool SameIdAndChangeKey(ServiceId other) {
    if (this == other) {
      return ((this.ChangeKey == null) && (other.ChangeKey == null)) ||
          this.ChangeKey == other.ChangeKey;
    } else {
      return false;
    }
  }

  /// <summary>
  /// Determines whether the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <param name="obj">The <see cref="T:System.Object"/> to compare with the current <see cref="T:System.Object"/>.</param>
  /// <remarks>
  /// We do not consider the ChangeKey for ServiceId.Equals.</remarks>
  /// <returns>
  /// true if the specified <see cref="T:System.Object"/> is equal to the current <see cref="T:System.Object"/>; otherwise, false.
  /// </returns>
  /// <exception cref="T:System.NullReferenceException">The <paramref name="obj"/> parameter is null.</exception>
  @override
  bool operator ==(obj) {
    if (identical(this, obj)) {
      return true;
    } else {
      ServiceId? other = obj is ServiceId ? obj : null;

      if (other == null) {
        return false;
      } else if (!(this.IsValid && other.IsValid)) {
        return false;
      } else {
        return this.UniqueId == other.UniqueId;
      }
    }
  }

  /// <summary>
  /// Serves as a hash function for a particular type.
  /// </summary>
  /// <remarks>
  /// We do not consider the change key in the hash code computation.
  /// </remarks>
  /// <returns>
  /// A hash code for the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  int get hashCode {
    return this.IsValid ? this.UniqueId.hashCode : super.hashCode;
  }

  /// <summary>
  /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
  /// </returns>
  @override
  String toString() {
    return (this._uniqueId == null) ? "" : this._uniqueId!;
  }
}
