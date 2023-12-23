import 'package:freezed_annotation/freezed_annotation.dart';

part 's3_file_model.freezed.dart';

part 's3_file_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class S3FileModel with _$S3FileModel {
  const S3FileModel._();

  factory S3FileModel({
    @JsonKey(required: true)
    required String fileFullRoute,
    @JsonKey(required: true)
    required String fileContentType,
    @JsonKey(required: true)
    required String fileObjectData,
    @JsonKey(required: true)
    required String userId,
  }) = _S3FileModel;

  
  factory S3FileModel.fromJson(Map<String, dynamic> json) =>
      _$S3FileModelFromJson(json);

}
