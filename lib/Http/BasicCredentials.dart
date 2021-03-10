import 'dart:convert';

import 'package:ews/Credentials/ExchangeCredentials.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';

class BasicCredentials extends ExchangeCredentials {
  String? domain;
  String userName;
  String password;

  /// <summary>
  /// Initializes a new instance to use specified credential.
  /// </summary>
  /// <param name="userName">Account user name.</param>
  /// <param name="password">Account password.</param>
  /// <param name="domain">Account domain.</param>
  BasicCredentials(this.userName, this.password, this.domain);

  void PrepareWebRequest(IEwsHttpWebRequest request) {
    final secret = "$userName:$password";
    final encodedSecret = base64Encode(utf8.encode(secret));
    request.Headers.Add("Authorization", "Basic $encodedSecret");
  }
}
