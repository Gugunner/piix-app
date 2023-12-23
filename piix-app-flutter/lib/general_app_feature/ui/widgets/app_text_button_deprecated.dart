import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///Switches text of the button based on the [authMethod]. Executes the switching of auth inputs between
///email and phone number.
@Deprecated('Use instead AppTextSizedButton')
class AppTextButtonDeprecated extends StatelessWidget {
  const AppTextButtonDeprecated({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              visualDensity: VisualDensity.compact,
            ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: color != null
              ? context.primaryTextTheme?.titleMedium?.copyWith(
                  color: color,
                )
              : null,
        ),
      ),
    );
  }
}
