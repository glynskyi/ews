class InvalidOperationException implements Exception {
  String errorMessage;

  InvalidOperationException(this.errorMessage);

  @override
  String toString() {
    return 'InvalidOperationException{errorMessage: $errorMessage}';
  }
}
