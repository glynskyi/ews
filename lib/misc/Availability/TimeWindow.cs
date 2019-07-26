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
    /// Represents a time period.
    /// </summary>
 class TimeWindow extends ISelfValidate
    {
        /* private */ DateTime startTime;
        /* private */ DateTime endTime;

        /// <summary>
        /// Initializes a new instance of the <see cref="TimeWindow"/> class.
        /// </summary>
        TimeWindow()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="TimeWindow"/> class.
        /// </summary>
        /// <param name="startTime">The start date and time.</param>
        /// <param name="endTime">The end date and time.</param>
 TimeWindow(DateTime startTime, DateTime endTime)
            : this()
        {
            this.startTime = startTime;
            this.endTime = endTime;
        }

        /// <summary>
        /// Gets or sets the start date and time.
        /// </summary>
 DateTime StartTime
        {
            get { return this.startTime; }
            set { this.startTime = value; }
        }

        /// <summary>
        /// Gets or sets the end date and time.
        /// </summary>
 DateTime EndTime
        {
            get { return this.endTime; }
            set { this.endTime = value; }
        }

        /// <summary>
        /// Loads from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        void LoadFromXml(EwsServiceXmlReader reader)
        {
            reader.EnsureCurrentNodeIsStartElement(XmlNamespace.Types, XmlElementNames.Duration);

            this.startTime = reader.ReadElementValueAsDateTime(XmlNamespace.Types, XmlElementNames.StartTime).Value;
            this.endTime = reader.ReadElementValueAsDateTime(XmlNamespace.Types, XmlElementNames.EndTime).Value;

            reader.ReadEndElement(XmlNamespace.Types, XmlElementNames.Duration);
        }

        /// <summary>
        /// Writes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        /// <param name="startTime">The start time.</param>
        /// <param name="endTime">The end time.</param>
        /* private */ static void WriteToXml(
            EwsServiceXmlWriter writer,
            String xmlElementName,
            object startTime,
            object endTime)
        {
            writer.WriteStartElement(XmlNamespace.Types, xmlElementName);

            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.StartTime,
                startTime);

            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.EndTime,
                endTime);

            writer.WriteEndElement(); // xmlElementName
        }

        /// <summary>
        /// Writes to XML without scoping the dates and without emitting times.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        void WriteToXmlUnscopedDatesOnly(EwsServiceXmlWriter writer, String xmlElementName)
        {
            const String DateOnlyFormat = "yyyy-MM-ddT00:00:00";

            TimeWindow.WriteToXml(
                writer,
                xmlElementName,
                this.StartTime.ToString(DateOnlyFormat, CultureInfo.InvariantCulture),
                this.EndTime.ToString(DateOnlyFormat, CultureInfo.InvariantCulture));
        }

        /// <summary>
        /// Writes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
        void WriteToXml(EwsServiceXmlWriter writer, String xmlElementName)
        {
            TimeWindow.WriteToXml(
                writer,
                xmlElementName,
                this.StartTime,
                this.EndTime);
        }

        /// <summary>
        /// Gets the duration.
        /// </summary>
        TimeSpan Duration
        {
            get { return this.endTime - this.startTime; }
        }

        #region ISelfValidate Members

        /// <summary>
        /// Validates this instance.
        /// </summary>
        void ISelfValidate.Validate()
        {
            if (this.StartTime >= this.EndTime)
            {
                throw new ArgumentError(Strings.TimeWindowStartTimeMustBeGreaterThanEndTime);
            }
        }

        #endregion
    }
