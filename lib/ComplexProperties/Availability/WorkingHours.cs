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







    /// <summary>
    /// Represents the working hours for a specific time zone.
    /// </summary>
 class WorkingHours extends ComplexProperty
    {
        /* private */ TimeZoneInfo timeZone;
        /* private */ Collection<DayOfTheWeek> daysOfTheWeek = new Collection<DayOfTheWeek>();
        /* private */ TimeSpan startTime;
        /* private */ TimeSpan endTime;

        /// <summary>
        /// Initializes a new instance of the <see cref="WorkingHours"/> class.
        /// </summary>
        WorkingHours()
            : super()
        {
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if appropriate element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.TimeZone:
                    LegacyAvailabilityTimeZone legacyTimeZone = new LegacyAvailabilityTimeZone();
                    legacyTimeZone.LoadFromXml(reader, reader.LocalName);

                    this.timeZone = legacyTimeZone.ToTimeZoneInfo();

                    return true;
                case XmlElementNames.WorkingPeriodArray:
                    List<WorkingPeriod> workingPeriods = new List<WorkingPeriod>();

                    do
                    {
                        await reader.Read();

                        if (reader.IsStartElement(XmlNamespace.Types, XmlElementNames.WorkingPeriod))
                        {
                            WorkingPeriod workingPeriod = new WorkingPeriod();

                            workingPeriod.LoadFromXml(reader, reader.LocalName);

                            workingPeriods.Add(workingPeriod);
                        }
                    }
                    while (!reader.IsEndElement(XmlNamespace.Types, XmlElementNames.WorkingPeriodArray));

                    // Availability supports a structure that can technically represent different working
                    // times for each day of the week. This is apparently how the information is stored in
                    // Exchange. However, no client (Outlook, OWA) either will let you specify different
                    // working times for each day of the week, and Outlook won't either honor that complex
                    // structure if it happens to be in Exchange.
                    // So here we'll do what Outlook and OWA do: we'll use the start and end times of the
                    // first working period, but we'll use the week days of all the periods.
                    this.startTime = workingPeriods[0].StartTime;
                    this.endTime = workingPeriods[0].EndTime;

                    for (WorkingPeriod workingPeriod in workingPeriods)
                    {
                        for (DayOfTheWeek dayOfWeek in workingPeriods[0].DaysOfWeek)
                        {
                            if (!this.daysOfTheWeek.Contains(dayOfWeek))
                            {
                                this.daysOfTheWeek.Add(dayOfWeek);
                            }
                        }
                    }

                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Gets the time zone to which the working hours apply.
        /// </summary>
 TimeZoneInfo TimeZone
        {
            get { return this.timeZone; }
        }

        /// <summary>
        /// Gets the working days of the attendees.
        /// </summary>
 Collection<DayOfTheWeek> DaysOfTheWeek
        {
            get { return this.daysOfTheWeek; }
        }

        /// <summary>
        /// Gets the time of the day the attendee starts working.
        /// </summary>
 TimeSpan StartTime
        {
            get { return this.startTime; }
        }

        /// <summary>
        /// Gets the time of the day the attendee stops working.
        /// </summary>
 TimeSpan EndTime
        {
            get { return this.endTime; }
        }
    }
