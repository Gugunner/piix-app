import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/dropdown_field/implemented_dropdown_field/country_code_form_field.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/implemented_text_form_field/phone_form_field.dart';

///Manages a phone input that includes two [FormField]s.
///
///The first [FormField] is the [CountryCodeFormField]
///and requires to pass over an [onCountryCodeChanged] to communicate
///between this class parent and the [FormField]. The method is triggered
///each time the value is changed in the selection.
///
///The second [FormField] is the [PhoneFormField] and requires
///to pass over an [onPhoneChanged] to communciate between this class parent
///and the [FormField]. The method is triggered each time the value is changed
///by editing.
///
///Additionaly each [FormField] can also pass an [onCountryCodeSaved] and an
///[onPhoneSaved] which is triggered when a parent of this class has a
///[Form] and triggers the [saved] method.
final class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({
    super.key,
    required this.onPhoneChanged,
    required this.onCountryCodeChanged,
    this.onPhoneSaved,
    this.onCountryCodeSaved,
    this.apiException,
  });

  ///Communicates the value between [PhoneFormField] and
  ///this parent class.
  final ValueChanged<String>? onPhoneChanged;

  ///Communicates the value between [CountryCodeFormField]
  ///and this parent class.
  final ValueChanged<String?>? onCountryCodeChanged;

  ///Triggers if the parent class contains a [Form] and the
  ///[saved] method is called.
  final Function(String?)? onPhoneSaved;

  ///Triggers if the parent class contains a [Form] and the
  ///[saved] method is called.
  final Function(String?)? onCountryCodeSaved;

  ///Contains the information when an api call
  ///is not succesful.
  final AppApiException? apiException;

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

///Handles the state of the [PhoneFormField] by storing its value
///inside the [_phoneNumber] which is used to detect if an the [FormField]
///has any error.
///
///To detect the error an [_onPhoneValidator] method is passed to the
///[PhoneFormField] and an [_onCountryCodeValidator] is passed
///to the [CountryCodeFormField], this second validator
///does not use the value of the [DropdownButtonFormField] instead it uses
///the [_phoneNumber] to trigger any possible error and maintain a cohesion
///between both [FormField] and their errors.
class _PhoneNumberInputState extends State<PhoneNumberInput> with AppRegex {
  ///The state which stores the value of [PhoneFormField]
  String _phoneNumber = '';

  double get _width => 264.w;

  final _focusNode = FocusNode();

  ///Calls the parent [onPhoneChanged] if not null
  ///and stores the [value] in [_phoneNumber].
  void _onPhoneChanged(String value) {
    widget.onPhoneChanged?.call(value);
    setState(() {
      _phoneNumber = value;
    });
  }

  ///
  String? _onPhoneValidator(value) {
    if (value is! String) return null;

    final localeMessage = context.localeMessage;

    if (!validPhone(value)) return localeMessage.invalidPhone;
    final apiException = widget.apiException;
    //If no api error is found then no error is shown.
    if (apiException == null) return null;
    if (apiException.errorCodes.isNullOrEmpty) return null;
    //Checks for specific error codes.
    if (apiException.errorCodes!.contains(apiPhoneAlreadyUsed))
      return localeMessage.registeredPhone;
    if (apiException.errorCodes!.contains(apiUserNotFoundWithCredential))
      return localeMessage.unregisteredPhone;
    return null;
  }

  ///Returns a list of '\n' characters based on the length
  ///of the String error returned by [_onPhoneValidator].
  ///
  ///The calculation of the [numberOfLines] is based is a
  ///constant value of '29' which works for the specific
  ///[TextStyle] of the errorText inside the [AppTextFormField].
  ///If there is no error then it returns null.
  ///
  String? _onCountryCodeValidator(_) {
    final errorText = _onPhoneValidator(_phoneNumber);
    if (errorText.isNotNullEmpty) {
      final errorLength = errorText!.characters.length;
      //Specific number of characters given by the text style
      //for the phone fields before changing lines.
      const maxCharactersInLine = 29;
      final numberOfLines = (errorLength / maxCharactersInLine).ceil();
      return List.generate(numberOfLines - 1, (index) => '\n').join();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SizedBox(
        width: _width,
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: CountryCodeFormField<String>(
                onChanged: widget.onCountryCodeChanged,
                onSaved: widget.onCountryCodeSaved,
                apiException: widget.apiException,
                validator: _onCountryCodeValidator,
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              flex: 7,
              child: PhoneFormField(
                onSaved: widget.onPhoneSaved,
                onChanged: _onPhoneChanged,
                apiException: widget.apiException,
                validator: _onPhoneValidator,
                newFocusNode: _focusNode,
                handleFocusNode: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
