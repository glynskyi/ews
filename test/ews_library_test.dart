//import 'package:ews/Core/ExchangeService.dart';
//import 'package:ews/Core/ServiceObjects/Folders/Folder.dart';
//import 'package:ews/Enumerations/ExchangeVersion.dart';
//import 'package:ews/Enumerations/WellKnownFolderName.dart';
//import 'package:ews/Http/WebCredentials.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:xml/xml_events.dart';
//
//ExchangeService _prepareExchangeService() {
//  ExchangeService exchangeService = ExchangeService.withVersion(ExchangeVersion.Exchange2007_SP1);
//  exchangeService.url = Uri.parse("https://outlook.office365.com/ews/exchange.asmx");
//  exchangeService.credentials = WebCredentials("*** EMAIL ****", "*** PASSWORD ***", null);
//  return exchangeService;
//}
//
//void main() {
////  test('adds one to input values', () {
////    final calculator = Calculator();
////    expect(calculator.addOne(2), 3);
////    expect(calculator.addOne(-7), -6);
////    expect(calculator.addOne(0), 1);
////    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
////  });
//
////  test('creates and deletes a note folder', () async {
////    final service = _prepareExchangeService();
////    Folder folder = new Folder(service);
////    folder.DisplayName = "Custom Folder 2";
////    folder.FolderClass = "IPF.StickyNote";
////    await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Inbox);
////  });
//
//  test('gets folder', () async {
//    final service = _prepareExchangeService();
//    Folder rootfolder = await Folder.BindWithWellKnownFolder(service, WellKnownFolderName.MsgFolderRoot);
//    print("The ${rootfolder.DisplayName} has ${rootfolder.ChildFolderCount} child folders.");
//  });
//
//
//  final testXml = """<?xml version="1.0" encoding="utf-8"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Header><h:ServerVersionInfo MajorVersion="15" MinorVersion="20" MajorBuildNumber="2052" MinorBuildNumber="15" Version="V2018_01_08" xmlns:h="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/></s:Header><s:Body><m:GetFolderResponse xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types"><m:ResponseMessages><m:GetFolderResponseMessage ResponseClass="Success"><m:ResponseCode>NoError</m:ResponseCode><m:Folders><t:Folder><t:FolderId Id="AQMkADRmN2U5ZDIzLWQxMzQtNGIwZi1iMTg3LWE2YTU4Y2JmOGFhADkALgAAAzH+PySrpxdIpz/4xMDrNskBAAULK7hZ1eJBjJiDEHu5ORUAAAIBCAAAAA==" ChangeKey="AQAAABYAAAAFCyu4WdXiQYyYgxB7uTkVAAJ2TwFB"/><t:ParentFolderId Id="AAMkADRmN2U5ZDIzLWQxMzQtNGIwZi1iMTg3LWE2YTU4Y2JmOGFhOQAuAAAAAAAx/j8kq6cXSKc/+MTA6zbJAQAFCyu4WdXiQYyYgxB7uTkVAAAAAAEBAAA=" ChangeKey="AQAAAA=="/><t:DisplayName>Top of Information Store</t:DisplayName><t:TotalCount>0</t:TotalCount><t:ChildFolderCount>26</t:ChildFolderCount><t:EffectiveRights><t:CreateAssociated>true</t:CreateAssociated><t:CreateContents>true</t:CreateContents><t:CreateHierarchy>true</t:CreateHierarchy><t:Delete>true</t:Delete><t:Modify>true</t:Modify><t:Read>true</t:Read><t:ViewPrivateItems>true</t:ViewPrivateItems></t:EffectiveRights><t:UnreadCount>0</t:UnreadCount></t:Folder></m:Folders></m:GetFolderResponseMessage></m:ResponseMessages></m:GetFolderResponse></s:Body></s:Envelope>""";
//
//  test('print events', () async {
//    parseEvents(testXml).forEach((xmlEvent) {
//      print("${xmlEvent.nodeType} $xmlEvent");
//      if (xmlEvent is XmlStartElementEvent) {
//        final namespaces = xmlEvent.attributes.where((attr) => attr.namespacePrefix == "xmlns").toList();
//        namespaces.forEach((namespace) {
//          print("namespace: ${namespace.localName} ${namespace.value}");
//        });
//      }
//    });
//  });
//
////  test('creates and deletes a task folder', () async {
////    final service = _prepareExchangeService();
////    Folder folder = new Folder(service);
////    folder.DisplayName = "Custom Folder";
////    folder.FolderClass = "IPF.Task";
////    await folder.SaveWithWellKnownFolderName(WellKnownFolderName.Inbox);
////  });
//}
