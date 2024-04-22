import 'package:flutter/material.dart';
import 'package:piix_mobile/src/common_widgets/common_widgets_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/one_column_sign_in_sign_up_submit.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';
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
