import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/ui/common/piix_tooltip_deprecated.dart';
import 'package:piix_mobile/widgets/app_bar/static_app_bar_deprecated.dart';

@Deprecated('Use instead InfoTooltipAppBar')
class TooltipAppBar extends StaticAppBar {
  const TooltipAppBar({
    super.key,
    super.title,
    required this.message,
  }) : assert(title != null && title.length > 0);

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaticAppBarBuilder(
      title: title,
      actions: [
        IconButton(
          onPressed: () => _launchTooltip(context, message: message),
          icon: const Icon(PiixIcons.info),
        ),
      ],
    );
  }

  void _launchTooltip(BuildContext context, {required String message}) {
    //TODO: Create new Tooltip rules once the UI guidelines are established
    final tooltip = PiixTooltipDeprecated(
      content: _AppBarTooltip(
        message: message,
      ),
    );
    tooltip.controller?.showTooltip();
  }
}

class _AppBarTooltip extends StatelessWidget {
  const _AppBarTooltip({
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 240.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 12.w,
      ),
      child: Text(
        message,
        style: context.bodySmall?.copyWith(
          color: PiixColors.white,
        ),
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
