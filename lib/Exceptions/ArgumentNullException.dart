class ArgumentNullException implements Exception {
  final String message;

  ArgumentNullException(this.message);

  @override
  String toString() {
    return 'ArgumentNullException{message: $message}';
  }
}
