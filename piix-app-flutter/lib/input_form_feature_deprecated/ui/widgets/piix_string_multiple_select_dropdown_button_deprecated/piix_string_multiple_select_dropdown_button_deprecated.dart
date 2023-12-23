import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_string_multiple_select_dropdown_button_deprecated/piix_checkbox_list_tile_dialog_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_text_utils.dart';

@Deprecated('Use instead AppOnActionMultipleSelectField')

///Widget used as a general [PiixStringMultipleSelectDropdownButtonDeprecated] for
///"string" dataTypeId formFields [FormFieldModelOld]
///that have the property isArray and isMultiple both set to true.
///
///This widget manages an overlay entry that acts as a special dialog for
///the checkbox tile list. Calculations are made by using getters, if any
///additional information
///is to be inserted, consider using service locators or dependency injections.
///The only property received in the constructor is a [formField] which is
///derived from a [FormFieldModelOld] and contains all the information to
///retrieve and store user response.
///
///This is a stateful widget to manage the state of the [FocusNode] and the
///[TextEditingController] which stores the focus and text property
///respectively.
class PiixStringMultipleSelectDropdownButtonDeprecated
    extends ConsumerStatefulWidget {
  const PiixStringMultipleSelectDropdownButtonDeprecated({
    super.key,
    required this.formField,
  });

  ///A data model that contains all the information to render the [Dialog]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixStringMultipleSelectDropdownButtonDeprecated>
      createState() => _PiixStringMultipleSelectDropdownButtonState();
}

class _PiixStringMultipleSelectDropdownButtonState
    extends ConsumerState<PiixStringMultipleSelectDropdownButtonDeprecated> {
  ///Used to pass and assign values selected from the dialog
  final TextEditingController _controller = TextEditingController();

  ///Used to manage focus on the [TextFormField]
  final FocusNode focusNode = FocusNode();

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  ///Used to contain the widget that shows the [Dialog]
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    focusNode..addListener(_onFocus);
    super.initState();
  }

  @override
  void dispose() {
    //We must dispose the controller to avoid memory leaks
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  ///Retrieves the list of string values that is found inside the property [values]
  ///in a [PiixFormFieldModel].
  ///
  /// Checks if the list is only [String] and then returns it casting it since
  /// [values] is a list of dynamic type.
  /// Currently it can process either a list of only [String] values or a list of
  /// [SelectorModel] values.
  /// Any other type of list returns an empty list.
  List<String> get _stringValues {
    if (!widget.formField.returnId &&
        widget.formField.stringValues.isNotNullOrEmpty) {
      return widget.formField.stringValues!;
    } else if (widget.formField.returnId &&
        widget.formField.values.isNotNullOrEmpty) {
      return widget.formField.values!.map((v) => v.name).toList();
    }
    return [];
  }

  ///Retrieves a list of string [formFieldId] values that is found inside the property [values] in a [PiixFormFieldModel].
  ///
  /// Currently it can only process list of [SelectorModel], any other type of list returns an empty list.
  List<String> get _idValues {
    if (widget.formField.returnId && widget.formField.values.isNotNullOrEmpty) {
      return widget.formField.values!.map((v) => v.id).toList();
    }
    return [];
  }

  FormFieldModelOld get formField => widget.formField;

  //A simple string list of the [stringResponse] split by ','.
  List<String>? get formFieldStringResponses =>
      formField.stringResponse?.split(',');

  //A simple string list of the [idResponse] split by ','.
  List<String>? get formFieldIdResponses => formField.idResponse?.split(',');

  ///Controls showing and cleaning the [OverlayEntry]
  void _onFocus() {
    if (focusNode.hasPrimaryFocus || focusNode.hasFocus) {
      // _overlayEntry = _focusNode.unfocus();
      _overlayEntry = _onShowEntry(MediaQuery.of(context).size);
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _onCleanEntry();
    }
  }

  ///Cleans the [OverlayEntry] only if it is not null,
  ///it also looses focus on the [TextFormField] if it has
  ///primary or normal focus.
  void _onCleanEntry() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      if (focusNode.hasPrimaryFocus || focusNode.hasFocus) {
        focusNode.unfocus();
      }
    }
  }

  ///By receiving the screenSize it creates an [OverlayEntry]
  ///that contains a [PiixCheckBoxLisTileDialogDeprecated].
  ///
  ///This method should not be removed from this.
  OverlayEntry _onShowEntry(Size screenSize) {
    //Obtain the box and dimensions of this
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    ///The height of the [TextFormField]
    final renderBoxHeight = size.height;

    ///The maximum height the card inside the dialog can handle
    final entryHeight = _stringValues.length >= 5
        ? (renderBoxHeight) * 5
        : _stringValues.length * (renderBoxHeight);

    ///Translates the [TextFormField] offset to the screen offset
    final offset = renderBox.localToGlobal(Offset.zero);
    final dy = offset.dy;

    ///The top position for the card inside [PiixCheckBoxLisTileDialog]
    final top =
        obtainTopPosition(renderBoxHeight, entryHeight, dy, screenSize.height);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        top: 0,
        width: screenSize.width,
        child: PiixCheckBoxLisTileDialogDeprecated(
          formField: formField,
          onChecked: _onChanged,
          stringValues: _stringValues,
          top: top,
          left: screenSize.width * 0.025,
          onCleanEntry: _onCleanEntry,
          entryHeight: entryHeight,
          renderBoxHeight: renderBoxHeight,
        ),
      ),
    );
  }

  ///Receives different height parameters and calculates
  ///the top position for the [Card] inside [PiixCheckBoxLisTileDialogDeprecated].
  double obtainTopPosition(
    double renderBoxHeight,
    double entryHeight,
    double dy,
    double screenHeight,
  ) {
    // TODO: Optimize algorithm of calculating top position
    ///The number of times the [TextFormField] height fits above the offset [dy] position.
    final floorDy = (dy / renderBoxHeight).floor();

    ///This condition keeps part of the [Card] from positioning below the screen
    if (dy > screenHeight * 0.85) {
      return dy - (entryHeight - renderBoxHeight ~/ 2);
    }

    ///The number of times the [TextFormField] height fits the card
    final floorEntryHeight = (entryHeight / renderBoxHeight).floor();

    ///This evaluation is to move the [Card] inside [PiixCheckBoxLisTileDialog]
    ///when the [TextFormField] moves downwards by a scrolling of the user.
    if (dy >= screenHeight * 0.33) {
      if (floorDy > 0) {
        ///Evaluation used to keep the [Card] fixed to the scroll offset position
        ///of the [Card]
        if (floorDy < floorEntryHeight) {
          return renderBoxHeight * floorDy;
        }

        ///Evaluation used when the [Card] can appear on top of the
        ///[TextFormField].
        if (floorEntryHeight > 3) {
          return renderBoxHeight * floorEntryHeight - renderBoxHeight;
        }
      }
    }
    return dy;
  }

  ///Receives a value and checks if the value is inside the [StringResponse].
  ///
  ///If the index is found, the value is removed from the [stringResponse] and if
  ///the options need to return an id from the [idResponse].
  ///
  ///It also sets the text in the [_controller].
  void _onChanged(String value) {
    final index = formFieldStringResponses?.indexWhere((v) => v == value) ?? -1;
    var stringResponses = <String>[];
    var idResponses = <String>[];
    //Remove Logic
    if (index > -1) {
      stringResponses = formFieldStringResponses ?? [];
      stringResponses.removeAt(index);
      if (widget.formField.returnId && _idValues.isNotNullOrEmpty) {
        idResponses = formFieldIdResponses ?? [];
        idResponses.removeAt(index);
      }
    }
    //Add Logic
    else if (index == -1) {
      stringResponses = formFieldStringResponses ?? [];
      if (widget.formField.returnId && _idValues.isNotNullOrEmpty) {
        final idIndex = _stringValues.indexWhere((v) => v == value);
        if (idIndex > -1) {
          idResponses = formFieldIdResponses ?? [];
          idResponses.add(_idValues[idIndex]);
        }
      }
      stringResponses.add(value);
    }
    final stringResponse = stringResponses.join(',');
    final newFormField =
        ref.read(formNotifierProvider.notifier).updateFormField(
              formField: widget.formField,
              value: stringResponse.isEmpty ? null : stringResponse,
              type: ResponseType.string,
            );
    if (widget.formField.returnId && _idValues.isNotNullOrEmpty) {
      final idResponse = idResponses.join(',');
      ref.read(formNotifierProvider.notifier).updateFormField(
            formField: newFormField,
            value: idResponse.isEmpty ? null : idResponse,
            type: ResponseType.id,
          );
    }

    _controller.text = stringResponses.join(', ');
  }

  int get maximumLines => 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //TODO: Add color to inkwell
      child: Container(
        margin: EdgeInsets.symmetric(vertical: context.height * 0.0085),
        child: TextFormField(
          enabled: widget.formField.isEditable,
          controller: _controller,
          focusNode: focusNode,
          //TODO: Check if focus should pass to next input
          readOnly: true,
          decoration: decoration(context),
          style: InputStyleUtilsDeprecated.style(
            context,
            isEditable: formField.isEditable,
          ),
          maxLines: maximumLines,
        ),
      ),
    );
  }
}

///An extension used to decorate the [_PiixDateTextFormFieldState] styles, texts and colors
///
/// Use [helperText] if other kind of helper text need to be added.
extension _PiixStringMultipleSelectDropdownButtonDecoration
    on _PiixStringMultipleSelectDropdownButtonState {
  ///Calculates the text based on the properties of the [formField].
  ///The [required] property and the [helperText] property are what defines
  ///what is shown in the [TextFormField].
  String? get helperText {
    String? helperText;
    if (formField.required) {
      helperText = PiixCopiesDeprecated.requiredField + (helperText ?? ' ');
    }
    helperText = (helperText ?? '') +
        'Por favor elige máximo ${formField.maxOptions} opciones.';
    if (formField.helperText.isNotNullEmpty) {
      helperText = helperText + formField.helperText!;
    }
    return helperText;
  }

  String? get errorText {
    if ((formFieldStringResponses ?? []).length > formField.maxOptions) {
      return 'Elige máximo ${formField.maxOptions} opciones.';
    }
    return null;
  }

  InputDecoration decoration(BuildContext context) {
    final splitName = splitTextBy(name: formField.name);
    return InputDecoration(
      enabledBorder: InputDecorationUtilsDeprecated.enabledBorder(hasFocus),
      focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      suffixIcon: Align(
        alignment: Alignment.centerRight,
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Icon(
          Icons.arrow_drop_down,
          color: formField.stringResponse.isNotNullEmpty
              ? PiixColors.azure
              : PiixColors.brownishGrey,
        ),
      ),
      label: Text(
        getTextLabel(splitName, formField.required),
      ),
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
      helperText: helperText,
      helperStyle: InputStyleUtilsDeprecated.helperStyle(
        context,
        hasFocus: hasFocus,
        isEditable: formField.isEditable,
      ),
      errorText: errorText,
    );
  }
}
