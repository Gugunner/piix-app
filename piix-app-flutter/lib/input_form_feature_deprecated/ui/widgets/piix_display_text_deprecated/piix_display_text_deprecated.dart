import 'package:flutter/material.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 6.0')

///Widget uses as a general [Text] to display the stringResponse for
///"display" dataTypeId formFields [FormFieldModelOld].
///
/// The only property received in the constructor is a [formField] which
/// is derived from a [FormFieldModelOld] and contains all the information
/// to retrieve and store user response.
class PiixDisplayTextDeprecated extends StatelessWidget {
  const PiixDisplayTextDeprecated({
    Key? key,
    required this.formField,
  }) : super(key: key);

  ///A data model that contains all the information to render the [Text].
  final FormFieldModelOld formField;

  TextStyle? style(BuildContext context) => context.textTheme?.titleMedium;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.height * 0.0085),
      width: context.width,
      child: Text(
        formField.stringResponse ?? '',
        style: style(context),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
