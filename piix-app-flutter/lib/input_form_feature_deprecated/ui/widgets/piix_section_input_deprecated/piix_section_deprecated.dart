import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/form_feature/ui/form_field_input_builder_deprecated.dart';
import 'package:piix_mobile/input_form_feature_deprecated/utils/forms_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';

@Deprecated('No longer in use in 6.0')

///The widget can only be used inside a [PiixSectionContainer].
/// The [formField] contains one or more [childFormFields] which call again the
/// [FormFieldInputBuilderDeprecated] widget to render them in the [Form].
class PiixSectionDeprecated extends StatelessWidget {
  const PiixSectionDeprecated({
    Key? key,
    required this.formField,
    this.useExpansionTile = false,
  }) : super(key: key);

  ///A data model that contains all the information to render the [PiixSectionDeprecated]
  final FormFieldModelOld formField;
  final bool useExpansionTile;

  ///Simple [String] interpolation of an '*' after the [SIGNING] if the
  ///[formField] is [required].
  String get requiredName =>
      '${formField.name} ${formField.required ? '*' : ''}';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 8,
      ),
      elevation: 2,
      //Use theme to override current theme, but copy context theme and change
      //divider color
      child: Theme(
        data: context.theme.copyWith(
          dividerColor: Colors.transparent,
        ),
        child: Builder(builder: (context) {
          if (useExpansionTile) {
            return ExpansionTile(
              initiallyExpanded: true,
              maintainState: true,
              iconColor: PiixColors.primaryLight,
              title: Text(
                FormsCopiesDeprecated.clickToShowSection,
                style: context.textTheme?.bodyMedium,
                textAlign: TextAlign.left,
              ),
              tilePadding: EdgeInsets.symmetric(
                horizontal: context.width * 0.013,
              ),
              childrenPadding: EdgeInsets.symmetric(
                horizontal: context.width * 0.035,
                vertical: context.height * 0.0085,
              ),
              children: [
                if (formField.childFormFields.isNotNullOrEmpty)
                  ...formField.childFormFields!.map(
                    (childFormField) => FormFieldInputBuilderDeprecated(
                      formField: childFormField,
                    ),
                  ),
              ],
            );
          }
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.035,
              vertical: context.height * 0.0085,
            ),
            child: Column(
              children: [
                if (formField.childFormFields.isNotNullOrEmpty)
                  ...formField.childFormFields!.map(
                    (childFormField) => FormFieldInputBuilderDeprecated(
                      formField: childFormField,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
