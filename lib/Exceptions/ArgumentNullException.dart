import 'package:ews/Exceptions/ArgumentException.dart';

class ArgumentNullException extends ArgumentException {
  ArgumentNullException(String message) : super(message);

  @override
  String toString() {
    return 'ArgumentNullException{message: $message}';
  }
}
