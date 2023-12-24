import 'package:json_annotation/json_annotation.dart';

part 'form_item_model.g.dart';

///Stores the information that is entered by the user of one field when a form is being filled.
@Deprecated('Use instead PiixFormFieldModel')
@JsonSerializable()
class FormItemModel {
  FormItemModel({
    this.id,
    this.index,
    this.fieldName,
    this.response = '',
    this.dataTypeId,
    this.required = false,
  });

  String? index;
  String? fieldName;
  String? response;
  String? dataTypeId;
  @JsonKey(name: 'formFieldId')
  String? id;
  bool? required;

  factory FormItemModel.fromJson(Map<String, dynamic> json) =>
      _$FormItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormItemModelToJson(this);

  FormItemModel copyWith({
    String? index,
    String? fieldName,
    String? response,
    String? dataTypeId,
    String? id,
    bool? required,
  }) {
    return FormItemModel(
      index: index ?? this.index,
      fieldName: fieldName ?? this.fieldName,
      response: response ?? this.response,
      dataTypeId: dataTypeId ?? this.dataTypeId,
      id: id ?? this.id,
      required: required ?? this.required,
    );
  }
}

@JsonSerializable()
class ListFormItemModel {
  ListFormItemModel({
    required this.formItems,
  });

  final List<FormItemModel> formItems;

  factory ListFormItemModel.fromJson(Map<String, dynamic> json) =>
      _$ListFormItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListFormItemModelToJson(this);

  ListFormItemModel copyWith({
    List<FormItemModel>? formItems,
  }) =>
      ListFormItemModel(formItems: formItems ?? this.formItems);
}
