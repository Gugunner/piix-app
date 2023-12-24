import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A constrained [Text] box for the [AppTooltipContent] description.
final class AppTooltipDescription extends StatelessWidget {
  const AppTooltipDescription(this.text, {super.key});

  final String text;

  ///The maximum width allowed for the [Text].
  @protected
  double get _maxWidth => 212.w;

  ///The text color of the [Text] style.
  @protected
  Color get _color => PiixColors.space;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: _maxWidth),
      child: Text(
        text,
        style: context.labelMedium?.copyWith(
          color: _color,
        ),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        maxLines: 4,
      ),
    );
  }
}
