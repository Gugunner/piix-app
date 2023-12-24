// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/app_button.dart';

///An abstract implementation of [AppButton] to create a [FilledButton]
///that calls [createState], use it with an inherited Widget pattern
///and factory constructor.
abstract class AppFilledButton extends AppButton {
  const AppFilledButton({
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
  State<StatefulWidget> createState() => _AppFilledButtonState();
}

final class _AppFilledButtonState extends AppButtonState<AppFilledButton> {
  ///Returns the [FilledButtonThemeData] style of the [ThemeData]
  ///or the passed [style].

  ButtonStyle? get _buttonStyle {
    final style = widget.style ?? context.theme.filledButtonTheme.style;
    return onSelected(
      style,
    );
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
            return FilledButton(
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
            return FilledButton.icon(
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
          return FilledButton.icon(
            onPressed: null,
            icon: SizedBox(
              width: 14.w,
              height: 14.w,
              child: const CircularProgressIndicator(
                color: PiixColors.space,
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
