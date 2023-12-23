import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/protected_model.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

///Get a protected personal data for protected detail screen
Map<String, String> protectedPersonalData(
  ProtectedModel? protected,
) {
  return !(protected?.membership?.isActive ?? false)
      ? {
          PiixCopiesDeprecated.names: protected?.name ?? '-',
          PiixCopiesDeprecated.lastNames: protected?.firstLastName ?? '-',
          PiixCopiesDeprecated.email: protected?.email ?? '-',
          PiixCopiesDeprecated.areaCode:
              protected?.internationalPhoneCode ?? '-',
          PiixCopiesDeprecated.phone: protected?.phoneNumber ?? '-',
          PiixCopiesDeprecated.relationship:
              protected?.membership?.usersMembershipPlans.first.kinship.name ??
                  '',
        }
      : {
          PiixCopiesDeprecated.uniqueId: protected?.uniqueId ?? '-',
          PiixCopiesDeprecated.names: protected?.name ?? '-',
          PiixCopiesDeprecated.lastNames: protected?.firstLastName ?? '-',
          PiixCopiesDeprecated.Curp: protected?.governmentNumber ?? '-',
          PiixCopiesDeprecated.gender: protected?.genderName ?? '-',
          PiixCopiesDeprecated.email: protected?.email ?? '-',
          PiixCopiesDeprecated.areaCode:
              protected?.internationalPhoneCode ?? '-',
          PiixCopiesDeprecated.phone: protected?.phoneNumber ?? '-',
          PiixCopiesDeprecated.birthDate:
              protected?.birthdate.dateFormat ?? '-',
          PiixCopiesDeprecated.relationship:
              protected?.membership?.usersMembershipPlans.first.kinship.name ??
                  '',
        };
}
