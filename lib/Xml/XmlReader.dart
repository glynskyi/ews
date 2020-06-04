import 'dart:convert';

import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Xml/XmlNodeType.dart' as xml;
import 'package:xml/xml.dart';
import 'package:xml/xml_events.dart';

class XmlReader {
  Iterator<XmlEvent> events;
  final namespaces = Map<String, String>();

  XmlReader(String data) {
    events = parseEvents(data).iterator;
  }

  String get Value => throw NotImplementedException("Value");

  xml.XmlNodeType get NodeType {
    if (events.current == null) return xml.XmlNodeType.None;

    switch (events.current.nodeType) {
      case XmlNodeType.TEXT:
        return xml.XmlNodeType.Text;
      case XmlNodeType.ELEMENT:
        if (events.current is XmlStartElementEvent) {
          return xml.XmlNodeType.Element;
        } else if (events.current is XmlEndElementEvent) {
          return xml.XmlNodeType.EndElement;
        } else {
          throw StateError("Unexpected ${events.current} element");
        }
        break;
      case XmlNodeType.ATTRIBUTE:
        break;
      case XmlNodeType.CDATA:
        // TODO: Handle this case.
        break;
      case XmlNodeType.PROCESSING:
        return xml.XmlNodeType.XmlDeclaration;
      case XmlNodeType.COMMENT:
        // TODO: Handle this case.
        break;
      case XmlNodeType.DOCUMENT:
        // TODO: Handle this case.
        break;
      case XmlNodeType.DOCUMENT_FRAGMENT:
        // TODO: Handle this case.
        break;
      case XmlNodeType.DOCUMENT_TYPE:
        // TODO: Handle this case.
        break;
    }
    throw NotImplementedException(
        "Can't convert NodeType of ${events.current}");
  }

  String get Name {
    XmlEvent event = events.current;
    if (event is XmlStartElementEvent) {
      return event.name;
    } else if (event is XmlEndElementEvent) {
      return event.name;
    } else {
      throw StateError("Can't retrieve Name for $event");
    }
  }

  get NamespaceURI => namespaces[Prefix ?? "xmlns"];

  get Prefix {
    XmlEvent event = events.current;
    if (event is XmlStartElementEvent) {
      return event.namespacePrefix;
    } else if (event is XmlEndElementEvent) {
      return event.namespacePrefix;
    } else {
      throw StateError("Can't retrieve Prefix for $event");
    }
  }

  get LocalName {
    XmlEvent event = events.current;
    if (event is XmlStartElementEvent) {
      return event.localName;
    } else if (event is XmlEndElementEvent) {
      return event.localName;
    } else if (event is XmlTextEvent) {
      return "#text";
    } else {
      throw StateError("Can't retrieve LocalName for $event");
    }
  }

  bool get IsEmptyElement {
    final event = (events.current as XmlStartElementEvent);
    return event.isSelfClosing;
  }

  int get AttributeCount {
    final event = (events.current as XmlStartElementEvent);
    return event.attributes.length;
  }

  bool Read() {
    bool result = events.moveNext();

    if (result) {
      if (events.current is XmlStartElementEvent) {
        final attributes = (events.current as XmlStartElementEvent)
            .attributes
            .where((attr) =>
                attr.namespacePrefix == "xmlns" || attr.name == "xmlns")
            .toList();
        attributes.forEach((attr) {
          namespaces[attr.localName] = attr.value;
        });
      }
    }

    return result;
  }

  String GetAttribute(String attributeName) {
    return (events.current as XmlStartElementEvent)
        .attributes
        .firstWhere((attr) => attr.localName == attributeName,
            orElse: () => null)
        ?.value;
  }

  String GetAttributeWithNamespace(String attributeName, String namespace) {
    var namespacePrefix = namespaces.keys.firstWhere(
        (prefix) => namespaces[prefix] == namespace,
        orElse: () => null);
    return (events.current as XmlStartElementEvent)
        .attributes
        .firstWhere(
            (attr) =>
                attr.localName == attributeName &&
                attr.namespacePrefix == namespacePrefix,
            orElse: () => null)
        ?.value;
  }

  String ReadString() {
    if (events.current is XmlTextEvent) {
      final value = (events.current as XmlTextEvent).text;
      Read();
      return value;
    } else {
      if (events.current is XmlStartElementEvent &&
          (events.current as XmlStartElementEvent).isSelfClosing) {
        return "";
      } else {
        Read();
        final value = (events.current as XmlTextEvent).text;
        Read();
        return value;
      }
    }
  }

  String ReadInnerXml() {
    throw NotImplementedException("ReadInnerXml()");
  }

  String ReadOuterXml() {
    throw NotImplementedException("ReadOuterXml()");
  }

  XmlReader ReadSubtree() {
    throw NotImplementedException("ReadSubtree()");
  }

  void ReadToDescendant(String localName, String getNamespaceUri) {
    throw NotImplementedException(
        "ReadToDescendant($localName, $getNamespaceUri)");
  }

  static Future<XmlReader> Create(Stream<List<int>> inputStream) async {
    String data = await utf8.decodeStream(inputStream);
    return new XmlReader(data);
  }
}
