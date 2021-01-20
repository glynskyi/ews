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
import 'package:ews/ComplexProperties/TimeZones/TimeZoneDefinition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZoneTransition.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/misc/StringUtils.dart';
import 'package:ews/misc/TimeSpan.dart';

/// <summary>
/// Represents custom time zone creation parameters.
/// </summary>
class CustomTimeZoneCreateParams {
  TimeSpan? _baseOffsetToUtc;
  String? _standardDisplayName;
  String? _daylightDisplayName;

  /// <summary>
  /// Initializes a new instance of the <see cref="CustomTimeZoneCreateParams"/> class.
  /// </summary>
  CustomTimeZoneCreateParams() {}

  /// <summary>
  /// Gets or sets the base offset to UTC.
  /// </summary>
  TimeSpan? get BaseOffsetToUtc => this._baseOffsetToUtc;

  set BaseOffsetToUtc(TimeSpan? value) => this._baseOffsetToUtc = value;

  /// <summary>
  /// Gets or sets the display name of the standard period.
  /// </summary>
  String? get StandardDisplayName => this._standardDisplayName;

  set StandardDisplayName(String? value) => this._standardDisplayName = value;

  /// <summary>
  /// Gets or sets the display name of the daylight period.
  /// </summary>
  String? get DaylightDisplayName => this._standardDisplayName;

  set DaylightDisplayName(String? value) => this._standardDisplayName = value;

  /// <summary>
  /// Gets a value indicating whether the custom time zone should have a daylight period.
  /// </summary>
  /// <value>
  ///     <c>true</c> if the custom time zone should have a daylight period; otherwise, <c>false</c>.
  /// </value>
  bool get HasDaylightPeriod =>
      !StringUtils.IsNullOrEmpty(this._daylightDisplayName);
}

/// <summary>
/// Represents a group of time zone period transitions.
/// </summary>
class TimeZoneTransitionGroup extends ComplexProperty {
  /* private */ TimeZoneDefinition? timeZoneDefinition;

  /* private */
  String? id;

  /* private */
  List<TimeZoneTransition> transitions = <TimeZoneTransition>[];

  /* private */
  TimeZoneTransition? transitionToStandard;

  /* private */
  TimeZoneTransition? transitionToDaylight;

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXmlElementName(EwsServiceXmlReader reader) {
    this.LoadFromXml(reader, XmlElementNames.TransitionsGroup);
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXmlElementName(EwsServiceXmlWriter writer) {
    this.WriteToXml(writer, XmlElementNames.TransitionsGroup);
  }

  /// <summary>
  /// Reads the attributes from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadAttributesFromXml(EwsServiceXmlReader reader) {
    this.id = reader.ReadAttributeValue(XmlAttributeNames.Id);
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    writer.WriteAttributeValue(XmlAttributeNames.Id, this.id);
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    reader.EnsureCurrentNodeIsStartElement();

    TimeZoneTransition transition =
        TimeZoneTransition.Create(this.timeZoneDefinition, reader.LocalName);

    transition.LoadFromXmlElementName(reader);

    EwsUtilities.Assert(
        transition.TargetPeriod != null,
        "TimeZoneTransitionGroup.TryReadElementFromXml",
        "The transition's target period is null.");

    this.transitions.add(transition);

    return true;
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    for (TimeZoneTransition transition in this.transitions) {
      transition.WriteToXmlElementName(writer);
    }
  }

//        /// <summary>
//        /// Initializes this transition group based on the specified asjustment rule.
//        /// </summary>
//        /// <param name="adjustmentRule">The adjustment rule to initialize from.</param>
//        /// <param name="standardPeriod">A reference to the pre-created standard period.</param>
//        void InitializeFromAdjustmentRule(TimeZoneInfo.AdjustmentRule adjustmentRule, TimeZonePeriod standardPeriod)
//        {
//            if (adjustmentRule.DaylightDelta.TotalSeconds == 0)
//            {
//                // If the time zone info doesn't support Daylight Saving Time, we just need to
//                // create one transition to one group with one transition to the standard period.
//                TimeZonePeriod standardPeriodToSet = new TimeZonePeriod();
//                standardPeriodToSet.Id = string.Format(
//                    "{0}/{1}",
//                    standardPeriod.Id,
//                    adjustmentRule.DateStart.Year);
//                standardPeriodToSet.Name = standardPeriod.Name;
//                standardPeriodToSet.Bias = standardPeriod.Bias;
//                this.timeZoneDefinition.Periods.Add(standardPeriodToSet.Id, standardPeriodToSet);
//
//                this.transitionToStandard = new TimeZoneTransition(this.timeZoneDefinition, standardPeriodToSet);
//                this.transitions.Add(this.transitionToStandard);
//            }
//            else
//            {
//                TimeZonePeriod daylightPeriod = new TimeZonePeriod();
//
//                // Generate an Id of the form "Daylight/2008"
//                daylightPeriod.Id = string.Format(
//                    "{0}/{1}",
//                    TimeZonePeriod.DaylightPeriodId,
//                    adjustmentRule.DateStart.Year);
//                daylightPeriod.Name = TimeZonePeriod.DaylightPeriodName;
//                daylightPeriod.Bias = standardPeriod.Bias - adjustmentRule.DaylightDelta;
//
//                this.timeZoneDefinition.Periods.Add(daylightPeriod.Id, daylightPeriod);
//
//                this.transitionToDaylight = TimeZoneTransition.CreateTimeZoneTransition(
//                    this.timeZoneDefinition,
//                    daylightPeriod,
//                    adjustmentRule.DaylightTransitionStart);
//
//                TimeZonePeriod standardPeriodToSet = new TimeZonePeriod();
//                standardPeriodToSet.Id =
//                    "${standardPeriod.Id}/${adjustmentRule.DateStart.Year}";
//                standardPeriodToSet.Name = standardPeriod.Name;
//                standardPeriodToSet.Bias = standardPeriod.Bias;
//                this.timeZoneDefinition.Periods[standardPeriodToSet.Id] = standardPeriodToSet;
//
//                this.transitionToStandard = TimeZoneTransition.CreateTimeZoneTransition(
//                    this.timeZoneDefinition,
//                    standardPeriodToSet,
//                    adjustmentRule.DaylightTransitionEnd);
//
//                this.transitions.add(this.transitionToDaylight);
//                this.transitions.add(this.transitionToStandard);
//            }
//        }

  /// <summary>
  /// Validates this transition group.
  /// </summary>
  void Validate() {
    // There must be exactly one or two transitions in the group.
    if (this.transitions.length < 1 || this.transitions.length > 2) {
      throw new ServiceLocalException(
          "Strings.InvalidOrUnsupportedTimeZoneDefinition");
    }

    // If there is only one transition, it must be of type TimeZoneTransition
    if (this.transitions.length == 1 &&
        !(this.transitions[0].runtimeType == TimeZoneTransition)) {
      throw new ServiceLocalException(
          "Strings.InvalidOrUnsupportedTimeZoneDefinition");
    }

    // If there are two transitions, none of them should be of type TimeZoneTransition
    if (this.transitions.length == 2) {
      for (TimeZoneTransition transition in this.transitions) {
        if (transition.runtimeType == TimeZoneTransition) {
          throw new ServiceLocalException(
              "Strings.InvalidOrUnsupportedTimeZoneDefinition");
        }
      }
    }

    // All the transitions in the group must be to a period.
    for (TimeZoneTransition transition in this.transitions) {
      if (transition.TargetPeriod == null) {
        throw new ServiceLocalException(
            "Strings.InvalidOrUnsupportedTimeZoneDefinition");
      }
    }
  }

  /// <summary>
  /// Gets a value indicating whether this group contains a transition to the Daylight period.
  /// </summary>
  /// <value><c>true</c> if this group contains a transition to daylight; otherwise, <c>false</c>.</value>
  bool get SupportsDaylight => this.transitions.length == 2;

  /// <summary>
  /// Initializes the /* private */ members holding references to the transitions to the Daylight
  /// and Standard periods.
  /// </summary>
  /* private */
  void InitializeTransitions() {
    if (this.transitionToStandard == null) {
      for (TimeZoneTransition transition in this.transitions) {
        if (transition.TargetPeriod!.IsStandardPeriod ||
            (this.transitions.length == 1)) {
          this.transitionToStandard = transition;
        } else {
          this.transitionToDaylight = transition;
        }
      }
    }

    // If we didn't find a Standard period, this is an invalid time zone group.
    if (this.transitionToStandard == null) {
      throw new ServiceLocalException(
          "Strings.InvalidOrUnsupportedTimeZoneDefinition");
    }
  }

  /// <summary>
  /// Gets the transition to the Daylight period.
  /// </summary>
  /* private */
  TimeZoneTransition? get TransitionToDaylight {
    this.InitializeTransitions();

    return this.transitionToDaylight;
  }

  /// <summary>
  /// Gets the transition to the Standard period.
  /// </summary>
  /* private */
  TimeZoneTransition? get TransitionToStandard {
    this.InitializeTransitions();

    return this.transitionToStandard;
  }

  /// <summary>
  /// Gets the offset to UTC based on this group's transitions.
  /// </summary>
  CustomTimeZoneCreateParams GetCustomTimeZoneCreationParams() {
    CustomTimeZoneCreateParams result = new CustomTimeZoneCreateParams();

    if (this.TransitionToDaylight != null) {
      result.DaylightDisplayName = this.TransitionToDaylight!.TargetPeriod!.Name;
    }

    result.StandardDisplayName = this.TransitionToStandard!.TargetPeriod!.Name;

    // Assume that the standard period's offset is the base offset to UTC.
    // EWS returns a positive offset for time zones that are behind UTC, and
    // a negative one for time zones ahead of UTC. TimeZoneInfo does it the other
    // way around.
    throw NotImplementedException(
        "-this.TransitionToStandard.TargetPeriod.Bias");
//            result.BaseOffsetToUtc = -this.TransitionToStandard.TargetPeriod.Bias;

//            return result;
  }

  /// <summary>
  /// Gets the delta offset for the daylight.
  /// </summary>
  /// <returns></returns>
  TimeSpan GetDaylightDelta() {
    if (this.SupportsDaylight) {
      // EWS returns a positive offset for time zones that are behind UTC, and
      // a negative one for time zones ahead of UTC. TimeZoneInfo does it the other
      // way around.
      throw NotImplementedException(
          "- this.TransitionToDaylight.TargetPeriod.Bias");
//                return this.TransitionToStandard.TargetPeriod.Bias - this.TransitionToDaylight.TargetPeriod.Bias;
    } else {
      return TimeSpan.ZERO;
    }
  }

//        /// <summary>
//        /// Creates a time zone adjustment rule.
//        /// </summary>
//        /// <param name="startDate">The start date of the adjustment rule.</param>
//        /// <param name="endDate">The end date of the adjustment rule.</param>
//        /// <returns>An TimeZoneInfo.AdjustmentRule.</returns>
//        TimeZoneInfo.AdjustmentRule CreateAdjustmentRule(DateTime startDate, DateTime endDate)
//        {
//            // If there is only one transition, we can't create an adjustment rule. We have to assume
//            // that the base offset to UTC is unchanged.
//            if (this.transitions.Count == 1)
//            {
//                return null;
//            }
//
//            return TimeZoneInfo.AdjustmentRule.CreateAdjustmentRule(
//                startDate.Date,
//                endDate.Date,
//                this.GetDaylightDelta(),
//                this.TransitionToDaylight.CreateTransitionTime(),
//                this.TransitionToStandard.CreateTransitionTime());
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeZoneTransitionGroup"/> class.
  /// </summary>
  /// <param name="timeZoneDefinition">The time zone definition.</param>
  TimeZoneTransitionGroup(TimeZoneDefinition timeZoneDefinition) : super() {
    this.timeZoneDefinition = timeZoneDefinition;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeZoneTransitionGroup"/> class.
  /// </summary>
  /// <param name="timeZoneDefinition">The time zone definition.</param>
  /// <param name="id">The Id of the new transition group.</param>
  TimeZoneTransitionGroup.withId(
      TimeZoneDefinition timeZoneDefinition, String id)
      : super() {
    this.timeZoneDefinition = timeZoneDefinition;
    this.id = id;
  }

  /// <summary>
  /// Gets or sets the id of this group.
  /// </summary>
  String? get Id => this.id;

  set Id(String? value) => this.id = value;

  /// <summary>
  /// Gets the transitions in this group.
  /// </summary>
  List<TimeZoneTransition> get Transitions => this.transitions;
}
