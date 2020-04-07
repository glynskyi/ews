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
    /// Represents the details of a calendar event as returned by the GetUserAvailability operation.
    /// </summary>
 class CalendarEventDetails extends ComplexProperty
    {
        /* private */ String storeId;
        /* private */ String subject;
        /* private */ String location;
        /* private */ bool isMeeting;
        /* private */ bool isRecurring;
        /* private */ bool isException;
        /* private */ bool isReminderSet;
        /* private */ bool is/* private */;

        /// <summary>
        /// Initializes a new instance of the <see cref="CalendarEventDetails"/> class.
        /// </summary>
        CalendarEventDetails()
            : super()
        {
        }

        /// <summary>
        /// Attempts to read the element at the reader's current position.
        /// </summary>
        /// <param name="reader">The reader used to read the element.</param>
        /// <returns>True if the element was read, false otherwise.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.ID:
                    this.storeId = reader.ReadElementValue<String>();
                    return true;
                case XmlElementNames.Subject:
                    this.subject = reader.ReadElementValue<String>();
                    return true;
                case XmlElementNames.Location:
                    this.location = reader.ReadElementValue<String>();
                    return true;
                case XmlElementNames.IsMeeting:
                    this.isMeeting = reader.ReadElementValue<bool>();
                    return true;
                case XmlElementNames.IsRecurring:
                    this.isRecurring = reader.ReadElementValue<bool>();
                    return true;
                case XmlElementNames.IsException:
                    this.isException = reader.ReadElementValue<bool>();
                    return true;
                case XmlElementNames.IsReminderSet:
                    this.isReminderSet = reader.ReadElementValue<bool>();
                    return true;
                case XmlElementNames.Is/* private */:
                    this.is/* private */ = reader.ReadElementValue<bool>();
                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Gets the store Id of the calendar event.
        /// </summary>
 String StoreId
        {
            get { return this.storeId; }
        }

        /// <summary>
        /// Gets the subject of the calendar event.
        /// </summary>
 String Subject
        {
            get { return this.subject; }
        }

        /// <summary>
        /// Gets the location of the calendar event.
        /// </summary>
 String Location
        {
            get { return this.location; }
        }

        /// <summary>
        /// Gets a value indicating whether the calendar event is a meeting.
        /// </summary>
 bool IsMeeting
        {
            get { return this.isMeeting; }
        }

        /// <summary>
        /// Gets a value indicating whether the calendar event is recurring.
        /// </summary>
 bool IsRecurring
        {
            get { return this.isRecurring; }
        }

        /// <summary>
        /// Gets a value indicating whether the calendar event is an exception in a recurring series.
        /// </summary>
 bool IsException
        {
            get { return this.isException; }
        }

        /// <summary>
        /// Gets a value indicating whether the calendar event has a reminder set.
        /// </summary>
 bool IsReminderSet
        {
            get { return this.isReminderSet; }
        }

        /// <summary>
        /// Gets a value indicating whether the calendar event is /* private */.
        /// </summary>
 bool Is/* private */
        {
            get { return this.is/* private */; }
        }
    }
