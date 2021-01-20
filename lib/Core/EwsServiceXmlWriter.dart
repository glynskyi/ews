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

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeServiceBase.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Exceptions/ServiceXmlSerializationException.dart';
import 'package:ews/Xml/XmlNode.dart';
import 'package:ews/Xml/XmlWriter.dart';
import 'package:ews/misc/IDisposable.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// XML writer
/// </summary>
class EwsServiceXmlWriter implements IDisposable {
  /// <summary>
  /// Buffer size for writing Base64 encoded content.
  /// </summary>
  static const int _BufferSize = 4096;

  /// <summary>
  /// UTF-8 encoding that does not create leading Byte order marks
  /// </summary>
  static Encoding? _utf8Encoding = Encoding.getByName("utf8");

  bool _isDisposed = false;
  ExchangeServiceBase _service;
  XmlWriter? _xmlWriter;
  bool _isTimeZoneHeaderEmitted = false;
  bool _requireWSSecurityUtilityNamespace = false;

  /// <summary>
  /// Initializes a new instance of the <see cref="EwsServiceXmlWriter"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="stream">The stream.</param>
  EwsServiceXmlWriter(this._service, StreamConsumer<List<int>>? stream) {
//            XmlWriterSettings settings = new XmlWriterSettings();
//            settings.Indent = true;
//
//            settings.Encoding = EwsServiceXmlWriter.utf8Encoding;
//
//            this.xmlWriter = XmlWriter.Create(stream, settings);
    // todo("implement constructor with arguments")
    this._xmlWriter = XmlWriter(stream);
  }

  /// <summary>
  /// Try to convert object to a string.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <param name="strValue">The String representation of value.</param>
  /// <returns>True if object was converted, false otherwise.</returns>
  /// <remarks>A null object will be "successfully" converted to a null string.</remarks>
  bool TryConvertObjectToString(Object? value, OutParam<String> strValueOut) {
//          print("TryConvertObjectToString(${value.runtimeType} $value)");
    bool converted = true;
    strValueOut.param = null;
    if (value != null) {
      if (EwsUtilities.TrySerializeEnum(value, strValueOut)) {
      }
//            if (value.getClass().isEnum()) {
//              str.setParam(EwsUtilities.serializeEnum(value));
//            } else if (value.getClass().equals(Boolean.class)) {
//              str.setParam(EwsUtilities.boolToXSBool((Boolean) value));
//            } else if (value instanceof Date) {
//              str
//                  .setParam(this.service
//                  .convertDateTimeToUniversalDateTimeString(
//                  (Date) value));
//            } else if (value.getClass().isPrimitive()) {
//              str.setParam(value.toString());
//            } else if (value instanceof String) {
//              str.setParam(value.toString());
//            } else if (value instanceof ISearchStringProvider) {
//              ISearchStringProvider searchStringProvider =
//              (ISearchStringProvider) value;
//              str.setParam(searchStringProvider.getSearchString());
//            } else if (value instanceof Number) {
//              str.setParam(value.toString());
      else if (value is DateTime) {
        strValueOut.param =
            this.Service.ConvertDateTimeToUniversalDateTimeString(value);
      } else if (value is int) {
        strValueOut.param = value.toString();
      } else if (value is bool) {
        strValueOut.param = value.toString();
      } else if (value is String) {
        strValueOut.param = value.toString();
      } else {
        converted = false;
        throw new NotImplementedException(
            "!!! TryConvertObjectToString ${value} of type ${value.runtimeType}");
      }
    }
    return converted;

//            strValueOut.param = null;
//            bool converted = true;
//
//            if (value != null)
//            {
//                // All value types should implement IConvertible. There are a couple of special cases
//                // that need to be handled directly. Otherwise use IConvertible.ToString()

//                IConvertible convertible = value as IConvertible;
//                if (value.GetType().IsEnum)
//                {
//                    strValue = EwsUtilities.SerializeEnum((Enum)value);
//                }
//                else if (convertible != null)
//                {
//                    switch (convertible.GetTypeCode())
//                    {
//                        case TypeCode.Boolean:
//                            strValue = EwsUtilities.BoolToXSBool((bool)value);
//                            break;
//
//                        case TypeCode.DateTime:
//                            strValue = this.Service.ConvertDateTimeToUniversalDateTimeString((DateTime)value);
//                            break;
//
//                        default:
//                            strValue = convertible.ToString(CultureInfo.InvariantCulture);
//                            break;
//                    }
//                }
//                else
//                {
//                    // If the value type doesn't implement IConvertible but implements IFormattable, use its
//                    // toString()(format,formatProvider) method to convert to a string.
//                    IFormattable formattable = value as IFormattable;
//                    if (formattable != null)
//                    {
//                        // Null arguments mean that we use default format and default locale.
//                        strValue = formattable.ToString(null, null);
//                    }
//                    else if (value is ISearchStringProvider)
//                    {
//                        // If the value type doesn't implement IConvertible or IFormattable but implements
//                        // ISearchStringProvider convert to a string.
//                        // Note: if a value type implements IConvertible or IFormattable we will *not* check
//                        // to see if it also implements ISearchStringProvider. We'll always use its IConvertible.ToString
//                        // or IFormattable.ToString method.
//                        ISearchStringProvider searchStringProvider = value as ISearchStringProvider;
//                        strValue = searchStringProvider.GetSearchString();
//                    }
//                    else if (value is Uint8List)
//                    {
//                        // Special case for byte arrays. Convert to Base64-encoded string.
//                        strValue = Convert.ToBase64String((Uint8List)value);
//                    }
//                    else
//                    {
//                        converted = false;
//                    }
//                }
//            }
//
//            return converted;
  }

  /// <summary>
  /// Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
  /// </summary>
  Future<void> Dispose() async {
    if (!this._isDisposed) {
      await this._xmlWriter!.Close();

      this._isDisposed = true;
    }
  }

  /// <summary>
  /// Flushes this instance.
  /// </summary>
  Future<void> Flush() {
    return this._xmlWriter!.Flush();
  }

  /// <summary>
  /// Writes the start element.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">The local name of the element.</param>
  void WriteStartElement(XmlNamespace xmlNamespace, String? localName) {
    this._xmlWriter!.WriteStartElement(
        prefix: EwsUtilities.GetNamespacePrefix(xmlNamespace),
        localName: localName,
        ns: EwsUtilities.GetNamespaceUri(xmlNamespace));
  }

  /// <summary>
  /// Writes the end element.
  /// </summary>
  void WriteEndElement() {
    this._xmlWriter!.WriteEndElement();
  }

  /// <summary>
  /// Writes the attribute value.  Does not emit empty String values.
  /// </summary>
  /// <param name="localName">The local name of the attribute.</param>
//        /// <param name="value">The value.</param>
// void WriteAttributeValue(String localName, Object value)
//        {
//            this.WriteAttributeStringValue(localName, false /* alwaysWriteEmptyString */, value);
//        }

  /// <summary>
  /// Writes the attribute value.  Optionally emits empty String values.
  /// </summary>
  /// <param name="localName">The local name of the attribute.</param>
  /// <param name="alwaysWriteEmptyString">Always emit the empty String as the value.</param>
  /// <param name="value">The value.</param>
  void WriteAttributeValue(String localName, Object? value,
      [bool alwaysWriteEmptyString = false]) {
    OutParam<String> stringValue = new OutParam();
    if (this.TryConvertObjectToString(value, stringValue)) {
      if ((stringValue.param != null) &&
          (alwaysWriteEmptyString || (stringValue.param!.length != 0))) {
        this.WriteAttributeString(localName, stringValue.param);
      }
    } else {
      throw new ServiceXmlSerializationException(
          "AttributeValueCannotBeSerialized(${value.runtimeType}, $localName)");
    }
  }

  /// <summary>
  /// Writes the attribute value.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localName">The local name of the attribute.</param>
  /// <param name="value">The value.</param>
  void WriteAttributeValueWithPrefix(
      String namespacePrefix, String localName, Object value) {
    OutParam<String> stringValue = new OutParam();
    if (this.TryConvertObjectToString(value, stringValue)) {
      if (!StringUtils.IsNullOrEmpty(stringValue.param)) {
        this.WriteAttributeStringWithPrefix(
            namespacePrefix, localName, stringValue.param);
      }
    } else {
      throw new ServiceXmlSerializationException(
          "AttributeValueCannotBeSerialized(${value.runtimeType}, $localName)");
    }
  }

  /// <summary>
  /// Writes the attribute value.
  /// </summary>
  /// <param name="localName">The local name of the attribute.</param>
  /// <param name="stringValue">The String value.</param>
  /// <exception cref="ServiceXmlSerializationException">Thrown if String value isn't valid for XML.</exception>
  void WriteAttributeString(String localName, String? stringValue) {
    try {
      this._xmlWriter!.WriteAttributeStringJust(localName, stringValue);
    } on ArgumentException catch (ex, stacktrace) {
      // XmlTextWriter will throw ArgumentException if String includes invalid characters.
      throw new ServiceXmlSerializationException(
          "InvalidAttributeValue($stringValue, $localName)", ex, stacktrace);
    }
  }

  /// <summary>
  /// Writes the attribute value.
  /// </summary>
  /// <param name="namespacePrefix">The namespace prefix.</param>
  /// <param name="localName">The local name of the attribute.</param>
  /// <param name="stringValue">The String value.</param>
  /// <exception cref="ServiceXmlSerializationException">Thrown if String value isn't valid for XML.</exception>
  void WriteAttributeStringWithPrefix(
      String namespacePrefix, String localName, String? stringValue) {
    try {
      this._xmlWriter!.WriteAttributeString(
          prefix: namespacePrefix,
          localName: localName,
          ns: null,
          value: stringValue);
    } on ArgumentException catch (ex, stacktrace) {
      // XmlTextWriter will throw ArgumentException if String includes invalid characters.
      throw new ServiceXmlSerializationException(
          "InvalidAttributeValue($stringValue, $localName)", ex, stacktrace);
    }
  }

  /// <summary>
  /// Writes String value.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <param name="name">Element name (used for error handling)</param>
  /// <exception cref="ServiceXmlSerializationException">Thrown if String value isn't valid for XML.</exception>
  void WriteValue(String? value, String? name) {
    try {
      this._xmlWriter!.WriteValue(value);
    } on ArgumentException catch (ex, stacktrace) {
      // XmlTextWriter will throw ArgumentException if String includes invalid characters.
      throw new ServiceXmlSerializationException(
          "InvalidElementStringValue($value, $name)", ex, stacktrace);
    }
  }

  /// <summary>
  /// Writes the element value.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">The local name of the element.</param>
  /// <param name="displayName">The name that should appear in the exception message when the value can not be serialized.</param>
  /// <param name="value">The value.</param>
  void WriteElementValue(XmlNamespace xmlNamespace, String? localName,
      String? displayName, Object? value) {
    String? stringValue;
    OutParam<String> strOut = new OutParam<String>();
    if (this.TryConvertObjectToString(value, strOut)) {
      stringValue = strOut.param;
      //  PS # 205106: The code here used to check IsNullOrEmpty on stringValue instead of just null.
      //  Unfortunately, that meant that if someone really needed to update a String property to be the

      //  an error on the server because an update is required to have a single sub-element that is the
      //  value to update.  So we need to allow an empty String to create an empty element (like <Value />).
      //  Note that changing this check to just check for null is fine, because the other types that get
      //  converted by TryConvertObjectToString() won't return an empty String if the conversion is
      //  successful (for instance, converting an integer to a String won't return an empty String - it'll
      //  always return the stringized integer).
      if (stringValue != null) {
        this.WriteStartElement(xmlNamespace, localName);
        this.WriteValue(stringValue, displayName);
        this.WriteEndElement();
      }
    } else {
      throw new ServiceXmlSerializationException(
          "ElementValueCannotBeSerialized(${value.runtimeType}, $localName)");
    }
  }

  /// <summary>
  /// Writes the Xml Node
  /// </summary>
  /// <param name="xmlNode">The XML node.</param>
  void WriteNode(XmlNode xmlNode) {
    if (xmlNode != null) {
      xmlNode.WriteTo(this._xmlWriter);
    }
  }

  /// <summary>
  /// Writes the element value.
  /// </summary>
  /// <param name="xmlNamespace">The XML namespace.</param>
  /// <param name="localName">The local name of the element.</param>
  /// <param name="value">The value.</param>
  void WriteElementValueWithNamespace(
      XmlNamespace xmlNamespace, String localName, Object? value) {
    this.WriteElementValue(xmlNamespace, localName, localName, value);
  }

  /// <summary>
  /// Writes the base64-encoded element value.
  /// </summary>
  /// <param name="buffer">The buffer.</param>
  void WriteBase64ElementValue(Uint8List buffer) {
    this._xmlWriter!.WriteValue(base64.encode(buffer));
  }

  /// <summary>
  /// Writes the base64-encoded element value.
  /// </summary>
  /// <param name="stream">The stream.</param>
// void WriteBase64ElementValue(Stream stream)
//        {
//            Uint8List buffer = new byte[BufferSize];
//            int bytesRead;
//
//
//            {
//                do
//                {
//                    bytesRead = reader.Read(buffer, 0, BufferSize);
//
//                    if (bytesRead > 0)
//                    {
//                        this.xmlWriter.WriteBase64(buffer, 0, bytesRead);
//                    }
//                }
//                while (bytesRead > 0);
//            }
//        }

  /// <summary>
  /// Gets the XML writer.
  /// </summary>
  /// <value>The writer.</value>
  XmlWriter? get InternalWriter => this._xmlWriter;

  /// <summary>
  /// Gets the service.
  /// </summary>
  /// <value>The service.</value>
  ExchangeServiceBase get Service => this._service;

  /// <summary>
  /// Gets or sets a value indicating whether the time zone SOAP header was emitted through this writer.
  /// </summary>
  /// <value>
  ///     <c>true</c> if the time zone SOAP header was emitted; otherwise, <c>false</c>.
  /// </value>
  bool get IsTimeZoneHeaderEmitted => this._isTimeZoneHeaderEmitted;

  set IsTimeZoneHeaderEmitted(bool value) {
    this._isTimeZoneHeaderEmitted = value;
  }

  /// <summary>
  /// Gets or sets a value indicating whether the SOAP message need WSSecurity Utility namespace.
  /// </summary>
  bool get RequireWSSecurityUtilityNamespace =>
      this._requireWSSecurityUtilityNamespace;

  set RequireWSSecurityUtilityNamespace(bool value) {
    this._requireWSSecurityUtilityNamespace = value;
  }
}
