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

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/ServiceObjects/ServiceObject.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ChangeType.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Sync/Change.dart';
import 'package:ews/Sync/ChangeCollection.dart';
import 'package:ews/Sync/ItemChange.dart';
import 'package:ews/misc/Std/EnumToString.dart';

/// <summary>
/// Represents the base response class for synchronuization operations.
/// </summary>
/// <typeparam name="TServiceObject">ServiceObject type.</typeparam>
/// <typeparam name="TChange">Change type.</typeparam>
abstract class SyncResponse<TServiceObject extends ServiceObject,
    TChange extends Change> extends ServiceResponse {
  ChangeCollection<TChange> _changes = new ChangeCollection<TChange>();

  PropertySet? _propertySet;

  /// <summary>
  /// Initializes a new instance of the <see cref="SyncResponse&lt;TServiceObject, TChange&gt;"/> class.
  /// </summary>
  /// <param name="propertySet">Property set.</param>
  SyncResponse(PropertySet? propertySet) : super() {
    this._propertySet = propertySet;

    EwsUtilities.Assert(this._propertySet != null, "SyncResponse.ctor",
        "PropertySet should not be null");
  }

  /// <summary>
  /// Gets the name of the includes last in range XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  String GetIncludesLastInRangeXmlElementName();

  /// <summary>
  /// Creates the change instance.
  /// </summary>
  /// <returns>TChange instance</returns>
  TChange CreateChangeInstance();

  /// <summary>
  /// Gets the name of the change element.
  /// </summary>
  /// <returns>Change element name.</returns>
  String GetChangeElementName();

  /// <summary>
  /// Gets the name of the change id element.
  /// </summary>
  /// <returns>Change id element name.</returns>
  String GetChangeIdElementName();

  /// <summary>
  /// Reads response elements from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  @override
  void ReadElementsFromXml(EwsServiceXmlReader reader) {
    this.Changes.SyncState = reader.ReadElementValueWithNamespace(
        XmlNamespace.Messages, XmlElementNames.SyncState);
    this.Changes.MoreChangesAvailable =
        !reader.ReadElementValueWithNamespace<bool>(
            XmlNamespace.Messages, this.GetIncludesLastInRangeXmlElementName())!;

    reader.ReadStartElementWithNamespace(
        XmlNamespace.Messages, XmlElementNames.Changes);
    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if (reader.IsStartElement()) {
          TChange change = this.CreateChangeInstance();

          switch (reader.LocalName) {
            case XmlElementNames.Create:
              change.ChangeType = ChangeType.Create;
              break;
            case XmlElementNames.Update:
              change.ChangeType = ChangeType.Update;
              break;
            case XmlElementNames.Delete:
              change.ChangeType = ChangeType.Delete;
              break;
            case XmlElementNames.ReadFlagChange:
              change.ChangeType = ChangeType.ReadFlagChange;
              break;
            default:
              reader.SkipCurrentElement();
              break;
          }

          if (change != null) {
            reader.Read();
            reader.EnsureCurrentNodeIsStartElement();

            switch (change.ChangeType) {
              case ChangeType.Delete:
              case ChangeType.ReadFlagChange:
                change.Id = change.CreateId();
                change.Id!.LoadFromXml(reader, change.Id!.GetXmlElementName());

                if (change.ChangeType == ChangeType.ReadFlagChange) {
                  reader.Read();
                  reader.EnsureCurrentNodeIsStartElement();

                  ItemChange itemChange = change as ItemChange;

                  EwsUtilities.Assert(
                      itemChange != null,
                      "SyncResponse.ReadElementsFromXml",
                      "ReadFlagChange is only valid on ItemChange");

                  itemChange.IsRead =
                      reader.ReadElementValueWithNamespace<bool>(
                          XmlNamespace.Types, XmlElementNames.IsRead);
                }

                break;
              default:
                change.ServiceObject =
                    EwsUtilities.CreateEwsObjectFromXmlElementName<
                        TServiceObject>(reader.Service, reader.LocalName);

                change.ServiceObject!.LoadFromXmlWithPropertySet(
                    reader,
                    true,
                    /* clearPropertyBag */
                    this._propertySet,
                    this.SummaryPropertiesOnly);
                break;
            }

            reader.ReadEndElementIfNecessary(
                XmlNamespace.Types, EnumToString.parse(change.ChangeType));

            this._changes.Add(change);
          }
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Messages, XmlElementNames.Changes));
    }
  }

  /// <summary>
  /// Gets a list of changes that occurred on the synchronized folder.
  /// </summary>
  ChangeCollection<TChange> get Changes => this._changes;

  /// <summary>
  /// Gets a value indicating whether this request returns full or summary properties.
  /// </summary>
  bool get SummaryPropertiesOnly;
}
