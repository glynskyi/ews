class ArgumentException implements Exception {
  final String message;
  final Exception innerException;
  final StackTrace innerStackTrace;

  const ArgumentException(this.message,
      [this.innerException, this.innerStackTrace]);

  @override
  String toString() {
    return 'ArgumentException{message: $message, innerException: $innerException, innerStackTrace: $innerStackTrace}';
  }
}
