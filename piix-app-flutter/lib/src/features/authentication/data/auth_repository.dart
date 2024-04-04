import 'package:piix_mobile/src/network/app_dio.dart';
import 'package:piix_mobile/src/network/app_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

typedef CustomToken = String;

///The repository for authentication related operations
class AuthRepository {
  ///Constructor
  const AuthRepository(this._appDio);
  ///The instance of [AppDio] to make network requests
  final AppDio _appDio;

  ///Send verification code to passed email
  Future<dynamic> sendVerificationCodeByEmail(String email) async {
    return _appDio.post('/sendVerificationCodeRequest', data: {'email': email});
  }

  ///Create account with email and verification code and obtain custom token
  Future<CustomToken> createAccountWithEmailAndVerificationCode(
    String email,
    String verificationCode,
  ) async {
    final response = await _appDio.post(
        '/createAccountAndCustomTokenWithEmailRequest',
        data: {'email': email, 'verificationCode': verificationCode});
    if (response.data?['customToken'] == null) {
      throw CustomTokenFailedException();
    }
    return response.data?['customToken'];
  }

  ///Obtain a custom token with email and verification code
  Future<CustomToken> getCustomTokenWithEmailAndVerificationCode(
    String email,
    String verificationCode,
  ) async {
    final response = await _appDio.post('/getCustomTokenForCustomSignInRequest',
        data: {'email': email, 'verificationCode': verificationCode});
    if (response.data?['customToken'] == null) {
      throw CustomTokenFailedException();
    }
    return response.data?['customToken'];
  }

  ///Revoke refresh tokens
  Future<dynamic> revokeRefreshTokens() async {
    return  _appDio
        .put('/revokeRefreshTokensRequest');
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final appDio = ref.watch(appDioProvider);
  return AuthRepository(appDio);
}