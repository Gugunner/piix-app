import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/form_feature/form_model_barrel_file.dart';

part 'request_form_model.freezed.dart';
part 'request_form_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: false,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class RequestFormModel with _$RequestFormModel {
  @JsonSerializable(explicitToJson: true)
  const RequestFormModel._();

  factory RequestFormModel({
    @JsonKey(required: true, name: 'mainUserInfoFormId') required String formId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required List<FormFieldModel> formFields,
    @JsonKey(required: true) required DateTime registerDate,
    bool? editable,
  }) = _RequestFormModel;

  factory RequestFormModel.fromJson(Map<String, dynamic> json) =>
      _$RequestFormModelFromJson(json);
}
