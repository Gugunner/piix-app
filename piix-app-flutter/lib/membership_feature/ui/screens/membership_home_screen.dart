import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_provider_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_provider_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/ui/screens/app_membership_navigation_home_screen.dart';
import 'package:piix_mobile/notifications_feature/notifications_provider_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/membership_card/membership_card_barrel_file.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';

class MembershipHomeScreen extends AppLoadingWidget {
  static const routeName = '/membership_home_screen';
  const MembershipHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MembershipHomeScreenState();
}

class _MembershipHomeScreenState
    extends AppLoadingWidgetState<MembershipHomeScreen> {
  @override
  void initState() {
    super.initState();
    isRequesting = false;
  }

  @override
  Future<void> whileIsRequesting() async => ref
          .watch(membershipNotificationServiceNotifierProvider)
          .whenOrNull(data: (_) {
        endRequest();
      }, error: (_, __) {
        endRequest();
      });

  ///Prevents the screen from popping
  Future<bool> onWillPop() async => false;

  ///Navigates to the BlankMembershipScreen if the [user] or
  ///the [membership] are erased from the app state.
  void _navigateToBlankMembershipHomeScreen() {
    Future.microtask(() => NavigatorKeyState().fadeInRoute(
        page: const BlankMembershipHomeScreen(),
        routeName: BlankMembershipHomeScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userPodProvider);
    final membership = ref.watch(membershipNotifierPodProvider);
    // if (isRequesting) whileIsRequesting();

    //If there is no user or membership found navigate to
    // BlankMembershipHomeScreen
    if (membership == null || user == null) {
      _navigateToBlankMembershipHomeScreen();
      return const SizedBox();
    }

    return AppMembershipNavigationHomeScreen(
      user: user,
      membership: membership,
      onWillPop: onWillPop,
      ignore: isRequesting,
      child: Shimmer(
        child: ShimmerLoading(
          isLoading: isRequesting,
          child: Stack(
            children: [
              Container(
                width: context.width,
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  16.h,
                  8.w,
                  16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MembershipHomeScreenHeader(
                      user: user,
                      membership: membership,
                      isLoading: isRequesting,
                    ),
                    SizedBox(height: 24.h),
                    MembershipHomeScreenPanels(
                      membership: membership,
                      isLoading: isRequesting,
                    ),
                    SizedBox(height: 24.h),
                    MembershipHomeScreenDialogs(isLoading: isRequesting),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
              AppPannableMembershipCard(
                color: PiixColors.level1,
                child: UserMembershipCardContent(
                    user: user, membership: membership),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
