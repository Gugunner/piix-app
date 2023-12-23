import 'package:flutter/material.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Remove in 4.0')
class StartupSloganDeprecated extends StatelessWidget {
  const StartupSloganDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        AuthUserCopies.startupSlogan,
        style: context.primaryTextTheme?.displayMedium?.copyWith(
          color: PiixColors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
