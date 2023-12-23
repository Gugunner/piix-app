extension MapExtend on Map {
  bool hasNonNullableValue(String property) {
    return this[property] != null;
  }

  bool isNoEmptyValue<T>(T value) {
    if (value != null) {
      if (value is String) {
        return value.isNotEmpty;
      } else if (value is List) {
        return value.isNotEmpty;
      } else if (value is Map) {
        return value.isNotEmpty;
      }
    }
    return false;
  }

  bool isNullOrEmpty<T>(T value) {
    if (value is String) {
      return value.isEmpty;
    } else if (value is List) {
      return value.isEmpty;
    } else if (value is Map) {
      return value.isEmpty;
    }
    return value == null;
  }
}
