import 'package:ews/Credentials/ExchangeCredentials.dart';
import 'package:ews/Exceptions/ArgumentException.dart';

class WebCredentials extends ExchangeCredentials {
  String domain;
  String user;
  String pwd;
  bool useDefaultCredentials = false;

  /// <summary>
  /// Initializes a new instance to use specified credential.
  /// </summary>
  /// <param name="userName">Account user name.</param>
  /// <param name="password">Account password.</param>
  /// <param name="domain">Account domain.</param>
  WebCredentials(String userName, String password, String domain) {
    if (userName == null || password == null) {
      throw new ArgumentException("User name or password can not be null");
    }

    this.domain = domain;
    this.user = userName;
    this.pwd = password;
    useDefaultCredentials = false;
  }
}
