import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/progress_label_deprecated.dart';

@Deprecated('Use instead AppOutlinedSizedButton')

///The base class to build an [OutlinedButton] and defining
///[TextStyle], [minWidth] of the button and [height].
///
///All the values are defined by the [isMain] property.
///It also wraps the button inside a [ShimmerWrap]
///so the button can shimmer if the whole screen is loading
///instead of creating an [skeleton] widget.
class OutlinedAppButtonDeprecated extends OldAppButton {
  const OutlinedAppButtonDeprecated({
    super.key,
    required super.text,
    super.loading,
    super.clicked,
    super.onPressed,
    super.isMain,
    super.icon,
    super.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWrap(
      child: Container(
        constraints: BoxConstraints(
          minWidth: minWidth,
        ),
        height: isMain ? 32.h : 20.h,
        child: _OutlinedAppButtonBuilder(
            text: text,
            onPressed: onPressed,
            loading: loading,
            clicked: clicked,
            isMain: isMain,
            icon: icon,
            buttonStyle: buttonStyle),
      ),
    );
  }
}

///Returns an [OutlinedButton] either a default or icon
///constructor instance of the Widget.
///
///The [icon] property must be not null to retur an icon
///constructor instance.
///It also returns a [_ProgressOutlinedAppButton] if the
///button should wait for information if it is [loading].
@immutable
class _OutlinedAppButtonBuilder extends OutlinedAppButtonDeprecated {
  const _OutlinedAppButtonBuilder({
    required super.text,
    super.loading,
    super.clicked,
    super.isMain,
    super.onPressed,
    super.icon,
    super.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text.toUpperCase(),
    );
    if (loading) {
      return _ProgressOutlinedAppButton(
        isMain: isMain,
      );
    }
    if (icon == null) {
      return OutlinedButton(
        onPressed: loading ? null : onPressed,
        style: style(context),
        child: child,
      );
    }
    return OutlinedButton.icon(
      onPressed: loading ? null : onPressed,
      style: style(context),
      icon: Icon(
        icon,
        size: isMain ? null : 12.sp,
      ),
      label: child,
    );
  }

  @override
  ButtonStyle? style(BuildContext context) {
    if (buttonStyle != null) return buttonStyle;
    return context.theme.outlinedButtonTheme.style?.copyWith(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return PiixColors.inactive;
          }
          if (states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.selected)) {
            return PiixColors.primary;
          }
          return clickedColor;
        },
      ),
      side: MaterialStatePropertyAll(
        BorderSide(
          color: clickedColor,
        ),
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) {
        final style = textStyle(context);
        if (states.contains(MaterialState.disabled)) {
          return style?.copyWith(color: PiixColors.inactive);
        }
        if (states.contains(MaterialState.pressed) ||
            states.contains(MaterialState.selected)) {
          return style?.copyWith(color: PiixColors.primary);
        }
        return style?.copyWith(color: clickedColor);
      }),
    );
  }
}

///Builds a specific [OutlinedButton] that is always
///loading.
///
///Shows a loading text if [isMain] is true.
@immutable
class _ProgressOutlinedAppButton extends ProgressAppButtonLoader {
  const _ProgressOutlinedAppButton({
    super.isMain,
  });

  @override
  ButtonStyleButton build(BuildContext context) {
    return OutlinedButton(
      onPressed: null,
      child: ProgressLabel(
        isMain: isMain,
        progressColor: PiixColors.inactive,
      ),
    );
  }
}
