import 'dart:io';

import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

class EwsHttpWebExceptionResponse implements IEwsHttpWebResponse {
  final WebException _webException;

  EwsHttpWebExceptionResponse(this._webException);

  @override
  void Close() {
    throw NotImplementedException();
  }

  @override
  String get ContentEncoding =>
      this._webException.Response.headers[HttpHeaders.contentEncodingHeader]?.first ?? "";

  @override
  String get ContentType => this._webException.Response.headers.contentType?.value ?? "";

  @override
  Dispose() {
    throw NotImplementedException();
  }

  @override
  Stream<List<int>> GetResponseStream() {
    return this._webException.Response;
  }

  @override
  WebHeaderCollection get Headers {
    final headerCollection = WebHeaderCollection();
    _webException.Response.headers.forEach((headerName, headerValue) {
      headerCollection[headerName] = headerValue.join(";");
    });
    return headerCollection;
  }

  @override
  Uri get ResponseUri => _webException.Request!.uri;

  @override
  int get StatusCode => _webException.Response.statusCode;

  @override
  String get StatusDescription => _webException.Response.reasonPhrase;
}
