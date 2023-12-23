import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/input_form_feature_deprecated/ui/widgets/piix_section_input_deprecated/piix_section_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/forms_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';

@Deprecated('Will be removed in 6.0')

///Widget use to group formFields that belong to the same category, the
///formFields are found inside a [formField] of dataTypeId "section".
///
/// All calculations are made by using getters, if any additional information
/// is to be inserted, consider using service locators or dependency injections.
/// The only property received in the constructor is a [formField] which is
/// derived from a [FormFieldModelOld] and contains all the information to
/// retrieve and store user response.
class PiixSectionContainerDeprecated extends StatelessWidget {
  const PiixSectionContainerDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the [PiixSectionDeprecated]
  final FormFieldModelOld formField;

  ///Checks if any of the [childFormField] is [required]
  bool get requiredFields =>
      formField.childFormFields.isNotNullOrEmpty &&
      formField.childFormFields!.any((formField) => formField.required);

  ///Simple [String] interpolation of an '*' after the [SIGNING] if the
  ///[formField] is [required].
  String get requiredName => '${formField.name} ${requiredFields ? '*' : ''}';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.height * 0.0085,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${FormsCopiesDeprecated.sectionLabel} ${formField.name}',
            style: context.primaryTextTheme?.displayMedium,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 8.h,
          ),
          PiixSectionDeprecated(formField: formField)
        ],
      ),
    );
  }
}
