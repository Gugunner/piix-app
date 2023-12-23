import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///This class is an extension of the [BaseAppTextFormField] specifically
///designed to work with dates in the format 'mm/dd/yyyy' by default.
///
///The date format can change based on the app language prefference.
///To pass the [selectedDate] to a parent use the [onSelectDate] which
///passes the [value] as a [DateTime] object.
///
///To limit the selection of dates the [minDate] and [maxDate] properties
///can be set, note that [maxDate] must be greater or equal to [minDate] to
///avoid any errors.
abstract class BaseAppDateTextFormField extends BaseAppTextFormField {
  const BaseAppDateTextFormField({
    super.key,
    super.index,
    super.enabled,
    super.required,
    super.autofocus,
    super.handleFocusNode,
    super.readOnly,
    super.obscureText,
    super.scrollPadding,
    super.onSaved,
    super.onChanged,
    super.controller,
    super.validator,
    super.textInputAction,
    super.autovalidateMode,
    super.newFocusNode,
    super.keyboardType,
    super.minLines,
    super.maxLines,
    super.errorMaxLines,
    super.helperMaxLines,
    super.maxLength,
    super.onTap,
    super.onTapOutside,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onFocus,
    super.inputFormatters,
    super.scrollController,
    super.helperText,
    super.labelText,
    super.errorText,
    super.suffixIconData,
    super.icon,
    super.suffix,
    super.prefix,
    super.inputDecoration,
    super.apiException,
    this.onSelectDate,
    this.minDate,
    this.maxDate,
    this.initialDate,
  });

  ///An optional callback that passes the [value]
  ///back to its parent calling.
  final Function({
    required DateTime? value,
    int? index,
    bool? required,
  })? onSelectDate;

  ///The minimum date the user can select from.
  final DateTime? minDate;

  ///The maximum date the user can select up to.
  final DateTime? maxDate;

  ///The date that will appear the first time the
  ///[DatePickerDialog] is displayed in.
  final DateTime? initialDate;
}

///The actual implementation of the [BaseAppDateTextFormField] which
///works by assigning either the parent [controller] or its own.
///
///Normally builds an [TextFormField]  or is composed with it to
///pass on the [controller] which allows to handle the [text] inside
///and assign it in other ways different than from using the virtual
///keyboard.
///
///The [_initialDate] which is set in the [DatePickerDialog] by calling
///[showDatePicker] is set by either passing the parent [initialDate]
///value or a default value currently set at 50 years before current time
///execution.
///
///Since this is a [TextFormField] composed class the value must be shown as a
///[String] so to that extent if the parent [initialValue] is set when
///loading this a date is parsed to iso8601 format and later to the 'mm/dd/yyyy' format
///or the one based on the app language prefference.
///
///To set a new date the [onTap] method must be called and set in the composed
///[TextFormField] or using a GestureDetector. To use a default full
///working implementation use [AppTextFormField] inside [build].
abstract class BaseAppDateTextFormFieldState
    extends BaseAppTextFormFieldState<BaseAppDateTextFormField> {
  ///The [text] value of the [TextFormField] composed inside
  ///this.
  late TextEditingController controller;

  ///The selected date to show when first opening the
  ///[DatePickerDialog].
  late DateTime _initialDate;

  ///The value shown inside the [TextFormField] when first loading
  ///this. If null shows an empty [String] value.
  String? initialValue;

  ///Predefines the lower limit for the selectable dates. If
  ///no [minDate] is passed the value defaults to 100 year before
  ///current time execution.
  DateTime get _firstDate =>
      widget.minDate ?? DateTime(DateTime.now().year - 100);

  ///Predefines the upper limit for the selectable dates. If
  ///no [maxDate] is passed the value defaults current time execution.
  DateTime get _lastDate => widget.maxDate ?? DateTime.now();

  @override
  void initState() {
    super.initState();
    //Either sets parent passed on value or a new instance is created.
    controller = widget.controller ?? TextEditingController();
    //Either sets parent passed on value or defaults to 50 years before
    //current time execution.
    _initialDate = widget.initialDate ?? DateTime(DateTime.now().year - 50);
    //If the parent passes an intialDate value, the parsed value with the
    //'mm/dd/yyyy/' String format is set to be used in the [TextFormField] or
    //any other [Text] element that displays a [String].
    if (widget.initialDate != null) {
      Future.microtask(() {
        setState(() {
          controller.text = DateLocalizationUtils.getDYMFormat(context)
              .format(widget.initialDate!);
        });
      });
    }
  }

  @override
  void dispose() {
    //Clears the instance and all its other references when this
    //is removed from the [Navigator] stack.
    controller.dispose();
    super.dispose();
  }

  ///Wraps [showDatePicker] for easier encapsulation of logic.
  Future<DateTime?> _launchDatePicker() async {
    return showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: _firstDate,
      lastDate: _lastDate,
      locale: Localizations.localeOf(context),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
      keyboardType: TextInputType.datetime,
    );
  }

  ///If [currentFocus] is in this then it tries
  ///to unfocus the this.
  void onTapOutside(PointerDownEvent? event) {
    if (widget.handleFocusNode) {
      focusNode?.unfocus();
    }
  }

  ///Waits for the value returned from [_launchDatePicker]
  ///and checks if the user selected a date.
  ///
  ///If a date was selected it stores the value in [_initialDate]
  ///and parses it to the 'mm/dd/yyyy/' format or the current
  ///app language preference format.
  ///
  ///Finally if possible it passes the values to the parent
  ///by calling [onSelectDate] and moves the focus to the next
  ///element by executing [onEditingComplete].
  void onTap() async {
    final selectedDate = await _launchDatePicker();
    if (selectedDate == null) {
      focusNode?.requestFocus();
      focusNode?.unfocus();
      return;
    }
    setState(() {
      _initialDate = selectedDate;
      controller.text =
          DateLocalizationUtils.getDYMFormat(context).format(selectedDate);
    });
    widget.onSelectDate?.call(
      value: selectedDate,
      required: widget.required,
      index: widget.index,
    );
    onEditingComplete();
  }

  ///
  // void onSubmitted(String? value) {
  //   widget.onFieldSubmitted?.call(value);
  //   if (widget.handleFocusNode) {
  //     if (widget.textInputAction != TextInputAction.done) {
  //       focusNode?.nextFocus();
  //       return;
  //     }
  //     focusNode?.unfocus();
  //   }
  // }

  ///By default no error is shown in the [TextFormField]
  ///error section.
  @override
  String? validator(String? value) => null;
}
