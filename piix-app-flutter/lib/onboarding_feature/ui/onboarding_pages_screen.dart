import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/user_provider.dart';
import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_events_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_parameter_constants.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_analytics/piix_analytics_values.dart';
import 'package:piix_mobile/membership_feature/ui/screens/membership_loading_screen.dart';
import 'package:piix_mobile/onboarding_feature/data/onboard_data.dart';
import 'package:piix_mobile/onboarding_feature/domain/onboard_model.dart';
import 'package:piix_mobile/onboarding_feature/domain/provider/page_provider.dart';
import 'package:piix_mobile/onboarding_feature/ui/widgets/dot_indicator.dart';
import 'package:piix_mobile/utils/app_copies_barrel_file.dart';
import 'package:piix_mobile/utils/list_utils.dart';
import 'package:piix_mobile/utils/log_utils.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';

class OnboardingPagesScreen extends ConsumerStatefulWidget {
  static const routeName = '/onboarding_pages_screen';
  const OnboardingPagesScreen({super.key});

  @override
  ConsumerState<OnboardingPagesScreen> createState() =>
      _OnboardingPagesScreenState();
}

class _OnboardingPagesScreenState extends ConsumerState<OnboardingPagesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) ref.read(pageControllerNotifierProvider).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(pageNotifierProvider);
    final controller =
        ref.watch(pageControllerNotifierProvider.notifier).controller;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.height * 0.58,
                child: PageView.builder(
                  onPageChanged: (currentIndex) => ref
                      .read(pageNotifierProvider.notifier)
                      .setPage(currentIndex),
                  itemBuilder: (context, index) {
                    final onboardPage =
                        onboardPages.guardElementAt<OnboardPageModel?>(index);
                    if (onboardPage == null) return null;
                    return _OnboardPage(onboardPage: onboardPage);
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  itemCount: onboardPages.length,
                ),
              ),
              const _OnboardingControls(),
              SizedBox(
                height: 16.h,
              ),
              const _OnboardingDotsControls(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardPage extends StatelessWidget {
  const _OnboardPage({
    required this.onboardPage,
  });

  final OnboardPageModel onboardPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          onboardPage.title,
          style: context.primaryTextTheme?.displayMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          onboardPage.subtitle,
          style: context.textTheme?.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 12.h,
        ),
        Image.asset(
          onboardPage.image,
          height: 210,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              PiixAssets.membershipPlaceHolder,
              height: 300,
            );
          },
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          onboardPage.description,
          style: context.textTheme?.titleMedium,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class _OnboardingControls extends ConsumerWidget with LogAnalytics {
  const _OnboardingControls();

  void toMemberships(BuildContext context, WidgetRef ref, [bool skip = true]) async {
    final approved = ref.read(userPodProvider)?.approved ?? false;
    if (approved) {
      AppSharedPreferences.saveHasSeenOnboarding(true);
    }
    logEvent(
      eventName: PiixAnalyticsEvents.memberships,
      eventParameters: {
        PiixAnalyticsParameters.trigger: PiixAnalyticsValues.onboarding,
        PiixAnalyticsParameters.skip: PiixAnalyticsValues.yesOrNo(skip),
      },
    );
    NavigatorKeyState().fadeInRoute(
      page:  MembershipLoadingScreen(context),
      routeName: MembershipLoadingScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastPage = ref.watch(pageNotifierProvider) == onboardPages.length - 1;
    return Column(
      children: [
        SizedBox(
          height: 32.h,
          width: 156.w,
          child: ElevatedAppButtonDeprecated(
            onPressed: () async {
              if (lastPage) return toMemberships(context, ref, false);
              await ref
                  .read(pageControllerNotifierProvider.notifier)
                  .nextPage();
            },
            text: OnboardingCopies.next,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32.h,
          child: TextAppButtonDeprecated(
            onPressed: () => toMemberships(context, ref),
            text: lastPage
                ? OnboardingCopies.seeTutorialAgain
                : OnboardingCopies.skip,
            type: 'two',
            isMain: false,
          ),
        ),
      ],
    );
  }
}

class _OnboardingDotsControls extends ConsumerWidget {
  const _OnboardingDotsControls();

  void controlDots(WidgetRef ref,
      {required int index, required int page}) async {
    final stepDifference = (page - index).abs();
    final isNegative = (page - index).isNegative;
    for (var index = 0; index < stepDifference; index++) {
      if (isNegative) {
        await ref.read(pageControllerNotifierProvider.notifier).nextPage();
        continue;
      }
      await ref.read(pageControllerNotifierProvider.notifier).previousPage();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(pageNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardPages.length,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: GestureDetector(
            onTap: () => controlDots(ref, index: index, page: page),
            child: DotIndicator(
              isActive: index == page,
            ),
          ),
        ),
      ),
    );
  }
}
