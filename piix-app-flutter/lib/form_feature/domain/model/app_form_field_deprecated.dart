import 'package:equatable/equatable.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

@Deprecated('Use instead BaseFormFieldModel')
///The base class used for any [FormFieldModel] class or subclass used
abstract class AppFormFieldDeprecated extends Equatable {
  const AppFormFieldDeprecated({
    this.dataTypeId = '',
    this.formFieldId = '',
    this.name = '',
    this.required = true,
    this.isEditable = true,
    this.isArray = false,
    this.isMultiple = false,
    this.includesOtherOption = false,
    this.returnId = false,
  });

  ///Properties that are always included in service
  final String formFieldId;
  final String dataTypeId;
  final String name;
  final bool required;
  final bool isEditable;
  final bool isArray;
  final bool isMultiple;
  final bool includesOtherOption;
  final bool returnId;

  ///The list of properties that are used to compare
  ///instances of [AppFormFieldDeprecated]
  @override
  List<Object?> get props => [dataTypeId, formFieldId];

  ///Checks if the selected option is unique
  bool get isUniqueSelectFormField =>
      dataTypeId == ConstantsDeprecated.stringType &&
      isArray &&
      !isMultiple &&
      returnId;
}
