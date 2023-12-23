import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_phone_number_input_deprecated/piix_phone_number_input_dropdown_button_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_phone_number_input_deprecated/piix_phone_number_text_form_field_deprecated.dart';

@Deprecated('Use instead AppOnActionPhoneNumberField')

///Widget used when the app needs to present or ask for telephone number for
///"phoneNumber" dataTypeId formFields [FormFieldModelOld].
///
/// All calculations are made by using getters, if any additional informations
/// is to be inserted, consider
/// using service locators or dependency injections. The only property received
/// by the constructor is a [formField] which is derived from a
/// [FormFieldModelOld] and contains all the information to retrieve and store
///  user responses.
///
/// This do not use any type of [TextEditingController] or [FocusNode] which
/// are not necessary to process any information as this is only used inside
/// predefined forms.
class PiixPhoneNumberInputDeprecated extends StatelessWidget {
  const PiixPhoneNumberInputDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the
  ///[TextFormField]
  final FormFieldModelOld formField;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.only(
              right: context.width * 0.05,
            ),
            width: context.width * 0.15,
            child: PiixPhoneNumberInputDropdownButtonDeprecated(
                formField: formField),
          ),
          Expanded(
            child: PiixPhoneNumberTextFormFieldDeprecated(formField: formField),
          ),
        ],
      ),
    );
  }
}
