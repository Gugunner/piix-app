import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

class AlternateTextButton extends StatelessWidget {
  const AlternateTextButton({
    super.key,
    required this.child,
    this.onPressed,
    this.textStyle,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final MaterialStateProperty<TextStyle>? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              textStyle: textStyle ??
                  MaterialStateProperty.resolveWith<TextStyle>(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return context.accentTextTheme?.headlineLarge?.copyWith(
                              color: PiixColors.inactive,
                            ) ??
                            const TextStyle();
                      }
                      return context.accentTextTheme?.headlineLarge?.copyWith(
                            color: PiixColors.active,
                          ) ??
                          const TextStyle();
                    },
                  ),
            ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
