// ---------------------------------------------------------------------------
// <copyright file="ComputedInsightValueProperty.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
// ---------------------------------------------------------------------------

//-----------------------------------------------------------------------
// <summary>Implements the class for computed insight value property.</summary>
//-----------------------------------------------------------------------

    /// <summary>
    /// Represents a computed insight value.
    /// </summary>
 class ComputedInsightValueProperty extends ComplexProperty
    {
        /* private */ String key;
        /* private */ String value;

        /// <summary>
        /// Gets or sets the Key
        /// </summary>
 String Key
        {
            get
            {
                return this.key;
            }

            set
            {
                this.SetFieldValue<string>(ref this.key, value);
            }
        }

        /// <summary>
        /// Gets or sets the Value
        /// </summary>
 String Value
        {
            get
            {
                return this.value;
            }

            set
            {
                this.SetFieldValue<string>(ref this.value, value);
            }
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">XML reader</param>
        /// <returns>Whether the element was read</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.Key:
                    this.Key = reader.ReadElementValue();
                    break;
                case XmlElementNames.Value:
                    this.Value = reader.ReadElementValue();
                    break;
                default:
                    return false;
            }

            return true;
        }
    }

