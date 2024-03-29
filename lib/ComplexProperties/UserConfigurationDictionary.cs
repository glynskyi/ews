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
    /// Represents a user configuration's Dictionary property.
    /// </summary>
    [EditorBrowsable(EditorBrowsableState.Never)]
 class UserConfigurationDictionary extends ComplexProperty, Iterable
    {
        // TODO: Consider implementing IsDirty mechanism in ComplexProperty.
        /* private */ Map<object, object> dictionary;
        /* private */ bool isDirty = false;

        /// <summary>
        /// Initializes a new instance of <see cref="UserConfigurationDictionary"/> class.
        /// </summary>
        UserConfigurationDictionary()
                    : super()
        {
            this.dictionary = new Map<object, object>();
        }

        /// <summary>
        /// Gets or sets the element with the specified key.
        /// </summary>
        /// <param name="key">The key of the element to get or set.</param>
        /// <returns>The element with the specified key.</returns>
 object this[object key]
        {
            get
            {
                return this.dictionary[key];
            }

            set
            {
                this.ValidateEntry(key, value);

                this.dictionary[key] = value;

                this.Changed();
            }
        }

        /// <summary>
        /// Adds an element with the provided key and value to the user configuration dictionary.
        /// </summary>
        /// <param name="key">The object to use as the key of the element to add.</param>
        /// <param name="value">The object to use as the value of the element to add.</param>
 void Add(object key, object value)
        {
            this.ValidateEntry(key, value);

            this.dictionary.Add(key, value);

            this.Changed();
        }

        /// <summary>
        /// Determines whether the user configuration dictionary contains an element with the specified key.
        /// </summary>
        /// <param name="key">The key to locate in the user configuration dictionary.</param>
        /// <returns>true if the user configuration dictionary contains an element with the key; otherwise false.</returns>
 bool ContainsKey(object key)
        {
            return this.dictionary.ContainsKey(key);
        }

        /// <summary>
        /// Removes the element with the specified key from the user configuration dictionary.
        /// </summary>
        /// <param name="key">The key of the element to remove.</param>
        /// <returns>true if the element is successfully removed; otherwise false.</returns>
 bool Remove(object key)
        {
            bool isRemoved = this.dictionary.Remove(key);

            if (isRemoved)
            {
                this.Changed();
            }

            return isRemoved;
        }

        /// <summary>
        /// Gets the value associated with the specified key.
        /// </summary>
        /// <param name="key">The key whose value to get.</param>
        /// <param name="value">When this method returns, the value associated with the specified key, if the key is found; otherwise, null.</param>
        /// <returns>true if the user configuration dictionary contains the key; otherwise false.</returns>
 bool TryGetValue(object key, out object value)
        {
            return this.dictionary.TryGetValue(key, out value);
        }

        /// <summary>
        /// Gets the number of elements in the user configuration dictionary.
        /// </summary>
 int Count
        {
            get
            {
                return this.dictionary.Count;
            }
        }

        /// <summary>
        /// Removes all items from the user configuration dictionary.
        /// </summary>
 void Clear()
        {
            if (this.dictionary.Count != 0)
            {
                this.dictionary.Clear();

                this.Changed();
            }
        }

        #region Iterable members

        /// <summary>
        /// Returns an enumerator that iterates through the user configuration dictionary.
        /// </summary>
        /// <returns>An IEnumerator that can be used to iterate through the user configuration dictionary.</returns>
 IEnumerator GetEnumerator()
        {
            return this.dictionary.GetEnumerator();
        }

        #endregion

        /// <summary>
        /// Gets or sets the isDirty flag.
        /// </summary>
        bool IsDirty
        {
            get
            {
                return this.isDirty;
            }

            set
            {
                this.isDirty = value;
            }
        }

        /// <summary>
        /// Instance was changed.
        /// </summary>
@override
        void Changed()
        {
            base.Changed();

            this.isDirty = true;
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            EwsUtilities.Assert(
                writer != null,
                "UserConfigurationDictionary.WriteElementsToXml",
                "writer is null");

            for (MapEntry<object, object> dictionaryEntry in this.dictionary)
            {
                writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.DictionaryEntry);

                this.WriteObjectToXml(
                    writer,
                    XmlElementNames.DictionaryKey,
                    dictionaryEntry.Key);

                this.WriteObjectToXml(
                    writer,
                    XmlElementNames.DictionaryValue,
                    dictionaryEntry.Value);

                writer.WriteEndElement();
            }
        }

        /// <summary>
        /// Gets the type code.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="dictionaryObject">The dictionary object.</param>
        /// <param name="dictionaryObjectType">Type of the dictionary object.</param>
        /// <param name="valueAsString">The value as string.</param>
        /* private */ static void GetTypeCode(ExchangeServiceBase service, object dictionaryObject, ref UserConfigurationDictionaryObjectType dictionaryObjectType, ref String valueAsString)
        {
            // Handle all other types by TypeCode
            switch (Type.GetTypeCode(dictionaryObject.GetType()))
            {
                case TypeCode.Boolean:
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.Boolean;
                    valueAsString = EwsUtilities.BoolToXSBool((bool)dictionaryObject);
                    break;
                case TypeCode.Byte:
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.Byte;
                    valueAsString = ((byte)dictionaryObject).ToString();
                    break;
                case TypeCode.DateTime:
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.DateTime;
                    valueAsString = service.ConvertDateTimeToUniversalDateTimeString((DateTime)dictionaryObject);
                    break;
                case TypeCode.Int32:
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.Integer32;
                    valueAsString = ((int)dictionaryObject).ToString();
                    break;
                case TypeCode.Int64:
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.Integer64;
                    valueAsString = ((long)dictionaryObject).ToString();
                    break;
                case TypeCode.String:
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.String;
                    valueAsString = (string)dictionaryObject;
                    break;
                case TypeCode.UInt32:
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.UnsignedInteger32;
                    valueAsString = ((uint)dictionaryObject).ToString();
                    break;
                case TypeCode.UInt64:
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.UnsignedInteger64;
                    valueAsString = ((ulong)dictionaryObject).ToString();
                    break;
                default:
                    EwsUtilities.Assert(
                        false,
                        "UserConfigurationDictionary.WriteObjectValueToXml",
                        "Unsupported type: " + dictionaryObject.GetType().ToString());
                    break;
            }
        }

        /// <summary>
        /// Gets the type of the object.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <returns></returns>
        /* private */ static UserConfigurationDictionaryObjectType GetObjectType(String type)
        {
            return (UserConfigurationDictionaryObjectType)Enum.Parse(typeof(UserConfigurationDictionaryObjectType), type, false);
        }

        /// <summary>
        /// Writes a dictionary object (key or value) to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="xmlElementName">The Xml element name.</param>
        /// <param name="dictionaryObject">The object to write.</param>
        /* private */ void WriteObjectToXml(
            EwsServiceXmlWriter writer,
            String xmlElementName,
            object dictionaryObject)
        {
            EwsUtilities.Assert(
                writer != null,
                "UserConfigurationDictionary.WriteObjectToXml",
                "writer is null");
            EwsUtilities.Assert(
                xmlElementName != null,
                "UserConfigurationDictionary.WriteObjectToXml",
                "xmlElementName is null");

            writer.WriteStartElement(XmlNamespace.Types, xmlElementName);

            if (dictionaryObject == null)
            {
                EwsUtilities.Assert(
                    xmlElementName != XmlElementNames.DictionaryKey,
                    "UserConfigurationDictionary.WriteObjectToXml",
                    "Key is null");

                writer.WriteAttributeValue(
                    EwsUtilities.EwsXmlSchemaInstanceNamespacePrefix,
                    XmlAttributeNames.Nil,
                    EwsUtilities.XSTrue);
            }
            else
            {
                this.WriteObjectValueToXml(writer, dictionaryObject);
            }

            writer.WriteEndElement();
        }

        /// <summary>
        /// Writes a dictionary Object's value to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="dictionaryObject">The dictionary object to write.</param>
        /* private */ void WriteObjectValueToXml(EwsServiceXmlWriter writer, object dictionaryObject)
        {
            EwsUtilities.Assert(
                writer != null,
                "UserConfigurationDictionary.WriteObjectValueToXml",
                "writer is null");
            EwsUtilities.Assert(
                dictionaryObject != null,
                "UserConfigurationDictionary.WriteObjectValueToXml",
                "dictionaryObject is null");

            // This logic is based on Microsoft.Exchange.Services.Core.GetUserConfiguration.ConstructDictionaryObject().
            //
            // Object values are either:
            //   . an array of strings
            //   . a single value
            //
            // Single values can be:
            //   . base64 String (from a byte array)
            //   . datetime, boolean, byte, short, int, long, string, ushort, unint, ulong
            //
            // First check for a String array
            string[] dictionaryObjectAsStringArray = dictionaryObject as string[];
            if (dictionaryObjectAsStringArray != null)
            {
                this.WriteEntryTypeToXml(writer, UserConfigurationDictionaryObjectType.StringArray);

                for (String arrayElement in dictionaryObjectAsStringArray)
                {
                    this.WriteEntryValueToXml(writer, arrayElement);
                }
            }
            else
            {
                // if not a String array, all other object values are returned as a single element
                UserConfigurationDictionaryObjectType dictionaryObjectType = UserConfigurationDictionaryObjectType.String;
                String valueAsString = null;

                Uint8List dictionaryObjectAsByteArray = dictionaryObject as Uint8List;
                if (dictionaryObjectAsByteArray != null)
                {
                    // Convert byte array to base64 string
                    dictionaryObjectType = UserConfigurationDictionaryObjectType.ByteArray;
                    valueAsString = Convert.ToBase64String(dictionaryObjectAsByteArray);
                }
                else
                {
                    GetTypeCode(writer.Service, dictionaryObject, ref dictionaryObjectType, ref valueAsString);
                }

                this.WriteEntryTypeToXml(writer, dictionaryObjectType);
                this.WriteEntryValueToXml(writer, valueAsString);
            }
        }

        /// <summary>
        /// Writes a dictionary entry type to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="dictionaryObjectType">Type to write.</param>
        /* private */ void WriteEntryTypeToXml(EwsServiceXmlWriter writer, UserConfigurationDictionaryObjectType dictionaryObjectType)
        {
            writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Type);
            writer.WriteValue(dictionaryObjectType.ToString(), XmlElementNames.Type);
            writer.WriteEndElement();
        }

        /// <summary>
        /// Writes a dictionary entry value to Xml.
        /// </summary>
        /// <param name="writer">The writer.</param>
        /// <param name="value">Value to write.</param>
        /* private */ void WriteEntryValueToXml(EwsServiceXmlWriter writer, String value)
        {
            writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Value);

            // While an entry value can't be null, if the entry is an array, an element of the array can be null.
            if (value != null)
            {
                writer.WriteValue(value, XmlElementNames.Value);
            }

            writer.WriteEndElement();
        }

        /// <summary>
        /// Loads this dictionary from the specified reader.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <param name="xmlNamespace">The dictionary's XML namespace.</param>
        /// <param name="xmlElementName">Name of the XML element representing the dictionary.</param>
@override
        void LoadFromXml(
            EwsServiceXmlReader reader,
            XmlNamespace xmlNamespace,
            String xmlElementName)
        {
            base.LoadFromXml(
                reader,
                xmlNamespace,
                xmlElementName);

            this.isDirty = false;
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            reader.EnsureCurrentNodeIsStartElement(this.Namespace, XmlElementNames.DictionaryEntry);

            this.LoadEntry(reader);

            return true;
        }

        /// <summary>
        /// Loads an entry, consisting of a key value pair, into this dictionary from the specified reader.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /* private */ void LoadEntry(EwsServiceXmlReader reader)
        {
            EwsUtilities.Assert(
                reader != null,
                "UserConfigurationDictionary.LoadEntry",
                "reader is null");

            object key;
            object value = null;

            // Position at DictionaryKey
            reader.ReadStartElement(this.Namespace, XmlElementNames.DictionaryKey);

            key = this.GetDictionaryObject(reader);

            // Position at DictionaryValue
            reader.ReadStartElement(this.Namespace, XmlElementNames.DictionaryValue);

            String nil = reader.ReadAttributeValue(XmlNamespace.XmlSchemaInstance, XmlAttributeNames.Nil);
            bool hasValue = (nil == null) || (! Convert.ToBoolean(nil));
            if (hasValue)
            {
                value = this.GetDictionaryObject(reader);
            }

            this.dictionary.Add(key, value);
        }

        /// <summary>
        /// Gets the object value.
        /// </summary>
        /// <param name="valueArray">The value array.</param>
        ///
        /// <returns></returns>
        /* private */ List<string> GetObjectValue(object[] valueArray)
        {
            List<string> stringArray = new List<string>();

            for (object value in valueArray)
            {
                stringArray.Add(value as string);
            }

            return stringArray;
        }

        /// <summary>
        /// Extracts a dictionary object (key or entry value) from the specified reader.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>Dictionary object.</returns>
        /* private */ object GetDictionaryObject(EwsServiceXmlReader reader)
        {
            EwsUtilities.Assert(
                reader != null,
                "UserConfigurationDictionary.LoadFromXml",
                "reader is null");

            UserConfigurationDictionaryObjectType type = this.GetObjectType(reader);

            List<string> values = this.GetObjectValue(reader, type);

            return this.ConstructObject(type, values, reader.Service);
        }

        /// <summary>
        /// Extracts a dictionary object (key or entry value) as a String list from the
        /// specified reader.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <param name="type">The object type.</param>
        /// <returns>String list representing a dictionary object.</returns>
        /* private */ List<string> GetObjectValue(EwsServiceXmlReader reader, UserConfigurationDictionaryObjectType type)
        {
            EwsUtilities.Assert(
                reader != null,
                "UserConfigurationDictionary.LoadFromXml",
                "reader is null");

            List<string> values = new List<string>();

            reader.ReadStartElement(this.Namespace, XmlElementNames.Value);

            do
            {
                String value = null;

                if (reader.IsEmptyElement)
                {
                    // Only String types can be represented with empty values.
                    switch (type)
                    {
                        case UserConfigurationDictionaryObjectType.String:
                        case UserConfigurationDictionaryObjectType.StringArray:
                            value = "";
                            break;
                        default:
                            EwsUtilities.Assert(
                                false,
                                "UserConfigurationDictionary.GetObjectValue",
                                "Empty element passed for type: " + type.ToString());
                            break;
                    }
                }
                else
                {
                    value = reader.ReadElementValue<String>();
                }

                values.Add(value);

                await reader.Read(); // Position at next element or DictionaryKey/DictionaryValue end element
            }
            while (reader.IsStartElement(this.Namespace, XmlElementNames.Value));

            return values;
        }

        /// <summary>
        /// Extracts the dictionary object (key or entry value) type from the specified reader.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>Dictionary object type.</returns>
        /* private */ UserConfigurationDictionaryObjectType GetObjectType(EwsServiceXmlReader reader)
        {
            EwsUtilities.Assert(
                reader != null,
                "UserConfigurationDictionary.LoadFromXml",
                "reader is null");

            reader.ReadStartElement(this.Namespace, XmlElementNames.Type);

            String type = reader.ReadElementValue<String>();

            return GetObjectType(type);
        }

        /// <summary>
        /// Constructs a dictionary object (key or entry value) from the specified type and String list.
        /// </summary>
        /// <param name="type">Object type to construct.</param>
        /// <param name="value">Value of the dictionary object as a String list</param>
        /// <param name="service">The service.</param>
        /// <returns>Dictionary object.</returns>
        /* private */ object ConstructObject(
            UserConfigurationDictionaryObjectType type,
            List<string> value,
            ExchangeService service)
        {
            EwsUtilities.Assert(
                value != null,
                "UserConfigurationDictionary.ConstructObject",
                "value is null");
            EwsUtilities.Assert(
                (value.Count == 1 || type == UserConfigurationDictionaryObjectType.StringArray),
                "UserConfigurationDictionary.ConstructObject",
                "value is array but type is not StringArray");

            object dictionaryObject = null;

            switch (type)
            {
                case UserConfigurationDictionaryObjectType.Boolean:
                    dictionaryObject = bool.Parse(value[0]);
                    break;

                case UserConfigurationDictionaryObjectType.Byte:
                    dictionaryObject = byte.Parse(value[0]);
                    break;

                case UserConfigurationDictionaryObjectType.ByteArray:
                    dictionaryObject = Convert.FromBase64String(value[0]);
                    break;

                case UserConfigurationDictionaryObjectType.DateTime:
                    DateTime? dateTime = service.ConvertUniversalDateTimeStringToLocalDateTime(value[0]);

                    if (dateTime.HasValue)
                    {
                        dictionaryObject = dateTime.Value;
                    }
                    else
                    {
                        EwsUtilities.Assert(
                            false,
                            "UserConfigurationDictionary.ConstructObject",
                            "DateTime is null");
                    }

                    break;

                case UserConfigurationDictionaryObjectType.Integer32:
                    dictionaryObject = int.Parse(value[0]);
                    break;

                case UserConfigurationDictionaryObjectType.Integer64:
                    dictionaryObject = long.Parse(value[0]);
                    break;

                case UserConfigurationDictionaryObjectType.String:
                    dictionaryObject = value[0];
                    break;

                case UserConfigurationDictionaryObjectType.StringArray:
                    dictionaryObject = value.ToArray();
                    break;

                case UserConfigurationDictionaryObjectType.UnsignedInteger32:
                    dictionaryObject = uint.Parse(value[0]);
                    break;

                case UserConfigurationDictionaryObjectType.UnsignedInteger64:
                    dictionaryObject = ulong.Parse(value[0]);
                    break;

                default:
                    EwsUtilities.Assert(
                        false,
                        "UserConfigurationDictionary.ConstructObject",
                        "Type not recognized: " + type.ToString());
                    break;
            }

            return dictionaryObject;
        }

        /// <summary>
        ///  Validates the specified key and value.
        /// </summary>
        /// <param name="key">The dictionary entry key.</param>
        /// <param name="value">The dictionary entry value.</param>
        /* private */ void ValidateEntry(object key, object value)
        {
            this.ValidateObject(key);
            this.ValidateObject(value);
        }

        /// <summary>
        /// Validates the dictionary object (key or entry value).
        /// </summary>
        /// <param name="dictionaryObject">Object to validate.</param>
        /* private */ void ValidateObject(object dictionaryObject)
        {
            // Keys may not be null but we rely on the dictionary to throw if the key is null.
            if (dictionaryObject != null)
            {
                Array dictionaryObjectAsArray = dictionaryObject as Array;
                if (dictionaryObjectAsArray != null)
                {
                    this.ValidateArrayObject(dictionaryObjectAsArray);
                }
                else
                {
                    this.ValidateObjectType(dictionaryObject.GetType());
                }
            }
        }

        /// <summary>
        /// Validate the array object.
        /// </summary>
        /// <param name="dictionaryObjectAsArray">Object to validate</param>
        /* private */ void ValidateArrayObject(Array dictionaryObjectAsArray)
        {
            // This logic is based on Microsoft.Exchange.Data.Storage.ConfigurationDictionary.CheckElementSupportedType().
            if (dictionaryObjectAsArray is string[])
            {
                if (dictionaryObjectAsArray.Length > 0)
                {
                    for (object arrayElement in dictionaryObjectAsArray)
                    {
                        if (arrayElement == null)
                        {
                            throw new ServiceLocalException(Strings.NullStringArrayElementInvalid);
                        }
                    }
                }
                else
                {
                    throw new ServiceLocalException(Strings.ZeroLengthArrayInvalid);
                }
            }
            else if (dictionaryObjectAsArray is Uint8List)
            {
                if (dictionaryObjectAsArray.Length <= 0)
                {
                    throw new ServiceLocalException(Strings.ZeroLengthArrayInvalid);
                }
            }
            else
            {
                throw new ServiceLocalException(string.Format(Strings.ObjectTypeNotSupported, dictionaryObjectAsArray.GetType()));
            }
        }

        /// <summary>
        /// Validates the dictionary object type.
        /// </summary>
        /// <param name="type">Type to validate.</param>
        /* private */ void ValidateObjectType(Type type)
        {
            // This logic is based on Microsoft.Exchange.Data.Storage.ConfigurationDictionary.CheckElementSupportedType().
            bool isValidType = false;

            switch (Type.GetTypeCode(type))
            {
                case TypeCode.Boolean:
                case TypeCode.Byte:
                case TypeCode.DateTime:
                case TypeCode.Int32:
                case TypeCode.Int64:
                case TypeCode.String:
                case TypeCode.UInt32:
                case TypeCode.UInt64:
                    isValidType = true;
                    break;
            }

            if (! isValidType)
            {
                throw new ServiceLocalException(string.Format(Strings.ObjectTypeNotSupported, type));
            }
        }
    }
