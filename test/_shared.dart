import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Http/WebCredentials.dart';

ExchangeService prepareExchangeService() {
  final userName = String.fromEnvironment("USER_NAME");
  final userPassword = String.fromEnvironment("USER_PASSWORD");
  ExchangeService exchangeService = ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1);
  exchangeService.url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx");
  exchangeService.credentials = WebCredentials(userName, userPassword, null);
  return exchangeService;
}
