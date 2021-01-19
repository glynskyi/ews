class Uuid {
  final String value;

  Uuid(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Uuid && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Uuid{value: $value}';
  }
}
