import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';

enum VerificationInputState {
  idle,
  resendByPhone,
  resendByEmail,
  error,
}

extension VerificationInputStateExtend on VerificationInputState {
  String get bannerMessage {
    switch (this) {
      case VerificationInputState.resendByPhone:
        return AuthUserCopies.codeSentAgainByPhone;
      case VerificationInputState.resendByEmail:
        return AuthUserCopies.codeSentAgainByEmail;
      default:
        return '';
    }
  }
}
