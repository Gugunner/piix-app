import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A Material Design "tab button"
class AppTabButton extends ButtonStyleButton {
  //Create a custom AppTabButton
  const AppTabButton({
    super.key,
    required super.onPressed,
    required super.child,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.statesController,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
  });

  ///Create a tab button with an [icon] and a [label], optionally
  ///pass an [arrow] which appears at the end of the button.
  factory AppTabButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    MaterialStatesController? statesController,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
    Widget? arrow,
  }) = _AppTabButtonWithIcon;

  ///A static method that is used by both [defaultStyleOf] and
  ///[themeStyleOf] since there is no Material [Theme] for the
  ///[AppTabButton].
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
            : _AppTabButtonDefaultColor(background, disabledBackground);
    final foreground = foregroundColor;
    final disabledForeground = disabledForegroundColor;
    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foreground == null && disabledForeground == null)
            ? null
            : _AppTabButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? overlayColor =
        (foreground == null) ? null : _AppTabButtonDefaultOverlay(foreground);
    final MaterialStateProperty<double?>? elevationValue =
        (elevation == null) ? null : _AppTabButtonDefaultElevation(elevation);
    final MaterialStateProperty<MouseCursor?>? mouseCursor =
        (enabledMouseCursor == null && disabledMouseCursor == null)
            ? null
            : _AppTabButtonDefaultMouseCursor(
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
    final padding1x = 16.w;
    return ButtonStyleButton.scaledPadding(
      EdgeInsets.symmetric(horizontal: padding1x, vertical: padding1x / 2),
      EdgeInsets.symmetric(
          horizontal: padding1x / 2, vertical: (padding1x / 2) / 2),
      EdgeInsets.symmetric(
          horizontal: (padding1x / 2) / 2, vertical: ((padding1x / 2) / 2) / 2),
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
      minimumSize: Size(64.w, 32.h),
      maximumSize: Size.infinite,
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
final class _AppTabButtonDefaultColor extends MaterialStateProperty<Color?> {
  _AppTabButtonDefaultColor(this.color, this.disabledColor);

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
final class _AppTabButtonDefaultOverlay extends MaterialStateProperty<Color?> {
  _AppTabButtonDefaultOverlay(this.overlayColor);

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
final class _AppTabButtonDefaultElevation
    extends MaterialStateProperty<double?> {
  _AppTabButtonDefaultElevation(this.elevation);

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
final class _AppTabButtonDefaultMouseCursor
    extends MaterialStateProperty<MouseCursor?> {
  _AppTabButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

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

///A predefined class that builds the [child] of the [AppTabButton]
///with an [_AppTabButtonWithIconChild].
final class _AppTabButtonWithIcon extends AppTabButton {
  _AppTabButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
    Widget? arrow,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _AppTabButtonWithIconChild(
            label: label,
            icon: icon,
            arrow: arrow,
          ),
        );
}

///The child class which builds the content of the [AppTabButton]
///icon constructor.
final class _AppTabButtonWithIconChild extends StatelessWidget {
  const _AppTabButtonWithIconChild({
    required this.label,
    required this.icon,
    this.arrow,
  });

  final Widget label;

  final Widget icon;

  final Widget? arrow;

  double get _space => 2.w;

  double get _size => 16.w;

  Color get _color => PiixColors.active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        icon,
        SizedBox(width: _space),
        label,
        Flexible(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            arrow ??
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: _color,
                  size: _size,
                ),
          ],
        )),
      ],
    );
  }
}
