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

import 'package:ews/Autodiscover/DomainSettingError.dart';
import 'package:ews/Autodiscover/Responses/AutodiscoverResponse.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/EwsXmlReader.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/DomainSettingName.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Xml/XmlNodeType.dart';

/// <summary>
/// Represents the response to a GetDomainSettings call for an individual domain.
/// </summary>
class GetDomainSettingsResponse extends AutodiscoverResponse {
  String? _domain;

  String? _redirectTarget;

  Map<DomainSettingName?, Object?>? _settings;

  List<DomainSettingError>? _domainSettingErrors;

  /// <summary>
  /// Initializes a new instance of the <see cref="GetDomainSettingsResponse"/> class.
  /// </summary>
  GetDomainSettingsResponse() : super() {
    this._domain = "";
    this._settings = new Map<DomainSettingName?, Object?>();
    this._domainSettingErrors = <DomainSettingError>[];
  }

  /// <summary>
  /// Gets the domain this response applies to.
  /// </summary>
  String? get Domain => this._domain;

  set Domain(String? value) => this._domain = value;

  /// <summary>
  /// Gets the redirectionTarget (URL or email address)
  /// </summary>
  String? get RedirectTarget => this._redirectTarget;

  /// <summary>
  /// Gets the requested settings for the domain.
  /// </summary>
  Map<DomainSettingName?, Object?>? get Settings => this._settings;

  /// <summary>
  /// Gets error information for settings that could not be returned.
  /// </summary>
  List<DomainSettingError>? get DomainSettingErrors => this._domainSettingErrors;

  /// <summary>
  /// Loads response from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /// <param name="endElementName">End element name.</param>
  @override
  void LoadFromXml(EwsXmlReader reader, String endElementName) {
    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.RedirectTarget:
            this._redirectTarget = reader.ReadElementValue<String>();
            break;
          case XmlElementNames.DomainSettingErrors:
            this.LoadDomainSettingErrorsFromXml(reader);
            break;
          case XmlElementNames.DomainSettings:
            this.LoadDomainSettingsFromXml(reader);
            break;
          default:
            super.LoadFromXml(reader, endElementName);
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, endElementName));
  }

  /// <summary>
  /// Loads from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  void LoadDomainSettingsFromXml(EwsXmlReader reader) {
    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if ((reader.NodeType == XmlNodeType.Element) &&
            (reader.LocalName == XmlElementNames.DomainSetting)) {
          String? settingClass = reader.ReadAttributeValueWithNamespace(
              XmlNamespace.XmlSchemaInstance, XmlAttributeNames.Type);

          switch (settingClass) {
            case XmlElementNames.DomainStringSetting:
              this.ReadSettingFromXml(reader);
              break;

            default:
              EwsUtilities.Assert(
                  false,
                  "GetDomainSettingsResponse.LoadDomainSettingsFromXml",
                  "Invalid setting class '$settingClass' returned");
              break;
          }
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Autodiscover, XmlElementNames.DomainSettings));
    }
  }

  /// <summary>
  /// Reads domain setting from XML.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /* private */
  void ReadSettingFromXml(EwsXmlReader reader) {
    DomainSettingName? name = null;
    Object? value = null;

    do {
      reader.Read();

      if (reader.NodeType == XmlNodeType.Element) {
        switch (reader.LocalName) {
          case XmlElementNames.Name:
            name = reader.ReadElementValue<DomainSettingName>();
            break;
          case XmlElementNames.Value:
            value = reader.ReadElementValue<String>();
            break;
        }
      }
    } while (!reader.IsEndElementWithNamespace(
        XmlNamespace.Autodiscover, XmlElementNames.DomainSetting));

    EwsUtilities.Assert(
        name != null,
        "GetDomainSettingsResponse.ReadSettingFromXml",
        "Missing name element in domain setting");

    this._settings![name] = value;
  }

  /// <summary>
  /// Loads the domain setting errors.
  /// </summary>
  /// <param name="reader">The reader.</param>
  /* private */
  void LoadDomainSettingErrorsFromXml(EwsXmlReader reader) {
    if (!reader.IsEmptyElement) {
      do {
        reader.Read();

        if ((reader.NodeType == XmlNodeType.Element) &&
            (reader.LocalName == XmlElementNames.DomainSettingError)) {
          DomainSettingError error = new DomainSettingError();
          error.LoadFromXml(reader);
          _domainSettingErrors!.add(error);
        }
      } while (!reader.IsEndElementWithNamespace(
          XmlNamespace.Autodiscover, XmlElementNames.DomainSettingErrors));
    }
  }
}
