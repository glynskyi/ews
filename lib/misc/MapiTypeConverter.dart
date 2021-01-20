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

import 'dart:convert';
import 'dart:typed_data';

import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Enumerations/MapiPropertyType.dart';
import 'package:ews/misc/MapiTypeConverterMapEntry.dart' as misc;

/// <summary>
/// Utility class to convert between MAPI Property type values and strings.
/// </summary>
class MapiTypeConverter {
  /// <summary>
  /// Assume DateTime values are in UTC.
  /// </summary>
//        /* private */ static const UtcDataTimeStyles = DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal;

  /// <summary>
  /// Map from MAPI property type to converter entry.
  /// </summary>
  /* private */
  static LazyMember<Map<MapiPropertyType, misc.MapiTypeConverterMapEntry>>
      MapiTypeConverterMap = new LazyMember(() {
    final map = new Map<MapiPropertyType, misc.MapiTypeConverterMapEntry>();

//                map[MapiPropertyType.ApplicationTime] = new misc.MapiTypeConverterMapEntry(typeof(double));
//
//                map[MapiPropertyType.ApplicationTimeArray] = new misc.MapiTypeConverterMapEntry(typeof(double)) { IsArray = true };

    var byteConverter = new misc.MapiTypeConverterMapEntry(Uint8List);
    byteConverter.Parse = (o) => base64.decode(o!);
    byteConverter.ConvertToString = (s) => base64.encode(s as List<int>);
    map[MapiPropertyType.Binary] = byteConverter;

    var intConverter = new misc.MapiTypeConverterMapEntry(int);
    intConverter.Parse = (o) => int.parse(o!);
    intConverter.ConvertToString = (s) => s.toString();
    map[MapiPropertyType.Integer] = intConverter;
    map[MapiPropertyType.Long] = intConverter;

//
//                var byteArrayConverter = new misc.MapiTypeConverterMapEntry(typeof(Uint8List))
//                    {
//                        Parse = (s) => StringUtils.IsNullOrEmpty(s) ? null : Convert.FromBase64String(s),
//                        ConvertToString = (o) => Convert.ToBase64String((Uint8List)o),
//                        IsArray = true
//                    };
//
//                map.add(
//                    MapiPropertyType.BinaryArray,
//                    byteArrayConverter);
//
    var boolConverter = new misc.MapiTypeConverterMapEntry(bool);
    boolConverter.Parse = (s) => s!.toLowerCase() == "true";
    boolConverter.ConvertToString = (o) => o.toString().toLowerCase();
    map[MapiPropertyType.Boolean] = boolConverter;

    var stringConverter = new misc.MapiTypeConverterMapEntry(String);
    stringConverter.Parse = (s) => s;
    stringConverter.ConvertToString = (o) => o.toString();
    map[MapiPropertyType.String] = stringConverter;
//
//                var clsidConverter = new misc.MapiTypeConverterMapEntry(typeof(Guid))
//                    {
//                        Parse = (s) => new Guid(s),
//                        ConvertToString = (o) => ((Guid)o).ToString(),
//                    };
//
//                map.add(
//                    MapiPropertyType.CLSID,
//                    clsidConverter);
//
//                var clsidArrayConverter = new misc.MapiTypeConverterMapEntry(typeof(Guid))
//                    {
//                        Parse = (s) => new Guid(s),
//                        ConvertToString = (o) => ((Guid)o).ToString(),
//                        IsArray = true
//                    };
//
//                map.add(
//                    MapiPropertyType.CLSIDArray,
//                    clsidArrayConverter);
//
//                map.add(
//                    MapiPropertyType.Currency,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int64)));
//
//                map.add(
//                    MapiPropertyType.CurrencyArray,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int64)) { IsArray = true });
//
//                map.add(
//                    MapiPropertyType.Double,
//                    new misc.MapiTypeConverterMapEntry(typeof(double)));
//
//                map.add(
//                    MapiPropertyType.DoubleArray,
//                    new misc.MapiTypeConverterMapEntry(typeof(double)) { IsArray = true });
//
//                map.add(
//                    MapiPropertyType.Error,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int32)));
//
//                map[MapiPropertyType.Float] = new misc.MapiTypeConverterMapEntry(typeof(float));
//
//                map.add(
//                    MapiPropertyType.FloatArray,
//                    new misc.MapiTypeConverterMapEntry(typeof(float)) { IsArray = true });
//
//                map.add(
//                    MapiPropertyType.Integer,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int32))
//                    {
//                        Parse = (s) => MapiTypeConverter.ParseMapiIntegerValue(s)
//                    });
//
//                map.add(
//                    MapiPropertyType.IntegerArray,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int32)) { IsArray = true });
//
//                map.add(
//                    MapiPropertyType.Long,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int64)));
//
//                map.add(
//                    MapiPropertyType.LongArray,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int64)) { IsArray = true });
//
//                var objectConverter = new misc.MapiTypeConverterMapEntry(typeof(string))
//                    {
//                        Parse = (s) => s
//                    };
//
//                map.add(
//                    MapiPropertyType.Object,
//                    objectConverter);
//
//                var objectArrayConverter = new misc.MapiTypeConverterMapEntry(typeof(string))
//                    {
//                        Parse = (s) => s,
//                        IsArray = true
//                    };
//
//                map.add(
//                    MapiPropertyType.ObjectArray,
//                    objectArrayConverter);
//
//                map.add(
//                    MapiPropertyType.Short,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int16)));
//
//                map.add(
//                    MapiPropertyType.ShortArray,
//                    new misc.MapiTypeConverterMapEntry(typeof(Int16)) { IsArray = true });
//
//                var stringConverter = new misc.MapiTypeConverterMapEntry(typeof(string))
//                    {
//                        Parse = (s) => s
//                    };
//
//                map.add(
//                    MapiPropertyType.String,
//                    stringConverter);
//
//                var stringArrayConverter = new misc.MapiTypeConverterMapEntry(typeof(string))
//                    {
//                        Parse = (s) => s,
//                        IsArray = true
//                    };
//
//                map.add(
//                    MapiPropertyType.StringArray,
//                    stringArrayConverter);
//
//                var sysTimeConverter = new misc.MapiTypeConverterMapEntry(typeof(DateTime))
//                    {
//                        Parse = (s) => DateTime.Parse(s, CultureInfo.InvariantCulture, UtcDataTimeStyles),
//                        ConvertToString = (o) => EwsUtilities.DateTimeToXSDateTime((DateTime)o) // Can't use DataTime.ToString()
//                    };
//
//                map.add(
//                    MapiPropertyType.SystemTime,
//                    sysTimeConverter);
//
//                var sysTimeArrayConverter = new misc.MapiTypeConverterMapEntry(typeof(DateTime))
//                    {
//                        IsArray = true,
//                        Parse = (s) => DateTime.Parse(s, CultureInfo.InvariantCulture, UtcDataTimeStyles),
//                        ConvertToString = (o) => EwsUtilities.DateTimeToXSDateTime((DateTime)o) // Can't use DataTime.ToString()
//                    };
//
//                map.add(
//                    MapiPropertyType.SystemTimeArray,
//                    sysTimeArrayConverter);

    return map;
  });

  /// <summary>
  /// Converts the String list to array.
  /// </summary>
  /// <param name="mapiPropType">Type of the MAPI property.</param>
  /// <param name="strings">Strings.</param>
  /// <returns>Array of objects.</returns>
  static List ConvertToValue(
      MapiPropertyType? mapiPropType, Iterable<String?> strings) {
    // todo("implement ConvertToValue")
    print("implement ConvertToValue");
    return [];
//            EwsUtilities.ValidateParam(strings, "strings");
//
//            misc.MapiTypeConverterMapEntry typeConverter = misc.MapiTypeConverterMap[mapiPropType];
//            Array array = Array.CreateInstance(typeConverter.Type, strings.Count<string>());
//
//            int index = 0;
//            for (String stringValue in strings)
//            {
//                object value = typeConverter.ConvertToValueOrDefault(stringValue);
//                array.SetValue(value, index++);
//            }
//
//            return array;
  }

  /// <summary>
  /// Converts a String to value consistent with MAPI type.
  /// </summary>
  /// <param name="mapiPropType">Type of the MAPI property.</param>
  /// <param name="stringValue">String to convert to a value.</param>
  /// <returns></returns>
  static Object? ConvertToValueWithStringValue(
      MapiPropertyType? mapiPropType, String? stringValue) {
    if (!MapiTypeConverterMap.Member!.containsKey(mapiPropType)) {
      throw UnsupportedError(
          "!!! ConvertToValueWithStringValue($mapiPropType)");
    }
    return MapiTypeConverterMap.Member![mapiPropType!]!
        .ConvertToValue(stringValue);
  }

  /// <summary>
  /// Converts a value to a string.
  /// </summary>
  /// <param name="mapiPropType">Type of the MAPI property.</param>
  /// <param name="value">Value to convert to string.</param>
  /// <returns>String value.</returns>
  static String ConvertToString(MapiPropertyType? mapiPropType, Object? value) {
    return (value == null)
        ? ""
        : MapiTypeConverterMap.Member![mapiPropType!]!.ConvertToString(value);
  }

  /// <summary>
  /// Change value to a value of compatible type.
  /// </summary>
  /// <param name="mapiType">Type of the mapi property.</param>
  /// <param name="value">The value.</param>
  /// <returns>Compatible value.</returns>
  static Object? ChangeType(MapiPropertyType? mapiType, Object? value) {
    EwsUtilities.ValidateParam(value, "value");

    return MapiTypeConverterMap.Member![mapiType!]!.ChangeType(value);
  }

  /// <summary>
  /// Converts a MAPI Integer value.
  /// </summary>
  /// <remarks>
  /// Usually the value is an integer but there are cases where the value has been "schematized" to an
  /// Enumeration value (e.g. NoData) which we have no choice but to fallback and represent as a string.
  /// </remarks>
  /// <param name="s">The String value.</param>
  /// <returns>Integer value or the original String if the value could not be parsed as such.</returns>
//        static object ParseMapiIntegerValue(String s)
//        {
//            int intValue;
//            if (Int32.TryParse(s, NumberStyles.Integer, CultureInfo.InvariantCulture, out intValue))
//            {
//                return intValue;
//            }
//            else
//            {
//                return s;
//            }
//        }

  /// <summary>
  /// Determines whether MapiPropertyType is an array type.
  /// </summary>
  /// <param name="mapiType">Type of the mapi.</param>
  /// <returns>True if this is an array type.</returns>
  static bool IsArrayType(MapiPropertyType? mapiType) {
    return MapiTypeConverterMap.Member![mapiType!]!.IsArray;
  }

  /// <summary>
  /// Gets the MAPI type converter map.
  /// </summary>
  /// <value>The MAPI type converter map.</value>
//        static misc.MapiTypeConverterMap get MapiTypeConverterMap => misc.MapiTypeConverterMap.Member;
}
