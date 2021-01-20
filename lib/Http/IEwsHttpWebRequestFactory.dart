import 'dart:io';

import 'package:ews/Core/ExchangeServiceBase.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

abstract class IEwsHttpWebRequestFactory {
  IEwsHttpWebRequest CreateRequest(HttpClient httpClient);

  IEwsHttpWebRequest CreateRequestWithExchangeServiceAndUrl(ExchangeServiceBase exchangeService, Uri url);

  IEwsHttpWebRequest CreateRequestWithUrl(HttpClient? httpClient, Uri url);

  IEwsHttpWebResponse CreateExceptionResponse(WebException e);
}
