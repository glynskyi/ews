import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Http/WebCredentials.dart';
import 'package:dotenv/dotenv.dart' show env;

ExchangeService prepareExchangeService() {
  final userName = env["USER_NAME"];
  final userPassword = env["USER_PASSWORD"];
  ExchangeService exchangeService = ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1);
  exchangeService.url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx");
  exchangeService.credentials = WebCredentials(userName, userPassword, null);
  return exchangeService;
}
