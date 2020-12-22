import 'package:ews/ComplexProperties/PhysicalAddressEntry.dart';
import 'package:ews/Core/PropertySet.dart';
import 'package:ews/Core/Responses/FindItemResponse.dart';
import 'package:ews/Core/Responses/ServiceResponseCollection.dart';
import 'package:ews/Enumerations/Enumerations.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';
import 'package:uuid_enhanced/uuid.dart';

import '_shared.dart';

main() {
  test('searches contacts', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);
    final ContactsFolder contactsFolder =
        await ContactsFolder.BindWithWellKnownFolder(
            exchangeService, WellKnownFolderName.Contacts);

    // Set the number of items to the number of items in the Contacts folder or 50, whichever is smaller.
    int numItems =
        contactsFolder.TotalCount < 50 ? contactsFolder.TotalCount : 50;

    // Instantiate the item view with the number of items to retrieve from the Contacts folder.
    ItemView view = new ItemView.withPageSize(numItems);

    // To keep the request smaller, request only the display name property.
    view.PropertySet = new PropertySet(BasePropertySet.IdOnly,
        [ContactSchema.DisplayName, ContactSchema.EmailAddress1]);

    // Retrieve the items in the Contacts folder that have the properties that you selected.
    SearchFilter filter = ContainsSubString.withPropertyAndValue(
        ContactSchema.DisplayName, "qa1");
    ServiceResponseCollection<FindItemResponse<Item>> response =
        await exchangeService.FindItemsGeneric([contactsFolder.Id], null, null,
            view, null, ServiceErrorHandling.ThrowOnError);

    response.first.Results.Items.forEach((contact) {
      expect(contact.Id, isNotNull);
    });
  });

  test('resolves name', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);
    final result = await exchangeService.ResolveNameSimple("qa");
    result.forEach((nameResolution) {
      print(nameResolution.Mailbox.Address);
    });
  });

  test('resolves name with contacts', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);
    await exchangeService.ResolveName(
        secondaryUserCredential.user.substring(0, 2),
        null,
        ResolveNameSearchLocation.ContactsThenDirectory,
        true,
        null);
  });

  test('resolves name with contact photos', () async {
    final exchangeService = prepareExchangeService(
        primaryUserCredential, ExchangeVersion.Exchange2010_SP1);
    final response = await exchangeService.ResolveName(
        secondaryUserCredential.user,
        null,
        ResolveNameSearchLocation.ContactsThenDirectory,
        true,
        PropertySet.FirstClassProperties);
    expect(response.first.Contact.DirectoryPhoto.length, greaterThan(0));
  });

  test('creates contact', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);

    final folder = Folder(exchangeService);
    folder.DisplayName = "${Uuid.randomUuid()}";
    folder.FolderClass = "IPF.Contact";
    await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Contacts);

    final contact = Contact(exchangeService);
    contact.GivenName = "GivenName";
    contact.Surname = "Surname";
    contact.EmailAddresses[EmailAddressKey.EmailAddress1] =
        EmailAddress(smtpAddress: "test@gmail.com");
    contact.PhoneNumbers[PhoneNumberKey.BusinessPhone] = "093 76-71-0111";
    contact.PhoneNumbers[PhoneNumberKey.MobilePhone] = "093 76-71-0222";
    contact.PhysicalAddresses[PhysicalAddressKey.Home] = PhysicalAddressEntry()
      ..CountryOrRegion = "Ukraine"
      ..City = "Kharkiv"
      ..Street = "Hrushevsky 23";
    contact.ImAddresses[ImAddressKey.ImAddress1] = "1234566";
    contact.FileAsMapping = FileAsMapping.Company;
    contact.Birthday = DateTime.utc(1988, 11, 22);
    await contact.SaveWithFolderId(folder.Id);

    await exchangeService.SyncFolderItems(
        folder.Id,
        PropertySet.fromPropertyDefinitions([
          ContactSchema.FileAsMapping,
          ContactSchema.GivenName,
          ContactSchema.Surname,
        ]),
        [],
        100,
        SyncFolderItemsScope.NormalItems,
        null);

    final savedContact = await Contact.BindWithItemIdAndPropertySet(
        exchangeService,
        contact.Id,
        PropertySet.fromPropertyDefinitions([
          ContactSchema.FileAsMapping,
          ContactSchema.GivenName,
          ContactSchema.Surname,
          ContactSchema.BusinessPhone,
          ContactSchema.MobilePhone,
          ContactSchema.Birthday,
        ]));

    expect(savedContact.GivenName, contact.GivenName);
    expect(savedContact.Surname, contact.Surname);
    expect(savedContact.FileAsMapping, contact.FileAsMapping);
    expect(savedContact.PhoneNumbers[PhoneNumberKey.BusinessPhone],
        "093 76-71-0111");
    expect(savedContact.PhoneNumbers[PhoneNumberKey.MobilePhone],
        "093 76-71-0222");
    expect(savedContact.Birthday.year, 1988);
    expect(savedContact.Birthday.month, 11);
    expect(savedContact.Birthday.day, 22);

    await folder.Delete(DeleteMode.HardDelete);
  });

  test('updates contact', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);

    final sourceContact = Contact(exchangeService);
    sourceContact.GivenName = "GivenName";
    sourceContact.Surname = "Surname";
    sourceContact.EmailAddresses[EmailAddressKey.EmailAddress1] =
        EmailAddress(smtpAddress: "test@gmail.com");
    sourceContact.PhoneNumbers[PhoneNumberKey.BusinessPhone] = "093 76-71-0111";
    sourceContact.PhoneNumbers[PhoneNumberKey.MobilePhone] = "093 76-71-0222";
    sourceContact.PhysicalAddresses[PhysicalAddressKey.Home] =
        PhysicalAddressEntry()
          ..CountryOrRegion = "Ukraine"
          ..City = "Kharkiv"
          ..Street = "Hrushevsky 23";
    sourceContact.ImAddresses[ImAddressKey.ImAddress1] = "1234566";
    sourceContact.FileAsMapping = FileAsMapping.Company;
    await sourceContact.SaveWithFolderId(
        FolderId.fromWellKnownFolder(WellKnownFolderName.Contacts));

    final updatedContact =
        await Contact.BindWithItemId(exchangeService, sourceContact.Id);
    updatedContact.GivenName = "GivenName 2";
    updatedContact.PhysicalAddresses[PhysicalAddressKey.Home] = null;
    updatedContact.PhysicalAddresses[PhysicalAddressKey.Home] =
        PhysicalAddressEntry()
          ..CountryOrRegion = "USA"
          ..City = "Ostin"
          ..State = "Texas"
          ..Street = "W Martin Luther King Jr Blvd";
    updatedContact.PhoneNumbers[PhoneNumberKey.BusinessPhone] =
        "093 76-71-0333";
    await updatedContact.Update(ConflictResolutionMode.AlwaysOverwrite);

    final contact =
        await Contact.BindWithItemId(exchangeService, updatedContact.Id);
    expect(
        contact.PhoneNumbers[PhoneNumberKey.BusinessPhone], "093 76-71-0333");
    expect(contact.PhysicalAddresses[PhysicalAddressKey.Home].City, "Ostin");
  });
}
