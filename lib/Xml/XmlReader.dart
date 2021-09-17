import 'dart:convert';

import 'package:async/async.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:ews/Exceptions/ArgumentException.dart';
import 'package:ews/Exceptions/NotImplementedException.dart';
import 'package:ews/Xml/XmlNodeType.dart' as xml;
import 'package:xml/xml.dart';
import 'package:xml/xml_events.dart';

class RotConverter extends Converter<List<XmlEvent>, List<XmlEvent>> {
  // final _key;
  const RotConverter();

  @override
  List<XmlEvent> convert(List<XmlEvent> input) {
    print(">>> $input");
    return input;
  }

// List<int> convert(List<int> data, { int? key }) {
//   print(">>> $data");
//   return data;
// }
}

class XmlReader {
  // late Stream<List<XmlEvent>> _events;
  late StreamQueue<List<XmlEvent>> _queue;
  final _namespaces = <Map<String, String>>[];
  var _isStarted = false;
  var _isFinished = false;
  List<XmlEvent> _retrieved = [];
  XmlEvent? _previous;
  XmlEvent? _current;

  XmlReader(Stream<String> inputStream) {
    _queue =
        StreamQueue(inputStream.toXmlEvents().transform(XmlNormalizeEvents()));
  }

  String get Value => throw NotImplementedException("Value");

  xml.XmlNodeType? get NodeType {
    if (!_isStarted || _isFinished) {
      return null;
    }
    switch (_current!.nodeType) {
      case XmlNodeType.TEXT:
        return xml.XmlNodeType.Text;
      case XmlNodeType.ELEMENT:
        if (_current is XmlStartElementEvent) {
          return xml.XmlNodeType.Element;
        } else if (_current is XmlEndElementEvent) {
          return xml.XmlNodeType.EndElement;
        } else {
          throw ArgumentException("Unexpected ${_current} element");
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
    throw NotImplementedException("Can't convert NodeType of ${_current}");
  }

  String get Name {
    XmlEvent event = _current!;
    if (event is XmlStartElementEvent) {
      return event.name;
    } else if (event is XmlEndElementEvent) {
      return event.name;
    } else {
      throw ArgumentException("Can't retrieve Name for $event");
    }
  }

  String? get NamespaceURI {
    for (final namespaces in _namespaces) {
      if (namespaces.containsKey(Prefix)) {
        return namespaces[Prefix];
      }
    }
    for (final namespaces in _namespaces) {
      if (namespaces.containsKey("xmlns")) {
        return namespaces["xmlns"];
      }
    }
    return null;
  }

  String? get Prefix {
    XmlEvent event = _current!;
    if (event is XmlStartElementEvent) {
      return event.namespacePrefix;
    } else if (event is XmlEndElementEvent) {
      return event.namespacePrefix;
    } else {
      throw ArgumentException("Can't retrieve Prefix for $event");
    }
  }

  String get LocalName {
    XmlEvent event = _current!;
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
    final event = (_current as XmlStartElementEvent);
    return event.isSelfClosing;
  }

  int get AttributeCount {
    final event = (_current as XmlStartElementEvent);
    return event.attributes.length;
  }

  Future<bool> Read() async {
    _isStarted = true;

    if (_retrieved.isNotEmpty) {
      _current = _retrieved.removeAt(0);
      _parseAttributesAndNamespaces();
      return true;
    }
    // _isFinished = !_events.moveNext();

    if (!_isFinished) {
      if (await _queue.hasNext) {
        _retrieved = List.from(await _queue.next);
        _current = _retrieved.removeAt(0);
        _parseAttributesAndNamespaces();
      } else {
        _isFinished = true;
      }
    }

    return !_isFinished;
  }

  void _parseAttributesAndNamespaces() {
    if (_previous is XmlEndElementEvent) {
      _namespaces.removeAt(0);
    }
    if (_current is XmlStartElementEvent) {
      _namespaces.insert(0, {});
      final attributes = (_current as XmlStartElementEvent)
          .attributes
          .where(
              (attr) => attr.namespacePrefix == "xmlns" || attr.name == "xmlns")
          .toList();
      attributes.forEach((attr) {
        _namespaces.first[attr.localName] = attr.value;
      });
    }
    _previous = _current;
  }

  String? GetAttribute(String attributeName) {
    return (_current as XmlStartElementEvent)
        .attributes
        .firstWhereOrNull((attr) => attr.localName == attributeName)
        ?.value;
  }

  String? GetAttributeWithNamespace(String attributeName, String namespace) {
    final resolvedNamespaces = <String, String>{};
    for (final namespaces in _namespaces) {
      for (final namespace in namespaces.entries) {
        resolvedNamespaces[namespace.key] = namespace.value;
      }
    }
    var namespacePrefix = resolvedNamespaces.keys
        .firstWhereOrNull((prefix) => resolvedNamespaces[prefix] == namespace);
    return (_current as XmlStartElementEvent)
        .attributes
        .firstWhereOrNull((attr) =>
            attr.localName == attributeName &&
            attr.namespacePrefix == namespacePrefix)
        ?.value;
  }

  Future<String> ReadString() async {
    if (_current is XmlStartElementEvent &&
        (_current as XmlStartElementEvent).isSelfClosing) {
      return "";
    } else {
      if (_current is XmlStartElementEvent) {
        await Read();
      }
      final buffer = StringBuffer();
      do {
        buffer.write((_current as XmlTextEvent).text);
      } while (await Read() && _current is XmlTextEvent);
      return buffer.toString();
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
    return new XmlReader(inputStream.transform(utf8.decoder));
  }
}

/// A converter that normalizes sequences of [XmlEvent] objects, namely combines
/// adjacent and removes empty text events.
class XmlNormalizeEvents extends XmlListConverter<XmlEvent, XmlEvent> {
  const XmlNormalizeEvents();

  @override
  ChunkedConversionSink<List<XmlEvent>> startChunkedConversion(
          Sink<List<XmlEvent>> sink) =>
      _XmlNormalizeEventsSink(sink);
}

class _XmlNormalizeEventsSink extends ChunkedConversionSink<List<XmlEvent>> {
  _XmlNormalizeEventsSink(this.sink);

  int _nestingLevel = 0;

  final Sink<List<XmlEvent>> sink;
  final List<XmlEvent> buffer = <XmlEvent>[];

  @override
  void add(List<XmlEvent> chunk) {
    final normalizedChunks = chunk.where((xmlEvent) {
      if (xmlEvent is XmlStartElementEvent && !xmlEvent.isSelfClosing) {
        _nestingLevel++;
      } else if (xmlEvent is XmlEndElementEvent) {
        _nestingLevel--;
      }
      return xmlEvent is! XmlTextEvent || _nestingLevel > 0;
    });
    buffer.addAll(normalizedChunks);
    // Filter out empty text nodes.
    // buffer.addAll(
    //     chunk.where((event) => !(event is XmlTextEvent && event.text.isEmpty)));
    // Merge adjacent text nodes.
    // for (var i = 0; i < buffer.length - 1;) {
    //   final event1 = buffer[i], event2 = buffer[i + 1];
    //   if (event1 is XmlTextEvent && event2 is XmlTextEvent) {
    //     final event = XmlTextEvent(event1.text + event2.text);
    //     event.attachParentEvent(event1.parentEvent);
    //     buffer[i] = event;
    //     buffer.removeAt(i + 1);
    //   } else {
    //     i++;
    //   }
    // }
    // Move to sink whatever is possible.
    // if (buffer.isNotEmpty) {
    //   if (buffer.last is XmlTextEvent) {
    //     if (buffer.length > 1) {
    //       sink.add(buffer.sublist(0, buffer.length - 1));
    //       buffer.removeRange(0, buffer.length - 1);
    //     }
    //   } else {
    //     sink.add(buffer.toList(growable: false));
    //     buffer.clear();
    //   }
    // }
    if (buffer.isNotEmpty) {
      sink.add(buffer.toList(growable: false));
      buffer.clear();
    }
  }

  @override
  void close() {
    if (buffer.isNotEmpty) {
      sink.add(buffer.toList(growable: false));
      buffer.clear();
    }
    sink.close();
  }
}

abstract class XmlListConverter<S, T> extends Converter<List<S>, List<T>> {
  const XmlListConverter();

  @override
  List<T> convert(List<S> input) {
    final list = <T>[];
    final sink = ConversionSink<List<T>>(list.addAll);
    startChunkedConversion(sink)
      ..add(input)
      ..close();
    return list;
  }
}

/// A sink that executes [callback] for each addition.
class ConversionSink<T> implements Sink<T> {
  void Function(T data) callback;

  ConversionSink(this.callback);

  @override
  void add(T data) => callback(data);

  @override
  void close() {}
}
