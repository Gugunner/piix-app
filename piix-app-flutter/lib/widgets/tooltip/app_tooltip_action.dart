import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/color_utils.dart';
import 'package:piix_mobile/widgets/button/text_app_button/text_app_button_deprecated.dart';

///A constrained [TeTextAppButtonxt] box for the [AppTooltipContent] action
///callback.
final class AppTooltipAction extends StatelessWidget {
  const AppTooltipAction(
    this.action, {
    super.key,
    required this.text,
  });

  final String text;

  final VoidCallback action;

  ///The maximum width allowed for the [TextAppButtonDeprecated].
  @protected
  double get _maxWidth => 212.w;

  ///The text color of the [TextAppButtonDeprecated] textStyle.
  @protected
  Color get _color => PiixColors.space;

  ///The color of the [TextAppButtonDeprecated] when pressed
  @protected
  Color get _overlayColor => ColorUtils.darken(_color, 0.5);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: _maxWidth),
      child: TextAppButtonDeprecated(
        text: text.toUpperCase(),
        onPressed: action,
        type: 'two',
        buttonStyle: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(
            _color,
          ),
          overlayColor: MaterialStatePropertyAll(
            _overlayColor,
          ),
          backgroundColor: const MaterialStatePropertyAll(
            PiixColors.infoDefault,
          ),
        ),
        isMain: false,
      ),
    );
  }
}
