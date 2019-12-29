import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  test('tests an autodiscovery', () async {
    final service =
        ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1)
          ..Credentials = primaryUserCredential
          ..EnableScpLookup = false
          ..TraceFlags = TraceFlags.values
          ..TraceEnabled = true;
    final url = await service.GetAutodiscoverUrlWithExchangeVersionAndCallback(
        "qa1@shafersystems.com", ExchangeVersion.Exchange2010, (url) => true);
    expect(url, Uri.parse("https://outlook.office365.com/EWS/Exchange.asmx"));
  });
}
