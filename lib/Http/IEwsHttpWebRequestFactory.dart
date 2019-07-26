import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

abstract class IEwsHttpWebRequestFactory {
  IEwsHttpWebRequest CreateRequest();

  IEwsHttpWebRequest CreateRequestWithUrl(ExchangeService exchangeService, Uri url) {}

  IEwsHttpWebResponse CreateExceptionResponse(WebException e) {}
}