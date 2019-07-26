class NotSupportedException implements Exception {
  final String message;

  NotSupportedException([this.message = ""]);
}