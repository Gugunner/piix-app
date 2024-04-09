import 'package:flutter/material.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/constants/screen_breakpoints.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/welcome_to_piix_one_time_code_login.dart';
import 'package:piix_mobile/src/theme/theme_barrel_file.dart';
import 'package:piix_mobile/src/utils/size_context.dart';

/// A layout that displays one column when the user is running the app
/// in the web in smaller screens.
class OneColumnSignIn extends StatelessWidget {
  const OneColumnSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // * Get the maximum width of the screen
        final maxWidth = constraints.maxWidth;
        // * Get the padding based on the screen size
        final padding = maxWidth >= ScreenBreakPoint.md ? Sizes.p64 : Sizes.p32;
        // * Get the width of the container based on the screen size
        final width = maxWidth >= ScreenBreakPoint.xl
            ? context.screenWidth
            : maxWidth >= ScreenBreakPoint.lg
                ? context.screenWidth * 0.5
                : maxWidth >= ScreenBreakPoint.md
                    ? context.screenWidth * 0.6
                    : context.screenWidth * 0.75;
        return Container(
          height: context.screenHeight,
          width: context.screenWidth,
        padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.p16),
              color: PiixColors.space,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
              child: WelcomeToPiixOneTimeCodeLogin(
                parentPadding: padding,
                width: width,
              ),
            ),
          ),
        );
      },
    );
  }
}
