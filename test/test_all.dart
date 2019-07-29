import 'package:test/test.dart';

import 'test_folder_crud.dart' as test_folder_crud;
import 'test_folder_hierarhy.dart' as test_folder_hierarhy;
import 'test_calendar_folder.dart' as test_calendar_folder;

void main() {
  group("folder crud", test_folder_crud.main);
  group("folder hierarhy", test_folder_hierarhy.main);
  group("calendar folder", test_calendar_folder.main);
}
