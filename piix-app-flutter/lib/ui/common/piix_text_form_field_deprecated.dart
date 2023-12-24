import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';

@Deprecated('Will be removed in 4.0')
/// Creates a custom [TextFormField] that refresh the UI when the text changes.
class PiixTextFormFieldDeprecated extends StatefulWidget {
  const PiixTextFormFieldDeprecated({
    Key? key,
    required this.refreshUI,
    required this.labelText,
    this.helperText,
    this.errorText,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.labelFontSize,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.isPasswordField = false,
    this.autovalidateMode,
  }) : super(key: key);

  final String labelText;
  final String? helperText;
  final String? errorText;
  final double? labelFontSize;
  final Widget? suffixIcon;
  final bool isPasswordField;

  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;

  final VoidCallback refreshUI;
  final AutovalidateMode? autovalidateMode;

  @override
  State<PiixTextFormFieldDeprecated> createState() => _PiixTextFormFieldDeprecatedState();
}

class _PiixTextFormFieldDeprecatedState extends State<PiixTextFormFieldDeprecated> {
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(4)),
      child: TextFormField(
        inputFormatters: widget.keyboardType == TextInputType.phone ||
                widget.keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        onChanged: (val) {
          widget.refreshUI();
        },
        autocorrect: false,
        controller: widget.controller,
        enableSuggestions: false,
        autovalidateMode:
            widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        obscureText: widget.isPasswordField && !isShown,
        decoration: decoration(context),
        style: style(context),
      ),
    );
  }
}

extension _PiixTextFormFielddDecoration on _PiixTextFormFieldDeprecatedState {
  TextStyle labelStyle(BuildContext context) =>
      context.textTheme?.bodyMedium?.copyWith(
        color: widget.errorText.isNotNullEmpty ||
                widget.validator != null &&
                    widget.validator!
                        .call(widget.controller?.text)
                        .isNotNullEmpty
            ? PiixColors.error
            : widget.controller != null && widget.controller!.text.isNotEmpty
                ? PiixColors.insurance
                : PiixColors.infoDefault,
      ) ??
      const TextStyle();

  TextStyle floatingLabelStyle(BuildContext context) =>
      context.textTheme?.bodyMedium?.copyWith(
        color: widget.errorText.isNotNullEmpty ||
                widget.validator != null &&
                    widget.validator!
                        .call(widget.controller?.text)
                        .isNotNullEmpty
            ? PiixColors.errorText
            : widget.controller != null && widget.controller!.text.isNotEmpty
                ? PiixColors.insurance
                : PiixColors.brownishGrey,
      ) ??
      const TextStyle();

  TextStyle helperStyle(BuildContext context) =>
      context.textTheme?.labelMedium?.copyWith(
        color: widget.controller != null && widget.controller!.text.isNotEmpty
            ? PiixColors.insurance
            : PiixColors.mainText,
        height: 10.sp / 10.sp,
      ) ??
      const TextStyle();

  TextStyle? style(BuildContext context) =>
      context.textTheme?.bodyMedium?.copyWith(
        color: PiixColors.contrast,
      );

  TextStyle? errorStyle(BuildContext context) =>
      context.textTheme?.labelMedium?.copyWith(
        color: PiixColors.error,
      );

  ///The decoration used by [PiixPhoneNumberTextFormField]
  InputDecoration decoration(BuildContext context) {
    //TODO: Make all colors erro when there is an errorTex
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: widget.controller != null && widget.controller!.text.isNotEmpty
              ? PiixColors.insurance
              : PiixColors.infoDefault,
        ),
      ),
      focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
      errorBorder: InputDecorationUtilsDeprecated.errorBorder,
      focusedErrorBorder: InputDecorationUtilsDeprecated.focusedErrorBorder,
      labelText: widget.labelText,
      suffixIcon: !widget.isPasswordField
          ? (widget.suffixIcon ?? null)
          : IconButton(
              icon: Icon(isShown ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => isShown = !isShown),
            ),
      labelStyle: labelStyle(context),
      floatingLabelStyle: floatingLabelStyle(context),
      helperText: widget.helperText,
      helperStyle: helperStyle(context),
      helperMaxLines: 3,
      errorStyle: errorStyle(context),
      errorText: widget.errorText,
    );
  }
}
