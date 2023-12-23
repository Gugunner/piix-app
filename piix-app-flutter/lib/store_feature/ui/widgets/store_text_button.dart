import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This is a text button template for the piix app store.
///
class StoreTextButtonDeprecated extends StatelessWidget {
  const StoreTextButtonDeprecated({
    super.key,
    required this.label,
    this.style,
    this.onTap,
  });
  final String label;
  final VoidCallback? onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: style ??
            context.textTheme?.labelLarge?.copyWith(
              color: PiixColors.active,
            ),
      ),
    );
  }
}
