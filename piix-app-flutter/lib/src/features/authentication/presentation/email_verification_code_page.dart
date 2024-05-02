import 'package:flutter/material.dart';
import 'package:piix_mobile/src/common_widgets/common_widgets_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/one_column_email_verification_code_page.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';
import 'package:piix_mobile/src/utils/verification_type.dart';


///Calls for a specific layout for the [EmailVerificationCodePage].
class EmailVerificationCodePage extends StatelessWidget {
  const EmailVerificationCodePage({
    super.key,
    required this.email,
    this.verificationType = VerificationType.login,
  });

  ///Controls whether the verification is for a login
  ///or to create a new account.
  final VerificationType verificationType;

  ///The email where the verification code will be sent.
  final String email;


  @override
  Widget build(BuildContext context) {
    return WebMobileTabletLayoutBuilder(
      twoColumn: OneColumnEmailVerificationCodePage(
        email: email,
        verificationType: verificationType,
      ),
      oneColumn: OneColumnEmailVerificationCodePage(
        email: email,
        verificationType: verificationType,
      ),
      tablet: Container(
        color: PiixColors.highlight,
      ),
      mobile: Container(
        color: PiixColors.assist,
      ),
    );
  }
}
