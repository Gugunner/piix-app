import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_feature/ui/screens/membership_loading_screen.dart';
import 'package:piix_mobile/onboarding_feature/ui/onboarding_pages_screen.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';

class OnboardingScreen extends ConsumerWidget with LogAnalytics {
  static const routeName = '/onboarding_screen';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(
            24.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                OnboardingCopies.welcomeToPiix,
                style: context.primaryTextTheme?.displayMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                '${OnboardingCopies.nowHave} ${PiixCopiesDeprecated.piix}, '
                '${OnboardingCopies.prepareWith} ${OnboardingCopies.tips} '
                '${OnboardingCopies.advantageOfMembership}',
                style: context.textTheme?.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              SvgPicture.asset(
                PiixAssets.welcomeTips,
                height: 300,
                placeholderBuilder: (context) {
                  return Image.asset(
                    PiixAssets.membershipPlaceHolder,
                    height: 300,
                  );
                },
              ),
              SizedBox(height: 24.h),
              SizedBox(
                height: 32.h,
                width: 156.w,
                child: ElevatedAppButtonDeprecated(
                  onPressed: () {
                    NavigatorKeyState().fadeInRoute(
                        page: const OnboardingPagesScreen(),
                        routeName: OnboardingPagesScreen.routeName);
                  },
                  text: OnboardingCopies.viewTips,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 32.h,
                child: TextAppButtonDeprecated(
                  onPressed: () {
                    final approved =
                        ref.read(userPodProvider)?.approved ?? false;
                    if (approved) {
                      AppSharedPreferences.saveHasSeenOnboarding(true);
                    }
                    logEvent(
                      eventName: PiixAnalyticsEvents.memberships,
                      eventParameters: {
                        PiixAnalyticsParameters.trigger:
                            PiixAnalyticsValues.onboarding,
                        PiixAnalyticsParameters.skip:
                            PiixAnalyticsValues.yesOrNo(true),
                      },
                    );
                    NavigatorKeyState().fadeInRoute(
                      page: MembershipLoadingScreen(context),
                      routeName: MembershipLoadingScreen.routeName,
                    );
                  },
                  text: OnboardingCopies.skip,
                  type: 'two',
                  isMain: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
