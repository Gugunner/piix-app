import 'package:flutter/material.dart';
import 'package:piix_mobile/src/common_widgets/common_widgets_barrel_file.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/constants/screen_breakpoints.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/one_column_sign_in_sign_up_submit.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/welcome_to_piix_one_time_code_submit.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';
import 'package:piix_mobile/src/utils/size_context.dart';
import 'package:piix_mobile/src/utils/verification_type.dart';

///Calls for a specific layout for the [SignInPage].
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebMobileTabletLayoutBuilder(
        twoColumn: const OneColumnSignInSignUpSubmit(
          verificationType: VerificationType.register,
        ),
        oneColumn: const OneColumnSignInSignUpSubmit(
          verificationType: VerificationType.register,
        ),
        tablet: Container(
          color: PiixColors.highlight,
        ),
        mobile: Container(
          color: PiixColors.assist,
        ),
      ),
    );
  }
}

class OneColumnSignUpPage extends StatelessWidget {
  const OneColumnSignUpPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        // * Get the maximum width of the screen
        final maxWidth = constraints.maxWidth;
        // * Get the padding based on the screen size
        final padding = maxWidth >= ScreenBreakPoint.md ? Sizes.p32 : Sizes.p16;
        // * Get the width of the container based on the screen size
        final width = maxWidth >= ScreenBreakPoint.xl
            ? context.screenWidth
            : maxWidth >= ScreenBreakPoint.lg
                ? context.screenWidth * 0.5
                : maxWidth >= ScreenBreakPoint.md
                    ? context.screenWidth * 0.6
                    : context.screenWidth * 0.75;
        return Container(
          color: PiixColors.primary,
          padding: EdgeInsets.all(padding),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.p16),
              color: PiixColors.space,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: maxWidth >= ScreenBreakPoint.xl
                    ? context.screenWidth * 0.25
                    : Sizes.p16,
              ),
              child: WelcomeToPiixOneTimeCodeSubmit(
                parentPadding: padding,
                width: width,
                verificationType: VerificationType.register,
              ),
            ),
          ),
        );
      }),
    );
  }
}
