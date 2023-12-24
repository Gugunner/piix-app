import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

class AuthGenericErrorWidget extends StatelessWidget {
  const AuthGenericErrorWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        text,
        style: context.textTheme?.labelMedium?.copyWith(
          color: PiixColors.error,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
