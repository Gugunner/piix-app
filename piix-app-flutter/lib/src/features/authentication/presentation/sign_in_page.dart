import 'package:flutter/material.dart';
import 'package:piix_mobile/src/common_widgets/common_widgets_barrel_file.dart';
import 'package:piix_mobile/src/features/authentication/presentation/web/one_column_sign_in_sign_up_submit.dart';
import 'package:piix_mobile/src/theme/piix_colors.dart';

///Calls for a specific layout for the [SignInPage].
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebMobileTabletLayoutBuilder(
        twoColumn: const OneColumnSignInSignUpSubmit(),
        oneColumn: const OneColumnSignInSignUpSubmit(),
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

