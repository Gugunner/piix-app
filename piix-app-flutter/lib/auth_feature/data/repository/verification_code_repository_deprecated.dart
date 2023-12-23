import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verification_code_repository_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
abstract class _VerificationCodeServiceRepositoryInterface {
  Future<UserAppModel> verifyCode(AuthUserModel authModel);
}

@Deprecated('Will be removed in 4.0')
///Verifies the code and returns the [UserAppModel]
@riverpod
class VerificationCodeServiceRepository
    extends _$VerificationCodeServiceRepository
    implements _VerificationCodeServiceRepositoryInterface {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  @override
  Future<UserAppModel> verifyCode(AuthUserModel authModel) async {
    final appConfig = AppConfig.instance;
    final path = '${appConfig.backendEndpoint}/users/checkVerificationCode';
    final response = await ref
        .read(piixDioProvider)
        .post(path, data: authModel.toJson());
    if (response.data == null) {
      throw Exception('There is no data in the response');
    }
    return UserAppModel.fromJson(response.data);
  }
}
