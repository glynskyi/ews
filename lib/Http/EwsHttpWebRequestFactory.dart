import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Http/EwsHttpWebExceptionResponse.dart';
import 'package:ews/Http/EwsHttpWebRequest.dart';
import 'package:ews/Http/IEwsHttpWebRequestFactory.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

class EwsHttpWebRequestFactory implements IEwsHttpWebRequestFactory {
  @override
  IEwsHttpWebRequest CreateRequest() {
    return EwsHttpWebRequest();
  }

  @override
  IEwsHttpWebRequest CreateRequestWithExchangeServiceAndUrl(
      ExchangeService exchangeService, Uri url) {
    return EwsHttpWebRequest()
      ..Credentials = exchangeService.Credentials
      ..RequestUri = url;
  }

  @override
  IEwsHttpWebRequest CreateRequestWithUrl(Uri url) {
    return EwsHttpWebRequest()..RequestUri = url;
  }

  @override
  IEwsHttpWebResponse CreateExceptionResponse(WebException e) {
    return new EwsHttpWebExceptionResponse(e);
  }
}
