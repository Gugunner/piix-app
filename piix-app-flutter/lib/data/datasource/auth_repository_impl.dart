import 'package:piix_mobile/app_config.dart';
import 'package:piix_mobile/domain/model/protected_register_data.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';

///Here are all the implementations of the api calls for authentication
@Deprecated('Use registerUserRequestedImpl in RegisterUserRepository')
class AuthRepositoryImpl {
  final appConfig = AppConfig.instance;
  Future<bool> registerProtectedUser(
      {required ProtectedRegisterData protectedRegisterData}) async {
    try {
      final _response = await PiixApiDeprecated.post(
        path: '${appConfig.signUpEndpoint}/Prod/register/protected-user',
        data: protectedRegisterData.toJson(),
      );
      if (PiixApiDeprecated.checkStatusCode(
          statusCode: _response.statusCode!)) {
        return true;
      }
      throw Exception(_response.data);
    } catch (_) {
      rethrow;
    }
  }
}
