import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/constants/widget_keys.dart';
import 'package:piix_mobile/src/features/authentication/presentation/authentication_page_barrel_file.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';
import 'package:piix_mobile/src/theme/theme_context.dart';
import 'package:piix_mobile/src/utils/size_context.dart';

import '../../../../common_widgets/common_widgets_barrel_file.dart';

/// A reusable widget that displays the welcome message and the email input
/// text field for the user to enter their email address in the web version 
/// of the app.
class WelcomeToPiixOneTimeCodeLogin extends StatelessWidget {
  const WelcomeToPiixOneTimeCodeLogin({
    super.key,
    required this.parentPadding,
    required this.width,
  });

  final double width;
  final double parentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  'assets/svgs/app_brand/piix_logo.svg',
                  color: context.theme.primaryColor,
                ),
                gapH16,
                Text(
                  'Welcome to Piix'.hardcoded,
                  style: context.theme.textTheme.displayMedium?.copyWith(
                    color: PiixColors.contrast,
                  ),
                  textAlign: TextAlign.center,
                ),
                gapH12,
                Text(
                  '''Manage your membership and invite others to join your family protection.'''
                      .hardcoded,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: PiixColors.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                gapH64,
                SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login with a one time code using your email.'
                            .hardcoded,
                        style: context.theme.textTheme.labelLarge?.copyWith(
                          color: PiixColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      gapH8,
                      const EmailInputTextField(
                        key: WidgetKeys.emailInputTextField,
                      ),
                      gapH16,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Send code'.hardcoded,
                          ),
                        ),
                      ),
                      gapH20,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child:
                                  OrSignUpLabel(key: WidgetKeys.signUpLabel)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            gapH64,
            gapH64,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2024 Piix'.hardcoded,
                    style: context.theme.textTheme.bodySmall?.copyWith(
                      color: PiixColors.secondaryLight,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
