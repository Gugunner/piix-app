import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';

enum AuthInputState {
  idle,
  validEmail,
  validPhone,
  emptyEmail,
  emptyPhone,
  invalidEmail,
  invalidPhone,
  alreadyUsedEmail,
  alreadyUsedPhone,
  unregisteredEmail,
  unregisteredPhone,
  error,
}

extension ExtendAuthInputState on AuthInputState {
  ///A validator used in the TextFormField
  String? validate(String? value) {
    switch (this) {
      case AuthInputState.emptyEmail:
        return AuthUserCopies.emptyEmail;
      case AuthInputState.invalidEmail:
        return AuthUserCopies.invalidEmail;
      case AuthInputState.alreadyUsedEmail:
        return AuthUserCopies.alreadyUsedEmail;
      case AuthInputState.unregisteredEmail:
        return AuthUserCopies.unregisteredEmail;
      case AuthInputState.emptyPhone:
        return AuthUserCopies.emptyPhone;
      case AuthInputState.invalidPhone:
        return AuthUserCopies.invalidPhone;
      case AuthInputState.alreadyUsedPhone:
        return AuthUserCopies.alreadyUsedPhone;
      case AuthInputState.unregisteredPhone:
        return AuthUserCopies.unregisteredPhone;
      default:
        return null;
    }
  }

  bool get incorrect {
    switch (this) {
      case AuthInputState.emptyPhone:
      case AuthInputState.invalidPhone:
      case AuthInputState.alreadyUsedPhone:
      case AuthInputState.unregisteredPhone:
      case AuthInputState.emptyEmail:
      case AuthInputState.invalidEmail:
      case AuthInputState.alreadyUsedEmail:
      case AuthInputState.unregisteredEmail:
        return true;
      default:
        return false;
    }
  }
}
