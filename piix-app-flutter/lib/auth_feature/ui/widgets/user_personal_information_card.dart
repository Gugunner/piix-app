import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_barrel_file.dart';
import 'package:piix_mobile/auth_feature/user_app_model_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///Shows a list of [Row]s with all the [user] properties selected.
///
///The selection of the properties of the user is obtained by calling
///[_getUserProperties]. 
final class UserPersonalInformationCard extends StatelessWidget {
  const UserPersonalInformationCard(this.user, {super.key});

  final UserAppModel user;


  ///Returns the properties to show as a list inside this.
  ///
  ///Consider any formatting of the property value inside this method.
  List<(String, dynamic)> _getUserProperties(BuildContext context) => [
        ('name', user.name),
        ('middleName', user.middleName),
        ('firstLastName', user.firstLastName),
        ('secondLastName', user.secondLastName),
        ('email', user.email),
        ('internationalPhoneCode', user.internationalPhoneCode),
        ('phoneNumber', user.phoneNumber),
        (
          'birthdate',
          DateLocalizationUtils.getDYM(
              context, user.birthdate ?? DateTime.now())
        ),
        ('genderName', user.genderName),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: PiixColors.space,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: PiixColors.contrast30.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.h),
            width: context.width,
            child: Text(
              context.localeMessage.personalInformation,
              style: context.accentTextTheme?.headlineLarge
                  ?.copyWith(color: PiixColors.infoDefault),
            ),
          ),
          ..._getUserProperties(context).map((properties) {
            final (property, userValue) = properties;
            final userProperty =
                user.getPersonalInformationLocalizedPropertyName(property,
                    context: context);
            return Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              child: UserPersonalInformationRow(
                userProperty: userProperty,
                userValue: userValue,
              ),
            );
          })
        ],
      ),
    );
  }
}
