import 'package:flutter/material.dart';
import 'package:piix_mobile/src/common_widgets/common_widgets_barrel_file.dart';
import 'package:piix_mobile/src/constants/app_sizes.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/or_sign_in_sign_up_label.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/submit_email_input_verification_code.dart';
import 'package:piix_mobile/src/localization/string_hardcoded.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';
import 'package:piix_mobile/src/theme/theme_context.dart';
import 'package:piix_mobile/src/utils/size_context.dart';
import 'package:piix_mobile/src/utils/verification_type.dart';

class WelcomeToPiixOneTimeCodeSubmit extends StatelessWidget {
  const WelcomeToPiixOneTimeCodeSubmit({
    super.key,
    required this.parentPadding,
    required this.width,
    this.verificationType = VerificationType.login,
  });

  final double width;
  final double parentPadding;
  final VerificationType verificationType;

  @override
  Widget build(BuildContext context) {
    final isLogin = verificationType.isLogin;
    return Container(
      height: context.screenHeight,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            gapH64,
            const AppLogo(),
            gapH16,
            Text(
              '${isLogin ? 'Welcome to Piix' : 'Create an account with us'}'
                  .hardcoded,
              style: context.theme.textTheme.displayMedium?.copyWith(
                color: PiixColors.contrast,
              ),
              textAlign: TextAlign.center,
            ),
            gapH12,
            Text(
              '''${isLogin ? 'Manage your membership and invite others to join your family protection.' : 'Verify your email to create an account.'}'''
                  .hardcoded,
              style: context.theme.textTheme.headlineMedium?.copyWith(
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
                    '''${isLogin ? 'Login with a one time code using your email.' : 'Enter your email for verification.'}'''
                        .hardcoded,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: PiixColors.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  gapH8,
                  SubmitEmailInputVerificationCodeForm(
                    verificationType: verificationType,
                  ),
                  gapH20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: OrSignInSigUpLabel(
                        verificationType: verificationType,
                      )),
                    ],
                  ),
                ],
              ),
            ),
            gapH64,
            Text(
              'Copyright © 2024 Piix'.hardcoded,
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: PiixColors.secondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
