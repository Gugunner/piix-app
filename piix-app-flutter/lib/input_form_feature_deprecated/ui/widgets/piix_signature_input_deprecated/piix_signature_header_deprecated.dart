import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 6.0')
//TODO: Add documentation
class PiixSignatureHeaderDeprecated extends StatelessWidget {
  const PiixSignatureHeaderDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the [PiixSignatureFormField]
  final FormFieldModelOld formField;

  //TODO: Explain getter
  String get signatureHeader =>
      '${formField.name} ${formField.required ? '*' : ''}';

  //TODO: Explain getter
  String get signatureGuideline {
    switch (formField.signatureType) {
      case SignatureType.SIGNING:
        return PiixCopiesDeprecated.signatureNameGuideline;
      case SignatureType.NAME_AND_PLACE:
      default:
        return PiixCopiesDeprecated.signatureDAndPGuideline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          signatureHeader,
          style: context.primaryTextTheme?.titleMedium,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: context.height * 0.017),
          child: Text(
            signatureGuideline,
            textAlign: TextAlign.justify,
            style: context.textTheme?.bodyMedium,
          ),
        ),
      ],
    );
  }
}
