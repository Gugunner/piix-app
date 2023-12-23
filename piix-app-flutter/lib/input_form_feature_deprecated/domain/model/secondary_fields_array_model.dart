import 'package:json_annotation/json_annotation.dart';
import 'package:piix_mobile/form_feature/domain/model/form_field_model_deprecated.dart';

part 'secondary_fields_array_model.g.dart';

@JsonSerializable()
class SecondaryFieldsArrayModel {
  SecondaryFieldsArrayModel({
    required this.dataTypeId,
    required this.name,
    required this.childFormFields,
  });

  final String dataTypeId;
  final String name;
  List<FormFieldModelOld> childFormFields;

  factory SecondaryFieldsArrayModel.fromJson(Map<String, dynamic> json) =>
      _$SecondaryFieldsArrayModelFromJson(json);

  Map<String, dynamic> toJson() => _$SecondaryFieldsArrayModelToJson(this);
}
