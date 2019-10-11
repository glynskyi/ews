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









    import 'package:ews/Autodiscover/Requests/AutodiscoverRequest.dart';
import 'package:ews/Autodiscover/Responses/AutodiscoverResponse.dart';
import 'package:ews/Autodiscover/Responses/GetDomainSettingsResponseCollection.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/AutodiscoverErrorCode.dart';
import 'package:ews/Enumerations/DomainSettingName.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';
import 'package:ews/Exceptions/ServiceValidationException.dart';
import 'package:ews/misc/StringUtils.dart';

import '../AutodiscoverService.dart';

/// <summary>
    /// Represents a GetDomainSettings request.
    /// </summary>
    class GetDomainSettingsRequest extends AutodiscoverRequest
    {
        /// <summary>
        /// Action Uri of Autodiscover.GetDomainSettings method.
        /// </summary>
        /* private */ static const String GetDomainSettingsActionUri = EwsUtilities.AutodiscoverSoapNamespace + "/Autodiscover/GetDomainSettings";

        /* private */ List<String> domains;
        /* private */ List<DomainSettingName> settings;
        /* private */ ExchangeVersion requestedVersion;

        /// <summary>
        /// Initializes a new instance of the <see cref="GetDomainSettingsRequest"/> class.
        /// </summary>
        /// <param name="service">Autodiscover service associated with this request.</param>
        /// <param name="url">URL of Autodiscover service.</param>
        GetDomainSettingsRequest(AutodiscoverService service, Uri url)
            : super(service, url)
        {
        }

        /// <summary>
        /// Validates the request.
        /// </summary>
@override
        void Validate()
        {
            super.Validate();

            EwsUtilities.ValidateParam(this.Domains, "domains");
            EwsUtilities.ValidateParam(this.Settings, "settings");

            if (this.Settings.length == 0)
            {
                throw new ServiceValidationException("Strings.InvalidAutodiscoverSettingsCount");
            }

            if (domains.length == 0)
            {
                throw new ServiceValidationException("Strings.InvalidAutodiscoverDomainsCount");
            }

            for (String domain in this.domains)
            {
                if (StringUtils.IsNullOrEmpty(domain))
                {
                    throw new ServiceValidationException("Strings.InvalidAutodiscoverDomain");
                }
            }
        }

        /// <summary>
        /// Executes this instance.
        /// </summary>
        /// <returns></returns>
        Future<GetDomainSettingsResponseCollection> Execute() async
        {
            GetDomainSettingsResponseCollection responses = (await this.InternalExecute()) as GetDomainSettingsResponseCollection;
            if (responses.ErrorCode == AutodiscoverErrorCode.NoError)
            {
                this.PostProcessResponses(responses);
            }
            return responses;
        }

        /// <summary>
        /// Post-process responses to GetDomainSettings.
        /// </summary>
        /// <param name="responses">The GetDomainSettings responses.</param>
        /* private */ void PostProcessResponses(GetDomainSettingsResponseCollection responses)
        {
            // Note:The response collection may not include all of the requested domains if the request has been throttled.
            for (int index = 0; index < responses.Count; index++)
            {
                responses[index].Domain = this.Domains[index];
            }
        }

        /// <summary>
        /// Gets the name of the request XML element.
        /// </summary>
        /// <returns>Request XML element name.</returns>
@override
        String GetRequestXmlElementName()
        {
            return XmlElementNames.GetDomainSettingsRequestMessage;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>Response XML element name.</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.GetDomainSettingsResponseMessage;
        }

        /// <summary>
        /// Gets the WS-Addressing action name.
        /// </summary>
        /// <returns>WS-Addressing action name.</returns>
@override
        String GetWsAddressingActionName()
        {
            return GetDomainSettingsActionUri;
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <returns>AutodiscoverResponse</returns>
@override
        AutodiscoverResponse CreateServiceResponse()
        {
            return new GetDomainSettingsResponseCollection();
        }

        /// <summary>
        /// Writes the attributes to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteAttributesToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteAttributeValueWithPrefix(
                "xmlns",
                EwsUtilities.AutodiscoverSoapNamespacePrefix,
                EwsUtilities.AutodiscoverSoapNamespace);
        }

        /// <summary>
        /// Writes request to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteStartElement(XmlNamespace.Autodiscover, XmlElementNames.Request);

            writer.WriteStartElement(XmlNamespace.Autodiscover, XmlElementNames.Domains);

            for (String domain in this.Domains)
            {
                if (!StringUtils.IsNullOrEmpty(domain))
                {
                    writer.WriteElementValueWithNamespace(
                        XmlNamespace.Autodiscover,
                        XmlElementNames.Domain,
                        domain);
                }
            }
            writer.WriteEndElement(); // Domains

            writer.WriteStartElement(XmlNamespace.Autodiscover, XmlElementNames.RequestedSettings);
            for (DomainSettingName setting in settings)
            {
                writer.WriteElementValueWithNamespace(
                    XmlNamespace.Autodiscover,
                    XmlElementNames.Setting,
                    setting);
            }

            writer.WriteEndElement(); // RequestedSettings

            if (this.requestedVersion != null)
            {
                writer.WriteElementValueWithNamespace(XmlNamespace.Autodiscover, XmlElementNames.RequestedVersion, this.requestedVersion.Value);
            }

            writer.WriteEndElement(); // Request
        }

        /// <summary>
        /// Gets or sets the domains.
        /// </summary>
    List<String> get Domains => this.domains;
    set Domains(List<String> value) => this.domains = value;


        /// <summary>
        /// Gets or sets the settings.
        /// </summary>
    List<DomainSettingName> get Settings => this.settings;
    set Settings(List<DomainSettingName> value) => this.settings = value;


        /// <summary>
        /// Gets or sets the RequestedVersion.
        /// </summary>
      ExchangeVersion get RequestedVersion => this.requestedVersion;
      set RequestedVersion(ExchangeVersion value) => this.requestedVersion = value;
    }
