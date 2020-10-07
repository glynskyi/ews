import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Http/CookieContainer.dart' as http;
import 'package:ews/Http/EwsHttpWebResponse.dart';
import 'package:ews/Http/ICredentials.dart';
import 'package:ews/Http/IWebProxy.dart';
import 'package:ews/Http/WebCredentials.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebExceptionStatus.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Http/X509CertificateCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

class EwsHttpWebRequest implements IEwsHttpWebRequest {
  @override
  String Accept;

  @override
  bool AllowAutoRedirect;

  @override
  X509CertificateCollection ClientCertificates;

  @override
  String ConnectionGroupName;

  @override
  String ContentType;

  @override
  http.CookieContainer CookieContainer;

  @override
  ICredentials Credentials;

  @override
  WebHeaderCollection Headers = WebHeaderCollection();

  @override
  bool KeepAlive;

  @override
  String Method;

  @override
  bool PreAuthenticate;

  @override
  IWebProxy Proxy;

  @override
  Uri RequestUri;

  @override
  int Timeout;

  @override
  bool UseDefaultCredentials;

  @override
  String UserAgent;

  @override
  void Abort() {
    // TODO: implement Abort
  }

  HttpClientRequest _request;

  @override
  Future<StreamConsumer<List<int>>> GetRequestStream() async {
    return _InternalGetRequest();
  }

  Future<HttpClientRequest> _InternalGetRequest() async {
    if (_request == null) {
      final client = HttpClient();
      if (Method == "POST") {
        _request = await client.postUrl(RequestUri);
      } else if (Method == "GET") {
        _request = await client.getUrl(RequestUri);
      } else {
        throw ArgumentException("Method: $Method, Unknown HTTP method");
      }
      _request.followRedirects = AllowAutoRedirect;

      if (Credentials != null) {
        final user = (Credentials as WebCredentials).user;
        String password = (Credentials as WebCredentials).pwd;
        String auth = 'Basic ' + base64Encode(utf8.encode('$user:$password'));
        _request.headers.add("Authorization", auth);
      }

      if (this.Accept != null) {
        _request.headers.add("Accept", this.Accept);
      }
      if (this.ContentType != null) {
        _request.headers.add("Content-Type", this.ContentType);
      }
    }
    return _request;
  }

  @override
  Future<IEwsHttpWebResponse> GetResponse() async {
    final request = await _InternalGetRequest();
    final HttpClientResponse response = await request.close();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw new WebException(
          WebExceptionStatus.ProtocolError, _request, response);
    }
    return EwsHttpWebResponse(this, response);
  }
}
