/// Extensions for String class to make it easier to work with strings.
extension StringExtend on String {
  /// Concat the word "(debug)" at the end of the string.
  String get debug => '$this (debug)';

  /// Transform to capitalized string.
  String capitalize() {
    if (isEmpty) return '';
    if (length == 1) return toUpperCase();
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Returns a string with the first letter of each word capitalized.
  String titleCase() => split(' ').map((word) => word.capitalize()).join(' ');

  /// Returns a string to phone number format.
  String phoneFormat() {
    if (length == 10) {
      return '(${substring(0, 3)}) ${substring(3, 6)}-${substring(6, 10)}';
    }
    return this;
  }

  ///Returns a string with a space end the word.
  String addSpace() {
    if (isEmpty) return '';
    return '$this ';
  }

  /// Returns a string with a comma end the word.
  String addComma() {
    if (isEmpty) return '';
    return '$this,';
  }

  String fromCamelToSnake({bool lowerCase = true}) {
    var newString = '';
    if (contains('_')) {
      if (lowerCase) {
        return toLowerCase();
      }
      return toUpperCase();
    }
    final exp = RegExp(r'(?<=[a-z])[A-Z]');
    newString = replaceAllMapped(
      exp,
      (Match m) => ('_${m.group(0) ?? ''}'),
    ).toLowerCase();
    if (lowerCase) {
      return newString.toLowerCase();
    }
    return newString.toUpperCase();
  }
}

extension OptionalStringExtend on String? {
  bool get isEmptyNull => this != null && this!.isEmpty;
  bool get isNotNullEmpty => this != null && this!.isNotEmpty;
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNull => this != null;
  bool get isNull => this == null;
}
