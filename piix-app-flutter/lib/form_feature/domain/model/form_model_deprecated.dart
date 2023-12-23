import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/utils/date_util.dart';
import 'package:piix_mobile/utils/list_utils.dart';

part 'form_model_deprecated.freezed.dart';
part 'form_model_deprecated.g.dart';

@Deprecated('Use instead FormModel')
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class FormModelOld with _$FormModelOld {
  @JsonSerializable(explicitToJson: true)
  const FormModelOld._();

  factory FormModelOld({
    required String formId,
    required String name,
    required List<FormFieldModelOld> formFields,
    required String jsonId,
    @JsonKey(
      fromJson: toDateTime,
      toJson: toIsoString,
    )
    DateTime? registerDate,
    @Default(false) bool requiresSignature,
  }) = _PiixFormModel;

  ///Homologizes all ids of a form to be stored in [jsonId]
  ///and the value to be stored in [formId].
  static void _addJsonId(Map<String, dynamic> json) {
    final jsonIndex =
        json.entries.toList().indexWhere((entry) => entry.key.contains('Id'));
    if (jsonIndex > -1) {
      final jsonEntry = json.entries.elementAt(jsonIndex);
      json['formId'] = jsonEntry.value;
      json['jsonId'] = jsonEntry.key;
    }
  }

  ///Returns original property id from [jsonId] and assigns it the value of
  ///[formId].
  ///Removes the property "jsonId" from then [json].
  static void _returnJsonId(Map<String, dynamic> json, FormModelOld instance) {
    json[instance.jsonId] = instance.formId;
    json.remove('formId');
  }

  static void _addIndexProperty(Map<String, dynamic> json) {
    for (var i = 0; i < (json['formFields'] as List<dynamic>).length; i++) {
      json['formFields'][i]['index'] = i;
    }
  }

  factory FormModelOld.fromJson(Map<String, dynamic> json) {
    _addJsonId(json);
    _addIndexProperty(json);
    return _$FormModelOldFromJson(json);
  }

  Map<String, dynamic> toCustomJson() {
    final json = toJson();
    _returnJsonId(json, this);
    return json;
  }
}

@Deprecated('Will be removed in 4.0')
extension PiixFormModelMutableDeprecated on FormModelOld {
  @Deprecated('Will be removed in 4.0')
  FormModelOld setFormFields(List<FormFieldModelOld> formFields) {
    return copyWith(formFields: formFields);
  }

  @Deprecated('Will be removed in 4.0')
  FormModelOld removeFormFieldBy(FormFieldModelOld oldFormField) {
    final filteredFormFields =
        formFields.where((formField) => formField != oldFormField).toList();
    return setFormFields(filteredFormFields);
  }

  @Deprecated('Will be removed in 4.0')

  ///Returns the response of the corresponding [formFieldId] if it is found
  ///if not a null value is returned.
  String? formFieldResponseBy(String formFieldId) {
    final index = formFields
        .indexWhere((formField) => formField.formFieldId == formFieldId);
    if (index < 0) return null;
    final formField = formFields[index];
    if (formField.isUniqueSelectFormField) {
      return formField.idResponse;
    }
    if (formField.dataTypeId == ConstantsDeprecated.phoneType) {
      final newStringResponse = formField.stringResponse
          ?.replaceAll(formField.otherResponse ?? '', '');
      return '${formField.otherResponse}$newStringResponse';
    }
    return formField.stringResponse;
  }

  @Deprecated('Will be removed in 4.0')
  FormFieldModelOld? formFieldBy(String formFieldId) {
    try {
      return formFields
          .firstWhere((formField) => formField.formFieldId == formFieldId);
    } catch (_) {
      return null;
    }
  }

  @Deprecated('Will be removed in 4.0')
  FormModelOld replaceFormFieldBy(FormFieldModelOld newFormField) {
    final index =
        formFields.indexWhere((formField) => formField == newFormField);
    if (index < 0) return this;
    final newFormFields =
        formFields.updateIndexValue(index, value: newFormField);
    return setFormFields(newFormFields);
  }
}
