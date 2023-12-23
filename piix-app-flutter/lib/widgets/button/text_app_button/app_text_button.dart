import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///An abstract implementation of [AppButton] to create a [TextButton]
///that calls [createState], use it with an inherited Widget pattern
///and factory constructor.
abstract class AppTextButton extends AppButton {
  const AppTextButton({
    super.key,
    required super.text,
    required super.onPressed,
    super.keepSelected,
    super.loading,
    super.iconData,
    super.height,
    super.maxWidth,
    super.minWidth,
    super.style,
  });

  @override
  State<StatefulWidget> createState() => _AppTextButtonState();
}

final class _AppTextButtonState extends AppButtonState<AppTextButton> {
  ///Returns the [TextButtonThemeData] style of the [ThemeData]
  ///or the passed [style].
  ButtonStyle? get _buttonStyle {
    final style = widget.style ?? context.theme.textButtonTheme.style;
    return onSelected(
      style,
      backgroundColor: PiixColors.space,
      foregroundColor: PiixColors.primary,
    );
  }

  @override
  ButtonStyle? onSelected(
    ButtonStyle? style, {
    Color backgroundColor = PiixColors.space,
    Color foregroundColor = PiixColors.space,
    Color iconColor = PiixColors.primary,
  }) {
    if (selected)
      return style?.copyWith(
        foregroundColor: MaterialStatePropertyAll<Color>(foregroundColor),
        iconColor: MaterialStatePropertyAll<Color>(iconColor),
        //Prevents any [Ink] splashing of button
        splashFactory: NoSplash.splashFactory,
      );
    if (widget.keepSelected)
      //Prevents any [Ink] splashing of button
      return style?.copyWith(splashFactory: NoSplash.splashFactory);
    return style;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth ?? double.infinity,
        minWidth: widget.minWidth ?? 0,
        maxHeight: widget.height ?? double.infinity,
      ),
      child: SizedBox(
        child: Builder(builder: (context) {
          ///If there is no Icon return normal button
          ///and just disable it if loading
          if (widget.iconData == null) {
            return TextButton(
              onPressed: !loading ? onButtonPressed : null,
              child: Text(
                widget.text,
                maxLines: 2,
              ),
              style: _buttonStyle,
            );
          }
          //If there is an icon it returns the real button
          //with the text and callback
          if (!loading)
            return TextButton.icon(
              onPressed: onButtonPressed,
              icon: Icon(widget.iconData),
              label: Text(
                widget.text,
                maxLines: 2,
              ),
              style: _buttonStyle,
            );
          //Returns a loading button with a progress
          //indicator.
          return TextButton.icon(
            onPressed: null,
            icon: SizedBox(
              width: 14.w,
              height: 14.w,
              child: const CircularProgressIndicator(
                color: PiixColors.inactive,
                strokeWidth: 2.0,
              ),
            ),
            label: Text(
              widget.text,
              maxLines: 2,
            ),
            style: _buttonStyle,
          );
        }),
      ),
    );
  }
}
