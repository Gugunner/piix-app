import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A custom input that wraps arount the [VerificationCodeBoxes] and
///custom [Text] that shows the label and helper text or error text.
///
///This passes over the [onChanged] method received and
///captures the [validator] method which is used to get the
///[_errorText] and determine what color and text to show.
final class VerificationCodeInput extends StatefulWidget {
  const VerificationCodeInput({
    super.key,
    required this.onChanged,
    this.validator,
  });

  ///Passes an index and the value to its parent.
  final Function(int, String) onChanged;

  ///Passes the value to its parent to be validated.
  final String? Function(String?)? validator;

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

final class _VerificationCodeInputState extends State<VerificationCodeInput> {
  ///A text used to show when the validator returns a [String] with
  ///an error value.
  String? _errorText;

  ///If [_errorText] is not null or empty it means it
  ///is an eror.
  bool get _hasError => _errorText.isNotNullEmpty;

  ///Returns either the helper text or the error text by
  ///checking [_hasError].
  String get _helperTextOrErrorText {
    if (_hasError) return _errorText!;
    return context.localeMessage.necessaryToFillField;
  }

  ///Returns either the helper color or the error collor
  ///by checking [_hasError].
  Color get _helperColorOrErrorColor {
    if (_hasError) return PiixColors.error;
    return PiixColors.infoDefault;
  }

  ///Calls parent [onChanged] and cleans the
  ///[_errorText] each time it changes.
  void _onChanged(int index, String value) {
    widget.onChanged.call(index, value);
    setState(() {
      _errorText = null;
    });
  }

  ///Calls parent [validator] and stores the value
  ///returned in [_errorText] as well as return it.
  String? _validator(String? value) {
    final errorText = widget.validator?.call(value);
    Future.microtask(() => setState(() {
          _errorText = _errorText ?? errorText;
        }));
    return errorText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localeMessage.verificationCode,
          style: context.bodyMedium?.copyWith(
            color: _helperColorOrErrorColor,
          ),
        ),
        SizedBox(height: 8.h),
        VerificationCodeBoxes(
          onChanged: _onChanged,
          validator: _validator,
        ),
        SizedBox(height: 8.h),
        Text(
          _helperTextOrErrorText,
          style: context.labelMedium?.copyWith(
            color: _helperColorOrErrorColor,
          ),
        ),
      ],
    );
  }
}
