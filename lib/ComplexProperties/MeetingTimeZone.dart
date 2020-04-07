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
import 'package:ews/ComplexProperties/TimeChange.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/misc/TimeSpan.dart';
import 'package:timezone/standalone.dart';

/// <summary>
/// Represents a time zone in which a meeting is defined.
/// </summary>
class MeetingTimeZone extends ComplexProperty {
  String _name;
  TimeSpan _baseOffset;
  TimeChange _standard;
  TimeChange _daylight;

  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingTimeZone"/> class.
  /// </summary>
  /// <param name="timeZone">The time zone used to initialize this instance.</param>
  MeetingTimeZone.fromTimeZone(TimeZone timeZone) {
    // Unfortunately, MeetingTimeZone does not support all the time transition types
    // supported by TimeZoneInfo. That leaves us unable to accurately convert TimeZoneInfo
    // into MeetingTimeZone. So we don't... Instead, we emit the time zone's Id and
    // hope the server will find a match (which it should).
    this.Name = timeZone.abbr;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingTimeZone"/> class.
  /// </summary>
  MeetingTimeZone() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="MeetingTimeZone"/> class.
  /// </summary>
  /// <param name="name">The name of the time zone.</param>
  MeetingTimeZone.fromName(String name) {
    this._name = name;
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.BaseOffset:
        this._baseOffset =
            EwsUtilities.XSDurationToTimeSpan(reader.ReadElementValue<String>());
        return true;
      case XmlElementNames.Standard:
        this._standard = new TimeChange();
        this._standard.LoadFromXml(reader, reader.LocalName);
        return true;
      case XmlElementNames.Daylight:
        this._daylight = new TimeChange();
        this._daylight.LoadFromXml(reader, reader.LocalName);
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Reads the attributes from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadAttributesFromXml(EwsServiceXmlReader reader) {
    this._name = reader.ReadAttributeValue(XmlAttributeNames.TimeZoneName);
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    writer.WriteAttributeValue(XmlAttributeNames.TimeZoneName, this.Name);
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    if (this.BaseOffset != null) {
      writer.WriteElementValueWithNamespace(
          XmlNamespace.Types,
          XmlElementNames.BaseOffset,
          EwsUtilities.TimeSpanToXSDuration(this.BaseOffset));
    }

    if (this.Standard != null) {
      this.Standard.WriteToXml(writer, XmlElementNames.Standard);
    }

    if (this.Daylight != null) {
      this.Daylight.WriteToXml(writer, XmlElementNames.Daylight);
    }
  }

//        /// <summary>
//        /// Converts this meeting time zone into a TimeZoneInfo structure.
//        /// </summary>
//        /// <returns></returns>
//        TimeZoneInfo ToTimeZoneInfo()
//        {
//            // MeetingTimeZone.ToTimeZoneInfo throws ArgumentNullException if name is null
//            // TimeZoneName is optional, may not show in the response.
//            if (StringUtils.IsNullOrEmpty(this.Name))
//            {
//                return null;
//            }
//
//            TimeZoneInfo result = null;
//
//            try
//            {
//                result = TimeZoneInfo.FindSystemTimeZoneById(this.Name);
//            }
//            catch (TimeZoneNotFoundException)
//            {
//                // Could not find a time zone with that Id on the local system.
//            }
//
//            // Again, we cannot accurately convert MeetingTimeZone into TimeZoneInfo
//            // because TimeZoneInfo doesn't support absolute date transitions. So if
//            // there is no system time zone that has a matching Id, we return null.
//            return result;
//        }

  /// <summary>
  /// Gets or sets the name of the time zone.
  /// </summary>
  String get Name => this._name;

  set Name(String value) {
    if (this.CanSetFieldValue(this._name, value)) {
      this._name = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the base offset of the time zone from the UTC time zone.
  /// </summary>
  TimeSpan get BaseOffset => this._baseOffset;

  set BaseOffset(TimeSpan value) {
    if (this.CanSetFieldValue(this._baseOffset, value)) {
      this._baseOffset = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets a TimeChange defining when the time changes to Standard Time.
  /// </summary>
  TimeChange get Standard => this._standard;

  set Standard(TimeChange value) {
    if (this.CanSetFieldValue(this._standard, value)) {
      this._standard = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets a TimeChange defining when the time changes to Daylight Saving Time.
  /// </summary>
  TimeChange get Daylight => this._daylight;

  set Daylight(TimeChange value) {
    if (this.CanSetFieldValue(this._daylight, value)) {
      this._daylight = value;
      this.Changed();
    }
  }
}
