import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Http/WebException.dart';
import 'package:ews/Http/WebHeaderCollection.dart';
import 'package:ews/Interfaces/IEwsHttpWebResponse.dart';

class EwsHttpWebExceptionResponse implements IEwsHttpWebResponse {
  final WebException _webException;

  EwsHttpWebExceptionResponse(this._webException);

  @override
  void Close() {
    throw NotImplementedException();
  }

  @override
  String get ContentEncoding => throw NotImplementedException();

  @override
  String get ContentType => throw NotImplementedException();

  @override
  Dispose() {
    throw NotImplementedException();
  }

  @override
  Stream<List<int>> GetResponseStream() {
    throw NotImplementedException();
  }

  @override
  WebHeaderCollection get Headers {
    final headerCollection = WebHeaderCollection();
    _webException.Response.headers.forEach((headerName, headerValue) {
      headerCollection[headerName] = headerValue.join(";");
    });
    return headerCollection;
  }

  @override
  Uri get ResponseUri => _webException.Request.uri;

  @override
  int get StatusCode => _webException.Response.statusCode;

  @override
  String get StatusDescription => _webException.Response.reasonPhrase;

}