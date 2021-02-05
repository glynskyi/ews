import 'package:ews/Credentials/ExchangeCredentials.dart';

class OAuthCredentials extends ExchangeCredentials {
  final String accessToken;

  OAuthCredentials(this.accessToken);
}
