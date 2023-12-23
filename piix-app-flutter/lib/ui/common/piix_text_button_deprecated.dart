import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

/// Creates a custom text button
///
/// [text] is the text to be displayed
/// [onPressed] is the function to be called when the button is pressed
class PiixTextButtonDeprecated extends StatelessWidget {
  const PiixTextButtonDeprecated(
      {Key? key, required this.text, required this.onPressed, this.padding})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
      ),
      child: Text(
        text,
        style: context.accentTextTheme?.headlineLarge?.copyWith(
          color: PiixColors.active,
        ),
      ),
    );
  }
}
