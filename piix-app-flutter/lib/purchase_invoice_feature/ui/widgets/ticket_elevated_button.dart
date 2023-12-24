import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This is a generic button for a ticket screen
class TicketElevatedButtonDeprecated extends StatelessWidget {
  const TicketElevatedButtonDeprecated({
    super.key,
    required this.label,
    this.onPressed,
    this.widthButton,
  });
  final VoidCallback? onPressed;
  final String label;
  final double? widthButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthButton ?? context.width * 0.579,
      height: 32.w,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: context.accentTextTheme?.labelMedium?.copyWith(
              color: PiixColors.space,
            ),
          )),
    );
  }
}
