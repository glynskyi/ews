import 'package:collection/collection.dart' show IterableExtension;

class EnumToString {
  static String? parse(Object? enumItem) {
    if (enumItem == null) return null;
    return enumItem.toString().split('.')[1];
  }

  static T? fromString<T>(List<T> enumValues, String? value) {
    if (value == null) return null;

    return enumValues
        .singleWhereOrNull((enumItem) => EnumToString.parse(enumItem) == value);
  }
}
