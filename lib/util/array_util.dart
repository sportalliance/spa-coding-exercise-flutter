class ArrayUtil {
  static bool isNotEmpty(Iterable value) {
    return (value != null && value.isNotEmpty);
  }

  static bool isEmpty(Iterable value) {
    return (value == null || value.isEmpty);
  }
}
