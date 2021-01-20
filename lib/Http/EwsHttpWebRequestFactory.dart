import 'dart:io';

import 'package:ews/Core/ExchangeServiceBase.dart';
import 'package:ews/Http/EwsHttpWebExceptionResponse.dart';
import 'package:ews/Http/EwsHttpWebRequest.dart';
import 'package:ews/Http/IEwsHttpWebRequestFactory.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

class EwsHttpWebRequestFactory implements IEwsHttpWebRequestFactory {
  @override
  IEwsHttpWebRequest CreateRequest(HttpClient httpClient) {
    return EwsHttpWebRequest(httpClient);
  }

  @override
  IEwsHttpWebRequest CreateRequestWithExchangeServiceAndUrl(ExchangeServiceBase exchangeService, Uri url) {
    return EwsHttpWebRequest(exchangeService.httpClient)
      ..Credentials = exchangeService.Credentials
      ..RequestUri = url;
  }

  @override
  IEwsHttpWebRequest CreateRequestWithUrl(HttpClient? httpClient, Uri url) {
    return EwsHttpWebRequest(httpClient)..RequestUri = url;
  }

  @override
  IEwsHttpWebResponse CreateExceptionResponse(WebException e) {
    return new EwsHttpWebExceptionResponse(e);
  }
}
