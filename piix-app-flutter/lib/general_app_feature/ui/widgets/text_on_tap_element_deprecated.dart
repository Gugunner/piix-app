import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a text with on tap gesture for make any action
///
class TextOnTapElementDeprecated extends StatelessWidget {
  const TextOnTapElementDeprecated({
    super.key,
    required this.text,
    this.activeStyle,
    this.inactiveStyle,
    this.onTap,
  });
  final String text;
  final VoidCallback? onTap;
  final TextStyle? activeStyle;
  final TextStyle? inactiveStyle;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = context.labelSmall?.copyWith(
      color: PiixColors.mainText,
    );
    final textStyle = onTap != null
        ? activeStyle ?? defaultStyle
        : inactiveStyle ?? defaultStyle;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }
}
