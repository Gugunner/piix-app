import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///The class wich composes an [AppDropdownFormField] and regulates the usage
///of either an [onSaved] or an [onChanged] in a [AppDropdownFormField]
///implementation.
///
///You must either pass the [items] to be used in the [AppDropdownFormField]
///or the [itemValues] which are mapped to a list of [DropdownMenuItem].
///
///If the [itemValues] are not [Widget]s then each value is interpolated
///as a [String] and wrapped inside a [Text] class.
abstract class BaseAppDropdownFormField<T> extends StatefulWidget {
  const BaseAppDropdownFormField({
    super.key,
    required this.onChanged,
    this.index = 0,
    this.enabled = true,
    this.required = true,
    this.autofocus = false,
    this.handleFocusNode = false,
    this.readOnly = false,
    this.isDense = false,
    this.isExpanded = false,
    this.iconSize = 24.0,
    this.alignment = AlignmentDirectional.centerStart,
    this.selectedItemBuilder,
    this.hint,
    this.disabledHint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.itemHeight,
    this.focusColor,
    this.newFocusNode,
    this.dropdownColor,
    this.decoration,
    this.onSaved,
    this.validator,
    this.onHandleForm,
    this.autovalidateMode,
    this.menuMaxHeight,
    this.enableFeedback,
    this.borderRadius,
    this.padding,
    this.items,
    this.itemValues,
    this.initialValue,
    this.onTap,
    this.errorText,
    this.helperText,
    this.labelText,
    this.errorMaxLines,
    this.helperMaxLines,
    this.prefix,
    this.suffix,
    this.contentPadding,
    this.apiException,
  }) : assert(!handleFocusNode || newFocusNode != null);

  ///The callback to execute each time a different option
  ///is selected.
  final ValueChanged<T?>? onChanged;

  ///Used to know what position in the [Form]
  ///should the value of this be set to in the answers.
  final int index;

  ///If false disables the [FormField].
  ///By default is set to true.
  final bool enabled;

  ///When set to true adds a '*' mark to the
  ///end of the [labelText].
  final bool required;

  ///Allows the [FormField] to be focused
  ///when it is first loaded in the screen.
  final bool autofocus;

  ///Allows to use a [FocusNode] managed by the State class.
  final bool handleFocusNode;

  ///Check [DropdownButtonFormField] property.
  final bool readOnly;

  ///Check [DropdownButtonFormField] property.
  final bool isDense;

  ///Check [DropdownButtonFormField] property.
  final bool isExpanded;

  ///Check [DropdownButtonFormField] property.
  final double iconSize;

  ///Check [DropdownButtonFormField] property.
  final AlignmentGeometry alignment;

  ///Check [DropdownButtonFormField] property.
  final DropdownButtonBuilder? selectedItemBuilder;

  ///Check [DropdownButtonFormField] property.
  final Widget? hint;

  ///Check [DropdownButtonFormField] property.
  final Widget? disabledHint;

  ///Check [DropdownButtonFormField] property.
  final Widget? icon;

  ///Check [DropdownButtonFormField] property.
  final Color? iconDisabledColor;

  ///Check [DropdownButtonFormField] property.
  final Color? iconEnabledColor;

  ///Check [DropdownButtonFormField] property.
  final double? itemHeight;

  ///Check [DropdownButtonFormField] property.
  final Color? focusColor;

  ///Check [DropdownButtonFormField] property.
  final FocusNode? newFocusNode;

  ///Check [DropdownButtonFormField] property.
  final Color? dropdownColor;

  ///Check [DropdownButtonFormField] property.
  final InputDecoration? decoration;

  ///The callback to execute when this
  ///is a child of [Form] parent class.
  final Function(T?)? onSaved;

  ///Check [DropdownButtonFormField] property.
  final String? Function(T?)? validator;

  ///Pass the callback when the [AppTextFormField] changes.
  ///
  ///Use when working with a form of an api call.
  final Function({
    required String? value,
    int? index,
    bool? required,
  })? onHandleForm;

  ///Check [DropdownButtonFormField] property.
  final AutovalidateMode? autovalidateMode;

  ///Check [DropdownButtonFormField] property.
  final double? menuMaxHeight;

  ///Check [DropdownButtonFormField] property.
  final bool? enableFeedback;

  ///Check [DropdownButtonFormField] property.
  final BorderRadius? borderRadius;

  ///Check [DropdownButtonFormField] property.
  final EdgeInsetsGeometry? padding;

  ///The items to be used as is in the [FormField].
  final List<DropdownMenuItem<T>>? items;

  ///The values which are processed and wrapped inside a
  ///[DropdownMenuItem] list.
  final List<T>? itemValues;

  ///The value to start the selection with.
  final T? initialValue;

  ///The callback that is executed by each
  ///of the [items] when tapped on.
  final VoidCallback? onTap;

  ///The text shown when the [TextFormField] has
  ///an error.
  final String? errorText;

  ///The text shown below the [TextFormField] to
  ///indicate what the user needs to comply with.
  final String? helperText;

  ///The text shown in the [TextFormField] to
  ///knwow what the field is for.
  final String? labelText;

  ///Maximum number of lines an error can show below the
  ///[TextFormField].
  final int? errorMaxLines;

  ///Maximum number of lines a help text can show below the
  ///[TextFormField].
  final int? helperMaxLines;

  ///Pass a non null value to show a suffix.
  ///[suffixIconData] and [icon] must be null.
  final Widget? suffix;

  ///Pass a non null value to show a prefix.
  final Widget? prefix;

  ///Allows to acommodate the content to make bigger or smaller
  ///the input space.
  final EdgeInsets? contentPadding;

  ///The instance of the api error with specific error codes.
  final AppApiException? apiException;
}

abstract class BaseAppDropdownFormFieldState<T extends BaseAppDropdownFormField>
    extends State<T> {
  FocusNode? focusNode;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String get requiredMark => widget.required ? '*' : '';

  ///The value selected by the [DropdownButtonFormField]
  dynamic selectedValue;

  ///Declare a helperText.
  String? get helperText {
    if (widget.helperText.isNotNullEmpty) {
      return widget.helperText;
    }
    if (widget.required) {
      return context.localeMessage.requiredField;
    }
    return null;
  }

  ///Declare a labelText.
  String? get labelText {
    if (widget.labelText.isNotNullEmpty) {
      return widget.labelText! + (widget.required ? '*' : '');
    }
    return null;
  }

  ///A simple call to avoid calling 'widget' each time itemValues
  ///is called.
  List<dynamic>? get itemValues => widget.itemValues;

  TextStyle? get textStyle {
    var color = PiixColors.infoDefault;
    if (!widget.enabled) {
      color = PiixColors.secondary;
    }
    return context.titleMedium?.copyWith(color: color);
  }

  ///Returns either the [items] or the [itemValues] wrapped inside
  ///a list of [DropdownMenuItem]. If the values in the [itemValues]
  ///are not [Widget]s they are interpolated in a [String] and
  ///wrapped inside a [Text]. Otherwise they are just wrapped in a
  /// [DropdownMenuItem] class.
  List<DropdownMenuItem<dynamic>> get items {
    if (widget.items.isNotNullOrEmpty) return widget.items!;
    return itemValues?.map((value) {
          return DropdownMenuItem<dynamic>(
            onTap: onTap,
            value: value,
            child: Builder(builder: (context) {
              if (value is! Widget) {
                return Text(
                  '$value',
                  style: textStyle,
                );
              }
              return value;
            }),
          );
        }).toList() ??
        [];
  }

  @override
  void initState() {
    super.initState();
    //initializes the [focusNode] only if
    //[useInternalFocusNode] is true.
    if (widget.handleFocusNode) {
      focusNode = widget.newFocusNode;
    }
    if (widget.initialValue != null) {
      selectedValue = widget.initialValue;
    }
  }

  @override
  void dispose() {
    //Correctly removes and disposes the [focusNode]
    //listener.
    if (widget.handleFocusNode) {
      focusNode?.dispose();
    }
    super.dispose();
  }

  ///Stores the [selectedValue] and
  ///
  void onChanged(value) {
    widget.onChanged?.call(value);
    //Pass value to parent call to store information
    //of the answers for the parent Form.
    widget.onHandleForm?.call(
      value: value,
      index: widget.index,
      required: widget.required,
    );
    setState(() {
      value = selectedValue;
    });
    //When a form is trying to be submitted the validation mode goes to always
    //sets the value to [onUserInteraction] when the form has an error
    //and can't be submitted.
    if (mounted) {
      if (autovalidateMode == AutovalidateMode.always)
        setState(() {
          autovalidateMode = AutovalidateMode.onUserInteraction;
        });
    }
  }

  ///Sets [autovalidateMode] to always after submitting once the form
  ///with [AppTextFormField].
  void onSaved(value) {
    if (widget.onSaved != null) widget.onSaved?.call(value);
    //Pass value to parent call to store information
    //of the answers for the parent Form.
    widget.onHandleForm?.call(
      value: value,
      index: widget.index,
      required: widget.required,
    );
    if (autovalidateMode == AutovalidateMode.disabled ||
        autovalidateMode == AutovalidateMode.onUserInteraction)
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
  }

  ///When an item is tapped it executes its
  ///parent callback and if [focusNode] is not null
  ///it changes focus to the next [Widget].
  void onTap() {
    widget.onTap?.call();
    if (widget.handleFocusNode) {
      focusNode?.requestFocus();
      focusNode?.nextFocus();
    }
  }

  ///Handles the focus listener of [focusNode].
  void onFocus() => throw UnimplementedError();

  ///Handles the internal validator of the [AppTextFormField].
  String? validator(value) => null;

  @override
  Widget build(BuildContext context);
}
