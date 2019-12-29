import 'dart:io';

import 'package:ews/Http/WebExceptionStatus.dart';

class WebException implements Exception {
  final WebExceptionStatus Status;
  final HttpClientRequest Request;
  final HttpClientResponse Response;

  WebException(this.Status, this.Request, this.Response);

  String get message => "$Status $Response";
}
