import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/base_app_text_form_field.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/app_text_form_field.dart';

///A specific [AppTextFormField] implementation for number inputs.
///
///The input can work with different [numberType]s incluidng whole or decimal
///values and either normal, percentage or currency values.
///Pass a [numberType] to change the [prefix] and [suffix] shown.
final class NumberFormField extends BaseAppTextFormField {
  const NumberFormField({
    super.key,
    super.index,
    super.enabled,
    super.required,
    super.readOnly,
    super.handleFocusNode = true,
    super.onSaved,
    super.onChanged,
    super.controller,
    super.validator,
    this.minValue = 0,
    this.maxValue = 999999,
    this.numberType = NumberType.WHOLE,
    this.showLimits = false,
    super.labelText,
    super.helperText,
    this.suffixString,
    this.prefixString,
    super.initialValue,
    super.inputFormatters,
    super.apiException,
  }) : assert(!showLimits || helperText == null);

  ///The minimum value accepted by the input
  final num minValue;

  ///The maximum value accepted by the input.
  final num maxValue;

  ///The different types of numbers that can be used.
  ///This value determines some default prefixes and
  ///[TextInputFormatter],
  final NumberType numberType;

  ///Set to true to show a [helperText] that
  ///explains the [minValue] and [maxValue].
  ///Can't be true if [helperText] is not null.
  final bool showLimits;

  ///Pass this value if a value should be added before
  ///the value, normally used with currency.
  final String? suffixString;

  ///Pass this value if a value should be added after
  ///the value, normally used with currency.
  final String? prefixString;

  @override
  State<StatefulWidget> createState() => _NumberFormFieldState();
}

///The implementation of [BaseAppTextFormFieldState] based on an
///[NumberFormField].
final class _NumberFormFieldState
    extends BaseAppTextFormFieldState<NumberFormField> {
  ///A simple call to avoid calling widget each time the minimum
  ///value is needed.
  num get _minValue => widget.minValue;

  ///A simple call to avoid calling widget each time the maximum
  ///value is needed.
  num get _maxValue => widget.maxValue;

  ///A simple call to avoid calling widget each time the numberType is needed.
  NumberType get _numberType => widget.numberType;

  List<TextInputFormatter>? get _inputFormatters {
    //If a list of input formatters is passed it overwrites any other internal
    //input formatter
    if (widget.inputFormatters.isNotNullOrEmpty) return widget.inputFormatters;
    //Checks the numberType and if it is a double limits the input
    //to two decimals otherwise it can only contain integer values.
    var regExp = RegExp(integerRegex);
    if (_numberType == NumberType.DECIMAL_PERCENTAGE) {
      regExp = RegExp(twoDecimalsPercentageRegex);
    } else if (_numberType.isPercentage) {
      regExp = RegExp(integerPercentageRegex);
    } else if (_numberType.isDouble) {
      regExp = RegExp(twoDecimalsRegex);
    }
    return [
      FilteringTextInputFormatter(
        regExp,
        allow: true,
      )
    ];
  }

  ///Uses the [suffix] value and if not checks if
  ///a default value must be used.
  String? get _suffix {
    if (widget.suffixString.isNotNullEmpty) return widget.suffixString;
    if (_numberType.isCurrency) return 'MXN';
    if (_numberType.isPercentage) return '%';
    return null;
  }

  ///Uses the [prefix] value and if not checks if
  ///a default value must be used.
  String? get _prefix {
    if (widget.prefixString.isNotNullEmpty) return widget.prefixString;
    if (_numberType.isCurrency) return '\$';
    return null;
  }

  @override
  String? get helperText {
    if (widget.helperText.isNotNullEmpty) return widget.helperText;
    if (widget.showLimits) {
      return context.localeMessage
          .numberInputInstructions(_minValue, _maxValue);
    }
    return null;
  }

  @override
  String? get labelText => widget.labelText;

  ///Returns the text inside the [controller].
  String? get controllerText {
    if (widget.controller != null) return widget.controller!.text;
    return null;
  }

  @override
  String? validator(String? value) {
    //If a [validator] callback is passed then it replaces this
    //method.
    if (widget.validator != null) return widget.validator?.call(value);
    if (widget.required && value.isNullOrEmpty) return null;
    final numValue = num.parse(value!);
    final localeMessage = context.localeMessage;
    //Check for percentage value
    if (widget.numberType.isPercentage) {
      if (numValue > 100) return localeMessage.percentageOver100;
      if (numValue < 0) return localeMessage.percentageUnder0;
    }
    //Check limits of values.
    if (numValue > _maxValue) return localeMessage.wrongMaxValue(_maxValue);
    if (numValue < _minValue) return localeMessage.wrongMinValue(_minValue);
    final apiException = widget.apiException;

    ///If no api error is found then no error is shown.
    if (apiException == null) return null;
    if (apiException.errorCodes.isNullOrEmpty) return null;
    //TODO: Add Api Errors
    return null;
  }

  ///Unfocus the [AppTextFormField] if
  /// [useInternalFocusNode] is true when
  /// the user taps outside the this.
  void onTapOutside(PointerDownEvent? event) {
    if (widget.handleFocusNode) {
      focusNode?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      autovalidateMode: autovalidateMode,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      focusNode: widget.handleFocusNode ? focusNode : null,
      readOnly: widget.readOnly,
      onSaved: onSaved,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      controller: widget.controller,
      validator: controllerText != null ? null : validator,
      helperText: helperText,
      initialValue: widget.initialValue,
      helperMaxLines: 2,
      labelText: labelText,
      errorText: controllerText != null ? validator(controllerText!) : null,
      errorMaxLines: 2,
      keyboardType: TextInputType.number,
      onTapOutside: onTapOutside,
      textInputAction: TextInputAction.done,
      inputFormatters: _inputFormatters,
      suffix: _suffix.isNotNullEmpty ? _NumberFix(_suffix!) : null,
      prefix: _prefix.isNotNullEmpty ? _NumberFix(_prefix!) : null,
    );
  }
}

///A simple styled [Text] that is called to show a [suffix]
///or [prefix] value.
final class _NumberFix extends StatelessWidget {
  const _NumberFix(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.titleMedium,
    );
  }
}
