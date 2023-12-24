import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';

part 'answer_model.freezed.dart';
part 'answer_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class AnswerModel with _$AnswerModel {
  @JsonSerializable(explicitToJson: true)
  const AnswerModel._();

  factory AnswerModel({
    @JsonKey(required: true) required String formFieldId,
    @JsonKey(required: true) required String dataTypeId,
    @JsonKey(required: true) answer,
    @JsonKey(includeToJson: false) @Default(true) bool required,
    @JsonKey(includeToJson: false) @Default(-1) int index,
  }) = _AnswerModel;

  //TODO: Add AnswerModel.phone if required

  factory AnswerModel.s3({
    @JsonKey(required: true) required String formFieldId,
    @JsonKey(required: true) required String dataTypeId,
    @JsonKey(required: true) answer,
    @JsonKey(includeToJson: false) S3FileModel? s3File,
    @JsonKey(includeToJson: false) @Default(true) bool required,
    @JsonKey(includeToJson: false) @Default(-1) int index,
    @JsonKey(includeToJson: false, includeFromJson: false) FileContentModel? fileContent,
  }) = _AnswerS3Model;

  AnswerModel toAnswerS3Model([FileContentModel? fileContent]) {
    return AnswerModel.s3(
      formFieldId: formFieldId,
      dataTypeId: dataTypeId,
      answer: answer,
      required: this.required,
      index: index,
      fileContent: fileContent,
    );
  }
}
