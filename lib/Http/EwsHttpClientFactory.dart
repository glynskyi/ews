import 'dart:io';

import 'package:ews/Http/IHttpClientFactory.dart';

class EwsHttpClientFactory implements IHttpClientFactory {
  @override
  Future<HttpClient> Create() async {
    return HttpClient();
  }
}
