import 'package:ews/Credentials/ExchangeCredentials.dart';

class WebCredentials extends ExchangeCredentials {
  String? domain;
  String userName;
  String password;

  /// <summary>
  /// Initializes a new instance to use specified credential.
  /// </summary>
  /// <param name="userName">Account user name.</param>
  /// <param name="password">Account password.</param>
  /// <param name="domain">Account domain.</param>
  WebCredentials(this.userName, this.password, this.domain);
}
