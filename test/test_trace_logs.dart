import 'package:ews/Interfaces/ITraceListener.dart';
import 'package:ews/ews.dart';
import 'package:test/test.dart';

import '_shared.dart';

main() {
  test('tests enabled trace', () async {
    final traceListener = MemoryTraceListener();
    final exchangeService = prepareExchangeService(primaryUserCredential)
      ..TraceEnabled = true
      ..TraceListener = traceListener;
    await Folder.BindWithWellKnownFolder(
        exchangeService, WellKnownFolderName.Notes);
    expect(traceListener.toString(), isNotEmpty);
  });

  test('tests disabled trace', () async {
    final traceListener = MemoryTraceListener();
    final exchangeService = prepareExchangeService(primaryUserCredential)
      ..TraceListener = traceListener
      ..TraceEnabled = false;
    await Folder.BindWithWellKnownFolder(
        exchangeService, WellKnownFolderName.Notes);
    expect(traceListener.toString(), isEmpty);
  });

  test('tests trace logs containts request headers', () async {
    final traceListener = MemoryTraceListener();
    final exchangeService = prepareExchangeService(primaryUserCredential)
      ..TraceFlags = [TraceFlags.EwsRequestHttpHeaders]
      ..TraceListener = traceListener;
    await Folder.BindWithWellKnownFolder(
        exchangeService, WellKnownFolderName.Notes);
    expect(traceListener.toString().toLowerCase(), contains("accept-encoding"));
  });

  test('tests trace logs containts response headers', () async {
    final traceListener = MemoryTraceListener();
    final exchangeService = prepareExchangeService(primaryUserCredential)
      ..TraceFlags = [TraceFlags.EwsResponseHttpHeaders]
      ..TraceListener = traceListener;
    await Folder.BindWithWellKnownFolder(
        exchangeService, WellKnownFolderName.Notes);
    expect(traceListener.toString().toLowerCase(), contains("request-id"));
  });

  test('tests trace logs containts request', () async {
    final traceListener = MemoryTraceListener();
    final exchangeService = prepareExchangeService(primaryUserCredential)
      ..TraceFlags = [TraceFlags.EwsRequest]
      ..TraceListener = traceListener;
    await Folder.BindWithWellKnownFolder(
        exchangeService, WellKnownFolderName.Notes);
    expect(traceListener.toString(), contains("DistinguishedFolderId"));
  });

  test('tests trace logs containts response', () async {
    final traceListener = MemoryTraceListener();
    final exchangeService = prepareExchangeService(primaryUserCredential)
      ..TraceFlags = [TraceFlags.EwsResponse]
      ..TraceListener = traceListener;
    await Folder.BindWithWellKnownFolder(
        exchangeService, WellKnownFolderName.Notes);
    expect(traceListener.toString(), contains("GetFolderResponseMessage"));
  });
}

class MemoryTraceListener extends ITraceListener {
  final _stringBuffer = StringBuffer();

  @override
  void Trace(String traceType, String traceMessage) {
    _stringBuffer.write(traceMessage);
  }

  @override
  String toString() {
    return _stringBuffer.toString();
  }
}
