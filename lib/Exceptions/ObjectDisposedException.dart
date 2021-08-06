import 'package:ews/Exceptions/InvalidOperationException.dart';

class ObjectDisposedException extends InvalidOperationException {
  ObjectDisposedException(String errorMessage) : super(errorMessage);
}
