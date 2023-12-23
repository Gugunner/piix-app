import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/text_form_field/text_form_field_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///The class which composes an [AppTextFormField] and regulates the usage of
///either an [onSaved] or an [onChanged] in a[TextFormField] implementation.
///
///Pass [handleFocusNode] to allow for focus and unfocus when a user
///interacts or leaves the input. It can also be used to pass the focus to
///the next input if this and the input are inside a [Form].
abstract class BaseAppTextFormField extends StatefulWidget {
  const BaseAppTextFormField({
    super.key,
    this.index = 0,
    this.enabled = true,
    this.required = true,
    this.autofocus = false,
    this.handleFocusNode = false,
    this.readOnly = false,
    this.obscureText = false,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.onSaved,
    this.onChanged,
    this.onHandleForm,
    this.controller,
    this.validator,
    this.textInputAction,
    this.obscuringCharacter = '•',
    this.autovalidateMode,
    this.initialValue,
    this.newFocusNode,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.errorMaxLines,
    this.helperMaxLines,
    this.maxLength,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onFocus,
    this.inputFormatters,
    this.scrollController,
    this.helperText,
    this.labelText,
    this.errorText,
    this.suffixIconData,
    this.icon,
    this.suffix,
    this.prefix,
    this.inputDecoration,
    this.apiException,
  }) : assert(controller == null || validator == null,
            !handleFocusNode || newFocusNode != null);

  ///Used to know what position in the [Form]
  ///should the value of this be set to in the answers.
  final int index;

  ///Check [TextFormField] property.
  final bool enabled;

  ///When set to true adds a '*' mark to the
  ///end of the [labelText].
  final bool required;

  ///Check [TextFormField] documentation.
  final bool autofocus;

  ///When set to true all listeners, unfocus, request focus, listeners and
  ///dispose should be handled by this.
  ///
  ///If true [newFocusNode] must not be null.
  final bool handleFocusNode;

  ///Check [TextFormField] property.
  final bool readOnly;

  ///Check [TextFormField] documentation.
  final bool obscureText;

  ///Check [TextFormField] documentation.
  final String obscuringCharacter;

  ///Check [TextFormField] documentation.
  final EdgeInsets scrollPadding;

  ///Pass the callback when the [AppTextFormField] is inside a
  ///[Form] and [GlobalKey] is read for the current [context].
  final Function(String?)? onSaved;

  ///Pass the callback when the [AppTextFormField] changes.
  final ValueChanged<String>? onChanged;

  ///Pass the callback when the [AppTextFormField] changes.
  ///
  ///Use when working with a form of an api call.
  final HandleFormValue? onHandleForm;

  ///Check [TextFormField] property.
  final TextEditingController? controller;

  ///Check [TextFormField] property.
  final String? Function(String?)? validator;

  final TextInputAction? textInputAction;

  ///Check [TextFormField] documentation.
  final AutovalidateMode? autovalidateMode;

  ///Check [TextFormField] documentation.
  final String? initialValue;

  ///Check [TextFormField] documentation.
  final FocusNode? newFocusNode;

  ///Check [TextFormField] documentation.
  final TextInputType? keyboardType;

  ///Check [TextFormField] documentation.
  final int? minLines;

  ///Check [TextFormField] documentation.
  final int? maxLines;

  ///Check [TextFormField] documentation.
  final int? errorMaxLines;

  ///Check [TextFormField] documentation.
  final int? helperMaxLines;

  ///Check [TextFormField] documentation.
  final int? maxLength;

  ///Check [TextFormField] documentation.
  final VoidCallback? onTap;

  ///Check [TextFormField] documentation.
  final Function(KeyDownEvent)? onTapOutside;

  ///Check [TextFormField] documentation.
  final VoidCallback? onEditingComplete;

  ///Check [TextFormField] documentation.
  final Function(String?)? onFieldSubmitted;

  ///The calback to execute when [handleFocusNode]
  ///is set to true.
  final VoidCallback? onFocus;

  ///Check [TextFormField] documentation.
  final List<TextInputFormatter>? inputFormatters;

  ///Check [TextFormField] documentation.
  final ScrollController? scrollController;

  ///Check [InputDecoration] documentation.
  final String? helperText;

  ///Check [InputDecoration] documentation.
  final String? labelText;

  ///Check [InputDecoration] documentation.
  final String? errorText;

  ///Check [AppTextFormField] documentation.
  ///if this property is not null [icon]
  ///must be null.
  final IconData? suffixIconData;

  ///Check [AppTextFormField] documentation.
  ///if this property is not null [suffixIconData]
  ///must be null.
  final Widget? icon;

  ///Check [InputDecoration] documentation.
  final Widget? suffix;

  ///Check [InputDecoration] documentation.
  final Widget? prefix;

  ///Overrides the default [GeneralFormInputDecoration].
  final InputDecoration? inputDecoration;

  ///The instance of the api error with specific error codes.
  final AppApiException? apiException;
}

///Defines internal methods that must be called to control focus, and validator
///for an [AppTextFormField].
abstract class BaseAppTextFormFieldState<T extends BaseAppTextFormField>
    extends State<T> {
  FocusNode? focusNode;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String get requiredMark => widget.required ? '*' : '';

  @override
  void initState() {
    super.initState();
    //initializes the [focusNode] only if
    //[useInternalFocusNode] is true.
    if (widget.handleFocusNode) {
      focusNode = widget.newFocusNode;
    }
  }

  @override
  void dispose() {
    if (widget.handleFocusNode) {
      //Correctly removes and disposes the [focusNode]
      //listener.
      focusNode?.dispose();
    }

    super.dispose();
  }

  //Declare a helperText.
  String? get helperText {
    if (widget.helperText.isNotNullEmpty) {
      return widget.helperText;
    }
    if (widget.required) {
      return context.localeMessage.requiredField;
    }
    return null;
  }

  //Declare a labelText, if this is [required]
  //mark it with * at the end.
  String? get labelText {
    if (widget.labelText.isNotNullEmpty) {
      return widget.labelText! + (widget.required ? '*' : '');
    }
    return null;
  }

  ///Handles the internal validator of the [AppTextFormField].
  String? validator(String? value);

  ///Sets [autovalidateMode] to always after submitting once the form
  ///with [AppTextFormField].
  void onSaved(String? value) {
    if (widget.onSaved != null) widget.onSaved?.call(value);
    //Pass value to parent call to store information
    //of the answers for the parent Form.
    widget.onHandleForm?.call(
      value: value ?? '',
      index: widget.index,
      required: widget.required,
    );
    if (autovalidateMode == AutovalidateMode.disabled ||
        autovalidateMode == AutovalidateMode.onUserInteraction)
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
  }

  ///Sets [autovalidateMode] to onUserInteraction only if it changes
  ///after the user has [submitted] once and an error on the [AppTextFormField]
  ///occurred.
  void onChanged(String value) {
    widget.onChanged?.call(value);
    //Pass value to parent call to store information
    //of the answers for the parent Form.
    widget.onHandleForm?.call(
      value: value,
      index: widget.index,
      required: widget.required,
    );
    if (autovalidateMode == AutovalidateMode.always)
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
  }

  ///Moves to the next element of the form
  ///when the user presses the done, go, search, next or previous
  ///key in the virtual devices keyboard.
  void onEditingComplete() {
    widget.onEditingComplete?.call();
    if (widget.handleFocusNode) {
      if (widget.textInputAction != TextInputAction.done) {
        focusNode?.nextFocus();
        return;
      }
      focusNode?.unfocus();
    }
  }

  ///Handles the focus listener of [focusNode].
  void onFocus() => throw UnimplementedError();

  @override
  Widget build(BuildContext context);
}
