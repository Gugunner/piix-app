import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

import 'package:piix_mobile/form_feature/ui/widgets/dropdown_field/dropdown_field_barrel_file.dart';

///An [AppDropdownFormField] that specifically works with
///ISO 3166-1 alpha-2 two-letter country codes to
///show a selection of countries by their flag emoji unicode.
final class CountryCodeFormField<T> extends BaseAppDropdownFormField<T> {
  const CountryCodeFormField({
    super.key,
    required super.onChanged,
    super.enabled,
    super.autofocus,
    super.handleFocusNode,
    super.readOnly,
    super.items,
    super.itemValues,
    super.onSaved,
    super.onTap,
    super.validator,
    this.labelText,
    this.helperText,
    this.apiException,
  });

  ///Overrides the default 'Country' label.
  final String? labelText;

  ///Overrides the defaul 'null' value of the
  ///text.
  final String? helperText;

  ///Pass any exception thrown by the api request.
  final AppApiException? apiException;

  @override
  State<StatefulWidget> createState() => _CountryCodeFormFieldState();
}

final class _CountryCodeFormFieldState
    extends BaseAppDropdownFormFieldState<CountryCodeFormField> with AppRegex {
  @override
  String? get labelText =>
      widget.labelText ?? '${context.localeMessage.country}*';

  @override
  String? get helperText => widget.helperText;

  EdgeInsets get _contentPadding => EdgeInsets.symmetric(vertical: 8.5.h);

  ///A list of [String] values that contain the concatenation of
  ///a flag  emoji unicode and the country phone code.
  @override
  List<dynamic> get itemValues =>
      CountryCodeLocalizationUtils.countryPhoneCodesWithIndicator;

  @override
  void initState() {
    super.initState();
    //initialize the [AppDropdownFormField] with an initial value.
    dynamic initialValue;
    if (widget.items.isNotNullOrEmpty) {
      initialValue = widget.items!.first;
    } else if (widget.itemValues.isNotNullOrEmpty) {
      initialValue = widget.itemValues!.first;
    } else {
      initialValue = itemValues.first;
    }
    selectedValue = initialValue;
  }

  ///Parses the value selected to just return to the parent
  ///call only the country phone code.
  @override
  void onChanged(value) {
    if (value is String) {
      //Separate the value by a space since its format is
      //'{flagEmoji} {countryPhoneCode}' and retrieve only the
      //countryPhoneCode.
      final internationalPhoneCode = (value).split(' ')[1];
      //Pass the countryPhoneCode to the parent call.
      widget.onChanged?.call(internationalPhoneCode);
      //When a form is trying to be submitted the validation mode goes to always
      //sets the value to [onUserInteraction] when the form has an error
      //and can't be submitted.
      if (mounted)
        setState(() {
          if (autovalidateMode == AutovalidateMode.always) {
            autovalidateMode = AutovalidateMode.onUserInteraction;
          }
          value = selectedValue;
        });
      return;
    }
    super.onChanged(value);
  }

  @override
  String? validator(value) {
    //If a [validator] callback is passed then it replaces this
    //method.
    if (widget.validator != null) return widget.validator?.call(value);
    final localeMessage = context.localeMessage;
    if (value is String) {
      if (value.isNullOrEmpty) return localeMessage.emptyField;
    }
    //If no api error is found then no error is shown.
    final apiException = widget.apiException;
    if (apiException?.errorCodes == null) return null;
    if (apiException!.errorCodes!.isNullOrEmpty) return null;
    //TODO: If needed implement apiException

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppDropdownFormField(
      items: items,
      autovalidateMode: autovalidateMode,
      enabled: widget.enabled,
      onChanged: widget.enabled ? onChanged : null,
      isExpanded: true,
      onSaved: onSaved,
      value: selectedValue,
      validator: validator,
      focusNode: widget.handleFocusNode ? focusNode : null,
      labelText: labelText,
      helperText: helperText,
      helperMaxLines: 5,
      errorMaxLines: 5,
      padding: EdgeInsets.zero,
      contentPadding: _contentPadding,
    );
  }
}
