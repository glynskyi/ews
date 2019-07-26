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

import 'package:ews/Attributes/ServiceObjectDefinitionAttribute.dart';
import 'package:ews/ComplexProperties/ExtendedProperty.dart';
import 'package:ews/ComplexProperties/ExtendedPropertyCollection.dart';
import 'package:ews/ComplexProperties/IServiceObjectChangedDelegate.dart';
import 'package:ews/ComplexProperties/ServiceId.dart';
import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertyBag.dart' as core;
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AffectedTaskOccurrence.dart';
import 'package:ews/Enumerations/DeleteMode.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/SendCancellationsMode.dart';
import 'package:ews/Exceptions/InvalidOperationException.dart';
import 'package:ews/Exceptions/NotSupportedException.dart';
import 'package:ews/Exceptions/ServiceObjectPropertyException.dart';
import 'package:ews/PropertyDefinitions/ExtendedPropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinitionBase.dart';
import 'package:ews/misc/OutParam.dart';
import 'package:ews/misc/StringUtils.dart';
import 'package:synchronized/synchronized.dart';

import '../EwsUtilities.dart';

/// <summary>
/// Represents the base class for all item and folder types.
/// </summary>
abstract class ServiceObject {
  final _lockObject = new Lock();
  ExchangeService _service;
  core.PropertyBag _propertyBag;
  String _xmlElementName;

  /// <summary>
  /// Triggers dispatch of the change event.
  /// </summary>
  void Changed() {
    for (IServiceObjectChangedDelegate change in this.onChange) {
      change(this);
    }
  }

  /// <summary>
  /// Throws exception if this is a new service object.
  /// </summary>
  void ThrowIfThisIsNew() {
    if (this.IsNew) {
      throw new InvalidOperationException("Strings.ServiceObjectDoesNotHaveId");
    }
  }

  /// <summary>
  /// Throws exception if this is not a new service object.
  /// </summary>
  void ThrowIfThisIsNotNew() {
    if (!this.IsNew) {
      throw new InvalidOperationException("Strings.ServiceObjectAlreadyHasId");
    }
  }

  /// <summary>
  /// This methods lets subclasses of ServiceObject override the default mechanism
  /// by which the XML element name associated with their type is retrieved.
  /// </summary>
  /// <returns>
  /// The XML element name associated with this type.
  /// If this method returns null or empty, the XML element name associated with this
  /// type is determined by the EwsObjectDefinition attribute that decorates the type,
  /// if present.
  /// </returns>
  /// <remarks>
  /// Item and folder classes that can be returned by EWS MUST rely on the EwsObjectDefinition
  /// attribute for XML element name determination.
  /// </remarks>
  String GetXmlElementNameOverride() {
    return null;
  }

  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute();

  /// <summary>
  /// GetXmlElementName retrieves the XmlElementName of this type based on the
  /// EwsObjectDefinition attribute that decorates it, if present.
  /// </summary>
  /// <returns>The XML element name associated with this type.</returns>
  String GetXmlElementName() {
    if (StringUtils.IsNullOrEmpty(this._xmlElementName)) {
      this._xmlElementName = this.GetXmlElementNameOverride();

      if (StringUtils.IsNullOrEmpty(this._xmlElementName)) {
        this._lockObject.synchronized(() {
//                        for (Attribute attribute in this.GetType().GetCustomAttributes(false))
//                        {
          ServiceObjectDefinitionAttribute definitionAttribute =
              getServiceObjectDefinitionAttribute(); // attribute as ServiceObjectDefinitionAttribute;

          if (definitionAttribute != null) {
            this._xmlElementName = definitionAttribute.XmlElementName;
          }
//                        }
        });
      }
    }

    EwsUtilities.Assert(
        !StringUtils.IsNullOrEmpty(this._xmlElementName),
        "EwsObject.GetXmlElementName",
        "The class ${this.runtimeType} does not have an associated XML element name.");

    return this._xmlElementName;
  }

  /// <summary>
  /// Gets the name of the change XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  String GetChangeXmlElementName() {
    return XmlElementNames.ItemChange;
  }

  /// <summary>
  /// Gets the name of the set field XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  String GetSetFieldXmlElementName() {
    return XmlElementNames.SetItemField;
  }

  /// <summary>
  /// Gets the name of the delete field XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  String GetDeleteFieldXmlElementName() {
    return XmlElementNames.DeleteItemField;
  }

  /// <summary>
  /// Gets a value indicating whether a time zone SOAP header should be emitted in a CreateItem
  /// or UpdateItem request so this item can be property saved or updated.
  /// </summary>
  /// <param name="isUpdateOperation">Indicates whether the operation being petrformed is an update operation.</param>
  /// <returns><c>true</c> if a time zone SOAP header should be emitted; otherwise, <c>false</c>.</returns>
  bool GetIsTimeZoneHeaderRequired(bool isUpdateOperation) {
    return false;
  }

  /// <summary>
  /// Determines whether properties defined with ScopedDateTimePropertyDefinition require custom time zone scoping.
  /// </summary>
  /// <returns>
  ///     <c>true</c> if this item type requires custom scoping for scoped date/time properties; otherwise, <c>false</c>.
  /// </returns>
  bool GetIsCustomDateTimeScopingRequired() {
    return false;
  }

  /// <summary>
  /// The property bag holding property values for this object.
  /// </summary>
  core.PropertyBag get PropertyBag => this._propertyBag;

  /// <summary>
  /// constructor.
  /// </summary>
  /// <param name="service">EWS service to which this object belongs.</param>
  ServiceObject(ExchangeService service) {
    EwsUtilities.ValidateParam(service, "service");
    EwsUtilities.ValidateServiceObjectVersion(this, service.RequestedServerVersion);

    this._service = service;
    this._propertyBag = new core.PropertyBag(this);
  }

  /// <summary>
  /// Gets the schema associated with this type of object.
  /// </summary>
  ServiceObjectSchema get Schema => this.GetSchema();

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  ServiceObjectSchema GetSchema();

  /// <summary>
  /// Gets the minimum required server version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
  ExchangeVersion GetMinimumRequiredServerVersion();

  /// <summary>
  /// Loads service object from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="clearPropertyBag">if set to <c>true</c> [clear property bag].</param>
  void LoadFromXml(EwsServiceXmlReader reader, bool clearPropertyBag) {
    this.PropertyBag.LoadFromXml(
        reader,
        clearPropertyBag,
        null, //* propertySet *//*
        false); //* summaryPropertiesOnly *//*
  }

  /// <summary>
  /// Validates this instance.
  /// </summary>
  void Validate() {
    this.PropertyBag.Validate();
  }

  /// <summary>
  /// Loads service object from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="clearPropertyBag">if set to <c>true</c> [clear property bag].</param>
  /// <param name="requestedPropertySet">The property set.</param>
  /// <param name="summaryPropertiesOnly">if set to <c>true</c> [summary props only].</param>
  void LoadFromXmlWithPropertySet(EwsServiceXmlReader reader, bool clearPropertyBag,
      PropertySet requestedPropertySet, bool summaryPropertiesOnly) {
    this
        .PropertyBag
        .LoadFromXml(reader, clearPropertyBag, requestedPropertySet, summaryPropertiesOnly);
  }

  /// <summary>
  /// Clears the object's change log.
  /// </summary>
  void ClearChangeLog() {
    this.PropertyBag.ClearChangeLog();
  }

  /// <summary>
  /// Writes service object as XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXml(EwsServiceXmlWriter writer) {
    this.PropertyBag.WriteToXml(writer);
  }

  /// <summary>
  /// Writes service object for update as XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void WriteToXmlForUpdate(EwsServiceXmlWriter writer) {
    this.PropertyBag.WriteToXmlForUpdate(writer);
  }

  /// <summary>
  /// Loads the specified set of properties on the object.
  /// </summary>
  /// <param name="propertySet">The properties to load.</param>
  Future<void> InternalLoad(PropertySet propertySet);

  /// <summary>
  /// Deletes the object.
  /// </summary>
  /// <param name="deleteMode">The deletion mode.</param>
  /// <param name="sendCancellationsMode">Indicates whether meeting cancellation messages should be sent.</param>
  /// <param name="affectedTaskOccurrences">Indicate which occurrence of a recurring task should be deleted.</param>
  Future<void> InternalDelete(DeleteMode deleteMode, SendCancellationsMode sendCancellationsMode,
      AffectedTaskOccurrence affectedTaskOccurrences);

  /// <summary>
  /// Loads the specified set of properties. Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="propertySet">The properties to load.</param>
  Future<void> LoadWithPropertySet(PropertySet propertySet) {
    return this.InternalLoad(propertySet);
  }

  /// <summary>
  /// Loads the first class properties. Calling this method results in a call to EWS.
  /// </summary>
  Future<void> Load() {
    return this.InternalLoad(PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// Gets the value of specified property in this instance.
  /// </summary>
  /// <param name="propertyDefinition">Definition of the property to get.</param>
  /// <exception cref="ServiceVersionException">Raised if this property requires a later version of Exchange.</exception>
  /// <exception cref="PropertyException">Raised if this property hasn't been assigned or loaded. Raised for set if property cannot be updated or deleted.</exception>
  Object operator [](PropertyDefinitionBase propertyDefinition) {
    Object propertyValue;

    PropertyDefinition propDef = propertyDefinition as PropertyDefinition;
    if (propDef != null) {
      return this.PropertyBag[propDef];
    } else {
      ExtendedPropertyDefinition extendedPropDef = propertyDefinition as ExtendedPropertyDefinition;
      if (extendedPropDef != null) {
        OutParam<Object> propertyValueOutParam = OutParam();
        if (this.TryGetExtendedProperty(extendedPropDef, propertyValueOutParam)) {
          return propertyValue;
        } else {
          throw new ServiceObjectPropertyException(/*Strings.MustLoadOrAssignPropertyBeforeAccess,*/
              propertyDefinition);
        }
      } else {
        // Other subclasses of PropertyDefinitionBase are not supported.
        throw new NotSupportedException("""string.Format(
                        Strings.OperationNotSupportedForPropertyDefinitionType,
                        propertyDefinition.GetType().Name)""");
      }
    }
  }

  /// <summary>
  /// Try to get the value of a specified extended property in this instance.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="propertyValue">The property value.</param>
  /// <typeparam name="T">Type of expected property value.</typeparam>
  /// <returns>True if property retrieved, false otherwise.</returns>
  bool TryGetExtendedProperty<T>(
      ExtendedPropertyDefinition propertyDefinition, OutParam<T> propertyValueOutParam) {
    ExtendedPropertyCollection propertyCollection = this.GetExtendedProperties();

    if ((propertyCollection != null) &&
        propertyCollection.TryGetValueGeneric<T>(propertyDefinition, propertyValueOutParam)) {
      return true;
    } else {
      propertyValueOutParam.param = null;
      return false;
    }
  }

  /// <summary>
  /// Try to get the value of a specified property in this instance.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="propertyValue">The property value.</param>
  /// <returns>True if property retrieved, false otherwise.</returns>
  bool TryGetProperty(
      PropertyDefinitionBase propertyDefinition, OutParam<Object> propertyValueOutParam) {
    return this.TryGetPropertyGeneric<Object>(propertyDefinition, propertyValueOutParam);
  }

  /// <summary>
  /// Try to get the value of a specified property in this instance.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="propertyValue">The property value.</param>
  /// <typeparam name="T">Type of expected property value.</typeparam>
  /// <returns>True if property retrieved, false otherwise.</returns>
  bool TryGetPropertyGeneric<T>(
      PropertyDefinitionBase propertyDefinition, OutParam<T> propertyValueOutParam) {
    PropertyDefinition propDef = propertyDefinition as PropertyDefinition;
    if (propDef != null) {
      return this.PropertyBag.TryGetPropertyTypeGeneric<T>(propDef, propertyValueOutParam);
    } else {
      ExtendedPropertyDefinition extPropDef = propertyDefinition as ExtendedPropertyDefinition;
      if (extPropDef != null) {
        return this.TryGetExtendedProperty<T>(extPropDef, propertyValueOutParam);
      } else {
        // Other subclasses of PropertyDefinitionBase are not supported.
        throw new NotSupportedException("""string.Format(
                        Strings.OperationNotSupportedForPropertyDefinitionType,
                        propertyDefinition.GetType().Name)""");
      }
    }
  }

  /// <summary>
  /// Gets the collection of loaded property definitions.
  /// </summary>
  /// <returns>Collection of property definitions.</returns>
  List<PropertyDefinitionBase> GetLoadedPropertyDefinitions() {
    List<PropertyDefinitionBase> propDefs = new List<PropertyDefinitionBase>();
    for (PropertyDefinition propDef in this.PropertyBag.Properties.keys) {
      propDefs.add(propDef);
    }

    if (this.GetExtendedProperties() != null) {
      for (ExtendedProperty extProp in this.GetExtendedProperties()) {
        propDefs.add(extProp.PropertyDefinition);
      }
    }

    return propDefs;
  }

  /// <summary>
  /// Gets the ExchangeService the object is bound to.
  /// </summary>
  ExchangeService get Service => this._service;

  set Service(ExchangeService value) => this._service = value;

  /// <summary>
  /// The property definition for the Id of this object.
  /// </summary>
  /// <returns>A PropertyDefinition instance.</returns>
  PropertyDefinition GetIdPropertyDefinition() {
    return null;
  }

  /// <summary>
  /// The unique Id of this object.
  /// </summary>
  /// <returns>A ServiceId instance.</returns>
  ServiceId GetId() {
    PropertyDefinition idPropertyDefinition = this.GetIdPropertyDefinition();

    OutParam<Object> serviceIdOutParam = new OutParam();

    if (idPropertyDefinition != null) {
      this.PropertyBag.TryGetValue(idPropertyDefinition, serviceIdOutParam);
    }

    return serviceIdOutParam.param;
  }

  /// <summary>
  /// Indicates whether this object is a real store item, or if it's a local object
  /// that has yet to be saved.
  /// </summary>
  bool get IsNew {
    ServiceId id = this.GetId();

    return id == null ? true : !id.IsValid;
  }

  /// <summary>
  /// Gets a value indicating whether the object has been modified and should be saved.
  /// </summary>
  bool get IsDirty {
    return this.PropertyBag.IsDirty;
  }

  /// <summary>
  /// Gets the extended properties collection.
  /// </summary>
  /// <returns>Extended properties collection.</returns>
  ExtendedPropertyCollection GetExtendedProperties() {
    return null;
  }

  /// <summary>
  /// Defines an event that is triggered when the service object changes.
  /// </summary>
  List<IServiceObjectChangedDelegate> onChange = new List<IServiceObjectChangedDelegate>();
//        event ServiceObjectChangedDelegate OnChange;
}
