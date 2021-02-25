import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Http/CookieContainer.dart' as http;
import 'package:ews/Http/EwsHttpWebResponse.dart';
import 'package:ews/Http/ICredentials.dart';
import 'package:ews/Http/IWebProxy.dart';
import 'package:ews/Http/OAuthCredentials.dart';
import 'package:ews/Http/WebCredentials.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebExceptionStatus.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Http/X509CertificateCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

class EwsHttpWebRequest implements IEwsHttpWebRequest {
  @override
  String? Accept;

  @override
  bool? AllowAutoRedirect;

  @override
  X509CertificateCollection? ClientCertificates;

  @override
  String? ConnectionGroupName;

  @override
  String? ContentType;

  @override
  http.CookieContainer? CookieContainer;

  @override
  ICredentials? Credentials;

  @override
  WebHeaderCollection? Headers = WebHeaderCollection();

  @override
  bool? KeepAlive;

  @override
  String? Method;

  @override
  bool? PreAuthenticate;

  @override
  IWebProxy? Proxy;

  @override
  Uri? RequestUri;

  @override
  int? Timeout;

  @override
  bool? UseDefaultCredentials;

  @override
  String? UserAgent;

  @override
  void Abort() {
    // TODO: implement Abort
  }

  late HttpClient _httpClient;

  HttpClientRequest? _request;

  EwsHttpWebRequest();

  @override
  Future<StreamConsumer<List<int>>> GetRequestStream() async {
    return _InternalGetRequest();
  }

  Future<HttpClientRequest> _InternalGetRequest() async {
    if (_request == null) {
      _httpClient = HttpClient();
      if (this.Timeout != null) {
        _httpClient.connectionTimeout = Duration(milliseconds: this.Timeout!);
      }

      if (this.UserAgent != null) {
        _httpClient.userAgent = this.UserAgent;
      }

      if (Method == "POST") {
        _request = await _httpClient.postUrl(RequestUri!);
      } else if (Method == "GET") {
        _request = await _httpClient.getUrl(RequestUri!);
      } else {
        throw ArgumentException("Method: $Method, Unknown HTTP method");
      }
      _request!.followRedirects = AllowAutoRedirect!;

      if (Credentials != null) {
        final credentials = Credentials;
        if (credentials is WebCredentials) {
          final secret = "${credentials.userName}:${credentials.password}";
          final encodedSecret = base64Encode(utf8.encode(secret));
          _request!.headers.add("Authorization", "Basic $encodedSecret");
        } else if (credentials is OAuthCredentials) {
          final token = credentials.accessToken;
          _request!.headers.add("Authorization", "Bearer $token");
        } else {
          throw ArgumentError.value(
              credentials, "Credentials", "Unknown credentials type");
        }
      }

      if (this.Accept != null) {
        _request!.headers.add("Accept", this.Accept!);
      }

      if (this.ContentType != null) {
        _request!.headers.add("Content-Type", this.ContentType!);
      }

      if (this.KeepAlive == true) {
        _request!.headers.add("Connection", "Keep-Alive");
        _request!.headers.add("Keep-Alive", "300");
      }
    }
    return _request!;
  }

  @override
  Future<IEwsHttpWebResponse> GetResponse() async {
    final request = await _InternalGetRequest();
    final HttpClientResponse response = await request.close();
    _httpClient.close();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw new WebException(
          WebExceptionStatus.ProtocolError, _request, response);
    }
    return EwsHttpWebResponse(this, response);
  }
}
