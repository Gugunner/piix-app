import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_wrap.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/widgets/button/app_button_deprecated.dart';
import 'package:piix_mobile/widgets/button/progress_label_deprecated.dart';

@Deprecated('Use instead AppTextSizedButton')

///The base class to build a [TextButton] and defining
///[TextStyle], [minWidth] of the button and [height].
///
///All the values are defined by the [isMain] property.
///You can override the font Size for a main button by passing either
///'one' which is TextStyle titleSmall or [type] 'two' as
///headlineLarge, by default it passes 'one'.
///It also wraps the button inside a [ShimmerWrap]
///so the button can shimmer if the whole screen is loading
///instead of creating an [skeleton] widget.
class TextAppButtonDeprecated extends OldAppButton {
  const TextAppButtonDeprecated({
    super.key,
    required super.text,
    this.type = 'one',
    super.loading,
    super.clicked,
    super.onPressed,
    super.isMain,
    super.icon,
    super.buttonStyle,
    this.iconSize,
  });

  ///Controls if the botton should handle type 'one' which'
  ///is TextStyle titleSmall or type 'two' as headlineLarge.
  ///Will not work if [buttonStyle] is declared.
  final String type;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return ShimmerWrap(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          minWidth: minWidth,
        ),
        height: isMain ? 32.h : 24.h,
        child: _TextAppButtonBuilder(
          text: text,
          type: type,
          onPressed: onPressed,
          loading: loading,
          clicked: clicked,
          isMain: isMain,
          icon: icon,
          iconSize: iconSize,
          buttonStyle: buttonStyle,
        ),
      ),
    );
  }
}

///Returns a [TextButton] either a default or icon
///constructor instance of the Widget.
///
///The [icon] property must be not null to retur an icon
///constructor instance.
///It also returns a [_ProgressTextAppButton] if the
///button should wait for information if it is [loading].
@immutable
class _TextAppButtonBuilder extends TextAppButtonDeprecated {
  const _TextAppButtonBuilder({
    required super.text,
    super.type,
    super.loading,
    super.clicked,
    super.isMain,
    super.onPressed,
    super.icon,
    super.buttonStyle,
    this.iconSize,
  });

  @override
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text,
      maxLines: 1,
    );
    if (loading) {
      return _ProgressTextAppButton(
        isMain: isMain,
      );
    }
    if (icon == null) {
      return TextButton(
        onPressed: loading ? null : onPressed,
        style: style(context),
        child: child,
      );
    }
    return TextButton.icon(
      onPressed: loading ? null : onPressed,
      style: style(context),
      icon: Icon(
        icon,
        size: iconSize ?? 14.sp,
      ),
      label: child,
    );
  }

  @override
  TextStyle? textStyle(BuildContext context) {
    if (type == 'two') return context.accentTextTheme?.headlineLarge;
    if (!isMain) return context.primaryTextTheme?.titleMedium;
    return context.accentTextTheme?.titleSmall;
  }

  @override
  ButtonStyle? style(BuildContext context) {
    final style = textStyle(context);
    final newStyle = context.theme.textButtonTheme.style?.copyWith(
      backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
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
      textStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return style?.copyWith(color: PiixColors.inactive);
        }
        return style?.copyWith(color: clickedColor);
      }),
      side: const MaterialStatePropertyAll<BorderSide>(BorderSide.none),
    );
    if (buttonStyle != null) return buttonStyle?.merge(newStyle);
    return newStyle;
  }
}

///Builds a specific [TextButton] that is always
///loading.
///
///Shows a loading text if [isMain] is true.
@immutable
class _ProgressTextAppButton extends ProgressAppButtonLoader {
  const _ProgressTextAppButton({
    super.isMain,
  });

  @override
  ButtonStyleButton build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: ProgressLabel(
        isMain: isMain,
        progressColor: PiixColors.inactive,
      ),
    );
  }
}
