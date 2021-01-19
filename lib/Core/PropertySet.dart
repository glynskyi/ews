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

import 'dart:collection';

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/LazyMember.dart';
import 'package:ews/Core/Requests/ServiceRequestBase.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/BasePropertySet.dart' as enumerations;
import 'package:ews/Enumerations/BodyType.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/ServiceObjectType.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/NotSupportedException.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/Interfaces/ISelfValidate.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/misc/StringUtils.dart';

/// <summary>
/// Represents a set of item or folder properties. Property sets are used to indicate what properties of an item or
/// folder should be loaded when binding to an existing item or folder or when loading an item or folder's properties.
/// </summary>
class PropertySet
    with IterableMixin<PropertyDefinitionBase>
    implements ISelfValidate, Iterable<PropertyDefinitionBase> {
  /// <summary>
  /// Returns a predefined property set that only includes the Id property.
  /// </summary>
  static PropertySet IdOnly = PropertySet._CreateReadonlyPropertySet(
      enumerations.BasePropertySet.IdOnly);

  /// <summary>
  /// Returns a predefined property set that includes the first class properties of an item or folder.
  /// </summary>
  static PropertySet FirstClassProperties =
      PropertySet._CreateReadonlyPropertySet(
          enumerations.BasePropertySet.FirstClassProperties);

  /// <summary>
  /// Maps BasePropertySet values to EWS's BaseShape values.
  /// </summary>
  static LazyMember<Map<enumerations.BasePropertySet, String>>
      _defaultPropertySetMap =
      new LazyMember<Map<enumerations.BasePropertySet, String>>(() {
    Map<enumerations.BasePropertySet, String> result =
        new Map<enumerations.BasePropertySet, String>();
    result[enumerations.BasePropertySet.IdOnly] = "IdOnly";
    result[enumerations.BasePropertySet.FirstClassProperties] = "AllProperties";
    return result;
  });

  /// <summary>
  /// The base property set this property set is based upon.
  /// </summary>
  enumerations.BasePropertySet _basePropertySet;

  /// <summary>
  /// The list of additional properties included in this property set.
  /// </summary>
  List<PropertyDefinitionBase> _additionalProperties =
      <PropertyDefinitionBase>[];

  /// <summary>
  /// The requested body type for get and find operations. If null, the "best body" is returned.
  /// </summary>
  BodyType _requestedBodyType;

  /// <summary>
  /// The requested unique body type for get and find operations. If null, the should return the same value as body type.
  /// </summary>
  BodyType _requestedUniqueBodyType;

  /// <summary>
  /// The requested normalized body type for get and find operations. If null, the should return the same value as body type.
  /// </summary>
  BodyType _requestedNormalizedBodyType;

  /// <summary>
  /// Value indicating whether or not the server should filter HTML content.
  /// </summary>
  bool _filterHtml;

  /// <summary>
  /// Value indicating whether or not the server should convert HTML code page to UTF8.
  /// </summary>
  bool _convertHtmlCodePageToUTF8;

  /// <summary>
  /// Value of the URL template to use for the src attribute of inline IMG elements.
  /// </summary>
  String _inlineImageUrlTemplate;

  /// <summary>
  /// Value indicating whether or not the server should block references to external images.
  /// </summary>
  bool _blockExternalImages;

  /// <summary>
  /// Value indicating whether or not to add a blank target attribute to anchor links.
  /// </summary>
  bool _addTargetToLinks;

  /// <summary>
  /// Value indicating whether or not this PropertySet can be modified.
  /// </summary>
  bool _isReadOnly = false;

  /// <summary>
  /// Value indicating the maximum body size to retrieve.
  /// </summary>
  int _maximumBodySize;

  /// <summary>
  /// Initializes a new instance of PropertySet.
  /// </summary>
  /// <param name="basePropertySet">The base property set to base the property set upon.</param>
  /// <param name="additionalProperties">Additional properties to include in the property set. Property definitions are available as static members from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)</param>
  PropertySet(enumerations.BasePropertySet basePropertySet,
      Iterable<PropertyDefinitionBase> additionalProperties) {
    this._basePropertySet = basePropertySet;

    if (additionalProperties != null) {
      this._additionalProperties.addAll(additionalProperties);
    }
  }

  /// <summary>
  /// Initializes a new instance of PropertySet based upon BasePropertySet.IdOnly.
  /// </summary>
  PropertySet.idOnly() : this(enumerations.BasePropertySet.IdOnly, null);

  /// <summary>
  /// Initializes a new instance of PropertySet.
  /// </summary>
  /// <param name="basePropertySet">The base property set to base the property set upon.</param>
  PropertySet.fromPropertySet(enumerations.BasePropertySet basePropertySet)
      : this(basePropertySet, null);

  /// <summary>
  /// Initializes a new instance of PropertySet based upon BasePropertySet.IdOnly.
  /// </summary>
  /// <param name="additionalProperties">Additional properties to include in the property set. Property definitions are available as static members from schema classes (for example, EmailMessageSchema.Subject, AppointmentSchema.Start, ContactSchema.GivenName, etc.)</param>
  PropertySet.fromPropertyDefinitions(
      List<PropertyDefinitionBase> additionalProperties)
      : this(enumerations.BasePropertySet.IdOnly, additionalProperties);

  /// <summary>
  /// Implements an implicit conversion between PropertySet and BasePropertySet.
  /// </summary>
  /// <param name="basePropertySet">The BasePropertySet value to convert from.</param>
  /// <returns>A PropertySet instance based on the specified base property set.</returns>
// static implicit operator PropertySet(BasePropertySet basePropertySet)
//        {
//            return new PropertySet(basePropertySet);
//        }

  /// <summary>
  /// Adds the specified property to the property set.
  /// </summary>
  /// <param name="property">The property to add.</param>
  void Add(PropertyDefinitionBase property) {
    this._ThrowIfReadonly();
//            EwsUtilities.ValidateParam(property, "property");

    if (!this._additionalProperties.contains(property)) {
      this._additionalProperties.add(property);
    }
  }

  /// <summary>
  /// Adds the specified properties to the property set.
  /// </summary>
  /// <param name="properties">The properties to add.</param>
  void AddRange(Iterable<PropertyDefinitionBase> properties) {
    this._ThrowIfReadonly();
//            EwsUtilities.ValidateParamCollection(properties, "properties");

    for (PropertyDefinitionBase property in properties) {
      this.Add(property);
    }
  }

  /// <summary>
  /// Remove all explicitly added properties from the property set.
  /// </summary>
  void Clear() {
    this._ThrowIfReadonly();
    this._additionalProperties.clear();
  }

  /// <summary>
  /// Creates a read-only PropertySet.
  /// </summary>
  /// <param name="basePropertySet">The base property set.</param>
  /// <returns>PropertySet</returns>
  static PropertySet _CreateReadonlyPropertySet(
      enumerations.BasePropertySet basePropertySet) {
    PropertySet propertySet = new PropertySet.fromPropertySet(basePropertySet);
    propertySet._isReadOnly = true;
    return propertySet;
  }

  /// <summary>
  /// Gets the name of the shape.
  /// </summary>
  /// <param name="serviceObjectType">Type of the service object.</param>
  /// <returns>Shape name.</returns>
  static String _GetShapeName(ServiceObjectType serviceObjectType) {
    switch (serviceObjectType) {
      case ServiceObjectType.Item:
        return XmlElementNames.ItemShape;
      case ServiceObjectType.Folder:
        return XmlElementNames.FolderShape;
      case ServiceObjectType.Conversation:
        return XmlElementNames.ConversationShape;
      case ServiceObjectType.Persona:
        return XmlElementNames.PersonaShape;
      default:
        EwsUtilities.Assert(false, "PropertySet.GetShapeName",
            "An unexpected object type $serviceObjectType for property shape. This code path should never be reached.");
        return "";
    }
  }

  /// <summary>
  /// Throws if readonly property set.
  /// </summary>
  void _ThrowIfReadonly() {
    if (this._isReadOnly) {
      throw new NotSupportedException("Strings.PropertySetCannotBeModified");
    }
  }

  /// <summary>

  /// </summary>
  /// <param name="property">The property.</param>
  /// <returns>
  ///     <c>true</c> if this property set contains the specified propert]; otherwise, <c>false</c>.
  /// </returns>
  bool Contains(PropertyDefinitionBase property) {
    return this._additionalProperties.contains(property);
  }

  /// <summary>
  /// Removes the specified property from the set.
  /// </summary>
  /// <param name="property">The property to remove.</param>
  /// <returns>true if the property was successfully removed, false otherwise.</returns>
  bool Remove(PropertyDefinitionBase property) {
    this._ThrowIfReadonly();
    return this._additionalProperties.remove(property);
  }

  /// <summary>
  /// Gets or sets the base property set the property set is based upon.
  /// </summary>
  enumerations.BasePropertySet get BasePropertySet => this._basePropertySet;

  set BasePropertySet(enumerations.BasePropertySet value) {
    this._ThrowIfReadonly();
    this._basePropertySet = value;
  }

  /// <summary>
  /// Gets or sets type of body that should be loaded on items. If RequestedBodyType is null, body is returned as HTML if available, plain text otherwise.
  /// </summary>
  BodyType get RequestedBodyType => this._requestedBodyType;

  set RequestedBodyType(BodyType value) {
    this._ThrowIfReadonly();
    this._requestedBodyType = value;
  }

  /// <summary>
  /// Gets or sets type of body that should be loaded on items. If null, the should return the same value as body type.
  /// </summary>
  BodyType get RequestedUniqueBodyType => this._requestedUniqueBodyType;

  set RequestedUniqueBodyType(BodyType value) {
    this._ThrowIfReadonly();
    this._requestedUniqueBodyType = value;
  }

  /// <summary>
  /// Gets or sets type of normalized body that should be loaded on items. If null, the should return the same value as body type.
  /// </summary>
  BodyType get RequestedNormalizedBodyType => this._requestedNormalizedBodyType;

  set RequestedNormalizedBodyType(BodyType value) {
    this._ThrowIfReadonly();
    this._requestedNormalizedBodyType = value;
  }

  /// <summary>
  /// Gets the number of explicitly added properties in this set.
  /// </summary>
  int get Count => this._additionalProperties.length;

  /// <summary>
  /// Gets or sets value indicating whether or not to filter potentially unsafe HTML content from message bodies.
  /// </summary>
  bool get FilterHtmlContent => this._filterHtml;

  set FilterHtmlContent(bool value) {
    this._ThrowIfReadonly();
    this._filterHtml = value;
  }

  /// <summary>
  /// Gets or sets value indicating whether or not to convert HTML code page to UTF8 encoding.
  /// </summary>
  bool get ConvertHtmlCodePageToUTF8 => this._convertHtmlCodePageToUTF8;

  set ConvertHtmlCodePageToUTF8(bool value) {
    this._ThrowIfReadonly();
    this._convertHtmlCodePageToUTF8 = value;
  }

  /// <summary>
  /// Gets or sets a value of the URL template to use for the src attribute of inline IMG elements.
  /// </summary>
  String get InlineImageUrlTemplate => this._inlineImageUrlTemplate;

  set InlineImageUrlTemplate(String value) {
    this._ThrowIfReadonly();
    this._inlineImageUrlTemplate = value;
  }

  /// <summary>
  /// Gets or sets value indicating whether or not to convert inline images to data URLs.
  /// </summary>
  bool get BlockExternalImages => this._blockExternalImages;

  set BlockExternalImages(bool value) {
    this._ThrowIfReadonly();
    this._blockExternalImages = value;
  }

  /// <summary>
  /// Gets or sets value indicating whether or not to add blank target attribute to anchor links.
  /// </summary>
  bool get AddBlankTargetToLinks => this._addTargetToLinks;

  set AddBlankTargetToLinks(bool value) {
    this._ThrowIfReadonly();
    this._addTargetToLinks = value;
  }

  /// <summary>
  /// Gets or sets the maximum size of the body to be retrieved.
  /// </summary>
  /// <value>
  /// The maximum size of the body to be retrieved.
  /// </value>
  int get MaximumBodySize => this._maximumBodySize;

  set MaximumBodySize(int value) {
    this._ThrowIfReadonly();
    this._maximumBodySize = value;
  }

  /// <summary>
  /// Gets the <see cref="Microsoft.Exchange.WebServices.Data.PropertyDefinitionBase"/> at the specified index.
  /// </summary>
  /// <param name="index">Index.</param>
  PropertyDefinitionBase operator [](int index) =>
      this._additionalProperties[index];

  /// <summary>
  /// Implements ISelfValidate.Validate. Validates this property set.
  /// </summary>
  void Validate() {
    this.InternalValidate();
  }

  /// <summary>
  /// Maps BasePropertySet values to EWS's BaseShape values.
  /// </summary>
  static LazyMember<Map<enumerations.BasePropertySet, String>>
      get DefaultPropertySetMap => PropertySet._defaultPropertySetMap;

  /// <summary>
  /// Writes additonal properties to XML.
  /// </summary>
  /// <param name="writer">The writer to write to.</param>
  /// <param name="propertyDefinitions">The property definitions to write.</param>
  static void WriteAdditionalPropertiesToXml(EwsServiceXmlWriter writer,
      Iterable<PropertyDefinitionBase> propertyDefinitions) {
    writer.WriteStartElement(
        XmlNamespace.Types, XmlElementNames.AdditionalProperties);

    for (PropertyDefinitionBase propertyDefinition in propertyDefinitions) {
      propertyDefinition.WriteToXml(writer);
    }

    writer.WriteEndElement();
  }

  /// <summary>
  /// Validates this property set.
  /// </summary>
  void InternalValidate() {
    for (int i = 0; i < this._additionalProperties.length; i++) {
      if (this._additionalProperties[i] == null) {
        throw new ServiceValidationException("AdditionalPropertyIsNull($i)");
      }
    }
  }

  /// <summary>
  /// Validates this property set instance for request to ensure that:
  /// 1. Properties are valid for the request server version.
  /// 2. If only summary properties are legal for this request (e.g. FindItem) then only summary properties were specified.
  /// </summary>
  /// <param name="request">The request.</param>
  /// <param name="summaryPropertiesOnly">if set to <c>true</c> then only summary properties are allowed.</param>
  void ValidateForRequest(
      ServiceRequestBase request, bool summaryPropertiesOnly) {
    for (PropertyDefinitionBase propDefBase in this._additionalProperties) {
      if (propDefBase is PropertyDefinition) {
        PropertyDefinition propertyDefinition =
            propDefBase as PropertyDefinition;
        if (propertyDefinition.Version.index >
            request.Service.RequestedServerVersion.index) {
          throw new ServiceVersionException("""string.Format(
                                Strings.PropertyIncompatibleWithRequestVersion,
                                propertyDefinition.Name,
                                propertyDefinition.Version)""");
        }

        if (summaryPropertiesOnly &&
            !propertyDefinition.HasFlag(PropertyDefinitionFlags.CanFind,
                request.Service.RequestedServerVersion)) {
          throw new ServiceValidationException("""string.Format(
                                Strings.NonSummaryPropertyCannotBeUsed,
                                propertyDefinition.Name,
                                request.GetXmlElementName())""");
        }
      }
    }

    if (this.FilterHtmlContent != null) {
      if (request.Service.RequestedServerVersion.index <
          ExchangeVersion.Exchange2010.index) {
        throw new ServiceVersionException("""string.Format(
                            Strings.PropertyIncompatibleWithRequestVersion,
                            "FilterHtmlContent",
                            ExchangeVersion.Exchange2010)""");
      }
    }

    if (this.ConvertHtmlCodePageToUTF8 != null) {
      if (request.Service.RequestedServerVersion.index <
          ExchangeVersion.Exchange2010_SP1.index) {
        throw new ServiceVersionException("""string.Format(
                            Strings.PropertyIncompatibleWithRequestVersion,
                            "ConvertHtmlCodePageToUTF8",
                            ExchangeVersion.Exchange2010_SP1)""");
      }
    }

    if (!StringUtils.IsNullOrEmpty(this.InlineImageUrlTemplate)) {
      if (request.Service.RequestedServerVersion.index <
          ExchangeVersion.Exchange2013.index) {
        throw new ServiceVersionException("""string.Format(
                            Strings.PropertyIncompatibleWithRequestVersion,
                            "InlineImageUrlTemplate",
                            ExchangeVersion.Exchange2013.index)""");
      }
    }

    if (this.BlockExternalImages != null) {
      if (request.Service.RequestedServerVersion.index <
          ExchangeVersion.Exchange2013.index) {
        throw new ServiceVersionException("""string.Format(
                            Strings.PropertyIncompatibleWithRequestVersion,
                            "BlockExternalImages",
                            ExchangeVersion.Exchange2013.index)""");
      }
    }

    if (this.AddBlankTargetToLinks != null) {
      if (request.Service.RequestedServerVersion.index <
          ExchangeVersion.Exchange2013.index) {
        throw new ServiceVersionException("""string.Format(
                            Strings.PropertyIncompatibleWithRequestVersion,
                            "AddTargetToLinks",
                            ExchangeVersion.Exchange2013.index)""");
      }
    }

    if (this.MaximumBodySize != null) {
      if (request.Service.RequestedServerVersion.index <
          ExchangeVersion.Exchange2013.index) {
        throw new ServiceVersionException("""string.Format(
                            Strings.PropertyIncompatibleWithRequestVersion,
                            "MaximumBodySize",
                            ExchangeVersion.Exchange2013.index)""");
      }
    }
  }

  /// <summary>
  /// Writes the property set to XML.
  /// </summary>
  /// <param name="writer">The writer to write to.</param>
  /// <param name="serviceObjectType">The type of service object the property set is emitted for.</param>
  void WriteToXml(
      EwsServiceXmlWriter writer, ServiceObjectType serviceObjectType) {
    String shapeElementName = _GetShapeName(serviceObjectType);

    writer.WriteStartElement(XmlNamespace.Messages, shapeElementName);

    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types,
        XmlElementNames.BaseShape,
        _defaultPropertySetMap.Member[this.BasePropertySet]);

    if (serviceObjectType == ServiceObjectType.Item) {
      if (this.RequestedBodyType != null) {
        writer.WriteElementValueWithNamespace(XmlNamespace.Types,
            XmlElementNames.BodyType, this.RequestedBodyType);
      }

      if (this.RequestedUniqueBodyType != null) {
        writer.WriteElementValueWithNamespace(XmlNamespace.Types,
            XmlElementNames.UniqueBodyType, this.RequestedUniqueBodyType);
      }

      if (this.RequestedNormalizedBodyType != null) {
        writer.WriteElementValueWithNamespace(
            XmlNamespace.Types,
            XmlElementNames.NormalizedBodyType,
            this.RequestedNormalizedBodyType);
      }

      if (this.FilterHtmlContent != null) {
        writer.WriteElementValueWithNamespace(XmlNamespace.Types,
            XmlElementNames.FilterHtmlContent, this.FilterHtmlContent);
      }

      if (this.ConvertHtmlCodePageToUTF8 != null &&
          writer.Service.RequestedServerVersion.index >=
              ExchangeVersion.Exchange2010_SP1.index) {
        writer.WriteElementValueWithNamespace(
            XmlNamespace.Types,
            XmlElementNames.ConvertHtmlCodePageToUTF8,
            this.ConvertHtmlCodePageToUTF8);
      }

      if (!StringUtils.IsNullOrEmpty(this.InlineImageUrlTemplate) &&
          writer.Service.RequestedServerVersion.index >=
              ExchangeVersion.Exchange2013.index) {
        writer.WriteElementValueWithNamespace(
            XmlNamespace.Types,
            XmlElementNames.InlineImageUrlTemplate,
            this.InlineImageUrlTemplate);
      }

      if (this.BlockExternalImages != null &&
          writer.Service.RequestedServerVersion.index >=
              ExchangeVersion.Exchange2013.index) {
        writer.WriteElementValueWithNamespace(XmlNamespace.Types,
            XmlElementNames.BlockExternalImages, this.BlockExternalImages);
      }

      if (this.AddBlankTargetToLinks != null &&
          writer.Service.RequestedServerVersion.index >=
              ExchangeVersion.Exchange2013.index) {
        writer.WriteElementValueWithNamespace(XmlNamespace.Types,
            XmlElementNames.AddBlankTargetToLinks, this.AddBlankTargetToLinks);
      }

      if (this.MaximumBodySize != null &&
          writer.Service.RequestedServerVersion.index >=
              ExchangeVersion.Exchange2013.index) {
        writer.WriteElementValueWithNamespace(XmlNamespace.Types,
            XmlElementNames.MaximumBodySize, this.MaximumBodySize);
      }
    }

    if (this._additionalProperties.length > 0) {
      WriteAdditionalPropertiesToXml(writer, this._additionalProperties);
    }

    writer.WriteEndElement(); // Item/FolderShape
  }

  @override
  Iterator<PropertyDefinitionBase> get iterator =>
      this._additionalProperties.iterator;

  /// <summary>
  /// Returns an enumerator that iterates through the collection.
  /// </summary>
  /// <returns>
  /// A <see cref="T:System.Collections.Generic.IEnumerator`1"/> that can be used to iterate through the collection.
  /// </returns>
//        IEnumerator<PropertyDefinitionBase> GetEnumerator()
//        {
//            return this.additionalProperties.GetEnumerator();
//        }

  /// <summary>
  /// Returns an enumerator that iterates through a collection.
  /// </summary>
  /// <returns>
  /// An <see cref="T:System.Collections.IEnumerator"/> object that can be used to iterate through the collection.
  /// </returns>
//        System.Collections.IEnumerator System.Collections.Iterable.GetEnumerator()
//        {
//            return this.additionalProperties.GetEnumerator();
//        }
}
