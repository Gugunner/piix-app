import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

///Extension for [List] to make it easier to work with lists.
extension ListExtended on List {
  String joinNameSpaceComma() {
    return map((e) => e.name).toList().join(', ');
  }

  void sortByRegisterDate() =>
      sort((a, b) => b.registerDate!.compareTo(a.registerDate == null
          ? ConstantsDeprecated.lowestDate
          : a.registerDate!));
}

extension ListExtends on List? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}
