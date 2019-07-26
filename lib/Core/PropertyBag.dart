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
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/BasePropertySet.dart';
import 'package:ews/Enumerations/PropertyDefinitionFlags.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceLocalException.dart';
import 'package:ews/Exceptions/ServiceObjectPropertyException.dart';
import 'package:ews/Exceptions/ServiceVersionException.dart';
import 'package:ews/Interfaces/ICustomXmlUpdateSerializer.dart';
import 'package:ews/Interfaces/IOwnedProperty.dart';
import 'package:ews/Interfaces/ISelfValidate.dart';
import 'package:ews/PropertyDefinitions/ComplexPropertyDefinitionBase.dart';
import 'package:ews/PropertyDefinitions/PropertyDefinition.dart';
import 'package:ews/Xml/XmlNodeType.dart';
import 'package:ews/misc/OutParam.dart';

import 'ServiceObjects/Folders/Folder.dart';

/// <summary>
/// Represents a property bag keyed on PropertyDefinition objects.
/// </summary>
class PropertyBag {
  ServiceObject _owner;
  bool _isDirty = false;
  bool _loading = false;
  bool _onlySummaryPropertiesRequested;
  List<PropertyDefinition> _loadedProperties = new List<PropertyDefinition>();
  Map<PropertyDefinition, Object> _properties = new Map<PropertyDefinition, Object>();
  Map<PropertyDefinition, Object> _deletedProperties = new Map<PropertyDefinition, Object>();
  List<PropertyDefinition> _modifiedProperties = new List<PropertyDefinition>();
  List<PropertyDefinition> _addedProperties = new List<PropertyDefinition>();
  PropertySet _requestedPropertySet;

  /// <summary>
  /// Initializes a new instance of PropertyBag.
  /// </summary>
  /// <param name="owner">The owner of the bag.</param>
  PropertyBag(ServiceObject owner) {
    EwsUtilities.Assert(owner != null, "PropertyBag.ctor", "owner is null");

    this._owner = owner;
  }

  /// <summary>
  /// Gets a dictionary holding the bag's properties.
  /// </summary>
  Map<PropertyDefinition, Object> get Properties => this._properties;

  /// <summary>
  /// Gets the owner of this bag.
  /// </summary>
  ServiceObject get Owner => this._owner;

  /// <summary>
  /// True if the bag has pending changes, false otherwise.
  /// </summary>
  bool get IsDirty {
    int changes = this._modifiedProperties.length +
        this._deletedProperties.length +
        this._addedProperties.length;

    return changes > 0 || this._isDirty;
  }

  /// <summary>
  /// Adds the specified property to the specified change list if it is not already present.
  /// </summary>
  /// <param name="propertyDefinition">The property to add to the change list.</param>
  /// <param name="changeList">The change list to add the property to.</param>
  static void AddToChangeList(
      PropertyDefinition propertyDefinition, List<PropertyDefinition> changeList) {
    if (!changeList.contains(propertyDefinition)) {
      changeList.add(propertyDefinition);
    }
  }

  /// <summary>
  /// Gets the name of the property update item.
  /// </summary>
  /// <param name="serviceObject">The service object.</param>
  /// <returns></returns>
  static String GetPropertyUpdateItemName(ServiceObject serviceObject) {
    return serviceObject is Folder ? XmlElementNames.Folder : XmlElementNames.Item;
  }

  /// <summary>
  /// Determines whether specified property is loaded. This also includes
  /// properties that were requested when the property bag was loaded but
  /// were not returned by the server. In this case, the property value
  /// will be null.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <returns>
  ///     <c>true</c> if property was loaded or requested; otherwise, <c>false</c>.
  /// </returns>
  bool IsPropertyLoaded(PropertyDefinition propertyDefinition) {
    // Is the property loaded?
    if (this._loadedProperties.contains(propertyDefinition)) {
      return true;
    } else {
      // Was the property requested?
      return this.IsRequestedProperty(propertyDefinition);
    }
  }

  /// <summary>
  /// Determines whether specified property was requested.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <returns>
  ///     <c>true</c> if property was requested; otherwise, <c>false</c>.
  /// </returns>
  /* private */
  bool IsRequestedProperty(PropertyDefinition propertyDefinition) {
    // If no requested property set, then property wasn't requested.
    if (this._requestedPropertySet == null) {
      return false;
    }

    // If base property set is all first-class properties, use the appropriate list of
    // property definitions to see if this property was requested. Otherwise, property had
    // to be explicitly requested and needs to be listed in AdditionalProperties.
    if (this._requestedPropertySet.BasePropertySet == BasePropertySet.FirstClassProperties) {
      List<PropertyDefinition> firstClassProps = this._onlySummaryPropertiesRequested
          ? this.Owner.Schema.FirstClassSummaryProperties
          : this.Owner.Schema.FirstClassProperties;

      return firstClassProps.contains(propertyDefinition) ||
          this._requestedPropertySet.Contains(propertyDefinition);
    } else {
      return this._requestedPropertySet.Contains(propertyDefinition);
    }
  }

  /// <summary>
  /// Determines whether the specified property has been updated.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <returns>
  ///     <c>true</c> if the specified property has been updated; otherwise, <c>false</c>.
  /// </returns>
  bool IsPropertyUpdated(PropertyDefinition propertyDefinition) {
    return this._modifiedProperties.contains(propertyDefinition) ||
        this._addedProperties.contains(propertyDefinition);
  }

  /// <summary>
  /// Tries to get a property value based on a property definition.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="propertyValue">The property value.</param>
  /// <returns>True if property was retrieved.</returns>
  bool TryGetProperty(
      PropertyDefinition propertyDefinition, OutParam<Object> propertyValueOutParam) {
    OutParam<ServiceLocalException> serviceExceptionOutParam =
        new OutParam<ServiceLocalException>();
    propertyValueOutParam.param =
        this.GetPropertyValueOrException(propertyDefinition, serviceExceptionOutParam);
    return serviceExceptionOutParam.param == null;
  }

  /// <summary>
  /// Tries to get a property value based on a property definition.
  /// </summary>
  /// <typeparam name="T">The types of the property.</typeparam>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="propertyValue">The property value.</param>
  /// <returns>True if property was retrieved.</returns>
  bool TryGetPropertyTypeGeneric<T>(
      PropertyDefinition propertyDefinition, OutParam<T> propertyValue) {
    // Verify that the type parameter and property definition's type are compatible.
    // todo("implement verifing")
//            if (!typeof(T).IsAssignableFrom(propertyDefinition.Type))
//            {
//                String errorMessage = string.Format(
//                    Strings.PropertyDefinitionTypeMismatch,
//                    EwsUtilities.GetPrintableTypeName(propertyDefinition.Type),
//                    EwsUtilities.GetPrintableTypeName(typeof(T)));
//                throw new ArgumentError(errorMessage, "propertyDefinition");
//            }

    OutParam<Object> value = new OutParam<Object>();

    bool result = this.TryGetProperty(propertyDefinition, value);

    if (result) {
      propertyValue.param = value.param;
    } else {
      propertyValue.param = null;
    }
//            propertyValue = result ? (T)value : default(T);

    return result;
  }

  /// <summary>
  /// Gets the property value.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /// <param name="exception">Exception that would be raised if there's an error retrieving the property.</param>
  /// <returns>Propert value. May be null.</returns>
  /* private */
  Object GetPropertyValueOrException(PropertyDefinition propertyDefinition,
      OutParam<ServiceLocalException> serviceExceptionOutParam) {
    OutParam<Object> propertyValueOutParam = new OutParam<Object>();
    propertyValueOutParam.param = null;
    serviceExceptionOutParam.param = null;

    if (propertyDefinition.Version.index > this.Owner.Service.RequestedServerVersion.index) {
      serviceExceptionOutParam.param = new ServiceVersionException("""string.Format(
                                        Strings.PropertyIncompatibleWithRequestVersion,
                                        propertyDefinition.Name,
                                        propertyDefinition.Version)""");
      return null;
    }

    if (this.TryGetValue(propertyDefinition, propertyValueOutParam)) {
      // If the requested property is in the bag, return it.
      return propertyValueOutParam.param;
    } else {
      if (propertyDefinition.HasFlagWithoutExchangeVersion(
          PropertyDefinitionFlags.AutoInstantiateOnRead)) {
        // The requested property is an auto-instantiate-on-read property
        ComplexPropertyDefinitionBase complexPropertyDefinition =
            propertyDefinition as ComplexPropertyDefinitionBase;

        EwsUtilities.Assert(complexPropertyDefinition != null, "PropertyBag.get_this[]",
            "propertyDefinition is marked with AutoInstantiateOnRead but is not a descendant of ComplexPropertyDefinitionBase");

        ComplexProperty propertyValue =
            complexPropertyDefinition.CreatePropertyInstance(this.Owner);
        propertyValueOutParam.param = propertyValue;

        if (propertyValue != null) {
          this.InitComplexProperty(propertyValue);
          this._properties[propertyDefinition] = propertyValue;
        }
      } else {
        // If the property is not the Id (we need to let developers read the Id when it's null) and if has
        // not been loaded, we throw.
        if (propertyDefinition != this.Owner.GetIdPropertyDefinition()) {
          if (!this.IsPropertyLoaded(propertyDefinition)) {
            serviceExceptionOutParam.param = new ServiceObjectPropertyException.withMessage(
                "Strings.MustLoadOrAssignPropertyBeforeAccess", propertyDefinition);
            return null;
          }

          // Non-nullable properties (int, bool, etc.) must be assigned or loaded; cannot return null value.
          if (!propertyDefinition.IsNullable) {
            String errorMessage = this.IsRequestedProperty(propertyDefinition)
                ? "Strings.ValuePropertyNotLoaded"
                : "Strings.ValuePropertyNotAssigned";
            serviceExceptionOutParam.param =
                new ServiceObjectPropertyException.withMessage(errorMessage, propertyDefinition);
          }
        }
      }

      return propertyValueOutParam.param;
    }
  }

  /// <summary>
  /// Gets or sets the value of a property.
  /// </summary>
  /// <param name="propertyDefinition">The property to get or set.</param>
  /// <returns>An object representing the value of the property.</returns>
  /// <exception cref="ServiceVersionException">Raised if this property requires a later version of Exchange.</exception>
  /// <exception cref="ServiceObjectPropertyException">Raised for get if property hasn't been assigned or loaded. Raised for set if property cannot be updated or deleted.</exception>
  Object operator [](PropertyDefinition propertyDefinition) {
    OutParam<ServiceLocalException> serviceExceptionOut = new OutParam<ServiceLocalException>();
    Object propertyValue =
        this.GetPropertyValueOrException(propertyDefinition, serviceExceptionOut);
    if (serviceExceptionOut.param == null) {
      return propertyValue;
    } else {
      throw serviceExceptionOut.param;
    }
  }

  operator []=(PropertyDefinition propertyDefinition, Object value) {
    if (propertyDefinition.Version.index > this.Owner.Service.RequestedServerVersion.index) {
      throw new ServiceVersionException("""string.Format(
                        Strings.PropertyIncompatibleWithRequestVersion,
                        propertyDefinition.Name,
                        propertyDefinition.Version)""");
    }

    // If the property bag is not in the loading state, we need to verify whether
    // the property can actually be set or updated.
    if (!this._loading) {
      // If the owner is new and if the property cannot be set, throw.
      if (this.Owner.IsNew &&
          !propertyDefinition.HasFlag(
              PropertyDefinitionFlags.CanSet, _owner.Service.requestedServerVersion)) {
        throw new ServiceObjectPropertyException(/*Strings.PropertyIsReadOnly, */
            propertyDefinition);
      }
       if (!this.Owner.IsNew)
        {
            // If owner is an item attachment, properties cannot be updated (EWS doesn't support updating item attachments)
            if (this.Owner is Item && (this.Owner as Item).IsAttachment)
            {
                throw new ServiceObjectPropertyException(/*Strings.ItemAttachmentCannotBeUpdated, */propertyDefinition);
            }

            // If the property cannot be deleted, throw.
            if (value == null && !propertyDefinition.HasFlagWithoutExchangeVersion(PropertyDefinitionFlags.CanDelete))
            {
                throw new ServiceObjectPropertyException(/*Strings.PropertyCannotBeDeleted,*/ propertyDefinition);
            }

            // If the property cannot be updated, throw.
            if (!propertyDefinition.HasFlagWithoutExchangeVersion(PropertyDefinitionFlags.CanUpdate))
            {
                throw new ServiceObjectPropertyException(/*"Strings.PropertyCannotBeUpdated",*/ propertyDefinition);
            }
        }
    }

    // If the value is set to null, delete the property.
    if (value == null) {
      this.DeleteProperty(propertyDefinition);
    } else {
      ComplexProperty complexProperty;

      if (this._properties.containsKey(propertyDefinition)) {
        if (this._properties[propertyDefinition] is ComplexProperty) {
          (this._properties[propertyDefinition] as ComplexProperty).removeChangeEvent(this.PropertyChanged);
        }
      }

      // If the property was to be deleted, the deletion becomes an update.
      if (this._deletedProperties.containsKey(propertyDefinition)) {
        this._deletedProperties.remove(propertyDefinition);
        AddToChangeList(propertyDefinition, this._modifiedProperties);
      } else {
        // If the property value was not set, we have a newly set property.
        if (!this._properties.containsKey(propertyDefinition)) {
          AddToChangeList(propertyDefinition, this._addedProperties);
        } else {
          // The last case is that we have a modified property.
          if (!this._modifiedProperties.contains(propertyDefinition)) {
            AddToChangeList(propertyDefinition, this._modifiedProperties);
          }
        }
      }

      if (value is ComplexProperty) {
        this.InitComplexProperty(value);
      }
      this._properties[propertyDefinition] = value;

      this.Changed();
    }
  }

  /// <summary>
  /// Sets the isDirty flag to true and triggers dispatch of the change event to the owner
  /// of the property bag. Changed must be called whenever an operation that changes the state
  /// of this property bag is performed (e.g. adding or removing a property).
  /// </summary>
  void Changed() {
    this._isDirty = true;
    this.Owner.Changed();
  }

  /// <summary>
  /// Determines whether the property bag contains a specific property.
  /// </summary>
  /// <param name="propertyDefinition">The property to check against.</param>
  /// <returns>True if the specified property is in the bag, false otherwise.</returns>
  bool Contains(PropertyDefinition propertyDefinition) {
    return this._properties.containsKey(propertyDefinition);
  }

  /// <summary>
  /// Tries to retrieve the value of the specified property.
  /// </summary>
  /// <param name="propertyDefinition">The property for which to retrieve a value.</param>
  /// <param name="propertyValue">If the method succeeds, contains the value of the property.</param>
  /// <returns>True if the value could be retrieved, false otherwise.</returns>
  bool TryGetValue(PropertyDefinition propertyDefinition, OutParam<Object> propertyValueOutParam) {
    if (this._properties.containsKey(propertyDefinition)) {
      Object param = _properties[propertyDefinition];
      propertyValueOutParam.param = param;
      return true;
    } else {
      propertyValueOutParam.param = null;
      return false;
    }
  }

  /// <summary>
  /// Handles a change event for the specified property.
  /// </summary>
  /// <param name="complexProperty">The property that changes.</param>
  void PropertyChanged(ComplexProperty complexProperty) {
    for (MapEntry<PropertyDefinition, Object> keyValuePair in this._properties.entries) {
      if (keyValuePair.value == complexProperty) {
        if (!this._deletedProperties.containsKey(keyValuePair.key)) {
          AddToChangeList(keyValuePair.key, this._modifiedProperties);
          this.Changed();
        }
      }
    }
  }

  /// <summary>
  /// Deletes the property from the bag.
  /// </summary>
  /// <param name="propertyDefinition">The property to delete.</param>
  void DeleteProperty(PropertyDefinition propertyDefinition) {
    if (!this._deletedProperties.containsKey(propertyDefinition)) {
      Object propertyValue;

      propertyValue = this._properties[propertyDefinition];

      this._properties.remove(propertyDefinition);
      this._modifiedProperties.remove(propertyDefinition);
      this._deletedProperties[propertyDefinition] = propertyValue;

      if (propertyValue is ComplexProperty) {
        propertyValue.removeChangeEvent(this.PropertyChanged);
      }
    }
  }

  /// <summary>
  /// Clears the bag.
  /// </summary>
  void Clear() {
    this.ClearChangeLog();
    this._properties.clear();
    this._loadedProperties.clear();
    this._requestedPropertySet = null;
  }

  /// <summary>
  /// Clears the bag's change log.
  /// </summary>
  void ClearChangeLog() {
    this._deletedProperties.clear();
    this._modifiedProperties.clear();
    this._addedProperties.clear();

    for (MapEntry<PropertyDefinition, Object> keyValuePair in this._properties.entries) {
      if (keyValuePair.value is ComplexProperty) {
        ComplexProperty complexProperty = keyValuePair.value as ComplexProperty;

        complexProperty.ClearChangeLog();
      }
    }

    this._isDirty = false;
  }

  /// <summary>
  /// Loads properties from XML and inserts them in the bag.
  /// </summary>
  /// <param name="reader">The reader from which to read the properties.</param>
  /// <param name="clear">Indicates whether the bag should be cleared before properties are loaded.</param>
  /// <param name="requestedPropertySet">The requested property set.</param>
  /// <param name="onlySummaryPropertiesRequested">Indicates whether summary or full properties were requested.</param>
  void LoadFromXml(EwsServiceXmlReader reader, bool clear, PropertySet requestedPropertySet,
      bool onlySummaryPropertiesRequested) {
    if (clear) {
      this.Clear();
    }

    // Put the property bag in "loading" mode. When in loading mode, no checking is done
    // when setting property values.
    this._loading = true;

    this._requestedPropertySet = requestedPropertySet;
    this._onlySummaryPropertiesRequested = onlySummaryPropertiesRequested;

    try {
      do {
        reader.Read();

        if (reader.NodeType == XmlNodeType.Element) {
          OutParam<PropertyDefinition> propertyDefinitionOutParam =
              new OutParam<PropertyDefinition>();

          if (this
              .Owner
              .Schema
              .TryGetPropertyDefinition(reader.LocalName, propertyDefinitionOutParam)) {
            PropertyDefinition propertyDefinition = propertyDefinitionOutParam.param;
            propertyDefinition.LoadPropertyValueFromXml(reader, this);

            this._loadedProperties.add(propertyDefinition);
          } else {
            reader.SkipCurrentElement();
          }
        }
      } while (
          !reader.IsEndElementWithNamespace(XmlNamespace.Types, this.Owner.GetXmlElementName()));

      this.ClearChangeLog();
    } finally {
      this._loading = false;
    }
  }

  /// <summary>
  /// Writes the bag's properties to XML.
  /// </summary>
  /// <param name="writer">The writer to write the properties to.</param>
  void WriteToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Types, this.Owner.GetXmlElementName());

    for (PropertyDefinition propertyDefinition in this.Owner.Schema) {
      // The following test should not be necessary since the property bag prevents
      // properties to be set if they don't have the CanSet flag, but it doesn't hurt...
      if (propertyDefinition.HasFlag(
          PropertyDefinitionFlags.CanSet, writer.service.requestedServerVersion)) {
        if (this.Contains(propertyDefinition)) {
          propertyDefinition.WritePropertyValueToXml(writer, this, false /* isUpdateOperation */);
        }
      }
    }

    writer.WriteEndElement();
  }

  /// <summary>
  /// Writes the EWS update operations corresponding to the changes that occurred in the bag to XML.
  /// </summary>
  /// <param name="writer">The writer to write the updates to.</param>
  void WriteToXmlForUpdate(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Types, this.Owner.GetChangeXmlElementName());

    this.Owner.GetId().WriteToXmlElemenetName(writer);

    writer.WriteStartElement(XmlNamespace.Types, XmlElementNames.Updates);

    for (PropertyDefinition propertyDefinition in this._addedProperties) {
      this.WriteSetUpdateToXml(writer, propertyDefinition);
    }

    for (PropertyDefinition propertyDefinition in this._modifiedProperties) {
      this.WriteSetUpdateToXml(writer, propertyDefinition);
    }

    for (MapEntry<PropertyDefinition, Object> property in this._deletedProperties.entries) {
      this.WriteDeleteUpdateToXml(writer, property.key, property.value);
    }

    writer.WriteEndElement();
    writer.WriteEndElement();
  }

  /// <summary>
  /// Determines whether an EWS UpdateItem/UpdateFolder call is necessary to save the changes that
  /// occurred in the bag.
  /// </summary>
  /// <returns>True if an UpdateItem/UpdateFolder call is necessary, false otherwise.</returns>
  bool GetIsUpdateCallNecessary() {
    List<PropertyDefinition> propertyDefinitions = new List<PropertyDefinition>();

    propertyDefinitions.addAll(this._addedProperties);
    propertyDefinitions.addAll(this._modifiedProperties);
    propertyDefinitions.addAll(this._deletedProperties.keys);

    for (PropertyDefinition propertyDefinition in propertyDefinitions) {
      if (propertyDefinition.HasFlagWithoutExchangeVersion(PropertyDefinitionFlags.CanUpdate)) {
        return true;
      }
    }

    return false;
  }

  /// <summary>
  /// Initializes a ComplexProperty instance. When a property is inserted into the bag, it needs to be
  /// initialized in order for changes that occur on that property to be properly detected and dispatched.
  /// </summary>
  /// <param name="complexProperty">The ComplexProperty instance to initialize.</param>
  /* private */
  void InitComplexProperty(ComplexProperty complexProperty) {
    if (complexProperty != null) {
      complexProperty.addOnChangeEvent(this.PropertyChanged);

      if (complexProperty is IOwnedProperty) {
        IOwnedProperty ownedProperty = complexProperty as IOwnedProperty;

        ownedProperty.Owner = this.Owner;
      }
    }
  }

  /// <summary>
  /// Writes an EWS SetUpdate opeartion for the specified property.
  /// </summary>
  /// <param name="writer">The writer to write the update to.</param>
  /// <param name="propertyDefinition">The property fro which to write the update.</param>
  /* private */
  void WriteSetUpdateToXml(EwsServiceXmlWriter writer, PropertyDefinition propertyDefinition) {
    // The following test should not be necessary since the property bag prevents
    // properties to be updated if they don't have the CanUpdate flag, but it
    // doesn't hurt...
    if (propertyDefinition.HasFlagWithoutExchangeVersion(PropertyDefinitionFlags.CanUpdate)) {
      Object propertyValue = this[propertyDefinition];

      bool handled = false;
      if (propertyValue is ICustomUpdateSerializer) {
        handled = propertyValue.WriteSetUpdateToXml(writer, this.Owner, propertyDefinition);
      }

      if (!handled) {
        writer.WriteStartElement(XmlNamespace.Types, this.Owner.GetSetFieldXmlElementName());

        propertyDefinition.WriteToXml(writer);

        writer.WriteStartElement(XmlNamespace.Types, this.Owner.GetXmlElementName());
        propertyDefinition.WritePropertyValueToXml(writer, this, true /* isUpdateOperation */);
        writer.WriteEndElement();

        writer.WriteEndElement();
      }
    }
  }

  /// <summary>
  /// Writes an EWS DeleteUpdate opeartion for the specified property.
  /// </summary>
  /// <param name="writer">The writer to write the update to.</param>
  /// <param name="propertyDefinition">The property fro which to write the update.</param>
  /// <param name="propertyValue">The current value of the property.</param>
  /* private */
  void WriteDeleteUpdateToXml(
      EwsServiceXmlWriter writer, PropertyDefinition propertyDefinition, Object propertyValue) {
    // The following test should not be necessary since the property bag prevents
    // properties to be deleted (set to null) if they don't have the CanDelete flag,
    // but it doesn't hurt...
    if (propertyDefinition.HasFlagWithoutExchangeVersion(PropertyDefinitionFlags.CanDelete)) {
      bool handled = false;

      if (propertyValue is ICustomUpdateSerializer) {
        handled = propertyValue .WriteDeleteUpdateToXml(writer, this.Owner);
      }

      if (!handled) {
        writer.WriteStartElement(XmlNamespace.Types, this.Owner.GetDeleteFieldXmlElementName());
        propertyDefinition.WriteToXml(writer);
        writer.WriteEndElement();
      }
    }
  }

  /// <summary>
  /// Validate property bag instance.
  /// </summary>
  void Validate() {
    for (PropertyDefinition propertyDefinition in this._addedProperties) {
      this.ValidatePropertyValue(propertyDefinition);
    }

    for (PropertyDefinition propertyDefinition in this._modifiedProperties) {
      this.ValidatePropertyValue(propertyDefinition);
    }
  }

  /// <summary>
  /// Validates the property value.
  /// </summary>
  /// <param name="propertyDefinition">The property definition.</param>
  /* private */
  void ValidatePropertyValue(PropertyDefinition propertyDefinition) {
    OutParam<Object> propertyValueOutParam = new OutParam<Object>();
    if (this.TryGetProperty(propertyDefinition, propertyValueOutParam)) {
      Object propertyValue = propertyValueOutParam.param;
      if (propertyValue is ISelfValidate) {
        propertyValue.Validate();
      }
    }
  }
}
