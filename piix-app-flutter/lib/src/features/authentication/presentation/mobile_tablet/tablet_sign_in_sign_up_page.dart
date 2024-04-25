import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/features/authentication/presentation/mobile_tablet/landscape_orientation_sign_in_sign_up.dart';
import 'package:piix_mobile/src/features/authentication/presentation/mobile_tablet/portrait_orientation_sign_in_sign_up.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';
import 'package:piix_mobile/src/utils/verification_type.dart';

/// A sign in sign up page for tablet devices.
class TabletSignInSignUpPage extends StatelessWidget {
  const TabletSignInSignUpPage({
    super.key,
    this.verificationType = VerificationType.login,
  });

  final VerificationType verificationType;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.p64.h,
            vertical: Sizes.p64.h,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.p16),
              color: PiixColors.space,
            ),
            padding: EdgeInsets.all(Sizes.p64.h),
            child: PortraitOrientationSignInSignUp(
              verificationType: verificationType,
            ),
          ),
        );
      }
      return LandscapeOrientationSignInSignUpPage(
        verificationType: verificationType,
      );
    });
  }
}
