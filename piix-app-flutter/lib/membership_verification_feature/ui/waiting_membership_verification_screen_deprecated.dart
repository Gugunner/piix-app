import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/onboarding_feature/ui/onboarding_screen.dart';
import 'package:piix_mobile/ui/common/logout_button_deprecated.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/screen/app_screen/pop_app_screen.dart';

@Deprecated('This class is no longer in use')

///A landing screen where the user is notified that her
///[membership] is still waiting approval or rejection
class WaitingMembershipVerificationScreenDeprecated extends StatelessWidget {
  static const routeName = '/waiting_verification_screen';
  const WaitingMembershipVerificationScreenDeprecated({super.key});

  double get spacerSize => 24;

  @override
  Widget build(BuildContext context) {
    return PopAppScreen(
      onWillPop: () async => true,
      appBar: LogoAppBar(),
      body: Padding(
        padding: EdgeInsets.all(spacerSize.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AuthUserCopies.checkingYourData,
              style: context.primaryTextTheme?.displayMedium?.copyWith(
                color: PiixColors.infoDefault,
              ),
            ),
            SizedBox(height: spacerSize.h),
            SizedBox(
              height: 121.h,
              width: 168.w,
              child: Image.asset(PiixAssets.saveTime),
            ),
            SizedBox(height: spacerSize.h),
            Text(
              AuthUserCopies.verificationInstruction,
              style: context.textTheme?.titleMedium?.copyWith(
                color: PiixColors.infoDefault,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: spacerSize.h),
            SizedBox(
              width: 156.w,
              height: 32.h,
              child: ElevatedAppButtonDeprecated(
                onPressed: toMembershipLoadingScreen,
                text: AuthUserCopies.iUnderstand.toUpperCase(),
              ),
            ),
            SizedBox(
              height: spacerSize.h,
            ),
            TextAppButtonDeprecated(
              onPressed: toOnboardingScreen,
              text: AuthUserCopies.seeTheTutorial,
              type: 'two',
            ),
            SizedBox(
              height: spacerSize.h,
            ),
            const LogoutButtonOld(),
          ],
        ),
      ),
    );
  }

  void toMembershipLoadingScreen() {
    // NavigatorKeyState().fadeInRoute(
    //   page:  MembershipLoadingScreen(),
    //   routeName: MembershipLoadingScreen.routeName,
    // );
  }

  void toOnboardingScreen() {
    NavigatorKeyState().getNavigator()?.pushNamed(
          OnboardingScreen.routeName,
        );
  }
}
