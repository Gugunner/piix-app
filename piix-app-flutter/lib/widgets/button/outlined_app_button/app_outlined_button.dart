import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/app_button.dart';

///An abstract implementation of [AppButton] to create an [OutlinedButton]
///that calls [createState], use it with an inherited Widget pattern
///and factory constructor.
abstract class AppOutlinedButton extends AppButton {
  const AppOutlinedButton({
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
  State<StatefulWidget> createState() => _AppOutlinedButtonState();
}

final class _AppOutlinedButtonState extends AppButtonState<AppOutlinedButton> {
  ///Returns the [OutlinedButtonThemeData] style of the [ThemeData]
  ///or the passed [style].
  ButtonStyle? get _buttonStyle {
    final style = widget.style ?? context.theme.outlinedButtonTheme.style;
    return onSelected(
      style,
      backgroundColor: PiixColors.space,
      foregroundColor: PiixColors.primary,
      sideColor: PiixColors.primary,
    );
  }

  @override
  ButtonStyle? onSelected(
    ButtonStyle? style, {
    Color backgroundColor = PiixColors.primary,
    Color foregroundColor = PiixColors.space,
    Color sideColor = PiixColors.primary,
    Color iconColor = PiixColors.primary,
  }) {
    if (selected)
      return style?.copyWith(
        backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
        foregroundColor: MaterialStatePropertyAll<Color>(foregroundColor),
        side: MaterialStatePropertyAll<BorderSide>(
          BorderSide(color: sideColor),
        ),
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
      ),
      child: SizedBox(
        height: widget.height,
        child: Builder(builder: (context) {
          ///If there is no Icon return normal button
          ///and just disable it if loading
          if (widget.iconData == null) {
            return OutlinedButton(
              onPressed: !loading ? onButtonPressed : null,
              child: Text(
                widget.text,
                maxLines: 1,
              ),
              style: _buttonStyle,
            );
          }
          //If there is an icon it returns the real button
          //with the text and callback
          if (!loading)
            return OutlinedButton.icon(
              onPressed: onButtonPressed,
              icon: Icon(widget.iconData),
              label: Text(
                widget.text,
                maxLines: 1,
              ),
              style: _buttonStyle,
            );
          //Returns a loading button with a progress
          //indicator.
          return OutlinedButton.icon(
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
              maxLines: 1,
            ),
            style: _buttonStyle,
          );
        }),
      ),
    );
  }
}
