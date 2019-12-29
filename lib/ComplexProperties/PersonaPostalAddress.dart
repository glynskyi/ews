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
class PersonaPostalAddress extends ComplexProperty {
  String _street;
  String _city;
  String _state;
  String _country;
  String _postalCode;
  String _postOfficeBox;
  String _type;
  double _latitude;
  double _longitude;
  double _accuracy;
  double _altitude;
  double _altitudeAccuracy;
  String _formattedAddress;
  String _uri;
  LocationSource _source;

  /// <summary>
  /// Initializes a new instance of the <see cref="PersonaPostalAddress"/> class.
  /// </summary>
  PersonaPostalAddress() : super();

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
      : super() {
    this._street = street;
    this._city = city;
    this._state = state;
    this._country = country;
    this._postalCode = postalCode;
    this._postOfficeBox = postOfficeBox;
    this._latitude = latitude;
    this._longitude = longitude;
    this._source = locationSource;
    this._uri = locationUri;
    this._formattedAddress = formattedAddress;
    this._accuracy = accuracy;
    this._altitude = altitude;
    this._altitudeAccuracy = altitudeAccuracy;
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.Street:
        this._street = reader.ReadValue<String>();
        return true;
      case XmlElementNames.City:
        this._city = reader.ReadValue<String>();
        return true;
      case XmlElementNames.State:
        this._state = reader.ReadValue<String>();
        return true;
      case XmlElementNames.Country:
        this._country = reader.ReadValue<String>();
        return true;
      case XmlElementNames.PostalCode:
        this._postalCode = reader.ReadValue<String>();
        return true;
      case XmlElementNames.PostOfficeBox:
        this._postOfficeBox = reader.ReadValue<String>();
        return true;
      case XmlElementNames.PostalAddressType:
        this._type = reader.ReadValue<String>();
        return true;
      case XmlElementNames.Latitude:
        this._latitude = reader.ReadValue<double>();
        return true;
      case XmlElementNames.Longitude:
        this._longitude = reader.ReadValue<double>();
        return true;
      case XmlElementNames.Accuracy:
        this._accuracy = reader.ReadValue<double>();
        return true;
      case XmlElementNames.Altitude:
        this._altitude = reader.ReadValue<double>();
        return true;
      case XmlElementNames.AltitudeAccuracy:
        this._altitudeAccuracy = reader.ReadValue<double>();
        return true;
      case XmlElementNames.FormattedAddress:
        this._formattedAddress = reader.ReadValue<String>();
        return true;
      case XmlElementNames.LocationUri:
        this._uri = reader.ReadValue<String>();
        return true;
      case XmlElementNames.LocationSource:
        this._source = reader.ReadValue<LocationSource>();
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadFromXmlElementName(EwsServiceXmlReader reader) {
    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        this.TryReadElementFromXml(reader);
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Types, XmlElementNames.PersonaPostalAddress));
  }

  /// <summary>
  /// Gets or sets the street.
  /// </summary>
  String get Street => this._street;

  set Street(String value) {
    if (this.CanSetFieldValue(this._street, value)) {
      this._street = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the City.
  /// </summary>
  String get City => this._city;

  set City(String value) {
    if (this.CanSetFieldValue(this._city, value)) {
      this._city = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the state.
  /// </summary>
  String get State => this._state;

  set State(String value) {
    if (this.CanSetFieldValue(this._state, value)) {
      this._state = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the Country.
  /// </summary>
  String get Country => this._country;

  set Country(String value) {
    if (this.CanSetFieldValue(this._country, value)) {
      this._country = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the postalCode.
  /// </summary>
  String get PostalCode => this._postalCode;

  set PostalCode(String value) {
    if (this.CanSetFieldValue(this._postalCode, value)) {
      this._postalCode = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the postOfficeBox.
  /// </summary>
  String get PostOfficeBox => this._postOfficeBox;

  set PostOfficeBox(String value) {
    if (this.CanSetFieldValue(this._postOfficeBox, value)) {
      this._postOfficeBox = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the type.
  /// </summary>
  String get Type => this._type;

  set Type(String value) {
    if (this.CanSetFieldValue(this._type, value)) {
      this._type = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the location source type.
  /// </summary>
  LocationSource get Source => this._source;

  set Source(LocationSource value) {
    if (this.CanSetFieldValue(this._source, value)) {
      this._source = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the location Uri.
  /// </summary>
  String get Uri => this._uri;

  set Uri(String value) {
    if (this.CanSetFieldValue(this._uri, value)) {
      this._uri = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets a value indicating location latitude.
  /// </summary>
  double get Latitude => this._latitude;

  set Latitude(double value) {
    if (this.CanSetFieldValue(this._latitude, value)) {
      this._latitude = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets a value indicating location longitude.
  /// </summary>
  double get Longitude => this._longitude;

  set Longitude(double value) {
    if (this.CanSetFieldValue(this._longitude, value)) {
      this._longitude = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the location accuracy.
  /// </summary>
  double get Accuracy => this._accuracy;

  set Accuracy(double value) {
    if (this.CanSetFieldValue(this._accuracy, value)) {
      this._accuracy = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the location altitude.
  /// </summary>
  double get Altitude => this._altitude;

  set Altitude(double value) {
    if (this.CanSetFieldValue(this._altitude, value)) {
      this._altitude = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the location altitude accuracy.
  /// </summary>
  double get AltitudeAccuracy => this._altitudeAccuracy;

  set AltitudeAccuracy(double value) {
    if (this.CanSetFieldValue(this._altitudeAccuracy, value)) {
      this._altitudeAccuracy = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the street address.
  /// </summary>
  String get FormattedAddress => this._formattedAddress;

  set FormattedAddress(String value) {
    if (this.CanSetFieldValue(this._formattedAddress, value)) {
      this._formattedAddress = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Street, this._street);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.City, this._city);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.State, this._state);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Country, this._country);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.PostalCode, this._postalCode);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.PostOfficeBox, this._postOfficeBox);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.PostalAddressType, this._type);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Latitude, this._latitude);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Longitude, this._longitude);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Accuracy, this._accuracy);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Altitude, this._altitude);
    writer.WriteElementValueWithNamespace(XmlNamespace.Types,
        XmlElementNames.AltitudeAccuracy, this._altitudeAccuracy);
    writer.WriteElementValueWithNamespace(XmlNamespace.Types,
        XmlElementNames.FormattedAddress, this._formattedAddress);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.LocationUri, this._uri);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.LocationSource, this._source);
  }

  /// <summary>
  /// Writes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXmlElementName(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(
        XmlNamespace.Types, XmlElementNames.PersonaPostalAddress);

    this.WriteElementsToXml(writer);

    writer.WriteEndElement(); // xmlElementName
  }
}
