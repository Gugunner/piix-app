import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/navigation_feature/navigation_provider_barrel_file.dart';
import 'package:piix_mobile/widgets/navigation_bar/navigation_bar_barrel_file.dart';

///A wrapper class that handles the app state of the navigation
///for the [AppNavigationBar].
final class MembershipBottomNavigationBar extends ConsumerWidget {
  const MembershipBottomNavigationBar({
    super.key,
    this.isActive = false,
  });

  ///Whether the membership is active and can show all the
  ///options.
  final bool isActive;

  ///Executes a specific navigation based on the [index] and
  ///stores the [index] in the [ref] provider.
  void _handleNavigateByIndex(int index, WidgetRef ref) {
    Future.microtask(() {
      ref.read(bottomNavigationPodProvider.notifier).set(index);
      if (index == 0) return _navigateToMembershipHomeScreen(index);
      //If the membership isActive the other options
      //open up for navigation.
      if (isActive) {
        if (index == 1) return _navigateToMyGroupHomeScreen(index);
        if (index == 2) return _navigateToStoreHomeScreen(index);
      }
      return _navigateToProfileHomeScreen(index);
    });
  }

  ///Navigates to [MyMembershipHomeScreen].
  void _navigateToMembershipHomeScreen(int index) {
    //TODO: Navigate to MyMembershipHomeScreen
  }

  ///Navigates to [MyGroupHomeScreen].
  void _navigateToMyGroupHomeScreen(int index) {
    //TODO: Navigate to MyGroupHomeScreen
  }

  ///Navigates to [StoreHomeScreen].
  void _navigateToStoreHomeScreen(int index) {
    //TODO: Navigate to StoreHomeScreen
  }

  ///Navigates to [ProfileHomeScreen].
  void _navigateToProfileHomeScreen(int index) {
    //TODO: Navigate to ProfileHomeScreen
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: Get membership notifications from membershipPod
    //TODO: Get user group notifications from userGroupPod
    //TODO: Get store notifications from storePod
    //TODO: Get user notifications from userPod

    final currentIndex = ref.watch(bottomNavigationPodProvider);
    return AppNavigationBar(context,
      onTap: (index) => _handleNavigateByIndex(index, ref),
      newItems: [
        MyMembershipBarItem(context, notificationsCount: 0),
        if (isActive) ...[
          MyGroupBarItem(context, notificationsCount: 0),
          StoreBarItem(context, notificationsCount: 0),
        ],
        MyProfileBarItem(context, notificationsCount: 0)
      ],
      currentIndex: currentIndex,
    );
  }
}
