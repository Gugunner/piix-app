import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

class FormGenericErroText extends StatelessWidget {
  const FormGenericErroText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Text(
        text,
        style: context.accentTextTheme?.labelSmall?.copyWith(
          color: PiixColors.errorText,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
