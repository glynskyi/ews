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







    import 'dart:core';
    import 'dart:core' as core;

import 'package:ews/ComplexProperties/TimeZones/TimeZoneDefinition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZoneTransition.dart';
import 'package:ews/ComplexProperties/TimeZones/TimeZoneTransitionGroup.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';

/// <summary>
    /// Represents a time zone period transition that occurs on a fixed (absolute) date.
    /// </summary>
    class AbsoluteDateTransition extends TimeZoneTransition
    {
        /* private */ core.DateTime dateTime;

//        /// <summary>
//        /// Initializes this transition based on the specified transition time.
//        /// </summary>
//        /// <param name="transitionTime">The transition time to initialize from.</param>
//@override
//        void InitializeFromTransitionTime(TimeZoneInfo.TransitionTime transitionTime)
//        {
//            throw new ServiceLocalException("Strings.UnsupportedTimeZonePeriodTransitionTarget");
//        }

        /// <summary>
        /// Gets the XML element name associated with the transition.
        /// </summary>
        /// <returns>The XML element name associated with the transition.</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.AbsoluteDateTransition;
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            bool result = super.TryReadElementFromXml(reader);

            if (!result)
            {
                if (reader.LocalName == XmlElementNames.DateTime)
                {
                    this.dateTime = core.DateTime.parse(reader.ReadElementValue());

                    result = true;
                }
            }

            return result;
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            super.WriteElementsToXml(writer);

            writer.WriteElementValueWithNamespace(
                XmlNamespace.Types,
                XmlElementNames.DateTime,
                this.dateTime);
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AbsoluteDateTransition"/> class.
        /// </summary>
        /// <param name="timeZoneDefinition">The time zone definition the transition will belong to.</param>
        AbsoluteDateTransition(TimeZoneDefinition timeZoneDefinition)
            : super(timeZoneDefinition)
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AbsoluteDateTransition"/> class.
        /// </summary>
        /// <param name="timeZoneDefinition">The time zone definition the transition will belong to.</param>
        /// <param name="targetGroup">The transition group the transition will target.</param>
        AbsoluteDateTransition.withTimeZoneTransitionGroup(TimeZoneDefinition timeZoneDefinition, TimeZoneTransitionGroup targetGroup)
            : super.withTimeZoneTransitionGroup(timeZoneDefinition, targetGroup)
        {
        }

        /// <summary>
        /// Gets or sets the absolute date and time when the transition occurs.
        /// </summary>
        core.DateTime get DateTime => this.dateTime;
        set DateTime(core.DateTime value) => this.dateTime = value;

    }
