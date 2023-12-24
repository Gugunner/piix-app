import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/enums/enum_barrel_file.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_text_utils.dart';

@Deprecated('Use instead AppOnActionNumberField')

///Widget uses as a general [TextFormField] for 'number' dataTypeId formFields
///[FormFieldModelOld].
///
/// All calculations are made by using getters, if any additional information is
///  to be inserted, consider using service locators or dependency injections.
/// The only property received in the constructor is a [formField] which is
/// derived from a [FormFieldModelOld] and contains all the information to
/// retrieve and store user responses.
///
/// This do not use any type of [TextEditingController] or [FocusNode]
/// which are not necessary to process any information
/// as this is only used inside predefined forms.
class PiixNumberTextFormFieldDeprecated extends ConsumerStatefulWidget {
  const PiixNumberTextFormFieldDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the [TextFormField]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixNumberTextFormFieldDeprecated> createState() =>
      _PiixNumberTextFormFieldState();
}

class _PiixNumberTextFormFieldState
    extends ConsumerState<PiixNumberTextFormFieldDeprecated> {
  final focusNode = FocusNode();

  late FormNotifier formNotifier;

  FormFieldModelOld get formField => widget.formField;

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  @override
  void initState() {
    focusNode.addListener(_onChangeFocus);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void _onChangeFocus() {
    debugPrint('Has primary Focus ${formField.formFieldId} - '
        '${focusNode.hasPrimaryFocus}');
    debugPrint('Has Focus ${formField.formFieldId} - '
        '${focusNode.hasFocus}');
    setState(() {});
  }

  ///How the app should behave when text is being edited.
  void _onChanged(String? value) {
    formNotifier.updateFormField(
      formField: widget.formField,
      value: value,
      type: ResponseType.string,
    );
  }

  ///The regular expression which determines what can be writter, if double
  ///it can have up to 2 decimals, if not double then it can only contain
  ///integer numbers.
  ///Always be sure to use same decimals as [2].
  String get _regex => _isDouble ? r'^(\d+)?\.?\d{0,2}' : r'^[0-9]{1,}';

  ///Simple calculation to know if the number should be treated as [double]
  ///type.
  bool get _isDouble =>
      widget.formField.numberType == NumberType.DECIMAL ||
      widget.formField.numberType == NumberType.DECIMAL_PERCENTAGE ||
      widget.formField.numberType == NumberType.DECIMAL_CURRENCY;

  ///Simple calculation to know if the number needs to be represented as
  ///percentage &.
  bool get _isPercentage =>
      widget.formField.numberType == NumberType.WHOLE_PERCENTAGE ||
      widget.formField.numberType == NumberType.DECIMAL_PERCENTAGE;

  bool get _isCurrency =>
      widget.formField.numberType == NumberType.WHOLE_CURRENCY ||
      widget.formField.numberType == NumberType.DECIMAL_CURRENCY;

  @override
  Widget build(BuildContext context) {
    formNotifier = ref.watch(formNotifierProvider.notifier);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.0085),
      child: TextFormField(
        focusNode: focusNode,
        initialValue: widget.formField.stringResponse,
        decoration: decoration(context),
        keyboardType: TextInputType.number,
        textInputAction:
            formField.lastField ? TextInputAction.done : TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter(
            RegExp(_regex),
            allow: true,
          )
        ],
        style: InputStyleUtilsDeprecated.style(
          context,
          isEditable: formField.isEditable,
        ),
        onChanged: _onChanged,
        validator: (value) => errorText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}

///An extension used to decorate the [PiixNumberTextFormFieldDeprecated] styles, texts
/// and colors
///
/// Use [helperText] if other kind of helper text need to be added.
/// Use [errorText] when new specific errors should be presented.
extension _PiixNumberTextFormFieldDecoration on _PiixNumberTextFormFieldState {
  ///Checks if the [stringResponse] property of the [formField] can be
  ///parsed as a [num] type. Since ```num.parse``` can throw an [Exception]
  ///then the catch will always return false if tha parsing fails.
  bool get isNumber {
    if (formField.stringResponse.isNullOrEmpty) {
      return false;
    }
    try {
      num.parse(formField.stringResponse!);
      return true;
    } catch (e) {
      return false;
    }
  }

  ///Calculates the high limit based on the [NumberType].
  num get highLimit {
    if (_isPercentage) {
      return 100;
    }
    if (_isDouble) {
      return formField.max.toDouble();
    }
    return formField.max;
  }

  ///Calculates the low limit based on the [NumberType].
  num get lowLimit {
    if (_isPercentage) {
      if (_isDouble) {
        return 1.00;
      }
      return 1;
    }
    if (_isDouble) {
      return formField.min.toDouble();
    }
    return formField.min;
  }

  ///Simple conditional evaluation to know how many decimals to add
  ///when the [helperText] or [errorText] limits are presented up to [2]
  ///decimal.
  String obtainDecimals(String limit) => limit.contains('.')
      ? limit.split('.').last.length == 2
          ? limit
          : limit.split('.').last.length == 1
              ? limit.padRight(limit.length + 1, '0')
              : limit.padRight(limit.length + 2, '0')
      : _isCurrency
          ? '$limit.99'
          : '$limit.00';

  ///The [String] representation of the [highLimit] with decimals
  String get stringHL => obtainDecimals(highLimit.toString());

  ///The [String] representation of the [lowLimit] with decimals
  String get stringLL => obtainDecimals(lowLimit.toString());

  ///When checking for default [helperText] or [errorText] the common
  ///characters that appear in both of them when the user does not comply
  ///with the limits.
  String get commonText {
    var text = '';
    if (_isDouble) {
      text = '$text decimal';
      text = '$text entre ${_isCurrency ? '\$' : ''}$stringLL y '
          '${_isCurrency ? '\$' : ''}$stringHL${_isCurrency ? ' MXN' : ''}';
    } else {
      text = '$text entre ${_isCurrency ? '\$' : ''}$lowLimit y '
          '${_isCurrency ? '\$' : ''}$highLimit${_isCurrency ? ' MXN' : ''}';
    }
    if (_isPercentage) {
      text = '$text%';
    }
    return '$text.';
  }

  String? get helperText {
    String? helperText;

    helperText = formField.required
        ? PiixCopiesDeprecated.requiredField
        : PiixCopiesDeprecated.optionalField;

    if (formField.helperText.isNotNullEmpty) {
      helperText = '${helperText}${formField.helperText!}';
      return '$helperText';
    }
    helperText = '${helperText} Ingresa un valor$commonText';
    return '$helperText';
  }

  ///Parses the string response back to a number;
  num get number => isNumber ? num.parse(formField.stringResponse!) : -1000;

  ///Checks what [errorText] should be returned if the number does not comply
  ///with type and limits. Returns a concatenated string text.
  String? get errorText {
    String? text;
    if (formField.stringResponse.isNotNullEmpty) {
      if (!isNumber) {
        text = '${PiixCopiesDeprecated.invalidNumber}.';
      }
      if ((number < num.parse(stringLL) || number > num.parse(stringHL)) ||
          number < lowLimit ||
          number > highLimit) {
        text = PiixCopiesDeprecated.invalidNumber;
        text = '$text$commonText';
      }
    }
    return text;
  }

  ///Whether the [TextFormField] should show a percentage '%' symbol or not.
  String? get suffixText => _isPercentage ? '%' : null;

  ///The decoration used by [PiixNumberTextFormFieldDeprecated]
  InputDecoration decoration(BuildContext context) {
    final splitName = splitTextBy(name: formField.name);
    return InputDecoration(
      enabledBorder: InputDecorationUtilsDeprecated.enabledBorder(hasFocus),
      focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
      errorBorder: InputDecorationUtilsDeprecated.errorBorder,
      focusedErrorBorder: InputDecorationUtilsDeprecated.focusedErrorBorder,
      suffixText: suffixText,
      suffixStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      labelText: getTextLabel(
        splitName,
        formField.required,
      ),
      labelStyle: InputStyleUtilsDeprecated.labelStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      floatingLabelStyle: InputStyleUtilsDeprecated.floatingLabelStyle(
        context,
        errorText: errorText,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      helperText: helperText,
      helperStyle: InputStyleUtilsDeprecated.helperStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      errorStyle: InputStyleUtilsDeprecated.errorStyle(context),
      helperMaxLines: 4,
      errorText: errorText,
      errorMaxLines: 4,
    );
  }
}
