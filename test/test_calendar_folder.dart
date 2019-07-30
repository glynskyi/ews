import 'dart:convert';

import 'package:ews/Enumerations/ItemTraversal.dart';
import 'package:ews/ews.dart';
import 'package:ews/misc/Std/EnumToString.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  test('load events', () async {
    final service = prepareExchangeService(primaryUserCredential);
    DateTime startDate = DateTime.now().subtract(Duration(days: 31));
    DateTime endDate = DateTime.now().add(Duration(days: 365));
    const int NUM_APPTS = 50;

//    ExtendedPropertyDefinition extendedPropertyDefinition =
//    new ExtendedPropertyDefinition.withPropertySetAndId(PropertySetId., "Expiration Date", MapiPropertyType.String);

    // Initialize the calendar folder object with only the folder ID.
    CalendarFolder calendar = await CalendarFolder.BindWithWellKnownFolderAndPropertySet(
        service, WellKnownFolderName.Calendar, PropertySet.idOnly());

    // Set the start and end time and number of appointments to retrieve.
    CalendarView cView = new CalendarView.withMaxItemsReturned(startDate, endDate, NUM_APPTS);

    // Limit the properties returned to the appointment's subject, start time, and end time.
    final specialProperty = ExtendedPropertyDefinition.withDefaultPropertySetAndId(
        DefaultExtendedPropertySet.Meeting, 3, MapiPropertyType.Binary);
    cView.PropertySet = new PropertySet.fromPropertyDefinitions([
      specialProperty,
      ItemSchema.Subject,
      AppointmentSchema.Start,
      AppointmentSchema.End,
      AppointmentSchema.AppointmentType,
      AppointmentSchema.Duration
    ]);

    // Retrieve a collection of appointments by using the calendar view.
    FindItemsResults<Appointment> appointments = await calendar.FindAppointments(cView);

    print("MoreAvailable : ${appointments.moreAvailable}");

    for (Appointment a in appointments) {
      if (a.ExtendedProperties.isNotEmpty) {
        final specialPropertyValue = a.ExtendedProperties.first;
        print("3: " + base64.encode(specialPropertyValue.Value) + " ");
      }
//      print("ICalUid: " + a.ICalUid.toString() + " ");
      print("Subject: " + a.Subject.toString() + " ");
      print("Start: " + a.Start.toString() + " ");
      print("End: " + a.End.toString());
      print("Duration: " + a.Duration.toString());
//      print("IsCancelled: " + (a.IsCancelled ?? false).toString());
      print("Appointment Type: " + EnumToString.parse(a.AppointmentType));

//      final fullAppointment = await Appointment
//          .BindWithItemIdAndPropertySet(service, a.Id, new PropertySet.fromPropertyDefinitions([AppointmentSchema.RequiredAttendees, AppointmentSchema.OptionalAttendees]));
//
//      print("Required Attendess: " + fullAppointment.RequiredAttendees.join(", "));
      print("");
    }
  });
}
