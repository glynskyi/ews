import 'dart:async';
import 'dart:typed_data';

class MemoryStream extends Stream<List<int>> implements StreamConsumer<Uint8List> {
  int Position;
  final elements = List<List<int>>();

  @override
  Future<void> addStream(Stream<List<int>> stream) async {
    await stream.forEach((element) {
      elements.add(element);
    });
  }

  List<int> get AllElements => elements.expand((portion) { return portion; }).toList();

  @override
  Future close() async {
  }

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event) onData, {Function onError, void Function() onDone, bool cancelOnError}) {
    return Stream.fromIterable(elements).listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}