import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_barrel_file.dart';
import 'package:piix_mobile/auth_feature/auth_utils_barrel_file.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

///A specific form that must pass an [onSend] to handle the call
///from the parent screen class.
///
///Set the [verificationType] to change what [Text] is shown in the
///the form for the [title].
///
///Pass the [validator] to the [VerificationCodeInput].
class VerifyVerificationCodeForm extends StatefulWidget {
  const VerifyVerificationCodeForm({
    super.key,
    required this.phoneNumber,
    required this.onSend,
    required this.onCodeChanged,
    this.loading = false,
    this.verificationType = VerificationType.signIn,
    this.validator,
  });

  final String phoneNumber;

  final Function(String) onSend;

  final VoidCallback onCodeChanged;

  ///Informs if the form send request is being processed.
  final bool loading;

  final VerificationType verificationType;

  final String? Function(String?)? validator;

  @override
  State<VerifyVerificationCodeForm> createState() =>
      _VerifyVerificationCodeFormState();
}

class _VerifyVerificationCodeFormState
    extends State<VerifyVerificationCodeForm> {
  ///The key which controls all the [FormField] inside
  ///this [Form].
  final _formKey = GlobalKey<FormState>();

  ///Stores the verification code.
  List<int> _code = [];

  //The correct length of a verification code.
  int get _requiredLength => 6;

  bool get _disableSubmit =>
      _code.isEmpty || _code.length < _requiredLength || _code.contains(-1);

  String get _title {
    if (widget.verificationType == VerificationType.update)
      return context.localeMessage.verifyYourNewPhone;
    return context.localeMessage.verifyYourPhone;
  }

  ///Triggers any [onSave] method of any [FormField]
  ///input inside the [Form] and validates the
  ///values entered in each one.
  ///
  ///Finally it calls [onSend] from the parent class
  ///and passes the converted value of [_code] into
  ///a [String].
  void _onSubmit() {
    //Check if the form can be processed if not
    //it will not send the form.
    if (_formKey.currentState == null) return;
    //Call any [FormField] onSaved method before
    //continuing
    _formKey.currentState!.save();
    //If any [FormField] hasError property is true
    //it will not send the form.
    if (!_formKey.currentState!.validate()) return;
    //Send the value to the parent calling
    final stringCode = _code.map((e) => '$e').toList().join();
    widget.onSend.call(stringCode);
  }

  ///Adds a new value to the code.
  ///
  ///If the value is not in sequential order of position
  ///it adds -1 to the other positions to avoid an out
  ///of bound error.
  void _onAddValueToCode(int index, int value) {
    var code = _code;
    for (var i = 0; i < index; i++) {
      final e = _code.guardElementAt<int?>(i);
      //Adds a -1 if the value is not in sequential
      //order position.
      if (e == null) {
        code = [...code, -1];
      }
    }
    //Finally it adds the correct value and
    //stores it.
    code.add(value);
    setState(() {
      _code = code;
    });
  }

  ///When the value is just being updated a new [List]
  ///is returned with the updated value in the correct position.
  void _onUpdateValueInCode(int index, int value) {
    setState(() {
      _code = _code.updateIndexValue<int>(index, value: value);
    });
  }

  ///When the code changes it either adds the new value to the
  ///[_code] as a new element for the [List] or as an updated
  ///element.
  void _onCodeChanged(int index, String value) {
    final intValue = value.isEmpty ? -1 : int.parse(value);
    final element = _code.guardElementAt<int?>(index);
    if (element == null) return _onAddValueToCode(index, intValue);
    widget.onCodeChanged.call();
    return _onUpdateValueInCode(index, intValue);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            _title,
            style: context.displaySmall?.copyWith(
              color: PiixColors.infoDefault,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Text.rich(
            TextSpan(
              text: '${context.localeMessage.enterTheSentCode} ',
              children: [
                TextSpan(
                  text: widget.phoneNumber,
                  style: context.headlineSmall?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                ),
              ],
              style: context.titleMedium?.copyWith(
                color: PiixColors.infoDefault,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          VerificationCodeInput(
            onChanged: _onCodeChanged,
            validator: widget.validator,
          ),
          SizedBox(height: 16.h),
          Text(
            context.localeMessage.didYouNotReceiveTheCode,
            style: context.bodyMedium?.copyWith(
              color: PiixColors.infoDefault,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          VerificationCodeTimerRetry(
            phoneNumber: widget.phoneNumber,
          ),
          SizedBox(height: 40.h),
          AppFilledSizedButton(
            text: context.localeMessage.verifyNumber.toUpperCase(),
            onPressed: _disableSubmit ? null : _onSubmit,
            loading: widget.loading,
          ),
        ],
      ),
    );
  }
}
