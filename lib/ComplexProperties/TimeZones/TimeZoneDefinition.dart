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
import 'package:ews/ComplexProperties/TimeZones/AbsoluteDateTransition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZonePeriod.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZoneTransition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZoneTransitionGroup.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/TraceFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/misc/StringUtils.dart';
import 'package:timezone/standalone.dart';

/// <summary>
/// Represents a time zone as defined by the EWS schema.
/// </summary>
class TimeZoneDefinition extends ComplexProperty {
  /// <summary>
  /// Prefix for generated ids.
  /// </summary>
  static const String _NoIdPrefix = "NoId_";

  String _name;

  String _id;

  Map<String, TimeZonePeriod> _periods = new Map<String, TimeZonePeriod>();

  Map<String, TimeZoneTransitionGroup> _transitionGroups =
      new Map<String, TimeZoneTransitionGroup>();

  List<TimeZoneTransition> _transitions = new List<TimeZoneTransition>();

  /// <summary>
  /// Compares the transitions.
  /// </summary>
  /// <param name="x">The first transition.</param>
  /// <param name="y">The second transition.</param>
  /// <returns>A negative number if x is less than y, 0 if x and y are equal, a positive number if x is greater than y.</returns>
  int _CompareTransitions(TimeZoneTransition x, TimeZoneTransition y) {
    if (x == y) {
      return 0;
    } else if (x.runtimeType == TimeZoneTransition) {
      return -1;
    } else if (y == TimeZoneTransition) {
      return 1;
    } else {
      AbsoluteDateTransition firstTransition = x as AbsoluteDateTransition;
      AbsoluteDateTransition secondTransition = y as AbsoluteDateTransition;

      return firstTransition.DateTime.compareTo(secondTransition.DateTime);
    }
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeZoneDefinition"/> class.
  /// </summary>
  TimeZoneDefinition() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="TimeZoneDefinition"/> class.
  /// </summary>
  /// <param name="timeZoneInfo">The time zone info used to initialize this definition.</param>
  TimeZoneDefinition.withTimeZone(TimeZone timeZoneInfo) {
    throw NotImplementedException("TimeZoneDefinition.withTimeZone");
//            this.Id = timeZoneInfo.Id;
//            this.Name = timeZoneInfo.DisplayName;
//
//            // TimeZoneInfo only supports one standard period, which bias is the time zone's base
//            // offset to UTC.
//            TimeZonePeriod standardPeriod = new TimeZonePeriod();
//            standardPeriod.Id = TimeZonePeriod.StandardPeriodId;
//            standardPeriod.Name = TimeZonePeriod.StandardPeriodName;
//            standardPeriod.Bias = -timeZoneInfo.BaseUtcOffset;
//
//            TimeZoneInfo.AdjustmentRule[] adjustmentRules = timeZoneInfo.GetAdjustmentRules();
//
//            TimeZoneTransition transitionToStandardPeriod = new TimeZoneTransition(this, standardPeriod);
//
//            if (adjustmentRules.Length == 0)
//            {
//                this.periods.Add(standardPeriod.Id, standardPeriod);
//
//                // If the time zone info doesn't support Daylight Saving Time, we just need to
//                // create one transition to one group with one transition to the standard period.
//                TimeZoneTransitionGroup transitionGroup = new TimeZoneTransitionGroup(this, "0");
//                transitionGroup.Transitions.Add(transitionToStandardPeriod);
//
//                this.transitionGroups.Add(transitionGroup.Id, transitionGroup);
//
//                TimeZoneTransition initialTransition = new TimeZoneTransition(this, transitionGroup);
//
//                this.transitions.Add(initialTransition);
//            }
//            else
//            {
//                for (int i = 0; i < adjustmentRules.Length; i++)
//                {
//                    TimeZoneTransitionGroup transitionGroup = new TimeZoneTransitionGroup(this, this.transitionGroups.Count.ToString());
//                    transitionGroup.InitializeFromAdjustmentRule(adjustmentRules[i], standardPeriod);
//
//                    this.transitionGroups.Add(transitionGroup.Id, transitionGroup);
//
//                    TimeZoneTransition transition;
//
//                    if (i == 0)
//                    {
//                        // If the first adjustment rule's start date in not undefined (DateTime.MinValue)
//                        // we need to add a dummy group with a single, simple transition to the Standard
//                        // period and a group containing the transitions mapping to the adjustment rule.
//                        if (adjustmentRules[i].DateStart > DateTime.MinValue.Date)
//                        {
//                            TimeZoneTransition transitionToDummyGroup = new TimeZoneTransition(
//                                this,
//                                this.CreateTransitionGroupToPeriod(standardPeriod));
//
//                            this.transitions.Add(transitionToDummyGroup);
//
//                            AbsoluteDateTransition absoluteDateTransition = new AbsoluteDateTransition(this, transitionGroup);
//                            absoluteDateTransition.DateTime = adjustmentRules[i].DateStart;
//
//                            transition = absoluteDateTransition;
//                            this.periods.Add(standardPeriod.Id, standardPeriod);
//                        }
//                        else
//                        {
//                            transition = new TimeZoneTransition(this, transitionGroup);
//                        }
//                    }
//                    else
//                    {
//                        AbsoluteDateTransition absoluteDateTransition = new AbsoluteDateTransition(this, transitionGroup);
//                        absoluteDateTransition.DateTime = adjustmentRules[i].DateStart;
//
//                        transition = absoluteDateTransition;
//                    }
//
//                    this.transitions.Add(transition);
//                }
//
//                // If the last adjustment rule's end date is not undefined (DateTime.MaxValue),
//                // we need to create another absolute date transition that occurs the date after
//                // the last rule's end date. We target this additional transition to a group that
//                // contains a single simple transition to the Standard period.
//                DateTime lastAdjustmentRuleEndDate = adjustmentRules[adjustmentRules.Length - 1].DateEnd;
//
//                if (lastAdjustmentRuleEndDate < DateTime.MaxValue.Date)
//                {
//                    AbsoluteDateTransition transitionToDummyGroup = new AbsoluteDateTransition(
//                        this,
//                        this.CreateTransitionGroupToPeriod(standardPeriod));
//                    transitionToDummyGroup.DateTime = lastAdjustmentRuleEndDate.AddDays(1);
//
//                    this.transitions.Add(transitionToDummyGroup);
//                }
//            }
  }

  /// <summary>
  /// Adds a transition group with a single transition to the specified period.
  /// </summary>
  /// <param name="timeZonePeriod">The time zone period.</param>
  /// <returns>A TimeZoneTransitionGroup.</returns>
  /* private */
  TimeZoneTransitionGroup CreateTransitionGroupToPeriod(
      TimeZonePeriod timeZonePeriod) {
    TimeZoneTransition transitionToPeriod =
        new TimeZoneTransition.withTimeZonePeriod(this, timeZonePeriod);

    TimeZoneTransitionGroup transitionGroup =
        new TimeZoneTransitionGroup.withId(
            this, this._transitionGroups.length.toString());
    transitionGroup.Transitions.add(transitionToPeriod);

    this._transitionGroups[transitionGroup.Id] = transitionGroup;

    return transitionGroup;
  }

  /// <summary>
  /// Reads the attributes from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadAttributesFromXml(EwsServiceXmlReader reader) {
    this._name = reader.ReadAttributeValue(XmlAttributeNames.Name);
    this._id = reader.ReadAttributeValue(XmlAttributeNames.Id);

    // EWS can return a TimeZone definition with no Id. Generate a new Id in this case.
    if (StringUtils.IsNullOrEmpty(this._id)) {
      String nameValue = StringUtils.IsNullOrEmpty(this.Name) ? "" : this.Name;
      this.Id = _NoIdPrefix + Abs(nameValue.hashCode).toString();
    }
  }

  int Abs(int value) => value < 0 ? -value : value;

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    // The Name attribute is only supported in Exchange 2010 and above.
    if (writer.Service.RequestedServerVersion !=
        ExchangeVersion.Exchange2007_SP1) {
      writer.WriteAttributeValue(XmlAttributeNames.Name, this._name);
    }

    writer.WriteAttributeValue(XmlAttributeNames.Id, this._id);
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.Periods:
        do {
          reader.Read();

          if (reader.IsStartElementWithNamespace(
              XmlNamespace.Types, XmlElementNames.Period)) {
            TimeZonePeriod period = new TimeZonePeriod();
            period.LoadFromXmlElementName(reader);

            // OM:1648848 Bad timezone data from clients can include duplicate rules
            // for one year, with duplicate ID. In that case, let the first one win.
            if (!this._periods.containsKey(period.Id)) {
              this._periods[period.Id] = period;
            } else {
              reader.Service.TraceMessage(
                  TraceFlags.EwsTimeZones, """string.Format(
                                        "An entry with the same key (Id) '{0}' already exists in Periods. Cannot add another one. Existing entry: [Name='{1}', Bias='{2}']. Entry to skip: [Name='{3}', Bias='{4}'].",
                                        period.Id,
                                        this.Periods[period.Id].Name,
                                        this.Periods[period.Id].Bias,
                                        period.Name,
                                        period.Bias)""");
            }
          }
        } while (!reader.IsEndElementWithNamespace(
            XmlNamespace.Types, XmlElementNames.Periods));

        return true;
      case XmlElementNames.TransitionsGroups:
        do {
          reader.Read();

          if (reader.IsStartElementWithNamespace(
              XmlNamespace.Types, XmlElementNames.TransitionsGroup)) {
            TimeZoneTransitionGroup transitionGroup =
                new TimeZoneTransitionGroup(this);

            transitionGroup.LoadFromXmlElementName(reader);

            this._transitionGroups[transitionGroup.Id] = transitionGroup;
          }
        } while (!reader.IsEndElementWithNamespace(
            XmlNamespace.Types, XmlElementNames.TransitionsGroups));

        return true;
      case XmlElementNames.Transitions:
        do {
          reader.Read();

          if (reader.IsStartElement()) {
            TimeZoneTransition transition =
                TimeZoneTransition.Create(this, reader.LocalName);

            transition.LoadFromXmlElementName(reader);

            this._transitions.add(transition);
          }
        } while (!reader.IsEndElementWithNamespace(
            XmlNamespace.Types, XmlElementNames.Transitions));

        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXmlElementName(EwsServiceXmlReader reader) {
    this.LoadFromXml(reader, XmlElementNames.TimeZoneDefinition);

    this._transitions.sort(this._CompareTransitions);
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    // We only emit the full time zone definition against Exchange 2010 servers and above.
    if (writer.Service.RequestedServerVersion !=
        ExchangeVersion.Exchange2007_SP1) {
      if (this._periods.length > 0) {
        writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Periods);

        for (MapEntry<String, TimeZonePeriod> keyValuePair
            in this._periods.entries) {
          keyValuePair.value.WriteToXmlElementName(writer);
        }

        writer.WriteEndElement(); // Periods
      }

      if (this._transitionGroups.length > 0) {
        writer.WriteStartElement(
            XmlNamespace.Types, XmlElementNames.TransitionsGroups);

        for (MapEntry<String, TimeZoneTransitionGroup> keyValuePair
            in this._transitionGroups.entries) {
          keyValuePair.value.WriteToXmlElementName(writer);
        }

        writer.WriteEndElement(); // TransitionGroups
      }

      if (this._transitions.length > 0) {
        writer.WriteStartElement(
            XmlNamespace.Types, XmlElementNames.Transitions);

        for (TimeZoneTransition transition in this._transitions) {
          transition.WriteToXmlElementName(writer);
        }

        writer.WriteEndElement(); // Transitions
      }
    }
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXmlElementName(EwsServiceXmlWriter writer) {
    this.WriteToXml(writer, XmlElementNames.TimeZoneDefinition);
  }

  /// <summary>
  /// Validates this time zone definition.
  /// </summary>
  void Validate() {
    // The definition must have at least one period, one transition group and one transition,
    // and there must be as many transitions as there are transition groups.
    if (this._periods.length < 1 ||
        this._transitions.length < 1 ||
        this._transitionGroups.length < 1 ||
        this._transitionGroups.length != this._transitions.length) {
      throw new ServiceLocalException(
          "Strings.InvalidOrUnsupportedTimeZoneDefinition");
    }

    // The first transition must be of type TimeZoneTransition.
    if (this._transitions[0].runtimeType != TimeZoneTransition) {
      throw new ServiceLocalException(
          "Strings.InvalidOrUnsupportedTimeZoneDefinition");
    }

    // All transitions must be to transition groups and be either TimeZoneTransition or
    // AbsoluteDateTransition instances.
    for (TimeZoneTransition transition in this._transitions) {
      Type transitionType = transition.runtimeType;

      if (transitionType != TimeZoneTransition &&
          transitionType != AbsoluteDateTransition) {
        throw new ServiceLocalException(
            "Strings.InvalidOrUnsupportedTimeZoneDefinition");
      }

      if (transition.TargetGroup == null) {
        throw new ServiceLocalException(
            "Strings.InvalidOrUnsupportedTimeZoneDefinition");
      }
    }

    // All transition groups must be valid.
    for (TimeZoneTransitionGroup transitionGroup
        in this._transitionGroups.values) {
      transitionGroup.Validate();
    }
  }

  /// <summary>
  /// Converts this time zone definition into a TimeZoneInfo structure.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <returns>A TimeZoneInfo representing the same time zone as this definition.</returns>
  TimeZone ToTimeZoneInfo(ExchangeService service) {
    throw NotImplementedException("TimeZoneDefinition.ToTimeZoneInfo");
//            this.Validate();
//
//            TimeZone result;
//
//            // Retrieve the base offset to UTC, standard and daylight display names from
//            // the last transition group, which is the one that currently applies given that
//            // transitions are ordered chronologically.
//            TimeZoneTransitionGroup.CustomTimeZoneCreateParams creationParams =
//                this.transitions[this.transitions.Count - 1].TargetGroup.GetCustomTimeZoneCreationParams();
//
//            List<TimeZoneInfo.AdjustmentRule> adjustmentRules = new List<TimeZoneInfo.AdjustmentRule>();
//
//            DateTime startDate = DateTime.MinValue;
//            DateTime endDate;
//            DateTime effectiveEndDate;
//
//            for (int i = 0; i < this.transitions.Count; i++)
//            {
//                if (i < this.transitions.Count - 1)
//                {
//                    endDate = (this.transitions[i + 1] as AbsoluteDateTransition).DateTime;
//                    effectiveEndDate = endDate.AddDays(-1);
//                }
//                else
//                {
//                    endDate = DateTime.MaxValue;
//                    effectiveEndDate = endDate;
//                }
//
//                // OM:1648848 Due to bad timezone data from clients the
//                // startDate may not always come before the effectiveEndDate
//                if (startDate < effectiveEndDate)
//                {
//                    TimeZoneInfo.AdjustmentRule adjustmentRule = this.transitions[i].TargetGroup.CreateAdjustmentRule(startDate, effectiveEndDate);
//
//                    if (adjustmentRule != null)
//                    {
//                        adjustmentRules.Add(adjustmentRule);
//                    }
//
//                    startDate = endDate;
//                }
//                else
//                {
//                    service.TraceMessage(
//                        TraceFlags.EwsTimeZones,
//                            string.Format(
//                                "The startDate '{0}' is not before the effectiveEndDate '{1}'. Will skip creating adjustment rule.",
//                                startDate,
//                                effectiveEndDate));
//                }
//            }
//
//            if (adjustmentRules.Count == 0)
//            {
//                // If there are no adjustment rule, the time zone does not support Daylight
//                // saving time.
//                result = TimeZoneInfo.CreateCustomTimeZone(
//                    this.Id,
//                    creationParams.BaseOffsetToUtc,
//                    this.Name,
//                    creationParams.StandardDisplayName);
//            }
//            else
//            {
//                result = TimeZoneInfo.CreateCustomTimeZone(
//                    this.Id,
//                    creationParams.BaseOffsetToUtc,
//                    this.Name,
//                    creationParams.StandardDisplayName,
//                    creationParams.DaylightDisplayName,
//                    adjustmentRules.ToArray());
//            }
//
//            return result;
  }

  /// <summary>
  /// Gets or sets the name of this time zone definition.
  /// </summary>
  String get Name => this._name;

  set Name(String value) => this._name = value;

  /// <summary>
  /// Gets or sets the Id of this time zone definition.
  /// </summary>
  String get Id => this._id;

  set Id(String value) => this._id = value;

  /// <summary>
  /// Gets the periods associated with this time zone definition, indexed by Id.
  /// </summary>
  Map<String, TimeZonePeriod> get Periods => this._periods;

  /// <summary>
  /// Gets the transition groups associated with this time zone definition, indexed by Id.
  /// </summary>
  Map<String, TimeZoneTransitionGroup> get TransitionGroups =>
      this._transitionGroups;
}
