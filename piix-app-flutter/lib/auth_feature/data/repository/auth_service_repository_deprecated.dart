import 'package:piix_mobile/api_deprecated/piix_dio_provider_deprecated.dart';
import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/auth_feature/domain/model/auth_user_model.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service_repository_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///An interface to mandate getting a customToken
abstract class _AuthCustomTokenServiceRepositoryInterface {
  Future<UserAppModel> getCustomTokenUser(AuthUserModel authModel);
}

@Deprecated('Will be removed in 4.0')
///An interface to mandate sending the user credentials
abstract class _AuthCredentialServiceRepositoryInterface {
  Future<void> sendCredential(AuthUserModel authModel);
}

@Deprecated('Will be removed in 4.0')
///A [Notifier] that handles requesting from the api
///an updated user with a new [customAccessToken].
@riverpod
class AuthCustomTokenServiceRepository
    extends _$AuthCustomTokenServiceRepository
    implements _AuthCustomTokenServiceRepositoryInterface {
  @override
  void build() => {};

  @Deprecated('Will be removed in 4.0')
  ///Returns a new [UserAppModel] with a new [customAccessToken]
  @override
  Future<UserAppModel> getCustomTokenUser(AuthUserModel authModel) async {
    final appConfig = AppConfig.instance;
    final path = '${appConfig.backendEndpoint}/users/customToken';
    final response = await ref
        .read(piixDioProvider)
        .post(path, data: authModel.toJson());
    return UserAppModel.fromJson(response.data);
  }
}

@Deprecated('Will be removed in 4.0')
///Sends the usern information and requests a new verification code.
@riverpod
class AuthCredentialServiceRepository extends _$AuthCredentialServiceRepository
    implements _AuthCredentialServiceRepositoryInterface {
  @override
  void build() => {};

  @override
  Future<void> sendCredential(AuthUserModel authModel) {
    final appConfig = AppConfig.instance;
    final path = '${appConfig.backendEndpoint}/users/checkCredentials';
    return ref.read(piixDioProvider).post(path, data: authModel.toJson());
  }
}
