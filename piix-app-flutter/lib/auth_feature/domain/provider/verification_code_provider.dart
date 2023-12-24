import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/auth_feature/data/repository/auth_repository.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_feature/user_app_model_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verification_code_provider.g.dart';

enum VerificationMode {
  signIn,
  signUp,
  update,
}

@riverpod
final class VerifyVerificationCodePod extends _$VerifyVerificationCodePod {
  String get _className => 'VerifyVerificationCodePod';

  @override
  Future<void> build({
    required String phoneNumber,
    required String verificationCode,
    required VerificationType verificationType,
  }) =>
      _checkUserVerificationCode(
        phoneNumber: phoneNumber,
        verificationCode: verificationCode,
        verificationType: verificationType,
      );

  Future<void> _checkUserVerificationCode({
    required String phoneNumber,
    required String verificationCode,
    required VerificationType verificationType,
  }) async {
    try {
      final hashableUnixTime = DateTime.now().millisecondsSinceEpoch;
      final authModel = AuthUserModel.phoneVerify(
        usernameCredential: phoneNumber,
        verificationCode: verificationCode,
        hashableUnixTime: hashableUnixTime,
        appFlow: _getAppFlow(verificationType),
      );
      final user = await ref
          .read(authRepositoryPod)
          .checkUserVerificationCode(authModel);
      await AppSharedPreferences.storeUser(
        user: user,
        hashableUnixTime: hashableUnixTime,
      );
      ref.read(userPodProvider.notifier).set(user);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }

  String _getAppFlow(VerificationType verificationType) {
    switch (verificationType) {
      case VerificationType.signIn:
        return 'START_LOGIN';
      case VerificationType.signUp:
        return 'START_REGISTER';
      case VerificationType.update:
      case VerificationType.recover:
        return 'START_CHANGE_CREDENTIAL';
    }
  }
}

@Deprecated('Use instead VerifyVerificationCodePod')
@riverpod
final class VerificationCodePod extends _$VerificationCodePod {
  String get _className => 'VerificationCodePod';

  @override
  Future<void> build({
    required String phoneNumber,
    required String verificationCode,
    VerificationMode mode = VerificationMode.signIn,
  }) async {
    if (mode == VerificationMode.signIn)
      return _verifySignIn(phoneNumber, verificationCode);
    if (mode == VerificationMode.signUp)
      return _verifySignUp(phoneNumber, verificationCode);
    return;
  }

  Future<void> _verifySignIn(
      String phoneNumber, String verificationCode) async {
    try {
      final hashableUnixTime = DateTime.now().millisecondsSinceEpoch;
      final authModel = AuthUserModel.phoneVerify(
        usernameCredential: phoneNumber,
        verificationCode: verificationCode,
        hashableUnixTime: hashableUnixTime,
        appFlow: AppFlow.START_LOGIN.name,
      );
      final user = await ref
          .read(authRepositoryPod)
          .checkUserVerificationCode(authModel);
      ref.read(userPodProvider.notifier).set(user);
      await AppSharedPreferences.storeUser(
        user: user,
        hashableUnixTime: hashableUnixTime,
      );
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }

  Future<void> _verifySignUp(
      String phoneNumber, String verificationCode) async {
    try {
      final hashableUnixTime = DateTime.now().millisecondsSinceEpoch;
      final authModel = AuthUserModel.phoneVerify(
        usernameCredential: phoneNumber,
        verificationCode: verificationCode,
        hashableUnixTime: hashableUnixTime,
        appFlow: AppFlow.START_REGISTER.name,
      );
      final user = await ref
          .read(authRepositoryPod)
          .checkUserVerificationCode(authModel);
      ref.read(userPodProvider.notifier).set(user);
      await AppSharedPreferences.storeUser(
        user: user,
        hashableUnixTime: hashableUnixTime,
      );
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
