import 'package:ews/Http/WebExceptionStatus.dart';

class WebException implements Exception {
  final WebExceptionStatus Status;
  final Object Response;

  WebException(this.Status, this.Response);
}