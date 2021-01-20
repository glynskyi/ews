class StringUtils {
  static bool IsNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static bool EqualsIgnoreCase(String left, String right) {
    return left.toLowerCase() == right.toLowerCase();
  }
}
