import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';

enum AuthMethod {
  none,
  phoneSignUp,
  emailSignUp,
  protectedPhoneSignUp,
  protectedEmailSignUp,
  phoneSignIn,
  emailSignIn,
  phoneUpdate,
  emailUpdate;

  //Returns the title of the SignUpOrSignIn screen based on the [AuthMethod]
  // current value
  String get authSignInOrUpTitle {
    switch (this) {
      case AuthMethod.phoneSignIn:
        return AuthUserCopies.signInPhoneTitle;
      case AuthMethod.emailSignIn:
        return AuthUserCopies.signInEmailTitle;
      case AuthMethod.phoneSignUp:
        return AuthUserCopies.signUpPhoneTitle;
      case AuthMethod.emailSignUp:
        return AuthUserCopies.signUpEmailTitle;
      default:
        return AuthUserCopies.testText;
    }
  }

  //Returns the description of the SignUpOrSignIn screen based on the
  //[AuthMethod] current value
  String get authSignInOrUpMessage {
    switch (this) {
      case AuthMethod.phoneSignIn:
      case AuthMethod.phoneSignUp:
        return AuthUserCopies.phoneConfirmation;
      case AuthMethod.emailSignIn:
      case AuthMethod.emailSignUp:
        return AuthUserCopies.emailConfirmation;
      default:
        return AuthUserCopies.testText;
    }
  }

  //Returns a brief disclaimer of the SignUpOrSignIn screen based on the
  //[AuthMethod] current value
  String get authDisclaimer {
    switch (this) {
      case AuthMethod.phoneSignUp:
        return AuthUserCopies.phoneDisclaimer;
      case AuthMethod.emailSignUp:
        return AuthUserCopies.emailDisclaimer;
      default:
        return AuthUserCopies.testText;
    }
  }

  //Returns the text for the auth input switch
  //of the SignUpOrSignIn screen based on the [AuthMethod] current value
  String get authActionBy {
    switch (this) {
      case AuthMethod.phoneSignIn:
        return AuthUserCopies.signInByEmail;
      case AuthMethod.emailSignIn:
        return AuthUserCopies.signInByPhone;
      case AuthMethod.phoneSignUp:
        return AuthUserCopies.signUpByEmail;
      case AuthMethod.emailSignUp:
        return AuthUserCopies.signUpByPhone;
      default:
        return AuthUserCopies.testText;
    }
  }

  //Returns the text for the auth method switch
  //of the SignUpOrSignIn screen based on the [AuthMethod] current value
  String get authMode {
    if (isSignIn) {
      return AuthUserCopies.piixSignUp;
    }
    return AuthUserCopies.piixSignIn;
  }

  String verificationSentTo(String credential) => isPhoneNumber
      ? AuthUserCopies.sentByPhone(credential)
      : AuthUserCopies.sentByEmail(credential);

  bool get isPhoneNumber => name.toLowerCase().contains('phone');

  bool get isSignIn => name.toLowerCase().contains('signin');

  bool get isSignUp => name.toLowerCase().contains('signup');

  bool get isUpdate => name.toLowerCase().contains('update');

  bool get isProtected => name.toLowerCase().contains('protected');
}

