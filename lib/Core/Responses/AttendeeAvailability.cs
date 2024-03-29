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
    /// Represents the availability of an individual attendee.
    /// </summary>
 class AttendeeAvailability extends ServiceResponse
    {
        /* private */ Collection<CalendarEvent> calendarEvents = new Collection<CalendarEvent>();
        /* private */ Collection<LegacyFreeBusyStatus> mergedFreeBusyStatus = new Collection<LegacyFreeBusyStatus>();
        /* private */ FreeBusyViewType viewType;
        /* private */ WorkingHours workingHours;

        /// <summary>
        /// Initializes a new instance of the <see cref="AttendeeAvailability"/> class.
        /// </summary>
        AttendeeAvailability()
            : super()
        {
        }

        /// <summary>
        /// Loads the free busy view from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <param name="viewType">Type of free/busy view.</param>
        void LoadFreeBusyViewFromXml(EwsServiceXmlReader reader, FreeBusyViewType viewType)
        {
            reader.ReadStartElement(XmlNamespace.Messages, XmlElementNames.FreeBusyView);

            String viewTypeString = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.FreeBusyViewType);

            this.viewType = (FreeBusyViewType)Enum.Parse(typeof(FreeBusyViewType), viewTypeString, false);

            do
            {
                await reader.Read();

                if (reader.IsStartElement())
                {
                    switch (reader.LocalName)
                    {
                        case XmlElementNames.MergedFreeBusy:
                            String mergedFreeBusy = reader.ReadElementValue<String>();

                            for (int i = 0; i < mergedFreeBusy.Length; i++)
                            {
                                this.mergedFreeBusyStatus.Add((LegacyFreeBusyStatus)Byte.Parse(mergedFreeBusy[i].ToString()));
                            }

                            break;
                        case XmlElementNames.CalendarEventArray:
                            do
                            {
                                await reader.Read();

                                // Sometimes Exchange Online returns blank CalendarEventArray tag like bellow.
                                // <CalendarEventArray xmlns="http://schemas.microsoft.com/exchange/services/2006/types" />
                                // So we have to check the end of CalendarEventArray tag.
                                if (reader.LocalName == XmlElementNames.FreeBusyView)
                                {
                                    // There is no the end tag of CalendarEventArray, but the reader is reading the end tag of FreeBusyView.
                                    break;
                                }
                                else if (reader.LocalName == XmlElementNames.WorkingHours)
                                {
                                    // There is no the end tag of CalendarEventArray, but the reader is reading the start tag of WorkingHours.
                                    goto case XmlElementNames.WorkingHours;
                                }

                                if (reader.IsStartElement(XmlNamespace.Types, XmlElementNames.CalendarEvent))
                                {
                                    CalendarEvent calendarEvent = new CalendarEvent();

                                    calendarEvent.LoadFromXml(reader, XmlElementNames.CalendarEvent);

                                    this.calendarEvents.Add(calendarEvent);
                                }
                            }
                            while (!reader.IsEndElement(XmlNamespace.Types, XmlElementNames.CalendarEventArray));

                            break;
                        case XmlElementNames.WorkingHours:
                            this.workingHours = new WorkingHours();
                            this.workingHours.LoadFromXml(reader, reader.LocalName);

                            break;
                    }
                }
            }
            while (!reader.IsEndElement(XmlNamespace.Messages, XmlElementNames.FreeBusyView));
        }

        /// <summary>
        /// Gets a collection of calendar events for the attendee.
        /// </summary>
 Collection<CalendarEvent> CalendarEvents
        {
            get { return this.calendarEvents; }
        }

        /// <summary>
        /// Gets the free/busy view type that wes retrieved for the attendee.
        /// </summary>
 FreeBusyViewType ViewType
        {
            get { return this.viewType; }
        }

        /// <summary>
        /// Gets a collection of merged free/busy status for the attendee.
        /// </summary>
 Collection<LegacyFreeBusyStatus> MergedFreeBusyStatus
        {
            get { return this.mergedFreeBusyStatus; }
        }

        /// <summary>
        /// Gets the working hours of the attendee.
        /// </summary>
 WorkingHours WorkingHours
        {
            get { return this.workingHours; }
        }
    }
