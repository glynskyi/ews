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
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/LobbyBypass.dart' as enumerations;
import 'package:ews/Enumerations/OnlineMeetingAccessLevel.dart';
import 'package:ews/Enumerations/Presenters.dart' as enumerations;
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents Lync online meeting settings.
/// </summary>
class OnlineMeetingSettings extends ComplexProperty {
  /// <summary>
  /// Email address.
  /// </summary>
  /* private */ enumerations.LobbyBypass lobbyBypass;

  /// <summary>
  /// Routing type.
  /// </summary>
  /* private */
  OnlineMeetingAccessLevel accessLevel;

  /// <summary>
  /// Routing type.
  /// </summary>
  /* private */
  enumerations.Presenters presenters;

  /// <summary>
  /// Initializes a new instance of the <see cref="OnlineMeetingSettings"/> class.
  /// </summary>
  OnlineMeetingSettings() : super() {}

  /// <summary>
  /// Initializes a new instance of the <see cref="OnlineMeetingSettings"/> class.
  /// </summary>
  /// <param name="lobbyBypass">The address used to initialize the OnlineMeetingSettings.</param>
  /// <param name="accessLevel">The routing type used to initialize the OnlineMeetingSettings.</param>
  /// <param name="presenters">Mailbox type of the participant.</param>
  OnlineMeetingSettings.withParams(
      enumerations.LobbyBypass lobbyBypass,
      OnlineMeetingAccessLevel accessLevel,
      enumerations.Presenters presenters) {
    this.lobbyBypass = lobbyBypass;
    this.accessLevel = accessLevel;
    this.presenters = presenters;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="OnlineMeetingSettings"/> class from another OnlineMeetingSettings instance.
  /// </summary>
  /// <param name="onlineMeetingSettings">OnlineMeetingSettings instance to copy.</param>
  OnlineMeetingSettings.withOnlineMeetingSettings(
      OnlineMeetingSettings onlineMeetingSettings)
      : super() {
    EwsUtilities.ValidateParam(onlineMeetingSettings, "OnlineMeetingSettings");

    this.LobbyBypass = onlineMeetingSettings.LobbyBypass;
    this.AccessLevel = onlineMeetingSettings.AccessLevel;
    this.Presenters = onlineMeetingSettings.Presenters;
  }

  /// <summary>
  /// Gets or sets the online meeting setting that describes whether users dialing in by phone have to wait in the lobby.
  /// </summary>
  enumerations.LobbyBypass get LobbyBypass => this.lobbyBypass;

  set LobbyBypass(enumerations.LobbyBypass value) {
    if (this.CanSetFieldValue(this.lobbyBypass, value)) {
      this.lobbyBypass = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the online meeting setting that describes access permission to the meeting.
  /// </summary>
  OnlineMeetingAccessLevel get AccessLevel => this.accessLevel;

  set AccessLevel(OnlineMeetingAccessLevel value) {
    if (this.CanSetFieldValue(this.accessLevel, value)) {
      this.accessLevel = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Gets or sets the online meeting setting that defines the meeting leaders.
  /// </summary>
  enumerations.Presenters get Presenters => this.presenters;

  set Presenters(enumerations.Presenters value) {
    if (this.CanSetFieldValue(this.presenters, value)) {
      this.presenters = value;
      this.Changed();
    }
  }

  /// <summary>
  /// Tries to read element from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <returns>True if element was read.</returns>
  @override
  bool TryReadElementFromXml(EwsServiceXmlReader reader) {
    switch (reader.LocalName) {
      case XmlElementNames.LobbyBypass:
        this.lobbyBypass = reader.ReadElementValue<enumerations.LobbyBypass>();
        return true;
      case XmlElementNames.AccessLevel:
        this.accessLevel = reader.ReadElementValue<OnlineMeetingAccessLevel>();
        return true;
      case XmlElementNames.Presenters:
        this.presenters = reader.ReadElementValue<enumerations.Presenters>();
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Writes elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.LobbyBypass, this.LobbyBypass);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.AccessLevel, this.AccessLevel);
    writer.WriteElementValueWithNamespace(
        XmlNamespace.Types, XmlElementNames.Presenters, this.Presenters);
  }
}
