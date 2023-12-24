import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_text_utils.dart';

@Deprecated('Will be removed in 4.0')

///Widget used as a general [TextFormField] for "date" dataTypeId formFields
///[FormFieldModelOld].
///
/// All calculations are made using getters, if any additional information is
/// to be inserted, consider
/// using service locators or dependency injections. The only property received
/// in the constructor is a [formField] which is derived from a
/// [FormFieldModelOld] and contains all the information to retrieve and store
/// user response.
///
/// This uses a [TextEditingController] to be able to assign a text value when
/// the [showDatePicker] is called and finishes the action, the [selectedDate]
/// is parsed and stored in the property [stringResponse] of the [formField].
/// Since a [_controller] is used this is extends from a [StatefulWidget] to
/// control the disposing of such [_controller].
class PiixDateTextFormFieldDeprecated extends ConsumerStatefulWidget {
  const PiixDateTextFormFieldDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the [TextFormField]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixDateTextFormFieldDeprecated> createState() =>
      _PiixDateTextFormFieldState();
}

//TODO: Restore date picker state in future releases
class _PiixDateTextFormFieldState
    extends ConsumerState<PiixDateTextFormFieldDeprecated> {
  final focusNode = FocusNode();

  ///Used to pass and assign values selected from the date picker
  final TextEditingController _controller = TextEditingController();

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  @override
  void initState() {
    super.initState();
    //Initializes if a default value exists
    _controller.text = startDate ?? '';
    focusNode.addListener(_onChangeFocus);
  }

  @override
  void dispose() {
    //We must dispose the controller to avoid memory leaks
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _onChangeFocus() {
    debugPrint('Has primary Focus ${formField.formFieldId} - '
        '${focusNode.hasPrimaryFocus}');
    debugPrint('Has Focus ${formField.formFieldId} - '
        '${focusNode.hasFocus}');
    if (hasFocus && formField.stringResponse.isNotNullEmpty) {
      focusNode.nextFocus();
    }
    setState(() {});
  }

  String? get startDate {
    final utcDate = formField.stringResponse;
    if (utcDate.isNotNullEmpty) {
      final startDateFormat = DateFormat('dd/MM/yyyy');
      try {
        final startDate = startDateFormat.format(DateTime.parse(utcDate!));
        return startDate;
      } catch (_) {
        //When the utcDate parsing fails
        return null;
      }
    }
    return null;
  }

  ///The [stringResponse] stores the selected Date
  String? get selectedDate => formField.stringResponse;

  FormFieldModelOld get formField => widget.formField;

  @override
  Widget build(BuildContext context) {
    ref.watch(formNotifierProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.height * 0.0085),
      child: TextFormField(
        focusNode: focusNode,
        enabled: formField.isEditable,
        controller: _controller,
        readOnly: true,
        onChanged: formField.isEditable ? (_) {} : null,
        decoration: decoration,
        style: style(context),
        onTap: () => formField.isEditable ? callDatePicker(context) : null,
      ),
    );
  }
}

///An extension used to decorate the [_PiixDateTextFormFieldState] styles,
///texts and colors
///
/// Use [helperText] if other kind of helper text need to be added.
extension _PiixDateTextFormFieldDecoration on _PiixDateTextFormFieldState {
  ///Calculates the text based on the properties of the [formField].
  ///The [required] property and the [helperText] property are what defines
  ///what is shown in the [TextFormField].
  String? get helperText {
    String? helperText;
    if (formField.required) {
      helperText = PiixCopiesDeprecated.requiredField + (helperText ?? ' ');
    }
    if (formField.helperText.isNotNullEmpty) {
      helperText = helperText ?? '' + formField.helperText!;
    }
    return helperText;
  }

  TextStyle style(BuildContext context) =>
      context.textTheme?.bodyMedium?.copyWith(
        color:
            formField.isEditable ? PiixColors.contrast : PiixColors.secondary,
      ) ??
      const TextStyle();

  InputDecoration get decoration {
    final splitName = splitTextBy(name: formField.name);
    return InputDecoration(
      enabledBorder: InputDecorationUtilsDeprecated.enabledBorder(hasFocus),
      focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
      suffixIcon: Icon(
        Icons.calendar_today,
        color: hasFocus
            ? PiixColors.insurance
            : formField.isEditable
                ? PiixColors.infoDefault
                : PiixColors.secondary,
      ),
      helperText: helperText,
      helperStyle: InputStyleUtilsDeprecated.helperStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      labelText: getTextLabel(splitName, formField.required),
      labelStyle: InputStyleUtilsDeprecated.labelStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      floatingLabelStyle: InputStyleUtilsDeprecated.floatingLabelStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
    );
  }
}

///An extension used to manage the [showDatePicker] of the
///[_PiixDateTextFormFieldState].
extension _PiixDateTextFormFieldDatePicker on _PiixDateTextFormFieldState {
  ///Creates the theme for the date picker inside the [builder].
  Theme datePickerTheme(Widget child) => Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child,
      );

  // ///Calculates the maximum date considered for a user to be treated as an adult.
  // ///The date is calculated based on the current date minus 18 years.
  // DateTime get legalDate => DateTime(
  //     DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  ///Calculates the initial date that can be selected from the date picker.
  DateTime get firstDate {
    if (formField.minDate.isNotNull && formField.minDate!.isNotEmpty) {
      return DateTime.parse(formField.minDate!);
    }

    return DateTime(DateTime.now().year - 40);
  }

  ///Calculates the final date that can be selected from the date picker
  DateTime get lastDate {
    if (formField.maxDate.isNotNull && formField.maxDate!.isNotEmpty) {
      return DateTime.parse(formField.maxDate!);
    }
    return DateTime.now();
  }

  DateTime get initialDate {
    if (firstDate.isAfter(lastDate)) {
      return DateTime(lastDate.year - 120);
    }
    return firstDate;
  }

  DateFormat get dateFormat => DateFormat('dd/MM/yyyy');

  ///Encapsulates the call of [showDatePicker], must be called by passing the
  ///[context].
  Future<DateTime?> datePicker(BuildContext context) => showDatePicker(
        context: context,
        builder: (context, child) => datePickerTheme(child!),
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: lastDate,
        locale: const Locale('es'),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        keyboardType: TextInputType.datetime,
      );

  ///An asynchronous method that calls [datePicker].
  ///
  /// Since the call opens a new dialog, the user can't interact with the form
  /// while the [datePicker] is open. When the user finishes selecting the date
  /// if the [selectedDate] is a non null value, the date is stored in the
  /// [stringResponse] property of [formField] and also the date is assigned to
  /// the [text] property of the [_controller].
  void callDatePicker(BuildContext context) async {
    final selectedDate = await datePicker(context);
    if (selectedDate != null) {
      final value = dateFormat.format(selectedDate);
      ref.read(formNotifierProvider.notifier).updateFormField(
            formField: formField,
            value: toIsoString(selectedDate),
            type: ResponseType.string,
          );
      _controller.text = value;
    }
  }
}
