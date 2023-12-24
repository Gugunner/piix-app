import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

///A subclass of an [InputDecoration] which uses only
///specific properties to create its equivalent [CameraInputDecoration].
//TODO: Remove extend from InputDecoration
class CameraInputDecoration extends InputDecoration {
  CameraInputDecoration({
    super.label,
    super.labelText,

    ///This value can replace super.labelStyle if not null
    TextStyle? labelStyle,
    super.helperText,

    ///This value can replace super.helperStyle if not null
    TextStyle? helperStyle,
    super.helperMaxLines,
    super.hintText,

    ///This value can replace super.hintStyle if not null
    TextStyle? hintStyle,
    super.hintMaxLines,
    super.error,
    super.errorText,
    super.errorStyle,
    super.errorMaxLines,
    super.contentPadding,
    super.filled,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    this.disabledColor,
    this.errorColor,
    this.enabledColor,
    this.actionText,
    this.canDelete = false,

    ///This value can replace this.actionStyle if not null
    TextStyle? actionStyle,
    super.enabled,
  })  : actionStyle = actionStyle ??
            MaterialStateTextStyle.resolveWith((states) {
              final textStyle = PrimaryTextTheme().titleSmall.copyWith(
                    inherit: false,
                  );
              final color = _defaultColor(
                states,
                enabledColor: enabledColor,
                focusColor: focusColor,
                errorColor: errorColor,
                disabledColor: disabledColor,
              );
              return textStyle.copyWith(color: color);
            }),
        super(
          labelStyle: labelStyle ??
              MaterialStateTextStyle.resolveWith((states) {
                final textStyle = AccentTextTheme().headlineMedium.copyWith(
                      inherit: false,
                    );
                final color = _defaultColor(
                  states,
                  enabledColor: enabledColor,
                  focusColor: focusColor,
                  errorColor: errorColor,
                  disabledColor: disabledColor,
                );
                return textStyle.copyWith(color: color);
              }),
          hintStyle: hintStyle ??
              MaterialStateTextStyle.resolveWith((states) {
                final textStyle = BaseTextTheme().bodyMedium.copyWith(
                      inherit: false,
                    );
                final color = _defaultColor(
                  states,
                  enabledColor: enabledColor,
                  focusColor: focusColor,
                  errorColor: errorColor,
                  disabledColor: disabledColor,
                );
                return textStyle.copyWith(color: color);
              }),
          helperStyle: helperStyle ??
              MaterialStateTextStyle.resolveWith((states) {
                final textStyle = BaseTextTheme().labelMedium.copyWith(
                      inherit: false,
                    );
                final color = _defaultColor(
                  states,
                  enabledColor: enabledColor,
                  focusColor: focusColor,
                  errorColor: errorColor,
                  disabledColor: disabledColor,
                );
                return textStyle.copyWith(color: color);
              }),
        );

  final bool canDelete;

  final Color? disabledColor;
  final Color? errorColor;
  final Color? enabledColor;
  final String? actionText;
  final TextStyle? actionStyle;

  ///Gets the color to be used for [labelStyle],
  ///[hintStyle], [helperStyle] or [actionStyle],
  ///if the property is not replaced.
  ///
  ///If the respective values of [enabledColor],
  ///[focusColor], [errorColor] or [disabledColor]
  ///are not null this values replace the default colors.
  static Color _defaultColor(
    Set<MaterialState> states, {
    Color? enabledColor,
    Color? focusColor,
    Color? errorColor,
    Color? disabledColor,
  }) {
    var color = enabledColor ?? PiixColors.infoDefault;
    if (states.contains(MaterialState.hovered) ||
        states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed) ||
        states.contains(MaterialState.selected)) {
      color = focusColor ?? PiixColors.active;
    } else if (states.contains(MaterialState.error)) {
      color = errorColor ?? PiixColors.error;
    } else if (states.contains(MaterialState.disabled)) {
      color = disabledColor ?? PiixColors.secondary;
    }
    return color;
  }

  @override
  InputDecoration copyWith({
    Widget? icon,
    Color? iconColor,
    Widget? label,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    String? helperText,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    TextStyle? hintStyle,
    TextDirection? hintTextDirection,
    Duration? hintFadeDuration,
    int? hintMaxLines,
    Widget? error,
    String? errorText,
    TextStyle? errorStyle,
    int? errorMaxLines,
    FloatingLabelBehavior? floatingLabelBehavior,
    FloatingLabelAlignment? floatingLabelAlignment,
    bool? isCollapsed,
    bool? isDense,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    Widget? prefix,
    String? prefixText,
    BoxConstraints? prefixIconConstraints,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    Widget? suffixIcon,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    Color? suffixIconColor,
    BoxConstraints? suffixIconConstraints,
    Widget? counter,
    String? counterText,
    TextStyle? counterStyle,
    bool? filled,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? enabledBorder,
    InputBorder? border,
    bool? enabled,
    String? semanticCounterText,
    bool? alignLabelWithHint,
    BoxConstraints? constraints,
    Color? disabledColor,
    Color? errorColor,
    Color? activeColor,
    Color? enabledColor,
    String? actionText,
    TextStyle? actionStyle,
    bool? canDelete,
  }) {
    return CameraInputDecoration(
      label: label ?? this.label,
      labelText: labelText ?? this.labelText,
      labelStyle: labelStyle ?? this.labelStyle,
      helperText: helperText ?? this.helperText,
      helperStyle: helperStyle ?? this.helperStyle,
      helperMaxLines: helperMaxLines ?? this.helperMaxLines,
      hintText: hintText ?? this.hintText,
      hintStyle: hintStyle ?? this.hintStyle,
      hintMaxLines: hintMaxLines ?? this.hintMaxLines,
      error: error ?? this.error,
      errorText: errorText ?? this.errorText,
      errorStyle: errorStyle ?? this.errorStyle,
      errorMaxLines: errorMaxLines ?? this.errorMaxLines,
      contentPadding: contentPadding ?? this.contentPadding,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      disabledColor: disabledColor ?? this.disabledColor,
      errorColor: errorColor ?? this.errorColor,
      enabledColor: enabledColor ?? this.enabledColor,
      enabled: enabled ?? this.enabled,
      actionText: actionText ?? this.actionText,
      actionStyle: actionStyle ?? this.actionStyle,
      canDelete: canDelete ?? this.canDelete,
    );
  }

  @override
  InputDecoration applyDefaults(InputDecorationTheme theme) {
    return copyWith(
      labelStyle: labelStyle ?? theme.labelStyle,
      helperStyle: helperStyle ?? theme.helperStyle,
      helperMaxLines: helperMaxLines ?? theme.helperMaxLines,
      hintStyle: hintStyle ?? theme.hintStyle,
      hintMaxLines: hintMaxLines ?? 2,
      errorStyle: errorStyle ?? theme.errorStyle,
      errorMaxLines: errorMaxLines ?? theme.errorMaxLines,
      contentPadding: contentPadding ?? theme.contentPadding,
      filled: filled ?? theme.filled,
      fillColor: fillColor ?? theme.fillColor,
      focusColor: focusColor ?? theme.focusColor,
      hoverColor: hoverColor ?? theme.hoverColor,
      disabledColor: disabledColor ?? PiixColors.secondary,
      errorColor: errorColor ?? PiixColors.error,
      enabledColor: enabledColor ?? PiixColors.infoDefault,
      //TODO: Add default actionStyle
      actionStyle: actionStyle ?? actionStyle,
    );
  }

  ///Allows to check other properties and define
  ///which properties are to be checked.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CameraInputDecoration &&
        other.label == label &&
        other.labelText == labelText &&
        other.labelStyle == labelStyle &&
        other.helperText == helperText &&
        other.helperStyle == helperStyle &&
        other.helperMaxLines == helperMaxLines &&
        other.hintText == hintText &&
        other.hintStyle == hintStyle &&
        other.hintMaxLines == hintMaxLines &&
        other.error == error &&
        other.errorText == errorText &&
        other.errorStyle == errorStyle &&
        other.errorMaxLines == errorMaxLines &&
        other.contentPadding == contentPadding &&
        other.filled == filled &&
        other.fillColor == fillColor &&
        other.focusColor == focusColor &&
        other.hoverColor == hoverColor &&
        other.errorColor == errorColor &&
        other.disabledColor == disabledColor &&
        other.enabledColor == enabledColor &&
        other.enabled == enabled &&
        other.actionText == actionText &&
        other.actionStyle == actionStyle &&
        other.canDelete == canDelete;
  }

  ///Used by the [build] method of a[Widget]
  ///to check if the [hashCode] changed and has made
  ///the [Widget] dirty and needs
  ///to be reubuilt.
  @override
  int get hashCode {
    final values = <Object?>[
      label,
      labelText,
      labelStyle,
      helperText,
      helperStyle,
      helperMaxLines,
      hintText,
      hintStyle,
      hintMaxLines,
      error,
      errorText,
      errorStyle,
      errorMaxLines,
      contentPadding,
      filled,
      fillColor,
      focusColor,
      hoverColor,
      errorColor,
      enabledColor,
      disabledColor,
      border,
      enabled,
      actionText,
      actionStyle,
      canDelete,
    ];
    return Object.hashAll(values);
  }
}
