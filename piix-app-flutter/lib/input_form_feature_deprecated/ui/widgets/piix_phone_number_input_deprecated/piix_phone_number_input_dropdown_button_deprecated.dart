import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/form_feature/domain/provider/form_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_phone_number_input_deprecated/piix_phone_number_input_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_decoration_utils_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/input_styles_utils_deprecated.dart';

@Deprecated('No longer in use in 4.0')

///Widget used specifically to select an international phone code generally
///known as lada for "phoneNumber" dataTypeId formFields [FormFieldModelOld].
///
/// This cannot be used independently and alway needs to be a child widget of
/// [PiixPhoneNumberInputDeprecated].
/// All calculations are made by using getters, if any additional information
/// is to be inserted, consider using service locators or dependency injections.
/// The only property received in the constructor is a [formField]which is
/// derived from a [FormFieldModelOld] and contains all the information to
/// retrieve and store user response.
class PiixPhoneNumberInputDropdownButtonDeprecated
    extends ConsumerStatefulWidget {
  const PiixPhoneNumberInputDropdownButtonDeprecated({
    super.key,
    required this.formField,
  });

  ///A data model that contains all the information to render the
  ///[DropdownButtonFormField]
  final FormFieldModelOld formField;

  @override
  ConsumerState<PiixPhoneNumberInputDropdownButtonDeprecated> createState() =>
      _PiixPhoneNumberInputDropdownButtonState();
}

class _PiixPhoneNumberInputDropdownButtonState
    extends ConsumerState<PiixPhoneNumberInputDropdownButtonDeprecated> {
  final focusNode = FocusNode();

  FormFieldModelOld get formField => widget.formField;

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  @override
  void initState() {
    focusNode.addListener(_onChangeFocus);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ConstantsDeprecated.ladas.length == 1) {
        final newFormField =
            formField.setOtherResponse(ConstantsDeprecated.ladas.first);
        ref.read(formNotifierProvider.notifier).replaceFormField(newFormField);
      }
    });
    super.initState();
  }

  void _onChangeFocus() {
    debugPrint('Has primary Focus ${formField.formFieldId} - '
        '${focusNode.hasPrimaryFocus}');
    debugPrint('Has Focus ${formField.formFieldId} - '
        '${focusNode.hasFocus}');
    setState(() {});
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  ///Updates the international phone code in the response if the symbol "+" is
  ///missing from [lada] it concatenates it, when [lada] is null it cleans the
  ///value inside [otherResponse] property of [widget.formField].
  ///
  void updateLadaInPhoneNumber(String? lada) {
    ref.read(formNotifierProvider.notifier).updateFormField(
        formField: widget.formField,
        value:
            '${lada.isNotNullEmpty && lada!.contains('+') ? lada : '+$lada'}',
        type: ResponseType.other);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      focusNode: focusNode,
      isDense: false,
      items: _dropdownItems(context),
      onChanged:
          _dropdownItems(context).length > 1 && widget.formField.isEditable
              ? updateLadaInPhoneNumber
              : null,
      value: widget.formField.otherResponse,
      decoration: decoration(context),
      style: InputStyleUtilsDeprecated.style(
        context,
        isEditable: formField.isEditable,
      ),
      icon: Align(
        alignment: Alignment.centerRight,
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Icon(
          Icons.arrow_drop_down,
          color: hasFocus ? PiixColors.insurance : PiixColors.infoDefault,
        ),
      ),
    );
  }
}

///An extension used to decorate the [PiixPhoneNumberInputDropdownButtonDeprecated]
///styles, texts and colors
extension _PiixPhoneNumberInputDropdownButtonDecoration
    on _PiixPhoneNumberInputDropdownButtonState {
  InputDecoration decoration(BuildContext context) => InputDecoration(
        border: InputDecorationUtilsDeprecated.border(hasFocus),
        enabledBorder: InputDecorationUtilsDeprecated.enabledBorder(hasFocus),
        focusedBorder: InputDecorationUtilsDeprecated.focusedBorder,
        contentPadding: EdgeInsets.only(
          top: 4.sp,
          bottom: -1.sp,
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
        labelText: '${PiixCopiesDeprecated.areaCode}*',
        helperStyle: InputStyleUtilsDeprecated.helperStyle(
          context,
          hasFocus: hasFocus,
          isEditable: formField.isEditable,
        ),
      );
}

///An extension used to obtain the [_dropdownItems] list for [PiixPhoneNumberInputDropdownButtonDeprecated].
extension _PiixPhoneNumberInputDropdownButtonMenuItem
    on _PiixPhoneNumberInputDropdownButtonState {
  //TODO: Add html unicode flag for each country when expanding the app to other places
  List<DropdownMenuItem<String>> _dropdownItems(BuildContext context) =>
      ConstantsDeprecated.ladas
          .map(
            (lada) => DropdownMenuItem<String>(
              child: Text(lada),
              value: lada,
              alignment: Alignment.center,
            ),
          )
          .toList();
}
