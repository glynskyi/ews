import 'package:ews/Credentials/ExchangeCredentials.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';

class OAuthCredentials extends ExchangeCredentials {
  String accessToken;

  OAuthCredentials(this.accessToken);

  void PrepareWebRequest(IEwsHttpWebRequest request) {
    request.Headers.Add("Authorization", "Bearer $accessToken");
  }
}
