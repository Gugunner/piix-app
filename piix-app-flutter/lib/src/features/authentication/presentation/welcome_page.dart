import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/src/constants/screen_breakpoints.dart';
import 'package:piix_mobile/src/constants/widget_keys.dart';
import 'package:piix_mobile/src/features/authentication/presentation/mobile/mobile_welcome_page.dart';
import 'package:piix_mobile/src/features/authentication/presentation/tablet/tablet_welcome_page.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/one_column_sign_in.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/two_column_sign_in.dart';

///A layout builder Widget that displays the appropriate welcome page based on 
///the screen size and the platform where the app currently running.
class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        // * Get the maximum width of the screen
        final maxWidth = constraints.maxWidth;
        // * Check if the app is running on a mobile or tablet device
        final isNotMobileOrTablet =
            ref.watch(platformProvider.notifier).isNotMobileOrTablet;
        // * Display the appropriate web welcome page based on the screen size
        if (isNotMobileOrTablet) {
          if (maxWidth >= ScreenBreakPoint.xl) {
            return const TwoColumnSignIn(
              key: WidgetKeys.twoColumnSignIn,
            );
          } else {
            return const OneColumnSignIn(
              key: WidgetKeys.oneColumnWelcome,
            );
          }
        }
        // * Display the appropriate mobile or tablet welcome page based on the
        // * screen size
        if (maxWidth >= ScreenBreakPoint.md) {
          return const TabletWelcomePage(
            key: WidgetKeys.tabletWelcomePage,
          );
        } else {
          return const MobileWelcomePage(
            key: WidgetKeys.mobileWelcomePage,
          );
        }
      }),
    );
  }
}
