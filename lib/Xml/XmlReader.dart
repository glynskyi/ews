import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Xml/XmlNodeType.dart' as xml;
import 'package:xml/xml.dart';
import 'package:xml/xml_events.dart';

class XmlReader {
  late Iterator<XmlEvent> _events;
  final _namespaces = Map<String, String>();
  var _isStarted = false;
  var _isFinished = false;

  XmlReader(String data) {
    _events = parseEvents(data).iterator;
  }

  String get Value => throw NotImplementedException("Value");

  xml.XmlNodeType? get NodeType {
    if (!_isStarted || _isFinished) {
      return null;
    }
    switch (_events.current.nodeType) {
      case XmlNodeType.TEXT:
        return xml.XmlNodeType.Text;
      case XmlNodeType.ELEMENT:
        if (_events.current is XmlStartElementEvent) {
          return xml.XmlNodeType.Element;
        } else if (_events.current is XmlEndElementEvent) {
          return xml.XmlNodeType.EndElement;
        } else {
          throw ArgumentException("Unexpected ${_events.current} element");
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
      case XmlNodeType.DECLARATION:
        return xml.XmlNodeType.XmlDeclaration;
    }
    throw NotImplementedException(
        "Can't convert NodeType of ${_events.current}");
  }

  String get Name {
    XmlEvent event = _events.current;
    if (event is XmlStartElementEvent) {
      return event.name;
    } else if (event is XmlEndElementEvent) {
      return event.name;
    } else {
      throw ArgumentException("Can't retrieve Name for $event");
    }
  }

  get NamespaceURI => _namespaces[Prefix ?? "xmlns"];

  get Prefix {
    XmlEvent event = _events.current;
    if (event is XmlStartElementEvent) {
      return event.namespacePrefix;
    } else if (event is XmlEndElementEvent) {
      return event.namespacePrefix;
    } else {
      throw ArgumentException("Can't retrieve Prefix for $event");
    }
  }

  get LocalName {
    XmlEvent event = _events.current;
    if (event is XmlStartElementEvent) {
      return event.localName;
    } else if (event is XmlEndElementEvent) {
      return event.localName;
    } else if (event is XmlTextEvent) {
      return "#text";
    } else {
      throw ArgumentException("Can't retrieve LocalName for $event");
    }
  }

  bool get IsEmptyElement {
    final event = (_events.current as XmlStartElementEvent);
    return event.isSelfClosing;
  }

  int get AttributeCount {
    final event = (_events.current as XmlStartElementEvent);
    return event.attributes.length;
  }

  bool Read() {
    _isStarted = true;
    _isFinished = !_events.moveNext();

    if (!_isFinished) {
      if (_events.current is XmlStartElementEvent) {
        final attributes = (_events.current as XmlStartElementEvent)
            .attributes
            .where((attr) =>
                attr.namespacePrefix == "xmlns" || attr.name == "xmlns")
            .toList();
        attributes.forEach((attr) {
          _namespaces[attr.localName] = attr.value;
        });
      }
    }

    return !_isFinished;
  }

  String? GetAttribute(String attributeName) {
    return (_events.current as XmlStartElementEvent)
        .attributes
        .firstWhereOrNull((attr) => attr.localName == attributeName)
        ?.value;
  }

  String? GetAttributeWithNamespace(String attributeName, String namespace) {
    var namespacePrefix = _namespaces.keys
        .firstWhereOrNull((prefix) => _namespaces[prefix] == namespace);
    return (_events.current as XmlStartElementEvent)
        .attributes
        .firstWhereOrNull((attr) =>
            attr.localName == attributeName &&
            attr.namespacePrefix == namespacePrefix)
        ?.value;
  }

  String ReadString() {
    if (_events.current is XmlTextEvent) {
      final value = (_events.current as XmlTextEvent).text;
      Read();
      return value;
    } else {
      if (_events.current is XmlStartElementEvent &&
          (_events.current as XmlStartElementEvent).isSelfClosing) {
        return "";
      } else {
        Read();
        final value = (_events.current as XmlTextEvent).text;
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
