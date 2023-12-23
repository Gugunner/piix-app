import 'package:piix_mobile/general_app_feature/utils/validators.dart';

/// Returns true if the given value is a valid name or lastname.
bool validateNames(String value) {
  final nameRegExp = RegExp(Validators.nameValidator);
  return nameRegExp.hasMatch(value) && value.length <= 40;
}

/// Returns true if the given value is a valid phone.
bool validateEmail(String value) {
  final emailRegExp = RegExp(Validators.emailValidator);
  return emailRegExp.hasMatch(value);
}
