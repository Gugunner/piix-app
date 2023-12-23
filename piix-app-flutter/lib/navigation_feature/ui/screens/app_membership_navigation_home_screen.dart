import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_feature/user_app_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_model_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/ui/widgets/membership_bottom_navigation_bar.dart';
import 'package:piix_mobile/notifications_feature/notifications_provider_barrel_file.dart';

import 'package:piix_mobile/widgets/app_bar/app_bar_barrel_file.dart';
import 'package:piix_mobile/widgets/drawer/app_drawer_barrel_file.dart';

///A home screen [ConsumerWidget] that is for any screen which appears after
///the user navigates to it by using the [MembershipBottomNavigationBar].
final class AppMembershipNavigationHomeScreen extends ConsumerWidget {
  const AppMembershipNavigationHomeScreen({
    super.key,
    required this.user,
    this.ignore = false,
    this.membership,
    this.child,
    this.onWillPop,
  });

  ///The current user information of the session.
  final UserAppModel user;

  ///Set to true to disable the whole screen when loading information.
  final bool ignore;

  ///The current user membership information in the session.
  final MembershipModel? membership;

  ///Pass the content of the [body] for the screen.
  final Widget? child;

  ///Use when the screen needs to handle specific logic
  ///when popping the screen.
  final Future<bool> Function()? onWillPop;

  ///The active state of the user membership.
  bool get _isActive => membership?.isActive ?? false;

  ///The name to display in the [AppBar] and in the [DrawerHeader]
  String get _displayName => user.displayShortFullName;

  ///The options to select from in the [Drawer].
  List<IDrawerOptionNavigation> get _drawerOptions => [
        const MembershipDrawerOptionMyMembership(),
        if (_isActive) ...[
          const MembershipDrawerOptionMyGroup(),
          const MembershipDrawerOptionImproveMembership(),
        ],
        const MembershipDrawerOptionProfile(),
        if (_isActive) ...[
          const MembershipDrawerOptionMyPurchases(),
          const MembershipDrawerOptionMyRequests(),
          const MembershipDrawerOptionNotifications(),
        ],
        const MembershipDrawerOptionContact(),
      ];

  ///When the user taps the screen it unfocuses any
  ///element with a focus.
  void _onUnfocus(BuildContext context) {
    //Checks if a primary focus is found.
    final focus = FocusManager().primaryFocus;
    if (focus == null) return;
    //If it has either focus it unfocus all.
    if (focus.hasFocus || focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  ///Navigates to [NotificationsScreen].
  void _navigateToNotifications() {
    // TODO: implement navigate to NotificationsScreen
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///Returns number of notifications if the membership notifications
    ///has been retrieved otherwise always sets at 0
    final notificationCount =
        ref.watch(membershipNotificationNotifierProvider)?.count ?? 0;
    return WillPopScope(
      onWillPop: onWillPop,
      child: IgnorePointer(
        ignoring: ignore,
        child: GestureDetector(
          onTap: () => _onUnfocus(context),
          child: Scaffold(
            appBar: NotificationsAppBar(
              appBarTitle: _displayName,
              onTap: _navigateToNotifications,
              notificationsCount: notificationCount,
            ),
            drawer: AppDrawer(
              header: AppDrawerHeader(
                headline: MembershipUserHeader(_displayName),
                bottomline: MembershipStatusHeader(isActive: _isActive),
              ),
              children: _drawerOptions,
              footer: AppDrawerFooter(child: MembershipFooter()),
            ),
            bottomNavigationBar: MembershipBottomNavigationBar(
              isActive: _isActive,
            ),
            body: SingleChildScrollView(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
