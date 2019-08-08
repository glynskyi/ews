# EWS

[![pub](https://img.shields.io/pub/v/ews)](https://pub.dartlang.org/packages/ews)
[![build](https://travis-ci.org/dmytro-glynskyi/ews.svg?branch=master)](https://travis-ci.org/dmytro-glynskyi/ews)
[![coverage](https://coveralls.io/repos/github/dmytro-glynskyi/ews/badge.svg?branch=master)](https://coveralls.io/github/dmytro-glynskyi/ews?branch=master)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/renggli/dart-xml/master/LICENSE)

This project is a Dart client library to access Microsoft Exchange web services. The library works against Office 365 Exchange Online as well as on premises Exchange.
By using it you can access almost all the information stored in an Office 365, Exchange Online, or Exchange Server mailbox.
However, this API is in sustaining mode, the recommended access pattern for Office 365 and Exchange online data is [Microsoft Graph](https://graph.microsoft.com)

## Getting started

In the library the ExchangeService class contains the methods and properties that are used to set user credentials, identify the Exchange Web Services endpoint, send and receive SOAP messages, and configure the connection with Exchange Web Services.
To perform an operation by using the library, you must set up the ExchangeService class.

```Dart
final service = ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1)
    ..Url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx")
    ..Credentials = WebCredentials("---USER_NAME---", "---USER_PASSWORD---", "---USER_DOMAIN---");
```

### Creating folders

The following code example shows how to create a folder with a custom folder class.

```Dart
final folder = new Folder(service)
    ..DisplayName = "Custom Folder"
    ..FolderClass = "IPF.MyCustomFolderClass";
await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);
```

### Creating custom extended properties 

The following code example shows how to create a new extended property, set a value for the extended property, and add it to a message.

```Dart
// Create a definition for the extended property.
final extendedPropertyDefinition = ExtendedPropertyDefinition.withDefaultPropertySetAndName(DefaultExtendedPropertySet.Common, "custom:MeetingDescription", MapiPropertyType.String);

// Create an e-mail message that you will add the extended property to.
final message = new EmailMessage(service)
    ..Subject = "Saved with the meeting description"
    ..Body = MessageBody.withText("The meeting description is contained within the extended property.")
    ..ToRecipients.Add(EmailAddress(smtpAddress: "user@contoso.com"))
    ..SetExtendedProperty(extendedPropertyDefinition, "The meeting purpose is make the right decision");

// Save the e-mail message.
await message.SendAndSaveCopy();
```

### Creating an appointment

The following code shows how to create an appointment and set a subject, a body, a start time, and an end time to one.

```Dart
final startTime = new DateTime(2019, 9, 9, 9, 10, 0);
final appointment = new Appointment(service)
  ..Subject = "Dentist Appointment"
  ..Body = MessageBody.withText("The appointment is with Dr. Smith.")
  ..Start = startTime
  ..End = startTime.add(Duration(hours: 2));

await appointment.SaveWithSendInvitationsMode(SendInvitationsMode.SendToNone);
```

## Support statement

Starting July 19th 2018, Exchange Web Services (EWS) will no longer receive feature updates. While the service will continue to receive security updates and certain non-security updates, product design and features will remain unchanged. This change also applies to the EWS SDKs for Java and .NET. More information here: https://developer.microsoft.com/en-us/graph/blogs/upcoming-changes-to-exchange-web-services-ews-api-for-office-365/

## Additional resources

See the following articles to help you get started:
- [Get started with EWS Managed API client applications](http://msdn.microsoft.com/en-us/library/office/dn567668(v=exchg.150).aspx)
- [How to: Reference the EWS Managed API assembly](http://msdn.microsoft.com/en-us/library/office/dn528373(v=exchg.150).aspx)
- [How to: Set the EWS service URL by using the EWS Managed API](http://msdn.microsoft.com/en-us/library/office/dn509511(v=exchg.150).aspx)
- [How to: Communicate with EWS by using the EWS Managed API](http://msdn.microsoft.com/en-us/library/office/dn467891(v=exchg.150).aspx)
- [How to: Trace requests and responses to troubleshoot EWS Managed API applications](http://msdn.microsoft.com/en-us/library/office/dn495632(v=exchg.150).aspx)

## Documentation

Documentation for the EWS Managed API is available in the [Web services](http://msdn.microsoft.com/en-us/library/office/dd877012(v=exchg.150).aspx) node of the [MSDN Library](http://msdn.microsoft.com/en-us/library/ms123401.aspx).
In addition to the getting started links provided, you can find how to topics and code samples for the most frequently used EWS Managed API objects in the [Develop](http://msdn.microsoft.com/en-us/library/office/jj900166(v=exchg.150).aspx) node. All the latest information about the EWS Managed API, EWS, and related web services can be found under the [Explore the EWS Managed API, EWS, and web services in Exchange](http://msdn.microsoft.com/en-us/library/office/jj536567(v=exchg.150).aspx) topic on MSDN.