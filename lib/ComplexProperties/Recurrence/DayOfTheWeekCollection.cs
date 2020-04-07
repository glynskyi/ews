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
    /// Represents a collection of DayOfTheWeek values.
    /// </summary>
 class DayOfTheWeekCollection extends ComplexProperty, Iterable<DayOfTheWeek>
    {
        /* private */ List<DayOfTheWeek> items = new List<DayOfTheWeek>();

        /// <summary>
        /// Initializes a new instance of the <see cref="DayOfTheWeekCollection"/> class.
        /// </summary>
        DayOfTheWeekCollection()
        {
        }

        /// <summary>
        /// Convert to string.
        /// </summary>
        /// <param name="separator">The separator.</param>
        /// <returns>String representation of collection.</returns>
        String toString()(String separator)
        {
            if (this.Count == 0)
            {
                return "";
            }
            else
            {
                string[] daysOfTheWeekArray = new string[this.Count];

                for (int i = 0; i < this.Count; i++)
                {
                    daysOfTheWeekArray[i] = this[i].ToString();
                }

                return string.Join(separator, daysOfTheWeekArray);
            }
        }

        /// <summary>
        /// Loads from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
@override
        void LoadFromXml(EwsServiceXmlReader reader, String xmlElementName)
        {
            reader.EnsureCurrentNodeIsStartElement(XmlNamespace.Types, xmlElementName);

            EwsUtilities.ParseEnumValueList<DayOfTheWeek>(
                this.items,
                reader.ReadElementValue<String>(),
                ' ');
        }

        /// <summary>
        /// Writes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlElementName">Name of the XML element.</param>
@override
        void WriteToXml(EwsServiceXmlWriter writer, String xmlElementName)
        {
            String daysOfWeekAsString = this.ToString(" ");

            if (!StringUtils.IsNullOrEmpty(daysOfWeekAsString))
            {
                writer.WriteElementValue(
                    XmlNamespace.Types,
                    XmlElementNames.DaysOfWeek,
                    daysOfWeekAsString);
            }
        }

        /// <summary>
        /// Builds String representation of the collection.
        /// </summary>
        /// <returns>A comma-delimited String representing the collection.</returns>
@override
 String toString()
        {
            return this.ToString(",");
        }

        /// <summary>
        /// Adds a day to the collection if it is not already present.
        /// </summary>
        /// <param name="dayOfTheWeek">The day to add.</param>
 void Add(DayOfTheWeek dayOfTheWeek)
        {
            if (!this.items.Contains(dayOfTheWeek))
            {
                this.items.Add(dayOfTheWeek);
                this.Changed();
            }
        }

        /// <summary>
        /// Adds multiple days to the collection if they are not already present.
        /// </summary>
        /// <param name="daysOfTheWeek">The days to add.</param>
 void AddRange(Iterable<DayOfTheWeek> daysOfTheWeek)
        {
            for (DayOfTheWeek dayOfTheWeek in daysOfTheWeek)
            {
                this.Add(dayOfTheWeek);
            }
        }

        /// <summary>
        /// Clears the collection.
        /// </summary>
 void Clear()
        {
            if (this.Count > 0)
            {
                this.items.Clear();
                this.Changed();
            }
        }

        /// <summary>
        /// Remove a specific day from the collection.
        /// </summary>
        /// <param name="dayOfTheWeek">The day to remove.</param>
        /// <returns>True if the day was removed from the collection, false otherwise.</returns>
 bool Remove(DayOfTheWeek dayOfTheWeek)
        {
            bool result = this.items.Remove(dayOfTheWeek);

            if (result)
            {
                this.Changed();
            }

            return result;
        }

        /// <summary>
        /// Removes the day at a specific index.
        /// </summary>
        /// <param name="index">The index of the day to remove.</param>
 void RemoveAt(int index)
        {
            if (index < 0 || index >= this.Count)
            {
                throw new ArgumentOutOfRangeException("index", Strings.IndexIsOutOfRange);
            }

            this.items.RemoveAt(index);
            this.Changed();
        }

        /// <summary>
        /// Gets the DayOfTheWeek at a specific index in the collection.
        /// </summary>
        /// <param name="index">Index</param>
        /// <returns>DayOfTheWeek at index</returns>
 DayOfTheWeek this[int index]
        {
            get
            {
                return this.items[index];
            }
        }

        /// <summary>
        /// Gets the number of days in the collection.
        /// </summary>
 int Count
        {
            get { return this.items.Count; }
        }

        #region Iterable<DayOfTheWeek> Members

        /// <summary>
        /// Gets an enumerator that iterates through the elements of the collection.
        /// </summary>
        /// <returns>An IEnumerator for the collection.</returns>
 IEnumerator<DayOfTheWeek> GetEnumerator()
        {
            return this.items.GetEnumerator();
        }

        #endregion

        #region Iterable Members

        /// <summary>
        /// Gets an enumerator that iterates through the elements of the collection.
        /// </summary>
        /// <returns>An IEnumerator for the collection.</returns>
        System.Collections.IEnumerator System.Collections.Iterable.GetEnumerator()
        {
            return this.items.GetEnumerator();
        }

        #endregion
    }
