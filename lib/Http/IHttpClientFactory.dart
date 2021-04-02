import 'dart:io';

abstract class IHttpClientFactory {
  Future<HttpClient> Create();
}
