import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This is a generic text button for a ticket screen
class TicketTextButtonDeprecated extends StatelessWidget {
  const TicketTextButtonDeprecated({
    super.key,
    required this.label,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.569,
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: context.primaryTextTheme?.titleMedium?.copyWith(
              color: PiixColors.active,
            ),
          )),
    );
  }
}
