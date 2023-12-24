import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/test_screens/app_bar_screens/app_bar_screens_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/button/elevated_app_button_deprecated/elevated_app_button_deprecated.dart';

class AppBarScreen extends StatelessWidget {
  static const routeName = '/app_bar_screen';
  const AppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const Text('APP BAR TESTS'),
                SizedBox(
                  height: 8.h,
                ),
                ElevatedAppButtonDeprecated(
                  text: 'Title App Bar Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(SimpleAppBarScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                ElevatedAppButtonDeprecated(
                  text: 'Logo App Bar Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(LogoAppBarScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                ElevatedAppButtonDeprecated(
                  text: 'Information Tooltip App Bar Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(TooltipAppBarScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                ElevatedAppButtonDeprecated(
                  text: 'Notifications App Bar Screen',
                  onPressed: () {
                    NavigatorKeyState()
                        .getNavigator(context)
                        ?.pushNamed(NotificationsAppBarScreen.routeName);
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
