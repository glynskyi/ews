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

/// <summary>
/// The Enum UserSettingName.
/// </summary>
/// <remarks>
/// Add new values to the end and keep in sync with Microsoft.Exchange.Autodiscover.ConfigurationSettings.UserConfigurationSettingName.
/// </remarks>
enum UserSettingName {
  /// <summary>
  /// The display name of the user.
  /// </summary>
  UserDisplayName,

  /// <summary>
  /// The legacy distinguished name of the user.
  /// </summary>
  UserDN,

  /// <summary>
  /// The deployment Id of the user.
  /// </summary>
  UserDeploymentId,

  /// <summary>
  /// The fully qualified domain name of the mailbox server.
  /// </summary>
  InternalMailboxServer,

  /// <summary>
  /// The fully qualified domain name of the RPC client server.
  /// </summary>
  InternalRpcClientServer,

  /// <summary>
  /// The legacy distinguished name of the mailbox server.
  /// </summary>
  InternalMailboxServerDN,

  /// <summary>
  /// The URL of the Exchange Control Panel.
  /// </summary>
  InternalEcpUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for VoiceMail Customization.
  /// </summary>
  InternalEcpVoicemailUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for Email Subscriptions.
  /// </summary>
  InternalEcpEmailSubscriptionsUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for Text Messaging.
  /// </summary>
  InternalEcpTextMessagingUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for Delivery Reports.
  /// </summary>
  InternalEcpDeliveryReportUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for RetentionPolicy Tags.
  /// </summary>
  InternalEcpRetentionPolicyTagsUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for Publishing.
  /// </summary>
  InternalEcpPublishingUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for photos.
  /// </summary>
  InternalEcpPhotoUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for People Connect subscriptions.
  /// </summary>
  InternalEcpConnectUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for Team Mailbox.
  /// </summary>
  InternalEcpTeamMailboxUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for creating Team Mailbox.
  /// </summary>
  InternalEcpTeamMailboxCreatingUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for editing Team Mailbox.
  /// </summary>
  InternalEcpTeamMailboxEditingUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for hiding Team Mailbox.
  /// </summary>
  InternalEcpTeamMailboxHidingUrl,

  /// <summary>
  /// The URL of the Exchange Control Panel for the extension installation.
  /// </summary>
  InternalEcpExtensionInstallationUrl,

  /// <summary>
  /// The URL of the Exchange Web Services.
  /// </summary>
  InternalEwsUrl,

  /// <summary>
  /// The URL of the Exchange Management Web Services.
  /// </summary>
  InternalEmwsUrl,

  /// <summary>
  /// The URL of the Offline Address Book.
  /// </summary>
  InternalOABUrl,

  /// <summary>
  /// The URL of the Photos service.
  /// </summary>
  InternalPhotosUrl,

  /// <summary>
  /// The URL of the Unified Messaging services.
  /// </summary>
  InternalUMUrl,

  /// <summary>
  /// The URLs of the Exchange web client.
  /// </summary>
  InternalWebClientUrls,

  /// <summary>
  /// The distinguished name of the mailbox database of the user's mailbox.
  /// </summary>
  MailboxDN,

  /// <summary>
  /// The name of the Public Folders server.
  /// </summary>
  PublicFolderServer,

  /// <summary>
  /// The name of the Active Directory server.
  /// </summary>
  ActiveDirectoryServer,

  /// <summary>
  /// The name of the RPC over HTTP server.
  /// </summary>
  ExternalMailboxServer,

  /// <summary>
  /// Indicates whether the RPC over HTTP server requires SSL.
  /// </summary>
  ExternalMailboxServerRequiresSSL,

  /// <summary>
  /// The authentication methods supported by the RPC over HTTP server.
  /// </summary>
  ExternalMailboxServerAuthenticationMethods,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for VoiceMail Customization.
  /// </summary>
  EcpVoicemailUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for Email Subscriptions.
  /// </summary>
  EcpEmailSubscriptionsUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for Text Messaging.
  /// </summary>
  EcpTextMessagingUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for Delivery Reports.
  /// </summary>
  EcpDeliveryReportUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for RetentionPolicy Tags.
  /// </summary>
  EcpRetentionPolicyTagsUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for Publishing.
  /// </summary>
  EcpPublishingUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for photos.
  /// </summary>
  EcpPhotoUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for People Connect.
  /// </summary>
  EcpConnectUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for Team Mailbox.
  /// </summary>
  EcpTeamMailboxUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for creating Team Mailbox.
  /// </summary>
  EcpTeamMailboxCreatingUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for editing Team Mailbox.
  /// </summary>
  EcpTeamMailboxEditingUrlFragment,

  /// <summary>
  /// The URL fragment of the Exchange Control Panel for installing extension.
  /// </summary>
  EcpExtensionInstallationUrlFragment,

  /// <summary>
  /// The external URL of the Exchange Control Panel.
  /// </summary>
  ExternalEcpUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for VoiceMail Customization.
  /// </summary>
  ExternalEcpVoicemailUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for Email Subscriptions.
  /// </summary>
  ExternalEcpEmailSubscriptionsUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for Text Messaging.
  /// </summary>
  ExternalEcpTextMessagingUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for Delivery Reports.
  /// </summary>
  ExternalEcpDeliveryReportUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for RetentionPolicy Tags.
  /// </summary>
  ExternalEcpRetentionPolicyTagsUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for Publishing.
  /// </summary>
  ExternalEcpPublishingUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for photos.
  /// </summary>
  ExternalEcpPhotoUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for People Connect subscriptions.
  /// </summary>
  ExternalEcpConnectUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for Team Mailbox.
  /// </summary>
  ExternalEcpTeamMailboxUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for creating Team Mailbox.
  /// </summary>
  ExternalEcpTeamMailboxCreatingUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for editing Team Mailbox.
  /// </summary>
  ExternalEcpTeamMailboxEditingUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for hiding Team Mailbox.
  /// </summary>
  ExternalEcpTeamMailboxHidingUrl,

  /// <summary>
  /// The external URL of the Exchange Control Panel for the extension installation.
  /// </summary>
  ExternalEcpExtensionInstallationUrl,

  /// <summary>
  /// The external URL of the Exchange Web Services.
  /// </summary>
  ExternalEwsUrl,

  /// <summary>
  /// The external URL of the Exchange Management Web Services.
  /// </summary>
  ExternalEmwsUrl,

  /// <summary>
  /// The external URL of the Offline Address Book.
  /// </summary>
  ExternalOABUrl,

  /// <summary>
  /// The external URL of the Photos service.
  /// </summary>
  ExternalPhotosUrl,

  /// <summary>
  /// The external URL of the Unified Messaging services.
  /// </summary>
  ExternalUMUrl,

  /// <summary>
  /// The external URLs of the Exchange web client.
  /// </summary>
  ExternalWebClientUrls,

  /// <summary>
  /// Indicates that cross-organization sharing is enabled.
  /// </summary>
  CrossOrganizationSharingEnabled,

  /// <summary>
  /// Collection of alternate mailboxes.
  /// </summary>
  AlternateMailboxes,

  /// <summary>
  /// The version of the Client Access Server serving the request (e.g. 14.XX.YYY.ZZZ)
  /// </summary>
  CasVersion,

  /// <summary>
  /// Comma-separated list of schema versions supported by Exchange Web Services. The schema version values
  /// will be the same as the values of the ExchangeServerVersion enumeration.
  /// </summary>
  EwsSupportedSchemas,

  /// <summary>
  /// The connection settings list for pop protocol
  /// </summary>
  InternalPop3Connections,

  /// <summary>
  /// The external connection settings list for pop protocol
  /// </summary>
  ExternalPop3Connections,

  /// <summary>
  /// The connection settings list for imap4 protocol
  /// </summary>
  InternalImap4Connections,

  /// <summary>
  /// The external connection settings list for imap4 protocol
  /// </summary>
  ExternalImap4Connections,

  /// <summary>
  /// The connection settings list for smtp protocol
  /// </summary>
  InternalSmtpConnections,

  /// <summary>
  /// The external connection settings list for smtp protocol
  /// </summary>
  ExternalSmtpConnections,

  /// <summary>
  /// If set to "Off" then clients should not connect via this protocol.
  /// The protocol contents are for informational purposes only.
  /// </summary>
  InternalServerExclusiveConnect,

  /// <summary>
  /// The version of the Exchange Web Services server ExternalEwsUrl is pointing to.
  /// </summary>
  ExternalEwsVersion,

  /// <summary>
  /// Mobile Mailbox policy settings.
  /// </summary>
  MobileMailboxPolicy,

  /// <summary>
  /// Document sharing locations and their settings.
  /// </summary>
  DocumentSharingLocations,

  /// <summary>
  /// Whether the user account is an MSOnline account.
  /// </summary>
  UserMSOnline,

  /// <summary>
  /// The authentication methods supported by the RPC client server.
  /// </summary>
  InternalMailboxServerAuthenticationMethods,

  /// <summary>
  /// Version of the server hosting the user's mailbox.
  /// </summary>
  MailboxVersion,

  /// <summary>
  /// Sharepoint MySite Host URL.
  /// </summary>
  SPMySiteHostURL,

  /// <summary>
  /// Site mailbox creation URL in SharePoint.
  /// It's used by Outlook to create site mailbox from SharePoint directly.
  /// </summary>
  SiteMailboxCreationURL,

  /// <summary>
  /// The FQDN of the server used for RPC/HTTP connectivity.
  /// </summary>
  InternalRpcHttpServer,

  /// <summary>
  /// Indicates whether SSL is required for RPC/HTTP connectivity.
  /// </summary>
  InternalRpcHttpConnectivityRequiresSsl,

  /// <summary>
  /// The authentication method used for RPC/HTTP connectivity.
  /// </summary>
  InternalRpcHttpAuthenticationMethod,

  /// <summary>
  /// If set to "On" then clients should only connect via this protocol.
  /// </summary>
  ExternalServerExclusiveConnect,

  /// <summary>
  /// If set, then clients can call the server via XTC
  /// </summary>
  ExchangeRpcUrl,

  /// <summary>
  /// If set to false then clients should not show the GAL by default, but show the contact list.
  /// </summary>
  ShowGalAsDefaultView,

  /// <summary>
  /// AutoDiscover Primary SMTP Address for the user.
  /// </summary>
  AutoDiscoverSMTPAddress,

  /// <summary>
  /// The 'interop' external URL of the Exchange Web Services.
  /// By interop it means a URL to E14 (or later) server that can serve mailboxes
  /// that are hosted in downlevel server (E2K3 and earlier).
  /// </summary>
  InteropExternalEwsUrl,

  /// <summary>
  /// Version of server InteropExternalEwsUrl is pointing to.
  /// </summary>
  InteropExternalEwsVersion,

  /// <summary>
  /// Public Folder (Hierarchy) information
  /// </summary>
  PublicFolderInformation,

  /// <summary>
  /// The version appropriate URL of the AutoDiscover service that should answer this query.
  /// </summary>
  RedirectUrl,

  /// <summary>
  /// The URL of the Exchange Web Services for Office365 partners.
  /// </summary>
  EwsPartnerUrl,

  /// <summary>
  /// SSL certificate name
  /// </summary>
  CertPrincipalName,

  /// <summary>
  /// The grouping hint for certain clients.
  /// </summary>
  GroupingInformation,

  /// <summary>
  /// OutlookService URL
  /// </summary>
  InternalOutlookServiceUrl,

  /// <summary>
  /// External OutlookService URL
  /// </summary>
  ExternalOutlookServiceUrl
}
