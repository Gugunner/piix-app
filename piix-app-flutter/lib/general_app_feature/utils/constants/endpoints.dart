import 'package:piix_mobile/app_config.dart';

class PiixAppEndpoints {
  static final updateUserEmailEndpoint =
      '${AppConfig.instance.backendEndpoint}/users/email/update';
  static final updateUserPhoneNumberEndpoint =
      '${AppConfig.instance.backendEndpoint}/users/phone/update';
  static final getLevelsAndPlansEndpoint =
      '${AppConfig.instance.backendEndpoint}/users/getPlanAndLevelForMemberships';
}
