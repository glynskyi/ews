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
import 'package:ews/ComplexProperties/GroupMemberCollection.dart';
import 'package:ews/ComplexProperties/ItemAttachment.dart';
import 'package:ews/ComplexProperties/ItemId.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ContactGroupSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ContactSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ItemSchema.dart';
import 'package:ews/Core/ServiceObjects/Schemas/ServiceObjectSchema.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Exceptions/ServiceObjectPropertyException.dart';

/// <summary>
/// Represents a Contact Group. Properties available on contact groups are defined in the ContactGroupSchema class.
/// </summary>
//    [ServiceObjectDefinition(XmlElementNames.DistributionList)]
class ContactGroup extends Item {
  /// <summary>
  /// Initializes an unsaved local instance of the <see cref="ContactGroup"/> class.
  /// </summary>
  /// <param name="service">EWS service to which this object belongs.</param>
  ContactGroup(ExchangeService service) : super(service) {}

  /// <summary>
  /// Initializes a new instance of the <see cref="ContactGroup"/> class.
  /// </summary>
  /// <param name="parentAttachment">The parent attachment.</param>
  ContactGroup.withAttachment(ItemAttachment parentAttachment)
      : super.withAttachment(parentAttachment) {}

//        #region Properties

  /// <summary>
  /// Gets the name under which this contact group is filed as.
  /// </summary>
//        [RequiredServerVersion(ExchangeVersion.Exchange2010)]
  String? get FileAs {
    return this.PropertyBag[ContactSchema.FileAs] as String?;
  }

  /// <summary>
  /// Gets or sets the display name of the contact group.
  /// </summary>
  String? get DisplayName {
    return this.PropertyBag[ContactSchema.DisplayName] as String?;
  }

  set DisplayName(String? value) {
    this.PropertyBag[ContactSchema.DisplayName] = value;
  }

  /// <summary>
  /// Gets the members of the contact group.
  /// </summary>
//        [RequiredServerVersion(ExchangeVersion.Exchange2010)]
  GroupMemberCollection get Members {
    return this.PropertyBag[ContactGroupSchema.Members]
        as GroupMemberCollection;
  }

//        #endregion

  /// <summary>
  /// Binds to an existing contact group and loads the specified set of properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the contact group.</param>
  /// <param name="id">The Id of the contact group to bind to.</param>
  /// <param name="propertySet">The set of properties to load.</param>
  /// <returns>A ContactGroup instance representing the contact group corresponding to the specified Id.</returns>
  static Future<ContactGroup> BindWithPropertySet(
      ExchangeService service, ItemId id, PropertySet propertySet) {
    return service.BindToItemGeneric<ContactGroup>(id, propertySet);
  }

  /// <summary>
  /// Binds to an existing contact group and loads its first class properties.
  /// Calling this method results in a call to EWS.
  /// </summary>
  /// <param name="service">The service to use to bind to the contact group.</param>
  /// <param name="id">The Id of the contact group to bind to.</param>
  /// <returns>A ContactGroup instance representing the contact group corresponding to the specified Id.</returns>
  static Future<ContactGroup> Bind(ExchangeService service, ItemId id) {
    return ContactGroup.BindWithPropertySet(
        service, id, PropertySet.FirstClassProperties);
  }

  /// <summary>
  /// method to return the schema associated with this type of object.
  /// </summary>
  /// <returns>The schema associated with this type of object.</returns>
  @override
  ServiceObjectSchema GetSchema() {
    return ContactGroupSchema.Instance;
  }

  /// <summary>
  /// Gets the minimum required server version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this service object type is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// Sets the subject.
  /// </summary>
  /// <param name="subject">The subject.</param>
  @override
  void SetSubject(String? subject) {
    // Set is disabled in client API even though it is implemented in protocol for Item.Subject.
    // Setting Subject out of sync with DisplayName breaks interop with OLK.
    throw new ServiceObjectPropertyException.withMessage(
        "Strings.PropertyIsReadOnly", ItemSchema.Subject);
  }

  @override
  ServiceObjectDefinitionAttribute getServiceObjectDefinitionAttribute() {
    return ServiceObjectDefinitionAttribute(
        XmlElementNames.DistributionList, false);
  }
}
