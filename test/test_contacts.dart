import 'package:ews/ComplexProperties/PhysicalAddressEntry.dart';
import 'package:ews/Core/Responses/FindItemResponse.dart';
import 'package:ews/Core/Responses/ServiceResponseCollection.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  test('searches contacts', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);
    final ContactsFolder contactsFolder =
        await ContactsFolder.BindWithWellKnownFolder(exchangeService, WellKnownFolderName.Contacts);

    // Set the number of items to the number of items in the Contacts folder or 50, whichever is smaller.
    int numItems = contactsFolder.TotalCount < 50 ? contactsFolder.TotalCount : 50;

    // Instantiate the item view with the number of items to retrieve from the Contacts folder.
    ItemView view = new ItemView.withPageSize(numItems);

    // To keep the request smaller, request only the display name property.
    view.PropertySet = new PropertySet(
        BasePropertySet.IdOnly, [ContactSchema.DisplayName, ContactSchema.EmailAddress1]);

    // Retrieve the items in the Contacts folder that have the properties that you selected.
    SearchFilter filter = ContainsSubString.withPropertyAndValue(ContactSchema.DisplayName, "qa1");
    ServiceResponseCollection<FindItemResponse<Item>> response =
        await exchangeService.FindItemsGeneric(
            [contactsFolder.Id], null, null, view, null, ServiceErrorHandling.ThrowOnError);

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
    final result = await exchangeService.ResolveName(secondaryUserCredential.user.substring(0, 2), null,
        ResolveNameSearchLocation.ContactsThenDirectory, true, null);
    result.forEach((nameResolution) {
      print(nameResolution.Contact.Id);
    });
  });

  test('creates contact', () async {
    final exchangeService = prepareExchangeService(primaryUserCredential);
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
    contact.FileAsMapping = FileAsMapping.SurnameCommaGivenName;
    await contact.Save();
    await contact.Delete(DeleteMode.HardDelete);
  });
}
