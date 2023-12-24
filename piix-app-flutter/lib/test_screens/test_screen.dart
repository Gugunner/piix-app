import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/membership_feature/membership_ui_barrel_file.dart';

import 'package:piix_mobile/test_screens/test_screens_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/drawer/app_drawer_barrel_file.dart';
import 'package:piix_mobile/widgets/navigation_bar/navigation_bar_barrel_file.dart';

final navigationTabIndexProvider = StateProvider<int>((ref) => 0);

class TestScreen extends ConsumerStatefulWidget {
  static const routeName = '/test_screen';
  const TestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  final drawerOptions = <IDrawerOptionNavigation>[
    const MembershipDrawerOptionMyMembership(),
    const MembershipDrawerOptionMyGroup(),
    const MembershipDrawerOptionImproveMembership(),
    const MembershipDrawerOptionProfile(),
    const MembershipDrawerOptionNotifications(),
    const MembershipDrawerOptionMyPurchases(),
    const MembershipDrawerOptionMyRequests(),
    const MembershipDrawerOptionContact(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabIndex = ref.watch(navigationTabIndexProvider);

    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(
        header: AppDrawerHeader(
          headline: const MembershipUserHeader('User name'),
          bottomline: const MembershipStatusHeader(isActive: true),
        ),
        children: [
          ...drawerOptions,
        ],
        footer: AppDrawerFooter(child: MembershipFooter()),
      ),
      bottomNavigationBar: AppNavigationBar(context,
        myGroupNotificationsCount: 3,
        profileNotificationsCount: 5,
        onTap: (int index) {
          ref.read(navigationTabIndexProvider.notifier).state = index;
        },
        currentIndex: tabIndex,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('WELCOME TO TEST RUN!'),
                SizedBox(
                  height: 8.h,
                ),
                AppFilledSizedButton(
                  text: 'App Button Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(AppButtonScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppOutlinedSizedButton(
                  text: 'App Banner Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(AppBannerScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppTextSizedButton(
                  text: 'App Tag Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(AppTagScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppFilledSizedButton(
                  text: 'App Bar Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(AppBarScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppFilledSizedButton(
                  text: 'App Card Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(AppCardScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppFilledSizedButton(
                  text: 'App Modal Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(AppModalScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                AppFilledSizedButton(
                  text: 'App Text Field Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(AppTextFieldScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
