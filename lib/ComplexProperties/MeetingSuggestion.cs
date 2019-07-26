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
    /// Represents an MeetingSuggestion object.
    /// </summary>
 class MeetingSuggestion extends ExtractedEntity
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="MeetingSuggestion"/> class.
        /// </summary>
        MeetingSuggestion()
            : super()
        {
        }

        /// <summary>
        /// Gets the meeting suggestion Attendees.
        /// </summary>
 EmailUserEntityCollection Attendees { get; set; }

        /// <summary>
        /// Gets the meeting suggestion Location.
        /// </summary>
 String Location { get; set; }

        /// <summary>
        /// Gets the meeting suggestion Subject.
        /// </summary>
 String Subject { get; set; }

        /// <summary>
        /// Gets the meeting suggestion MeetingString.
        /// </summary>
 String MeetingString { get; set; }

        /// <summary>
        /// Gets the meeting suggestion StartTime.
        /// </summary>
 DateTime? StartTime { get; set; }

        /// <summary>
        /// Gets the meeting suggestion EndTime.
        /// </summary>
 DateTime? EndTime { get; set; }

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
                case XmlElementNames.NlgAttendees:
                    this.Attendees = new EmailUserEntityCollection();
                    this.Attendees.LoadFromXml(reader, XmlNamespace.Types, XmlElementNames.NlgAttendees);
                    return true;

                case XmlElementNames.NlgLocation:
                    this.Location = reader.ReadElementValue();
                    return true;

                case XmlElementNames.NlgSubject:
                    this.Subject = reader.ReadElementValue();
                    return true;

                case XmlElementNames.NlgMeetingString:
                    this.MeetingString = reader.ReadElementValue();
                    return true;

                case XmlElementNames.NlgStartTime:
                    this.StartTime = reader.ReadElementValueAsDateTime();
                    return true;

                case XmlElementNames.NlgEndTime:
                    this.EndTime = reader.ReadElementValueAsDateTime();
                    return true;

                default:
                    return base.TryReadElementFromXml(reader);
            }
        }
    }
