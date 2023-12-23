import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_navigation_provider.dart';
import 'package:piix_mobile/membership_feature/domain/provider/membership_provider.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/navigation_bar/membership_navigation_item.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/navigation_bar/profile_navigation_item.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/navigation_bar/protected_navigation_item.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/navigation_bar/store_navigation_item.dart';
import 'package:piix_mobile/notifications_feature/domain/provider/membership_notification_provider.dart';

///A Navigation Bar wrapper to watch when the notifications and membership
///status changes to pass on the values to [_MembershipBottomNavigationBar]
class MembershipNavigationBar extends ConsumerWidget {
  const MembershipNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMembership = ref.watch(isMainUserProvider);
    final notificationCount = ref
            .watch(membershipNotificationNotifierProvider)
            ?.protectedNotificationCount ??
        0;
    final hasActiveStore = ref.watch(hasActiveStoreProvider);
    final isMainUser = ref.watch(isMainUserProvider);

    return _MembershipBottomNavigationBar(
      isMembership: isMembership,
      hasActiveStore: hasActiveStore,
      isMainUser: isMainUser,
      protectedNotificationCount: notificationCount,
    );
  }
}

///The Membership Navigation Bar used to select the different
///options while the user is inside the membership.
class _MembershipBottomNavigationBar extends ConsumerWidget {
  const _MembershipBottomNavigationBar({
    this.isMembership = false,
    this.hasActiveStore = false,
    this.isMainUser = false,
    this.protectedNotificationCount = 0,
  });

  ///Status that states if there is a real memberhsip to navigate
  final bool isMembership;

  ///Status to know if the user can see the store
  final bool hasActiveStore;

  ///Status that determines if the user has the
  ///main membership and can see the protected option
  final bool isMainUser;

  ///Number of protected that need to be checked
  ///by the main user
  final int protectedNotificationCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentNavigationBarItem =
        ref.watch(navigateMembershipNotifierProvider);
    return BottomNavigationBar(
      items: [
        const MembershipNavigationItem(),
        if (isMainUser) ProtectedNavigationItem(protectedNotificationCount),
        if (hasActiveStore) const StoreNavigationItem(),
        const ProfileNavigationItem(),
      ],
      onTap: isMembership
          ? ref.watch(navigateMembershipNotifierProvider.notifier).set
          //If there is no membership the navigation bar does nothing
          : (_) {},
      currentIndex: currentNavigationBarItem,
    );
  }
}
