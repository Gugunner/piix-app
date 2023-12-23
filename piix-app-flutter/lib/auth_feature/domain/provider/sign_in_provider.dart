import 'package:piix_mobile/auth_feature/data/repository/auth_repository.dart';
import 'package:piix_mobile/auth_feature/user_app_model_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_provider.g.dart';

@riverpod
final class SignInPod extends _$SignInPod {
  String get _className => 'SignInPod';

  @override
  Future<void> build(String phoneNumber) => _signIn(phoneNumber);

  Future<void> _signIn(String phoneNumber) async {
    try {
      final authModel = AuthUserModel.phoneSignIn(
        usernameCredential: phoneNumber,
      );
      await ref.read(authRepositoryPod).checkUserCredentials(authModel);
      //Always catch the DioException and extract it
      //and pass it as an AppApiError.
    } catch (error) {
      AppApiExceptionHandler.handleError(_className, error);
      rethrow;
    }
  }
}
