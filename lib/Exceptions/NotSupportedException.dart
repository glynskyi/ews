class NotSupportedException implements Exception {
  final String message;

  NotSupportedException([this.message = ""]);

  @override
  String toString() {
    return 'NotSupportedException{message: $message}';
  }
}
