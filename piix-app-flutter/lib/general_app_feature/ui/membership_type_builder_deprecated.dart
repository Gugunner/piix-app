import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/app_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/home_provider.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/load_error_widget_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_fab_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_alert_ui_provider.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/membership_screen_builder_deprecated.dart';
import 'package:piix_mobile/protected_feature_deprecated/ui/available_protected_screen_builder_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/store_home_screen.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/ui/home/widgets/piix_bottom_navigation_bar_deprecated.dart';
import 'package:piix_mobile/user_profile_feature/ui/profile_screen.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead MembershipHomeScreen')

/// Main screen of the app.
class MembershipTypeBuilderDeprecated extends StatelessWidget {
  static const routeName = '/membership_type_builder';
  const MembershipTypeBuilderDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    final membershipInfoBLoC = context.watch<MembershipProviderDeprecated>();
    final navigationProvider = context.watch<NavigationProviderDeprecated>();
    final signInState = context.watch<AppBLoC>().signInState;
    final currentBottomTab = navigationProvider.currentNavigationBottomTab;
    final shouldActivateStore = membershipInfoBLoC.activateStore;
    final membershipScreens = [
      Consumer<MembershipAlertUiProvider>(
        builder: (context, provider, child) {
          return const MembershipScreenBuilderDeprecated();
        },
      ),
      if (membershipInfoBLoC.isMainUserOfSelectedMembership)
        const ProtectedScreenBuilderDeprecated(),
      if (membershipInfoBLoC.isMainUserOfSelectedMembership &&
          shouldActivateStore)
        const StoreHomeScreen(),
      const ProfileScreen(),
    ];

    return ClampingScaleDeprecated(
      child: Scaffold(
        bottomNavigationBar: PiixBottomNavigationBarDeprecated(
            activeEcommerce: shouldActivateStore),
        body: Stack(
          children: [
            Builder(
              builder: (BuildContext context) {
                if (membershipInfoBLoC.selectedMembership == null &&
                    signInState != SignInState.signedOut) {
                  return SizedBox(
                    height: context.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.height * 0.14,
                        ),
                        Expanded(
                          child: LoadErrorWidgetDeprecated(
                            message: PiixCopiesDeprecated
                                .userInProcessOfVerification,
                            onPressed: () {
                              NavigatorKeyState().getNavigator()?.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                try {
                  return membershipScreens[currentBottomTab];
                } catch (e) {
                  return const SizedBox();
                }
              },
            ),
            if (showPiixFAB(context))
              Positioned(
                top: context.height * 0.756,
                right: context.width * 0.078,
                child: const PiixFABDeprecated(),
              ),
          ],
        ),
      ),
    );
  }

  bool showPiixFAB(BuildContext context) {
    final userBLoC = context.read<UserBLoCDeprecated>();
    final navigationProvider = context.read<NavigationProviderDeprecated>();
    final membershipInfoBLoC = context.read<MembershipProviderDeprecated>();
    final currentBottomTab = navigationProvider.currentNavigationBottomTab;
    final homeProvider = context.watch<HomeProvider>();
    if (userBLoC.user == null || membershipInfoBLoC.selectedMembership == null)
      return false;
    return currentBottomTab != 2 &&
        !membershipInfoBLoC.isSOSDisabled &&
        membershipInfoBLoC.isActiveMembership &&
        homeProvider.homeState == HomeStateDeprecated.finish;
  }
}
