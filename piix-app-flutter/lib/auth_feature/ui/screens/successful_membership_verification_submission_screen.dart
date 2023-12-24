import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///The screen that appears when the user finishes confirming the submitted
///information in [MembershipConfirmationScreen].
///
///This screen shows the first time after user confirms the personal information
///form and documentation form information and is the landing screen while the
///information is being verified.
final class SuccessfulMembershipVerificationSubmissionScreen
    extends StatelessWidget with ExitPrompt {
  static const routeName = '/waiting_membership_verification_screen';

  SuccessfulMembershipVerificationSubmissionScreen({super.key});

  ///Case when a user's membership has not been aproved
  void _navigateToWaitingMembershipReviewScreen(BuildContext context) {
    NavigatorKeyState().fadeInRoute(
      page: const WaitingMembershipReviewScreen(),
      routeName: WaitingMembershipReviewScreen.routeName,
      context: context,
      replaceAll: true,
    );
  }

  void _navigateToLinkupMembershipScreen(BuildContext context) async {
    final linkupModel =
        await NavigatorKeyState().slideToTopRoute<LinkupCodeTypeModel?>(
      page: const LinkupMembershipScreen(),
      routeName: LinkupMembershipScreen.routeName,
    );
    //Navigate to the screen only if the user has linked up the membership.
    if (linkupModel != null)
      return _navigateToWaitingMembershipReviewScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => (await showExitAppPrompt(context)) ?? false,
      child: Scaffold(
        appBar: LogoAppBar(
          elevation: 0,
          backgroundColor: PiixColors.space,
          logoColor: PiixColors.primary,
          size: Size(63.w, 36.h),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: context.width,
                  child: Text(
                    context.localeMessage.weReceivedYourInformation,
                    style: context.primaryTextTheme?.displayMedium?.copyWith(
                      color: PiixColors.infoDefault,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32.h),
                Icon(
                  Icons.check_circle_rounded,
                  color: PiixColors.success,
                  size: 120.w,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: context.width,
                  child: Text(
                    context.localeMessage.yourInformationIsBeingRevised,
                    style: context.titleMedium?.copyWith(
                      color: PiixColors.infoDefault,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 45.h),
                SizedBox(
                  width: context.width,
                  child: Text(
                    context.localeMessage.doYouHaveAnInvitationCode,
                    style: context.titleMedium?.copyWith(
                      color: PiixColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: 176.w,
                  height: 40.h,
                  child: AppOutlinedSizedButton(
                    text: context.localeMessage.enterCode.toUpperCase(),
                    onPressed: () => _navigateToLinkupMembershipScreen(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
