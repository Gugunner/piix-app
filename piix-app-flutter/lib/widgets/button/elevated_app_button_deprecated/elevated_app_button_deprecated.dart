import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/progress_label_deprecated.dart';

@Deprecated('Use instead AppFilledSizedButton')

///The base class to build an [ElevatedButton] and defining
///[TextStyle], [minWidth] of the button and [height].
///
///All the values are defined by the [isMain] property.
///It also wraps the button inside a [ShimmerWrap]
///so the button can shimmer if the whole screen is loading
///instead of creating an [skeleton] widget.
class ElevatedAppButtonDeprecated extends OldAppButton {
  const ElevatedAppButtonDeprecated({
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
        child: _ElevatedAppButtonBuilder(
          text: text,
          onPressed: onPressed,
          loading: loading,
          clicked: clicked,
          isMain: isMain,
          icon: icon,
          buttonStyle: buttonStyle,
        ),
      ),
    );
  }
}

///Returns an [ElevatedButton] either a default or icon
///constructor instance of the Widget.
///
///The [icon] property must be not null to retur an icon
///constructor instance.
///It also returns a [_ProgressElevatedAppButton] if the
///button should wait for information if it is [loading].
@immutable
class _ElevatedAppButtonBuilder extends ElevatedAppButtonDeprecated {
  const _ElevatedAppButtonBuilder({
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
      return _ProgressElevatedAppButton(isMain: isMain);
    }
    if (icon == null) {
      return ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: style(context),
        child: child,
      );
    }
    return ElevatedButton.icon(
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
    final style = textStyle(context);

    final newStyle = context.theme.elevatedButtonTheme.style?.copyWith(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return PiixColors.inactive;
          }
          if (states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.selected)) {
            return PiixColors.active;
          }
          return clickedColor;
        },
      ),
      textStyle: MaterialStatePropertyAll<TextStyle?>(
        style?.copyWith(color: PiixColors.space),
      ),
    );
    if (buttonStyle != null) return buttonStyle?.merge(newStyle);
    return newStyle;
  }
}

///Builds a specific [ElevatedButton] that is always
///loading.
///
///Shows a loading text if [isMain] is true.
@immutable
class _ProgressElevatedAppButton extends ProgressAppButtonLoader {
  const _ProgressElevatedAppButton({
    super.isMain,
  });

  @override
  ButtonStyleButton build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      child: ProgressLabel(
        isMain: isMain,
        progressColor: PiixColors.space,
      ),
    );
  }
}
