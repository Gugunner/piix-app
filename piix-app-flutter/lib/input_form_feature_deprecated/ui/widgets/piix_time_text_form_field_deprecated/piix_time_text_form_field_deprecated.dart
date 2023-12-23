import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_text_utils.dart';

@Deprecated('Use instead AppOnActionTimeField')

///Widget used as a general [TextFormField] for "time" dataTypeId formFields
///[FormFieldModelOld].
///
/// All calculations are made using getters, if any additional information is
/// to be inserted, consider using service locators or dependency injections.
/// The only property received in the constructor is a [formField] which is
/// derived from a [FormFieldModelOld] and contains all the information to
/// retrieve and store user response.
///
/// This uses a [TextEditingController] to be able to assign a text vale when
/// [showTimePicker] is called and finishes the action, the [selectedTime] is
/// formatted and stored in the property [stringResponse] of the [formField].
/// Since a [_controller] is used this extends from a [StatefulWidget] to
/// control the disposing of such [_controller].
class PiixTimeTextFormFieldDeprecated extends ConsumerStatefulWidget {
  const PiixTimeTextFormFieldDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the
  ///[TextFormField]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixTimeTextFormFieldDeprecated> createState() =>
      _PiixTimeTextFormFieldState();
}

class _PiixTimeTextFormFieldState
    extends ConsumerState<PiixTimeTextFormFieldDeprecated> {
  final focusNode = FocusNode();

  ///Used to pass and assign values selected from the time picker
  final TextEditingController _controller = TextEditingController();

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  @override
  void initState() {
    super.initState();
    //Initializes if a default value exists
    _controller.text = formField.stringResponse ?? '';
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

  String? get selectedTime => formField.stringResponse;

  FormFieldModelOld get formField => widget.formField;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.0085),
      child: TextFormField(
        focusNode: focusNode,
        enabled: formField.isEditable,
        controller: _controller,
        readOnly: true,
        onChanged: formField.isEditable ? (_) {} : null,
        decoration: decoration(context),
        style: InputStyleUtilsDeprecated.style(
          context,
          isEditable: formField.isEditable,
        ),
        onTap: () => formField.isEditable ? callTimePicker(context) : null,
        validator: (val) => errorText,
      ),
    );
  }
}

///An extension used to decorate the [_PiixTimeTextFormFieldState] styles, texts
/// and colors
///
/// Use [helperText] if other kind of helper text need to be added.
/// Use [errorText] when new specific errors should be presented.
extension _PiixTimeTextFormFieldDecoration on _PiixTimeTextFormFieldState {
  ///Calculates the text based on the properties of the [formField].
  ///It also checks for the [minTIme] and [maxTime] properties in [formField]
  ///to create an instruction text on the available range that is selectable.
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
    if (formField.minTime.isNotNullEmpty && formField.maxTime.isNotNullEmpty) {
      helperText = '$helperText De ${formField.minTime} a ${formField.maxTime}';
    }
    return '$helperText.';
  }

  ///Receives a nullable [String] type [time] and
  ///if it can be parsed to [TimeOFDay] then it returns the
  ///newly created instance. If not it returns null.
  TimeOfDay? toTime(String? time) {
    if (time.isNotNullEmpty) {
      if (time!.contains(':')) {
        final splitTime = time.split(':');
        if (splitTime.length >= 2) {
          final hour = int.parse(time.split(':').first);
          final minute = int.parse(time.split(':')[1]);
          return TimeOfDay(hour: hour, minute: minute);
        }
      }
    }
    return null;
  }

  ///A simple calculation that receives a [timeOfDay] and the sum
  ///of the time normalized in the minutes as a [double]
  double fromTimeOfDay(TimeOfDay timeOfDay) =>
      timeOfDay.hour.toDouble() + (timeOfDay.minute / 60);

  ///Creates the upper time limit that is checked when the user
  ///selects a time.
  double get upperTimeLimit {
    var timeOfDay = toTime(formField.maxTime);
    if (timeOfDay == null) {
      timeOfDay = const TimeOfDay(hour: 23, minute: 59);
    }
    return fromTimeOfDay(timeOfDay);
  }

  ///Creates the lower limit that is checked when the user
  ///selects a time.
  double get lowerTimeLimit {
    var timeOfDay = toTime(formField.minTime);
    if (timeOfDay == null) {
      timeOfDay = const TimeOfDay(hour: 0, minute: 0);
    }
    return fromTimeOfDay(timeOfDay);
  }

  ///Returns a [String] error only if the user selects a [currentValue]
  ///that is not inside the valid limits.
  String? get errorText {
    final time = _controller.text;
    final timeOfDay = toTime(time);
    if (timeOfDay != null) {
      final currentValue = fromTimeOfDay(timeOfDay);
      if (currentValue < lowerTimeLimit || currentValue > upperTimeLimit) {
        return '${PiixCopiesDeprecated.enterValidHour} '
            '${formField.minTime} - ${formField.maxTime}';
      }
    }
    return null;
  }

  InputDecoration decoration(BuildContext context) {
    final splitName = splitTextBy(name: formField.name);
    return InputDecoration(
      enabledBorder: InputDecorationUtilsDeprecated.enabledBorder(hasFocus),
      focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
      suffixIcon: Icon(
        Icons.schedule,
        color: hasFocus
            ? PiixColors.azure
            : formField.isEditable
                ? PiixColors.brownishGrey
                : PiixColors.labelText,
      ),
      helperText: helperText,
      helperStyle: InputStyleUtilsDeprecated.helperStyle(context,
          hasFocus: hasFocus, isEditable: formField.isEditable),
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
      errorText: errorText,
      errorStyle: InputStyleUtilsDeprecated.errorStyle(context),
    );
  }
}

///An extension used to manage the [showTimePicker] of the
///[_PiixTimeTextFormFieldState].
extension _PiixTimeTextFormFieldTimePicker on _PiixTimeTextFormFieldState {
  ///Creates the theme for the time picker inside the [builder].
  Theme timePickerTheme(Widget child) => Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child,
      );

  ///Encapsulates the call of [showTimePicker], must be called by passing the
  ///[context].
  Future<TimeOfDay?> timePicker(BuildContext context) => showTimePicker(
        context: context,
        builder: (context, child) => timePickerTheme(child!),
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        helpText: PiixCopiesDeprecated.enterTime,
        hourLabelText: PiixCopiesDeprecated.hour,
        minuteLabelText: PiixCopiesDeprecated.minute,
        confirmText: PiixCopiesDeprecated.accept,
        cancelText: PiixCopiesDeprecated.cancel,
        errorInvalidText: PiixCopiesDeprecated.enterValidTime,
      );

  ///An asynchronous method that calls [timePicker].
  ///
  /// Since the call opens a new dialog, the user can't interact with the form
  /// while the [timePicker] is open. When the user finishes selecting the time
  /// if the [selectedTime] is a non null value, the time is stored in the
  /// [stringResponse] property of [formField] and also the time is assigned
  /// to the [text] property of the [_controller].
  void callTimePicker(BuildContext context) async {
    final selectedTime = await timePicker(context);
    if (selectedTime != null) {
      final value = selectedTime.format(context);
      ref.read(formNotifierProvider.notifier).updateFormField(
            formField: formField,
            value: value,
            type: ResponseType.string,
          );
      _controller.text = value;
    }
  }
}
