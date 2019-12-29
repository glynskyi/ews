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
import 'package:ews/ComplexProperties/PersonaPostalAddress.dart' as complex;
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents Enhanced Location.
/// </summary>
class EnhancedLocation extends ComplexProperty {
  String _displayName;
  String _annotation;
  complex.PersonaPostalAddress _personaPostalAddress;

  /// <summary>
  /// Initializes a new instance of the <see cref="EnhancedLocation"/> class.
  /// </summary>
  EnhancedLocation() : super() {}

  // todo : restore constructors

  /// <summary>
  /// Initializes a new instance of the <see cref="EnhancedLocation"/> class.
  /// </summary>
  /// <param name="displayName">The location DisplayName.</param>
// EnhancedLocation(String displayName)
//            : this(displayName, String.Empty, new complex.PersonaPostalAddress())
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="EnhancedLocation"/> class.
  /// </summary>
  /// <param name="displayName">The location DisplayName.</param>
  /// <param name="annotation">The annotation on the location.</param>
// EnhancedLocation(String displayName, String annotation)
//            : this(displayName, annotation, new complex.PersonaPostalAddress())
//        {
//        }

  /// <summary>
  /// Initializes a new instance of the <see cref="EnhancedLocation"/> class.
  /// </summary>
  /// <param name="displayName">The location DisplayName.</param>
  /// <param name="annotation">The annotation on the location.</param>
  /// <param name="personaPostalAddress">The persona postal address.</param>
// EnhancedLocation(String displayName, String annotation, complex.PersonaPostalAddress personaPostalAddress)
//            : this()
//        {
//            this.displayName = displayName;
//            this.annotation = annotation;
//            this.personaPostalAddress = personaPostalAddress;
//            this.personaPostalAddress.OnChange += new ComplexPropertyChangedDelegate(PersonaPostalAddress_OnChange);
//        }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.LocationDisplayName:
        this._displayName = reader.ReadValue<String>();
        return true;
      case XmlElementNames.LocationAnnotation:
        this._annotation = reader.ReadValue<String>();
        return true;
      case XmlElementNames.PersonaPostalAddress:
        this._personaPostalAddress = new complex.PersonaPostalAddress();
        this._personaPostalAddress.LoadFromXmlElementName(reader);
        this
            ._personaPostalAddress
            .addOnChangeEvent(_PersonaPostalAddress_OnChange);
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Gets or sets the Location DisplayName.
  /// </summary>
  String get DisplayName => this._displayName;

  set DisplayName(String value) {
    if (this.CanSetFieldValue(this._displayName, value)) {
      this._displayName = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the Location Annotation.
  /// </summary>
  String get Annotation => this._annotation;

  set Annotation(String value) {
    if (this.CanSetFieldValue(this._annotation, value)) {
      this._annotation = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the Persona Postal Address.
  /// </summary>
//    complex.PersonaPostalAddress PersonaPostalAddress
//        {
//            get { return this.personaPostalAddress; }
//            set
//            {
//                if (!this.personaPostalAddress.Equals(value))
//                {
//                    if (this.personaPostalAddress != null)
//                    {
//                        this.personaPostalAddress.OnChange -= new ComplexPropertyChangedDelegate(PersonaPostalAddress_OnChange);
//                    }
//
//                    this.SetFieldValue<PersonaPostalAddress>(ref this.personaPostalAddress, value);
//
//                    this.personaPostalAddress.OnChange += new ComplexPropertyChangedDelegate(PersonaPostalAddress_OnChange);
//                }
//            }
//        }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteElementValueWithNamespace(XmlNamespace.Types,
        XmlElementNames.LocationDisplayName, this._displayName);
    writer.WriteElementValueWithNamespace(XmlNamespace.Types,
        XmlElementNames.LocationAnnotation, this._annotation);
    this._personaPostalAddress.WriteToXmlElementName(writer);
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  @override
  void InternalValidate() {
    super.InternalValidate();
    EwsUtilities.ValidateParam(this._displayName, "DisplayName");
    EwsUtilities.ValidateParamAllowNull(this._annotation, "Annotation");
    EwsUtilities.ValidateParamAllowNull(
        this._personaPostalAddress, "PersonaPostalAddress");
  }

  /// <summary>
  /// PersonaPostalAddress OnChange.
  /// </summary>
  /// <param name="complexProperty">ComplexProperty object.</param>
  void _PersonaPostalAddress_OnChange(ComplexProperty complexProperty) {
    this.Changed();
  }
}
