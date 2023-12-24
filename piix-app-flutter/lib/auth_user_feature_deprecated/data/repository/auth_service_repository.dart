import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository_impl.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository_test_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/service/auth_service_api_deprecated.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';

enum CredentialState {
  idle,
  sending,
  sent,
  notFound,
  conflict,
  error,
}

enum VerificationCodeState {
  idle,
  verifying,
  verified,
  conflict,
  error,
}

enum AuthState {
  idle,
  authorizing,
  authorized,
  unauthorized,
}

class AuthServiceRepository {
  AuthServiceRepository(this.serviceApi);

  final AuthServiceApiDeprecated serviceApi;

  Future<CredentialState> sendCredentialRequested(AuthUserModel authModel,
      [bool test = false]) async {
    if (test) {
      return sendCredentialRequestedTest(authModel);
    }
    return sendCredentialRequestedImpl(authModel);
  }

  Future<dynamic> sendVerificationCodeRequested(AuthUserModel authModel,
      [bool test = false]) async {
    if (test) {
      return sendVerificationCodeRequestedTest(authModel);
    }
    return sendVerificationCodeRequestedImpl(authModel);
  }

  Future<dynamic> sendHashableAuthValuesRequested(AuthUserModel authModel,
      [bool test = false]) async {
    if (test) {
      return sendHashableAuthValuesRequestedTest(authModel);
    }
    return sendHashableAuthValuesRequestedImpl(authModel);
  }
}

extension CredentialStateExtend on CredentialState {
  bool get hasError {
    switch (this) {
      case CredentialState.sent:
      case CredentialState.sending:
      case CredentialState.idle:
        return false;
      default:
        return true;
    }
  }
}

extension VerificationCodeStateExtend on VerificationCodeState {
  bool get hasError {
    switch (this) {
      case VerificationCodeState.verified:
      case VerificationCodeState.verifying:
      case VerificationCodeState.idle:
        return false;
      default:
        return true;
    }
  }
}
