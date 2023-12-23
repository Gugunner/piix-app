import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/dashed_border_painter.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/text_theme/base_text_theme.dart';
import 'package:piix_mobile/utils/theme/text_theme/primary_text_theme.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///Creates all the decorations used for a camera input by
///reading the different boolean values that the input can
///be in.
///
///The input requires a [decoration] pass to it to determine
///what type of [Color], [TextStyle] and [Widget] to present
///to inside the input.
///
///If [baseStyle] is not null it will replace any other [TextStyle]
///that is inside the [decoration].
///
///To control the [decoration] of the input when the input has focus
///pass the [isFocused] value, by default is false.
///
///To control the [decoration] of the input when the input
///is being hovered pass the [isHovering], by default is false.
///
///If [child] is passed the value replaces the [Icon] in the middle.
final class DocumentationCameraInputDecorator extends InputDecorator {
  const DocumentationCameraInputDecorator({
    super.key,
    required this.decoration,
    super.baseStyle,
    super.textAlign,
    super.isFocused,
    super.isHovering,
    super.child,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onReplacePhoto,
    this.onDeletePhoto,
  })  :
        super(
          decoration: decoration,
        );

  ///Contains all the decoration [Color] and [TextStyle]s
  ///as well as the basic [enabled], [hover] and [focused] for the input.
  @override
  final CameraInputDecoration decoration;

  ///Executes when the user taps the [_DashedContainer].
  final VoidCallback? onTap;

  ///Executes if the user keeps its finger pressed to the [_DashedContainer].
  final VoidCallback? onLongPress;

  ///Executes whe the user taps twice the [_DashedContainer].
  final VoidCallback? onDoubleTap;

  ///Executes if the [AppTextSizedButton] is visible.
  final VoidCallback? onReplacePhoto;

  ///Executes if the close button is visible.
  final VoidCallback? onDeletePhoto;

  @override
  State<DocumentationCameraInputDecorator> createState() =>
      _CameraInputDecoratorState();
}

final class _CameraInputDecoratorState
    extends State<DocumentationCameraInputDecorator> {
  ///Keeps track of the current decoration set when the [widget.decoration]
  ///changes values.
  CameraInputDecoration? _decoration;

  ///If no [_decoration] is set it first sets the value found in
  ///[widget.decoration] and then returns the value assigned.
  CameraInputDecoration get _effectiveDecoration => _decoration ??=
      widget.decoration.applyDefaults(Theme.of(context).inputDecorationTheme)
          as CameraInputDecoration;

  TextAlign? get textAlign => widget.textAlign;

  bool get isFocused => widget.isFocused;

  bool get isHovering => widget.isHovering;

  bool get isEmpty => widget.isEmpty;

  ///Returns a set of values when the input
  ///is [disabled], [focused], [hovered] or
  ///has an [error].
  Set<MaterialState> get materialState {
    return <MaterialState>{
      if (!_effectiveDecoration.enabled) MaterialState.disabled,
      if (isFocused) MaterialState.focused,
      if (isHovering) MaterialState.hovered,
      if (_effectiveDecoration.errorText != null) MaterialState.error,
    };
  }

  ThemeData get _themeData => Theme.of(context);

  ///Returns a specific color depending
  ///on the [_effectiveDecoration.filled] attribute.
  Color get _fillColor {
    if (_effectiveDecoration.filled != true) {
      return _themeData.hintColor;
    }
    if (_effectiveDecoration.fillColor != null) {
      return MaterialStateProperty.resolveAs(
          _effectiveDecoration.fillColor!, materialState);
    }
    return MaterialStateProperty.resolveAs(
        _themeData.colorScheme.primary, materialState);
  }

  ///Checks that the [_effectiveDecoration.filled]
  ///is not true and that the [_effectiveDecoration.enabled]
  ///is not false before returning a valid [hoverColor].
  Color get _hoverColor {
    if (_effectiveDecoration.filled == null ||
        !_effectiveDecoration.filled! ||
        isFocused ||
        !_effectiveDecoration.enabled) {
      return Colors.transparent;
    }
    return _effectiveDecoration.hoverColor ??
        _themeData.inputDecorationTheme.hoverColor ??
        _themeData.hoverColor;
  }

  ///Returns a [Color] that is used by the input for its
  ///[Path] border and [TextStyle] by first checking for the
  ///corresponding value in the [_effectiveDecoration.x] property and if
  ///it is null then returning the [InputDecorationTheme.x] property
  ///value by default.
  Color get _inputColor {
    //If the [decoration.enabled] is false and
    //the input has no focus then it returns the disabled
    //color and exits.
    if (!_effectiveDecoration.enabled && !isFocused) {
      return _effectiveDecoration.filled ?? false
          ? PiixColors.infoDefault
          : _effectiveDecoration.disabledColor ?? _themeData.hintColor;
    }
    //If the decoration has an error text the it returns
    //the decoration errorColor and exits.
    if (_effectiveDecoration.errorText != null) {
      return _effectiveDecoration.errorColor ?? _themeData.colorScheme.error;
    }
    //If the input is being focused then it returns the
    //decoration focus color and exits.
    if (isFocused) {
      return _effectiveDecoration.focusColor ?? _themeData.colorScheme.primary;
    }

    //If the input is being hovered then it returns the
    //calculated hover color.
    if (isHovering) {
      return _hoverColor;
    }
    //If the input has been filled and is not hovered nor
    //focused and has no error then it returns the calculated
    //fill color.
    if (_effectiveDecoration.filled ?? false) {
      return _fillColor;
    }
    //Returns the default color for the input.
    final enabledColor = _effectiveDecoration.enabledColor ??
        _themeData.colorScheme.onSurface.withOpacity(0.38);
    return enabledColor;
  }

  ///Obtains the default [helperStyle] which can be from the
  ///[InputDecorationTheme] or the [BaseTextTheme] and then
  ///merges into it any [_effectiveDecoration.helperStyle].
  TextStyle get _helperStyle {
    final defaultHelperStyle = _themeData.inputDecorationTheme.helperStyle ??
        context.labelMedium ??
        BaseTextTheme().labelMedium;
    //By default when merging the merged style not null properties
    //take priority.
    return MaterialStateProperty.resolveAs(defaultHelperStyle, materialState)
        .merge(MaterialStateProperty.resolveAs(
            _effectiveDecoration.helperStyle, materialState));
  }

  ///Obtains the default [errorStyle] which can be from the
  ///[InputDecorationTheme] or the [BaseTextTheme] and then
  ///merges into it any [_effectiveDecoration.errorStyle].
  TextStyle get _errorStyle {
    final errorColor =
        _effectiveDecoration.errorColor ?? _themeData.colorScheme.error;
    final defaultErrorStyle = _themeData.inputDecorationTheme.errorStyle ??
        context.labelMedium?.copyWith(
          color: errorColor,
        ) ??
        BaseTextTheme().labelMedium.copyWith(
              color: errorColor,
            );
    //By default when merging the merged style not null properties
    //take priority.
    return MaterialStateProperty.resolveAs(defaultErrorStyle, materialState)
        .merge(MaterialStateProperty.resolveAs(
            _effectiveDecoration.errorStyle, materialState));
  }

  ///Obtains the default [hintStyle] which can be from the
  ///[InputDecorationTheme] or the [BaseTextTheme] and then
  ///merges into it any [_effectiveDecoration.hintStyle].
  TextStyle get _hintStyle {
    final defaultHintStyle = _themeData.inputDecorationTheme.hintStyle ??
        context.bodyMedium ??
        BaseTextTheme().bodyMedium;
    final style = MaterialStateProperty.resolveAs(
            _effectiveDecoration.hintStyle, materialState) ??
        MaterialStateProperty.resolveAs(
            _themeData.inputDecorationTheme.hintStyle, materialState);
    //By default when merging the merged style not null properties
    //take priority.
    return defaultHintStyle.merge(widget.baseStyle).merge(style);
  }

  ///Obtains the default [actionStyle] which can be from the
  ///[InputDecorationTheme] or the [PrimaryTextTheme] and then
  ///merges into it any [_effectiveDecoration.actionStyle].
  TextStyle get _actionStyle {
    //There is no actionStyle in the InputDecorationTheme so hintStyle is used.
    final defaultActionStyle = _themeData.inputDecorationTheme.hintStyle ??
        context.primaryTextTheme?.titleSmall ??
        PrimaryTextTheme().titleMedium;
    final style = MaterialStateProperty.resolveAs(
            _effectiveDecoration.actionStyle, materialState) ??
        MaterialStateProperty.resolveAs(defaultActionStyle, materialState);
    //By default when merging the merged style not null properties
    //take priority.
    return defaultActionStyle.merge(widget.baseStyle).merge(style);
  }

  ///Obtains the default [labelStyle] which can be from the
  ///[InputDecorationTheme] or the [BaseTextTheme] and then
  ///merges into it any [_effectiveDecoration.labelStyle].
  TextStyle get _labelStyle {
    final defaultLabelStyle = _themeData.inputDecorationTheme.labelStyle ??
        context.bodyMedium ??
        BaseTextTheme().bodyMedium;
    final style = MaterialStateProperty.resolveAs(
            _effectiveDecoration.labelStyle, materialState) ??
        MaterialStateProperty.resolveAs(
            _themeData.inputDecorationTheme.labelStyle, materialState);
    //By default when merging the merged style not null properties
    //take priority.
    return defaultLabelStyle.merge(widget.baseStyle).merge(style);
  }

  @override
  void didUpdateWidget(DocumentationCameraInputDecorator oldWidget) {
    super.didUpdateWidget(oldWidget);
    //Resets the _effectiveDecoration when the new
    //values passed from the widget decoration are different
    //from the oldWidget decoration.
    if (widget.decoration != oldWidget.decoration) {
      _decoration = null;
    }
  }

  //TODO: Add Replace picture
  //TODO: Add Delete Picture X button
  @override
  Widget build(BuildContext context) {
    //Creates a painted dashed round border with a
    //predefined size.
    final dashedContainer = _DashedContainer(
      decoration: _effectiveDecoration,
      canDelete: _effectiveDecoration.canDelete,
      inputColor: _inputColor,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onDoubleTap: widget.onDoubleTap,
      onDeletePhoto: widget.onDeletePhoto,
      actionStyle: _actionStyle,
      child: widget.child,
    );
    final cardContainer = _CardContainer(
      child: dashedContainer,
      decoration: _effectiveDecoration,
      enabled: _effectiveDecoration.enabled,
      hasPicture: widget.child != null,
      onReplacePhoto: widget.onReplacePhoto,
      hintStyle: _hintStyle,
    );
    return IgnorePointer(
      ignoring: !_effectiveDecoration.enabled,
      child: SizedBox(
        width: context.width,
        child: Column(
          children: [
            SizedBox(
              width: context.width,
              child: _effectiveDecoration.label ??
                  Text(
                    _effectiveDecoration.labelText ?? '',
                    style: _labelStyle,
                  ),
            ),
            SizedBox(height: 12.h),
            cardContainer,
            SizedBox(height: 8.h),
            _HelperText(
              decoration: _effectiveDecoration,
              errorStyle: _errorStyle,
              helperStyle: _helperStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedContainer extends StatelessWidget {
  const _DashedContainer({
    required this.decoration,
    this.canDelete = false,
    this.inputColor,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onDeletePhoto,
    this.child,
    this.actionStyle,
  });

  ///The decoration passed to the [DocumentationCameraInputDecorator].
  final CameraInputDecoration decoration;

  ///Hides or shows the close button
  final bool canDelete;

  ///The color of the border.
  final Color? inputColor;

  ///Executes when tapping this.
  final VoidCallback? onTap;

  ///Executes when keeping this pressed.
  final VoidCallback? onLongPress;

  ///Executes when tapping twice this.
  final VoidCallback? onDoubleTap;

  ///Executes when pressing the close button
  ///if visible.
  final VoidCallback? onDeletePhoto;

  ///The children element of this.
  final Widget? child;

  ///A specific [TextStyle] for the [decoration.actionText].
  final TextStyle? actionStyle;

  @override
  Widget build(BuildContext context) {
    final splashColor =
        child == null ? decoration.focusColor : Colors.transparent;
    return Stack(
      children: [
        Container(
          width: 131.w,
          height: 108.h,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
          child: Material(
            child: InkWell(
              focusColor: decoration.focusColor,
              hoverColor: decoration.hoverColor,
              splashColor: splashColor,
              onTap: onTap,
              onLongPress: onLongPress,
              onDoubleTap: onDoubleTap,
              child: CustomPaint(
                size: Size(123.w, 100.h),
                painter: RoundOutlinedDashedBorderPainter(
                  color: inputColor,
                  strokeWidth: 1.w,
                  dashLength: 8.w,
                  gap: 4.w,
                ),
                child: SizedBox(
                  width: 123.w,
                  height: 100.h,
                  child: Builder(
                    builder: (context) {
                      if (child != null) {
                        return Container(
                          width: 123.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 2.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.w),
                            child: child!,
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: inputColor,
                            size: 38.w,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            decoration.actionText ?? '',
                            style: actionStyle,
                            maxLines: 1,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 100),
            scale: canDelete && child != null ? 1 : 0,
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: PiixColors.error,
              ),
              child: IconButton(
                iconSize: 18.w,
                padding: EdgeInsets.zero,
                onPressed: onDeletePhoto,
                icon: const Icon(
                  Icons.close,
                  color: PiixColors.space,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

final class _CardContainer extends StatelessWidget {
  const _CardContainer({
    required this.child,
    required this.decoration,
    this.hasPicture = false,
    this.enabled = false,
    this.onReplacePhoto,
    this.hintStyle,
  });

  final Widget child;

  final CameraInputDecoration decoration;

  final bool hasPicture;

  final bool enabled;

  final VoidCallback? onReplacePhoto;

  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: decoration.contentPadding ??
          EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: PiixColors.space,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: PiixColors.contrast30.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: context.width,
            child: Text(
              decoration.hintText ?? '',
              style: hintStyle,
              maxLines: decoration.hintMaxLines,
            ),
          ),
          SizedBox(height: 12.h),
          child,
          if (hasPicture) ...[
            SizedBox(height: 12.h),
            AppTextSizedButton.title(
              onPressed: enabled ? onReplacePhoto : null,
              text: context.localeMessage.replacePhoto,
            ),
          ],
        ],
      ),
    );
  }
}

class _HelperText extends StatelessWidget {
  const _HelperText({
    required this.decoration,
    this.errorStyle,
    this.helperStyle,
  });

  final CameraInputDecoration decoration;

  final TextStyle? errorStyle;

  final TextStyle? helperStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Builder(builder: (context) {
        if (decoration.error != null) return decoration.error!;
        if (decoration.errorText != null) {
          return decoration.error ??
              Text(
                decoration.errorText ?? '',
                style: errorStyle,
                maxLines: decoration.errorMaxLines,
              );
        }
        return Text(
          decoration.helperText ?? '',
          style: helperStyle,
          maxLines: decoration.helperMaxLines,
        );
      }),
    );
  }
}
