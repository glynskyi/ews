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

import 'package:ews/ComplexProperties/TimeZones/AbsoluteMonthTransition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZoneDefinition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZonePeriod.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents a time zone period transition that occurs on a specific day of a specific month.
/// </summary>
class AbsoluteDayOfMonthTransition extends AbsoluteMonthTransition {
  /* private */ int? dayOfMonth;

  /// <summary>
  /// Gets the XML element name associated with the transition.
  /// </summary>
  /// <returns>The XML element name associated with the transition.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.RecurringDateTransition;
  }

//        /// <summary>
//        /// Creates a timw zone transition time.
//        /// </summary>
//        /// <returns>A TimeZoneInfo.TransitionTime.</returns>
//@override
//        TimeZoneInfo.TransitionTime CreateTransitionTime()
//        {
//            return TimeZoneInfo.TransitionTime.CreateFixedDateRule(
//                new DateTime(this.TimeOffset.Ticks),
//                this.Month,
//                this.DayOfMonth);
//        }

//        /// <summary>
//        /// Initializes this transition based on the specified transition time.
//        /// </summary>
//        /// <param name="transitionTime">The transition time to initialize from.</param>
//@override
//        void InitializeFromTransitionTime(TimeZoneInfo.TransitionTime transitionTime)
//        {
//            super.InitializeFromTransitionTime(transitionTime);
//
//            this.dayOfMonth = transitionTime.Day;
//        }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  Future<bool> TryReadElementFromXml(EwsServiceXmlReader reader) async {
    if (await super.TryReadElementFromXml(reader)) {
      return true;
    } else {
      if (reader.LocalName == XmlElementNames.Day) {
        this.dayOfMonth = await reader.ReadElementValue<int>();

        EwsUtilities.Assert(
            this.dayOfMonth! > 0 && this.dayOfMonth! <= 31,
            "AbsoluteDayOfMonthTransition.TryReadElementFromXml",
            "dayOfMonth is not in the valid 1 - 31 range.");

        return true;
      } else {
        return false;
      }
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    super.WriteElementsToXml(writer);

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Day, this.dayOfMonth);
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="AbsoluteDayOfMonthTransition"/> class.
  /// </summary>
  /// <param name="timeZoneDefinition">The time zone definition this transition belongs to.</param>
  AbsoluteDayOfMonthTransition(TimeZoneDefinition? timeZoneDefinition)
      : super(timeZoneDefinition) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="AbsoluteDayOfMonthTransition"/> class.
  /// </summary>
  /// <param name="timeZoneDefinition">The time zone definition this transition belongs to.</param>
  /// <param name="targetPeriod">The period the transition will target.</param>
  AbsoluteDayOfMonthTransition.withTimeZonePeriod(
      TimeZoneDefinition timeZoneDefinition, TimeZonePeriod targetPeriod)
      : super.withTimeZonePeriod(timeZoneDefinition, targetPeriod) {}

  /// <summary>
  /// Gets the day of then month when this transition occurs.
  /// </summary>
  int? get DayOfMonth => this.dayOfMonth;
}
