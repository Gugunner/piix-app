extension IntExtend on int {
  String get pluralWithS => this > 1 || this == 0 ? 's' : '';
}
