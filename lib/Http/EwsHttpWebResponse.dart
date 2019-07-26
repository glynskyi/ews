import 'dart:io';

import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Http/EwsHttpWebRequest.dart';
import 'package:ews/Http/HttpStatusCode.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

class EwsHttpWebResponse implements IEwsHttpWebResponse {
  EwsHttpWebRequest request;
  HttpClientResponse httpClientResponse;

  EwsHttpWebResponse(this.request, this.httpClientResponse);

  @override
  void Close() {
//    throw NotImplementedException("Close");
  }

  @override
  String get ContentEncoding => this.httpClientResponse.headers[HttpHeaders.contentEncodingHeader]?.first ?? "";

  @override
  String get ContentType => this.httpClientResponse.headers.contentType?.value ?? "";

  @override
  Dispose() {
    throw NotImplementedException("Dispose");
    return null;
  }

  @override
  Stream<List<int>> GetResponseStream() {
    return this.httpClientResponse;
  }

  @override
  WebHeaderCollection get Headers {
    final headers = WebHeaderCollection();
    this.httpClientResponse.headers.forEach((header, values) {
      headers[header] = values.join(",");
    });
    return headers;
  }

  @override
  Uri get ResponseUri => throw NotImplementedException("Headers");

  @override
  HttpStatusCode get StatusCode => throw NotImplementedException("StatusCode");

  @override
  String get StatusDescription => throw NotImplementedException("StatusDescription");

}