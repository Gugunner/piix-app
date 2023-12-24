import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A Material Design "panel button"
class AppPanelButton extends ButtonStyleButton {
  //Create an AppPanelButton
  AppPanelButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.statesController,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    required this.title,
    required this.description,
  }) : super(
          child:
              _AppPanelButtonWithColumn(title: title, description: description),
        );

  final Widget title;

  final Widget description;

  ///A static method that is used by both [defaultStyleOf] and
  ///[themeStyleOf] since there is no Material [Theme] for the
  ///[AppPanelButton].
  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    final background = backgroundColor;
    final disabledBackground = disabledBackgroundColor;
    final MaterialStateProperty<Color?>? backgroundColorProp =
        (background == null && disabledBackground == null)
            ? null
            : _AppPanelButtonDefaultColor(background, disabledBackground);
    final foreground = foregroundColor;
    final disabledForeground = disabledForegroundColor;
    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foreground == null && disabledForeground == null)
            ? null
            : _AppPanelButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? overlayColor =
        (foreground == null) ? null : _AppPanelButtonDefaultOverlay(foreground);
    final MaterialStateProperty<double?>? elevationValue =
        (elevation == null) ? null : _AppPanelButtonDefaultElevation(elevation);
    final MaterialStateProperty<MouseCursor?>? mouseCursor =
        (enabledMouseCursor == null && disabledMouseCursor == null)
            ? null
            : _AppPanelButtonDefaultMouseCursor(
                enabledMouseCursor, disabledMouseCursor);
    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle?>(textStyle),
      backgroundColor: backgroundColorProp,
      foregroundColor: foregroundColorProp,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      elevation: elevationValue,
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }

  ///Returns a scalable padding based on the text scale factor.
  EdgeInsetsGeometry _scaledPadding(BuildContext context) {
    final padding1x = 12.w;
    final padding1y = 12.h;
    return ButtonStyleButton.scaledPadding(
      EdgeInsets.symmetric(horizontal: padding1x, vertical: padding1y),
      EdgeInsets.symmetric(
          horizontal: padding1x / 2, vertical: padding1y / 2),
      EdgeInsets.symmetric(
          horizontal: (padding1x / 2) / 2, vertical: (padding1y / 2) / 2),
      MediaQuery.textScaleFactorOf(context),
    );
  }

  ///The default style that is read if no [style] is passed.
  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    const backgroundColor = PiixColors.sky;
    return styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: PiixColors.infoDefault,
      disabledBackgroundColor: ColorUtils.darken(backgroundColor, 0.02),
      disabledForegroundColor: PiixColors.secondaryLight,
      shadowColor: PiixColors.shadowButton,
      elevation: 1,
      textStyle: PrimaryTextTheme().textTheme.titleSmall,
      padding: _scaledPadding(context),
      minimumSize: Size(288.w, 80.h),
      maximumSize: Size(288.w, double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.basic,
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    );
  }

  ///Returns the [defaultStyleOf] since there is no
  ///Material [Theme] for [AppTabButton].
  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return defaultStyleOf(context);
  }
}

///A simple class that handles returning the [color] or [disabledColor] based
///on the [MaterialState].
final class _AppPanelButtonDefaultColor extends MaterialStateProperty<Color?> {
  _AppPanelButtonDefaultColor(this.color, this.disabledColor);

  final Color? color;

  final Color? disabledColor;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) return disabledColor;
    return color;
  }
}

///A simple class that handles returning the [overlayColor] based
///on the [MaterialState].
final class _AppPanelButtonDefaultOverlay
    extends MaterialStateProperty<Color?> {
  _AppPanelButtonDefaultOverlay(this.overlayColor);

  final Color overlayColor;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered))
      return overlayColor.withOpacity(0.08);
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed))
      return overlayColor.withOpacity(0.24);
    return null;
  }
}

///A simple class that handles returning the [elevation] based
///on the [MaterialState].
final class _AppPanelButtonDefaultElevation
    extends MaterialStateProperty<double?> {
  _AppPanelButtonDefaultElevation(this.elevation);

  final double elevation;

  @override
  double resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) return 0;
    if (states.contains(MaterialState.hovered) ||
        states.contains(MaterialState.focused)) return elevation + 2;
    if (states.contains(MaterialState.pressed)) return elevation + 6;
    return elevation;
  }
}

///A simple class that handles returning the [enabledCursor] or [disabledCursor]
/// based on the [MaterialState].
final class _AppPanelButtonDefaultMouseCursor
    extends MaterialStateProperty<MouseCursor?> {
  _AppPanelButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor? enabledCursor;
  final MouseCursor? disabledCursor;

  @override
  MouseCursor? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }
}

///The child class which builds the content of the [AppPanelButton].
final class _AppPanelButtonWithColumn extends StatelessWidget {
  const _AppPanelButtonWithColumn({
    required this.title,
    required this.description,
  });

  final Widget title;

  final Widget description;

  double get _space => 8.h;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        SizedBox(height: _space),
        description,
      ],
    );
  }
}
