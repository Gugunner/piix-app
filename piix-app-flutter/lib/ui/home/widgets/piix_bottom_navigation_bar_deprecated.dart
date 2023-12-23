import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/home_provider.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/notification_bloc.dart';
import 'package:piix_mobile/ui/home/widgets/bottom_navigation_item.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:provider/provider.dart';

/// Creates a custom bottom navigation bar.
@Deprecated('Use Membership NavigationBar')
class PiixBottomNavigationBarDeprecated extends StatelessWidget {
  const PiixBottomNavigationBarDeprecated({
    super.key,
    required this.activeEcommerce,
  });
  final bool activeEcommerce;

  HomeStateDeprecated get finishHomeState => HomeStateDeprecated.finish;

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final notificationBLoC = context.watch<NotificationBLoC>();
    final membershipBLoC = context.watch<MembershipProviderDeprecated>();
    final navigationProvider = context.watch<NavigationProviderDeprecated>();
    if (membershipBLoC.selectedMembership == null) return const SizedBox();
    final isMainUserOfSelectedMembership =
        membershipBLoC.isMainUserOfSelectedMembership;
    final isProtectedSectionAvailable = isMainUserOfSelectedMembership;

    try {
      return homeProvider.homeState != finishHomeState
          ? const SizedBox()
          : BottomNavigationBar(
              items: [
                const BottomNavigationBarItem(
                  backgroundColor: PiixColors.skeletonGrey,
                  icon: BottomNavigationIcon(icon: PiixIcons.membresias),
                  label: PiixCopiesDeprecated.membershipWord,
                ),
                if (isProtectedSectionAvailable) ...[
                  BottomNavigationBarItem(
                      icon: BottomNavigationIcon(
                        icon: PiixIcons.protegidos,
                        numberOfNotifications:
                            notificationBLoC.protectedNotifications,
                      ),
                      label: PiixCopiesDeprecated.protectedText),
                  if (activeEcommerce)
                    const BottomNavigationBarItem(
                      icon:
                          BottomNavigationIcon(icon: Icons.storefront_outlined),
                      label: PiixCopiesDeprecated.storeLabel,
                    )
                ],
                BottomNavigationBarItem(
                  icon: BottomNavigationIcon(
                    icon: PiixIcons.perfil,
                    numberOfNotifications: notificationBLoC.totalNotifications,
                    isAnimated: true,
                  ),
                  label: PiixCopiesDeprecated.profileText,
                ),
              ],
              currentIndex: navigationProvider.currentNavigationBottomTab,
              onTap: (index) =>
                  navigationProvider.setCurrentNavigationBottomTab(index),
            );
    } catch (e) {
      return const SizedBox();
    }
  }
}
