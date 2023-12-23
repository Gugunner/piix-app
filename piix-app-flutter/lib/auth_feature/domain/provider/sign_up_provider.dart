import 'package:piix_mobile/auth_feature/data/repository/auth_repository.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/utils/api/app_api_exception_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_provider.g.dart';

@riverpod
final class SignUpPod extends _$SignUpPod {
  String get _className => 'SignUpPod';

  @override
  Future<void> build(String phoneNumber) => _signUp(phoneNumber);

  Future<void> _signUp(String phoneNumber) async {
    try {
      final authModel = AuthUserModel.phoneSignUp(usernameCredential: phoneNumber);
      await ref.read(authRepositoryPod).checkUserCredentials(authModel);
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
