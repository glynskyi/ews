import 'package:ews/ews.dart';

void main() async {
  final credentials = BasicCredentials(
    "---username---",
    "---password---",
    "---domain---",
  );
  final service = ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1)
    ..Url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx")
    ..Credentials = credentials
    ..TraceFlags = [TraceFlags.EwsRequest, TraceFlags.EwsResponse]
    ..TraceEnabled = true;
  final folder = Folder(service)..DisplayName = "My Folder";
  await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Notes);
}
