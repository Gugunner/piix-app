import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Use instead AppTextSizedButton.icon')
class IconTextButtonDeprecated extends StatelessWidget {
  const IconTextButtonDeprecated({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color? color;
  final VoidCallback? onPressed;

  bool get disabled => onPressed == null;

  Color get buttonColor {
    if (color == null) {
      return !disabled ? PiixColors.white : PiixColors.white.withOpacity(0.6);
    }
    return !disabled ? color! : color!.withOpacity(0.6);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IgnorePointer(
        ignoring: disabled,
        child: GestureDetector(
          onTap: onPressed,
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: buttonColor,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                text,
                style: context.accentTextTheme?.headlineLarge
                    ?.copyWith(color: buttonColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
