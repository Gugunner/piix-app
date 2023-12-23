import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///A special [TextFormField] that only accepts one digit value.
///
///Each [VerificationCodeBox] has its own [index] to make it easier
///for its parent to know which value is being changed when calling
///[onChanged]. It also uses a parent [validator] to determine whether or
///not an error occurs and to prevent any error text from appearing below
///the [TextFormField] when an error is detected it just shows an empty
///error text [String] value.
final class VerificationCodeBox extends StatefulWidget {
  const VerificationCodeBox({
    super.key,
    required this.index,
    required this.onChanged,
    required this.validator,
  });

  ///Indicates in which position the [VerificationCodeBox]
  ///is at.
  final int index;

  ///Indicates what value changed to the parent by passing the [index]
  ///and the [value].
  final Function(int, String) onChanged;

  ///Uses its parent validator to detect an error.
  final String? Function(String?) validator;

  @override
  State<VerificationCodeBox> createState() => _VerificationCodeBoxState();
}

class _VerificationCodeBoxState extends State<VerificationCodeBox> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  ///When the [TextFormField] has a digit value it will be set as true.
  ///
  ///It is used to fill the color of [TextFormField] internal [BoxDecoration].
  bool _filled = false;

  ///Stores whether or not the box has an error to show
  ///a different color for the [OutlineInputBorder].
  bool _hasError = false;

  ///It controls the flow between each [VerificationCodeBox] by
  ///passing the focus to the other [VerificationCodeBox], or
  ///unfocus current [VerificationCodeBox] when calling [_onTapOutside].
  final _focusNode = FocusNode();

  ///Checks if the value is not empty and set [_filled].
  ///
  ///When [_filled] it checks if the [VerificationCodeBox] has
  ///focus and if so passes it over to the next element.
  void _onChanged(String value) {
    final filled = value.isNotEmpty;
    setState(() {
      _filled = filled;
    });
    //Passes the valu to the parent and indicates which VerificationCodeBox
    //this is.
    widget.onChanged.call(widget.index, value);
    if (autovalidateMode == AutovalidateMode.always)
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    //If there is a value and this has focus it passes the focus to next
    //element.
    if (filled && (_focusNode.hasPrimaryFocus || _focusNode.hasFocus)) {
      if (widget.index == 5) return _focusNode.unfocus();
      FocusManager.instance.primaryFocus?.nextFocus();
    }
  }

  ///Calls the parent [validator] and reads its value if there is an
  ///error it returns an empty string to avoid putting the error text
  ///below the [TextFormField].
  String? _validator(String? value) {
    final errorText = widget.validator.call(value);
    //If there is no error it returns null otherwise returns an empty
    //String to alert of an error without showing the error value.
    Future.microtask(() => setState(() {
          _hasError = errorText.isNotNullEmpty;
        }));
    return null;
  }

  ///Controls the [TextStyle] of the [TextFormField] by
  //checking whether the VerificationCodeBox is filled or not.
  TextStyle? _getTextStyle() {
    var color = PiixColors.infoDefault;
    if (_filled) {
      color = PiixColors.space;
    }
    return context.displaySmall?.copyWith(color: color);
  }

  ///When the app receives an instruction that taps
  ///outside this it will unfocus the [TextFormField].
  void _onTapOutside(PointerDownEvent event) {
    //Only unfocus the TextFormField if it has focus.
    if (_focusNode.hasPrimaryFocus || _focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  ///Sets [autovalidateMode] to always after submitting once the form
  ///with [AppTextFormField].
  void _onSaved(String? value) {
    if (autovalidateMode == AutovalidateMode.disabled ||
        autovalidateMode == AutovalidateMode.onUserInteraction)
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 48.h,
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        focusNode: _focusNode,
        keyboardType: TextInputType.number,
        onChanged: _onChanged,
        onSaved: _onSaved,
        onTapOutside: _onTapOutside,
        validator: _validator,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        style: _getTextStyle(),
        textAlign: TextAlign.center,
        decoration: VerificationCodeBoxDecoration(
          filled: _filled,
          hasError: _hasError,
        ),
        cursorColor: _filled ? PiixColors.space : PiixColors.infoDefault,
      ),
    );
  }
}
