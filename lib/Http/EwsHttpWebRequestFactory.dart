import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/ExchangeServiceBase.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
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
  IEwsHttpWebRequest CreateRequestWithUrl(ExchangeService exchangeService, Uri url) {
    return EwsHttpWebRequest()
      ..Credentials = exchangeService.Credentials
      ..RequestUri = url;
  }

  @override
  IEwsHttpWebResponse CreateExceptionResponse(WebException e) {
    // TODO: implement CreateExceptionResponse
    return throw NotImplementedException("CreateExceptionResponse");
  }
}
