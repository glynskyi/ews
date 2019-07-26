import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Http/WebCredentials.dart';

ExchangeService prepareExchangeService() {
  ExchangeService exchangeService = ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1);
  exchangeService.url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx");
  exchangeService.credentials = WebCredentials("*** EMAIL ****", "*** PASSWORD ***", null);
  return exchangeService;
}