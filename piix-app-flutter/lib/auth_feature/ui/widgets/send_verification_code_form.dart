import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/auth_ui_screen_barrel_file.dart';
import 'package:piix_mobile/auth_feature/utils/enum/verification_type_enum.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/navigation_feature/navigation_utils_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_card/app_card.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';
import 'package:piix_mobile/widgets/phone_number_input.dart/phone_number_input.dart';

///A specific form that must pass an [onSend] to handle the
///call from the parent screen class.
///
///Set the [verificationType] to change what [Text] is shown in the
///the form for the [title] and [instructions].
///
///Pass an [apiException] if the [validator] of the [PhoneNumberInput]
///will check for them.
final class SendVerificationCodeForm extends StatefulWidget {
  const SendVerificationCodeForm({
    super.key,
    required this.onSend,
    required this.onChanged,
    this.loading = false,
    this.verificationType = VerificationType.signIn,
    this.apiException,
  });

  ///Handles what happens when sending the verification code.
  final Function(String) onSend;

  final VoidCallback onChanged;

  ///Informs if the form send request is being processed.
  final bool loading;

  ///Modify the type depengin on which screen is calling the form.
  final VerificationType verificationType;

  ///Pass the exception if a request returns an error.
  final AppApiException? apiException;

  @override
  State<SendVerificationCodeForm> createState() =>
      _SendVerificationCodeFormState();
}

///The handler of the states that are resolved by the form.
class _SendVerificationCodeFormState extends State<SendVerificationCodeForm> {
  ///The key which identifies the [Form] and is used to
  ///trigger the [onSave] and [validate] when submitting.
  final _formKey = GlobalKey<FormState>();

  late TapGestureRecognizer? _onTapRecognizer;

  ///Stores the value passed by [_onPhoneChanged].
  String _phoneNumber = '';

  ///Stores the value passed by [_onCountryCodeChanged].
  String _countryPhoneCode = '';

  @override
  void initState() {
    super.initState();
    //Initialize the _countryPhoneCode with the first
    //phone code of the applicable country phone codes.
    final countryPhoneCode = CountryCodeLocalizationUtils
        .countryPhoneCodesWithIndicator.first
        .split(' ')[1];
    _countryPhoneCode = countryPhoneCode;
    _onTapRecognizer = TapGestureRecognizer()
      ..onTapDown = _navigateToTermsAndConditionsScreen;
  }

  ///The title for the form based on the [verificationType].
  String get _title {
    final localeMessage = context.localeMessage;
    switch (widget.verificationType) {
      case VerificationType.signIn:
        return localeMessage.signIn;
      case VerificationType.signUp:
        //TODO: Add signup title
        return localeMessage.createAccount;
      case VerificationType.update:
        //TODO: Add update title
        return '';
      case VerificationType.recover:
        //TODO: Add update title
        return '';
    }
  }

  ///The instructions for the form based on the [verificationType].
  String get _instructions {
    final localeMessage = context.localeMessage;
    switch (widget.verificationType) {
      case VerificationType.signIn:
        return localeMessage.signInInstructions;
      case VerificationType.signUp:
        //TODO: Add signup instructions
        return localeMessage.signUpInstructions;
      case VerificationType.update:
        //TODO: Add update title
        return '';
      case VerificationType.recover:
        //TODO: Add update title
        return '';
    }
  }

  Color get _color => PiixColors.infoDefault;

  ///Stores the phone number value inside [PhoneNumberInput].
  void _onPhoneChanged(String value) {
    setState(() {
      _phoneNumber = value;
    });
    widget.onChanged.call();
  }

  ///Stores the country code value inside [PhoneNumberInput].
  void _onCountryCodeChanged(value) {
    if (value is String) {
      _countryPhoneCode = value;
    }
    widget.onChanged.call();
  }

  ///Triggers any [onSave] method of any [FormField]
  ///input inside the [Form] and validates the
  ///values entered in each one.
  ///
  ///Finally it calls [onSend] from the parent class
  ///and passes the compound value of the [_countryPhoneCode]
  ///and the [_phoneNumber] concatenated.
  void _onSubmit() {
    if (_formKey.currentState == null) return;
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) return;
    //Send the value to the parent calling
    widget.onSend.call('${_countryPhoneCode}${_phoneNumber}');
  }

  void _navigateToTermsAndConditionsScreen(TapDownDetails? details) async {
    NavigatorKeyState().fadeInRoute(
      page: const TermsAndConditionsScreen(),
      routeName: TermsAndConditionsScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _title,
            style: context.displaySmall?.copyWith(
              color: _color,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            _instructions,
            style: context.titleMedium?.copyWith(color: _color),
          ),
          SizedBox(height: 20.h),
          AppCard(
            maxHeight: 84.h,
            child: PhoneNumberInput(
              onPhoneChanged: _onPhoneChanged,
              onCountryCodeChanged: _onCountryCodeChanged,
              apiException: widget.apiException,
            ),
          ),
          //TODO: Add terms and conditions
          SizedBox(height: 12.h),
          Text.rich(
            TextSpan(
              text: context.localeMessage.acceptByPhoneNumber,
              style: context.labelMedium?.copyWith(
                color: PiixColors.infoDefault,
              ),
              children: [
                TextSpan(
                  text: context.localeMessage.termsAndConditions,
                  style: context.labelLarge?.copyWith(
                    color: PiixColors.primary,
                  ),
                  recognizer: _onTapRecognizer,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),
          AppFilledSizedButton(
            text: context.localeMessage.sendCode.toUpperCase(),
            onPressed: _phoneNumber.isEmpty ? null : _onSubmit,
            loading: widget.loading,
          ),
        ],
      ),
    );
  }
}
