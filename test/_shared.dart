import 'package:dotenv/dotenv.dart' show env;
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Http/WebCredentials.dart';

WebCredentials primaryUserCredential = WebCredentials(env["USER_NAME"], env["USER_PASSWORD"], null);
WebCredentials secondaryUserCredential =
    WebCredentials(env["USER_NAME_SECONDARY"], env["USER_PASSWORD_SECONDARY"], null);

ExchangeService prepareExchangeService(WebCredentials credentials) {
  ExchangeService exchangeService = ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1);
  exchangeService.url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx");
  exchangeService.credentials = credentials;
  return exchangeService;
}
