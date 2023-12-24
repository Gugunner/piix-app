import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';


///A default [BottomNavigationBarThemeData] with
///pre defined properties.
///
///Use copyWith to overwrite any property.
final class AppBottomNavigationBarTheme extends BottomNavigationBarThemeData {
  AppBottomNavigationBarTheme()
      : super(
          showUnselectedLabels: true,
          selectedItemColor: PiixColors.twilightBlue,
          unselectedItemColor: PiixColors.secondary,
          selectedLabelStyle: BaseTextTheme().bodyMedium.copyWith(
                color: PiixColors.primary,
              ),
          unselectedLabelStyle: BaseTextTheme().bodyMedium.copyWith(
                color: PiixColors.secondary,
              ),
          selectedIconTheme: IconThemeData(
            size: 24.h,
          ),
        );
}
