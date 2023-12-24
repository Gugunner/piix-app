import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A width constrained button that executes a callback function
///passed as a property to the class.
class BannerAction extends StatelessWidget {
  const BannerAction(this.onPressed, {super.key, this.text});

  ///The callback to execute when the [TextButton]
  ///is pressed.
  final VoidCallback onPressed;

  ///The text inside the [TextButton] by default is 'Accept'.
  final String? text;

  ///The color used by the [text] inside the button.
  @protected
  Color get _color => PiixColors.space;

  ///The maximum width that the [TextButton] can occupy.
  @protected
  double get _maxWidth => 296.w;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: _maxWidth,
      ),
      child: AppTextSizedButton(
        onPressed: onPressed,
        text: text ?? context.localeMessage.accept,
        style: context.theme.textButtonTheme.style?.copyWith(
            foregroundColor: MaterialStateColor.resolveWith(
          (states) => _color,
        )),
      ),
    );
  }
}
