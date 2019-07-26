class NotImplementedException implements Exception {
  final String message;

  NotImplementedException([this.message = ""]);

  @override
  String toString() {
    return 'NotImplementedException{message: $message}';
  }
}
