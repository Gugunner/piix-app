import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/widgets/icon_with_tootltip.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a row with title and a tooltip
///
class TitleTooltipListDeprecated extends StatelessWidget {
  const TitleTooltipListDeprecated({
    super.key,
    required this.label,
    required this.message,
  });
  final String message;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: context.primaryTextTheme?.displayMedium,
        ),
        IconWithTooltip(
          message: message,
        ).padLeft(8.w)
      ],
    );
  }
}
