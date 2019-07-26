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
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/LocationSource.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
    /// Represents PersonaPostalAddress.
    /// </summary>
  class PersonaPostalAddress extends ComplexProperty
    {
        /* private */ String street;
        /* private */ String city;
        /* private */ String state;
        /* private */ String country;
        /* private */ String postalCode;
        /* private */ String postOfficeBox;
        /* private */ String type;
        /* private */ double latitude;
        /* private */ double longitude;
        /* private */ double accuracy;
        /* private */ double altitude;
        /* private */ double altitudeAccuracy;
        /* private */ String formattedAddress;
        /* private */ String uri;
        /* private */ LocationSource source;

        /// <summary>
        /// Initializes a new instance of the <see cref="PersonaPostalAddress"/> class.
        /// </summary>
        PersonaPostalAddress()
            : super();

        /// <summary>
        /// Initializes a new instance of the <see cref="PersonaPostalAddress"/> class.
        /// </summary>
        /// <param name="street">The Street Address.</param>
        /// <param name="city">The City value.</param>
        /// <param name="state">The State value.</param>
        /// <param name="country">The country value.</param>
        /// <param name="postalCode">The postal code value.</param>
        /// <param name="postOfficeBox">The Post Office Box.</param>
        /// <param name="locationSource">The location Source.</param>
        /// <param name="locationUri">The location Uri.</param>
        /// <param name="formattedAddress">The location street Address in formatted address.</param>
        /// <param name="latitude">The location latitude.</param>
        /// <param name="longitude">The location longitude.</param>
        /// <param name="accuracy">The location accuracy.</param>
        /// <param name="altitude">The location altitude.</param>
        /// <param name="altitudeAccuracy">The location altitude Accuracy.</param>
 PersonaPostalAddress.withDetails(
            String street,
            String city,
            String state,
            String country,
            String postalCode,
            String postOfficeBox,
            LocationSource locationSource,
            String locationUri,
            String formattedAddress,
            double latitude,
            double longitude,
            double accuracy,
            double altitude,
            double altitudeAccuracy)
            : super()
        {
            this.street = street;
            this.city = city;
            this.state = state;
            this.country = country;
            this.postalCode = postalCode;
            this.postOfficeBox = postOfficeBox;
            this.latitude = latitude;
            this.longitude = longitude;
            this.source = locationSource;
            this.uri = locationUri;
            this.formattedAddress = formattedAddress;
            this.accuracy = accuracy;
            this.altitude = altitude;
            this.altitudeAccuracy = altitudeAccuracy;
        }

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
                case XmlElementNames.Street:
                    this.street = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.City:
                    this.city = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.State:
                    this.state = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.Country:
                    this.country = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.PostalCode:
                    this.postalCode = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.PostOfficeBox:
                    this.postOfficeBox = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.PostalAddressType:
                    this.type = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.Latitude:
                    this.latitude = reader.ReadValue<double>();
                    return true;
                case XmlElementNames.Longitude:
                    this.longitude = reader.ReadValue<double>();
                    return true;
                case XmlElementNames.Accuracy:
                    this.accuracy = reader.ReadValue<double>();
                    return true;
                case XmlElementNames.Altitude:
                    this.altitude = reader.ReadValue<double>();
                    return true;
                case XmlElementNames.AltitudeAccuracy:
                    this.altitudeAccuracy = reader.ReadValue<double>();
                    return true;
                case XmlElementNames.FormattedAddress:
                    this.formattedAddress = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.LocationUri:
                    this.uri = reader.ReadValue<String>();
                    return true;
                case XmlElementNames.LocationSource:
                    this.source = reader.ReadValue<LocationSource>();
                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Loads from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        void LoadFromXmlElementName(EwsServiceXmlReader reader)
        {
            do
            {
                reader.Read();

                if (reader.NodeType == XmlNodeType.Element)
                {
                    this.TryReadElementFromXml(reader);
                }
            }
            while (!reader.IsEndElementWithNamespace(XmlNamespace.Types, XmlElementNames.PersonaPostalAddress));
        }

        /// <summary>
        /// Gets or sets the street.
        /// </summary>
        String get Street => this.street;

        set Street(String value) {
           if (this.CanSetFieldValue(this.street, value)) {
             this.street = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the City.
        /// </summary>
        String get City => this.city;

        set City(String value) {
           if (this.CanSetFieldValue(this.city, value)) {
             this.city = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the state.
        /// </summary>
        String get State => this.state;

        set State(String value) {
           if (this.CanSetFieldValue(this.state, value)) {
             this.state = value;
             this.Changed();
           }
        }


        /// <summary>
        /// Gets or sets the Country.
        /// </summary>
        String get Country => this.country;

        set Country(String value) {
           if (this.CanSetFieldValue(this.country, value)) {
             this.country = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the postalCode.
        /// </summary>
        String get PostalCode => this.postalCode;

        set PostalCode(String value) {
           if (this.CanSetFieldValue(this.postalCode, value)) {
             this.postalCode = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the postOfficeBox.
        /// </summary>
        String get PostOfficeBox => this.postOfficeBox;

        set PostOfficeBox(String value) {
           if (this.CanSetFieldValue(this.postOfficeBox, value)) {
             this.postOfficeBox = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the type.
        /// </summary>
        String get Type => this.type;

        set Type(String value) {
           if (this.CanSetFieldValue(this.type, value)) {
             this.type = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the location source type.
        /// </summary>
        LocationSource get Source => this.source;

        set Source(LocationSource value) {
           if (this.CanSetFieldValue(this.source, value)) {
             this.source = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the location Uri.
        /// </summary>
        String get Uri => this.uri;

        set Uri(String value) {
           if (this.CanSetFieldValue(this.uri, value)) {
             this.uri = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets a value indicating location latitude.
        /// </summary>
        double get Latitude => this.latitude;

        set Latitude(double value) {
           if (this.CanSetFieldValue(this.latitude, value)) {
             this.latitude = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets a value indicating location longitude.
        /// </summary>
        double get Longitude => this.longitude;

        set Longitude(double value) {
           if (this.CanSetFieldValue(this.longitude, value)) {
             this.longitude = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the location accuracy.
        /// </summary>
        double get Accuracy => this.accuracy;

        set Accuracy(double value) {
           if (this.CanSetFieldValue(this.accuracy, value)) {
             this.accuracy = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the location altitude.
        /// </summary>
        double get Altitude => this.altitude;

        set Altitude(double value) {
          if (this.CanSetFieldValue(this.altitude, value)) {
            this.altitude = value;
            this.Changed();
          }
        }

        /// <summary>
        /// Gets or sets the location altitude accuracy.
        /// </summary>
        double get AltitudeAccuracy => this.altitudeAccuracy;

        set AltitudeAccuracy(double value) {
           if (this.CanSetFieldValue(this.altitudeAccuracy, value)) {
             this.altitudeAccuracy = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Gets or sets the street address.
        /// </summary>
        String get FormattedAddress => this.formattedAddress;

        set FormattedAddress(String value) {
           if (this.CanSetFieldValue(this.formattedAddress, value)) {
             this.formattedAddress = value;
             this.Changed();
           }
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Street, this.street);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.City, this.city);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.State, this.state);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Country, this.country);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.PostalCode, this.postalCode);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.PostOfficeBox, this.postOfficeBox);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.PostalAddressType, this.type);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Latitude, this.latitude);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Longitude, this.longitude);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Accuracy, this.accuracy);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.Altitude, this.altitude);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.AltitudeAccuracy, this.altitudeAccuracy);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.FormattedAddress, this.formattedAddress);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.LocationUri, this.uri);
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.LocationSource, this.source);
        }

        /// <summary>
        /// Writes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        void WriteToXmlElementName(EwsServiceXmlWriter writer)
        {
            writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.PersonaPostalAddress);

            this.WriteElementsToXml(writer);

            writer.WriteEndElement(); // xmlElementName
        }
    }
