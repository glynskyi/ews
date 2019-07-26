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
import 'package:ews/ComplexProperties/TimeZones/AbsoluteDayOfMonthTransition.dart';
import 'package:ews/ComplexProperties/TimeZones/RelativeDayOfMonthTransition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZoneDefinition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZonePeriod.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZoneTransitionGroup.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';

/// <summary>
    /// Represents the base class for all time zone transitions.
    /// </summary>
    class TimeZoneTransition extends ComplexProperty
    {
        /* private */ static const String PeriodTarget = "Period";
        /* private */ static const String GroupTarget = "Group";

        /* private */ TimeZoneDefinition timeZoneDefinition;
        /* private */ TimeZonePeriod targetPeriod;
        /* private */ TimeZoneTransitionGroup targetGroup;

        /// <summary>
        /// Creates a time zone period transition of the appropriate type given an XML element name.
        /// </summary>
        /// <param name="timeZoneDefinition">The time zone definition to which the transition will belong.</param>
        /// <param name="xmlElementName">The XML element name.</param>
        /// <returns>A TimeZonePeriodTransition instance.</returns>
        static TimeZoneTransition Create(TimeZoneDefinition timeZoneDefinition, String xmlElementName)
        {
            switch (xmlElementName)
            {
                case XmlElementNames.AbsoluteDateTransition:
                    return new AbsoluteDateTransition(timeZoneDefinition);
                case XmlElementNames.RecurringDayTransition:
                    return new RelativeDayOfMonthTransition(timeZoneDefinition);
                case XmlElementNames.RecurringDateTransition:
                    return new AbsoluteDayOfMonthTransition(timeZoneDefinition);
                case XmlElementNames.Transition:
                    return new TimeZoneTransition(timeZoneDefinition);
                default:
                    throw new ServiceLocalException(
                        """string.Format(
                            Strings.UnknownTimeZonePeriodTransitionType,
                            xmlElementName)""");
            }
        }

//        /// <summary>
//        /// Creates a time zone transition based on the specified transition time.
//        /// </summary>
//        /// <param name="timeZoneDefinition">The time zone definition that will own the transition.</param>
//        /// <param name="targetPeriod">The period the transition will target.</param>
//        /// <param name="transitionTime">The transition time to initialize from.</param>
//        /// <returns>A TimeZoneTransition.</returns>
//        static TimeZoneTransition CreateTimeZoneTransition(
//            TimeZoneDefinition timeZoneDefinition,
//            TimeZonePeriod targetPeriod,
//            TimeZoneInfo.TransitionTime transitionTime)
//        {
//            TimeZoneTransition transition;
//
//            if (transitionTime.IsFixedDateRule)
//            {
//                transition = new AbsoluteDayOfMonthTransition(timeZoneDefinition, targetPeriod);
//            }
//            else
//            {
//                transition = new RelativeDayOfMonthTransition(timeZoneDefinition, targetPeriod);
//            }
//
//            transition.InitializeFromTransitionTime(transitionTime);
//
//            return transition;
//        }

        /// <summary>
        /// Gets the XML element name associated with the transition.
        /// </summary>
        /// <returns>The XML element name associated with the transition.</returns>
        String GetXmlElementName()
        {
            return XmlElementNames.Transition;
        }

//        /// <summary>
//        /// Creates a time zone transition time.
//        /// </summary>
//        /// <returns>A TimeZoneInfo.TransitionTime.</returns>
//        TimeZoneInfo.TransitionTime CreateTransitionTime()
//        {
//            throw new ServiceLocalException("Strings.InvalidOrUnsupportedTimeZoneDefinition");
//        }

//        /// <summary>
//        /// Initializes this transition based on the specified transition time.
//        /// </summary>
//        /// <param name="transitionTime">The transition time to initialize from.</param>
//        void InitializeFromTransitionTime(TimeZoneInfo.TransitionTime transitionTime)
//        {
//        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.To:
                    String targetKind = reader.ReadAttributeValue(XmlAttributeNames.Kind);
                    String targetId = reader.ReadElementValue();

                    switch (targetKind)
                    {
                        case TimeZoneTransition.PeriodTarget:
                            if (!this.timeZoneDefinition.Periods.containsKey(targetId))
                            {
                                throw new ServiceLocalException(
                                    """string.Format(
                                        Strings.PeriodNotFound,
                                        targetId)""");
                            }

                            break;
                        case TimeZoneTransition.GroupTarget:
                            if (!this.timeZoneDefinition.TransitionGroups.containsKey(targetId))
                            {
                                throw new ServiceLocalException(
                                    """string.Format(
                                        Strings.TransitionGroupNotFound,
                                        targetId)""");
                            }

                            break;
                        default:
                            throw new ServiceLocalException("Strings.UnsupportedTimeZonePeriodTransitionTarget");
                    }

                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.To);

            if (this.targetPeriod != null)
            {
                writer.WriteAttributeValue(XmlAttributeNames.Kind, PeriodTarget);
                writer.WriteValue(this.targetPeriod.Id, XmlElementNames.To);
            }
            else
            {
                writer.WriteAttributeValue(XmlAttributeNames.Kind, GroupTarget);
                writer.WriteValue(this.targetGroup.Id, XmlElementNames.To);
            }

            writer.WriteEndElement(); // To
        }

        /// <summary>
        /// Loads from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        void LoadFromXmlElementName(EwsServiceXmlReader reader)
        {
            this.LoadFromXml(reader, this.GetXmlElementName());
        }

        /// <summary>
        /// Writes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        void WriteToXmlElementName(EwsServiceXmlWriter writer)
        {
            this.WriteToXml(writer, this.GetXmlElementName());
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="TimeZoneTransition"/> class.
        /// </summary>
        /// <param name="timeZoneDefinition">The time zone definition the transition will belong to.</param>
        TimeZoneTransition(TimeZoneDefinition timeZoneDefinition)
            : super()
        {
            this.timeZoneDefinition = timeZoneDefinition;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="TimeZoneTransition"/> class.
        /// </summary>
        /// <param name="timeZoneDefinition">The time zone definition the transition will belong to.</param>
        /// <param name="targetGroup">The transition group the transition will target.</param>
        TimeZoneTransition.withTimeZoneTransitionGroup(TimeZoneDefinition timeZoneDefinition, TimeZoneTransitionGroup targetGroup)
        {
          this.timeZoneDefinition = timeZoneDefinition;
            this.targetGroup = targetGroup;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="TimeZoneTransition"/> class.
        /// </summary>
        /// <param name="timeZoneDefinition">The time zone definition the transition will belong to.</param>
        /// <param name="targetPeriod">The period the transition will target.</param>
        TimeZoneTransition.withTimeZonePeriod(TimeZoneDefinition timeZoneDefinition, TimeZonePeriod targetPeriod)
        {
          this.timeZoneDefinition = timeZoneDefinition;
            this.targetPeriod = targetPeriod;
        }

        /// <summary>
        /// Gets the target period of the transition.
        /// </summary>
        TimeZonePeriod get TargetPeriod => this.targetPeriod; 

        /// <summary>
        /// Gets the target transition group of the transition.
        /// </summary>
        TimeZoneTransitionGroup get TargetGroup => this.targetGroup;
    }
