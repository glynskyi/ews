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

import 'dart:core';
import 'dart:core' as core;
import 'dart:typed_data';

import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Exceptions/ArgumentNullException.dart';
import 'package:ews/misc/Uuid.dart';

typedef R Func<T, R>(T arg);

/// <summary>
/// Represents an entry in the MapiTypeConverter map.
/// </summary>
class MapiTypeConverterMapEntry {
  /// <summary>
  /// Map CLR types used for MAPI properties to matching default values.
  /// </summary>
  /* private */
  static LazyMember<Map<core.Type, Object>> defaultValueMap =
      new LazyMember<Map<core.Type, Object>>(() {
    Map<core.Type, Object> map = new Map<core.Type, Object>();

    map[bool] = false;
//                map.Add(typeof(Uint8List), null);
    map[Uint8List] = null;
    map[int] = 0;
    map[double] = 0.0;
    map[DateTime] = DateTime.fromMicrosecondsSinceEpoch(0);
//                map.Add(typeof(Int32), (Int32)0);
//                map.Add(typeof(Int64), (Int64)0);
//                map[double], (float)0.0);
//                map.Add(typeof(double), (double)0.0);
//                map.Add(typeof(DateTime), DateTime.MinValue);
    map[Uuid] = null;
    map[String] = null;

    return map;
  });

  /// <summary>
  /// Initializes a new instance of the <see cref="MapiTypeConverterMapEntry"/> class.
  /// </summary>
  /// <param name="type">The type.</param>
  /// <remarks>
  /// By default, converting a type to String is done by calling value.ToString. Instances
  /// can override this behavior.
  /// By default, converting a String to the appropriate value type is done by calling Convert.ChangeType
  /// Instances may override this behavior.
  /// </remarks>
  MapiTypeConverterMapEntry(core.Type type) {
    EwsUtilities.Assert(
      defaultValueMap.Member.containsKey(type),
      "MapiTypeConverterMapEntry ctor",
      "No default value entry for type ${type.toString()}",
    );

    this.Type = type;
//            this.ConvertToString = (o) => (string)Convert.ChangeType(o, typeof(string), CultureInfo.InvariantCulture);
//            this.Parse = (s) => Convert.ChangeType(s, type, CultureInfo.InvariantCulture);
  }

  /**
   * Change value to a value of compatible type.
   * <p/>
   * The type of a simple value should match exactly or be convertible to the
   * appropriate type. An array value has to be a single dimension (rank),
   * contain at least one value and contain elements that exactly match the
   * expected type. (We could relax this last requirement so that, for
   * example, you could pass an array of Int32 that could be converted to an
   * array of Double but that seems like overkill).
   *
   * @param value The value.
   * @return New value.
   * @throws Exception the exception
   */
  Object ChangeType(Object value) {
    if (this.IsArray) {
      this.ValidateValueAsArray(value);
      return value;
    } else if (value.runtimeType == this.Type) {
      return value;
    } else {
      try {
        if (this.Type is int) {
          Object o = null;
          o = int.parse(value.toString());
          return o;
        } else if (this.Type == DateTime) {
//                DateFormat df = new SimpleDateFormat(
//                "yyyy-MM-dd'T'HH:mm:ss'Z'");
//                return df.parse(value + "");
          return DateTime.parse(value.toString());
        } else if (this.Type == bool) {
          return value.toString().toLowerCase() == "true";
        } else if (this.Type == String) {
          return value.toString();
        }
        return null;
      } on Exception {
        throw ArgumentException(
            "The value '$value' of type ${value?.runtimeType} can't be converted to a value of type ${this.Type}.");
      }
    }
  }

  /// <summary>
  /// Change value to a value of compatible type.
  /// </summary>
  /// <param name="value">The value.</param>
  /// <returns>New value.</returns>
  /// <remarks>
  /// The type of a simple value should match exactly or be convertible to the appropriate type. An
  /// array value has to be a single dimension (rank), contain at least one value and contain
  /// elements that exactly match the expected type. (We could relax this last requirement so that,
  /// for example, you could pass an array of Int32 that could be converted to an array of Double
  /// but that seems like overkill).
  /// </remarks>
//        Object ChangeType(Object value)
//        {
//            if (this.IsArray)
//            {
//                this.ValidateValueAsArray(value);
//                return value;
//            }
//            else if (value.runtimeType == this.Type)
//            {
//                return value;
//            }
//            else
//            {
//                try
//                {
//                    return Convert.ChangeType(value, this.Type, CultureInfo.InvariantCulture);
//                }
//                catch (InvalidCastException ex)
//                {
//                    throw new ArgumentException(
//                        string.Format(
//                            Strings.ValueOfTypeCannotBeConverted,
//                            value,
//                            value.GetType(),
//                            this.Type),
//                        ex);
//                }
//            }
//        }

  /// <summary>
  /// Converts a String to value consistent with type.
  /// </summary>
  /// <param name="stringValue">String to convert to a value.</param>
  /// <returns>Value.</returns>
  Object ConvertToValue(String stringValue) {
//            try
//            {
    return this.Parse(stringValue);
//            }
//            catch (FormatException ex)
//            {
//                throw new ServiceXmlDeserializationException(
//                    string.Format(
//                        Strings.ValueCannotBeConverted,
//                        stringValue,
//                        this.Type),
//                    ex);
//            }
//            catch (InvalidCastException ex)
//            {
//                throw new ServiceXmlDeserializationException(
//                    string.Format(
//                        Strings.ValueCannotBeConverted,
//                        stringValue,
//                        this.Type),
//                    ex);
//            }
//            catch (OverflowException ex)
//            {
//                throw new ServiceXmlDeserializationException(
//                    string.Format(
//                        Strings.ValueCannotBeConverted,
//                        stringValue,
//                        this.Type),
//                    ex);
//            }
  }

  /// <summary>
  /// Converts a String to value consistent with type (or uses the default value if the String is null or empty).
  /// </summary>
  /// <param name="stringValue">String to convert to a value.</param>
  /// <returns>Value.</returns>
  /// <remarks>For array types, this method is called for each array element.</remarks>
//        object ConvertToValueOrDefault(String stringValue)
//        {
//            return StringUtils.IsNullOrEmpty(stringValue) ? this.DefaultValue : this.ConvertToValue(stringValue);
//        }

  /// <summary>
  /// Validates array value.
  /// </summary>
  /// <param name="value">The value.</param>
  void ValidateValueAsArray(Object value) {
    if (value == null) {
      throw new ArgumentNullException("value");
    }

    if (value is List) {
      if (value.isEmpty) {
        ArgumentException("The Array value must have at least one element.");
      }
      if (value.first.runtimeType != this.Type) {
        throw new ArgumentException(
            "Type ${value.runtimeType} can't be used as an array of type ${this.Type}.");
      }
    }
  }

//        /* private */ void ValidateValueAsArray(object value)
//        {
//            Array array = value as Array;
//            if (array == null)
//            {
//                throw new ArgumentException(
//                    string.Format(
//                        Strings.IncompatibleTypeForArray,
//                        value.GetType(),
//                        this.Type));
//            }
//            else if (array.Rank != 1)
//            {
//                throw new ArgumentException(Strings.ArrayMustHaveSingleDimension);
//            }
//            else if (array.Length == 0)
//            {
//                throw new ArgumentException(Strings.ArrayMustHaveAtLeastOneElement);
//            }
//            else if (array.GetType().GetElementType() != this.Type)
//            {
//                throw new ArgumentException(
//                    string.Format(
//                        Strings.IncompatibleTypeForArray,
//                        value.GetType(),
//                        this.Type));
//            }
//        }

  /// <summary>
  /// Gets or sets the String parser.
  /// </summary>
  /// <remarks>For array types, this method is called for each array element.</remarks>
  Func<String, Object> Parse;

//        Func<string, object> Parse
//        {
//            get; set;
//        }

  /// <summary>
  /// Gets or sets the String to object converter.
  /// </summary>
  /// <remarks>For array types, this method is called for each array element.</remarks>
  Func<Object, String> ConvertToString;

//        Func<object, string> ConvertToString
//        {
//            get; set;
//        }

  /// <summary>
  /// Gets or sets the type.
  /// </summary>
  /// <remarks>For array types, this is the type of an element.</remarks>
  core.Type Type;

  /// <summary>
  /// Gets or sets a value indicating whether this instance is array.
  /// </summary>
  /// <value><c>true</c> if this instance is array; otherwise, <c>false</c>.</value>
  bool IsArray = false;

  /// <summary>
  /// Gets the default value for the type.
  /// </summary>
  Object get DefaultValue => defaultValueMap.Member[this.Type];
}
