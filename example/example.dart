import 'package:ews/Http/WebCredentials.dart';
import 'package:ews/ews.dart';

void main() async {
  final credentials = WebCredentials("---username---", "---password---", "---domain---");
  final service = ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1)
    ..Url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx")
    ..Credentials = credentials
    ..TraceFlags = [TraceFlags.EwsRequest, TraceFlags.EwsResponse]
    ..TraceEnabled = true;
  final folder = new Folder(service);
  folder.DisplayName = "My Folder";
  await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);
}
