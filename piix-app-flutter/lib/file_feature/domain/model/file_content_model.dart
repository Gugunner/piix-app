import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_content_model.freezed.dart';

part 'file_content_model.g.dart';

///This class contains info for file content
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class FileContentModel with _$FileContentModel {
  const FileContentModel._();

  factory FileContentModel({
    @JsonKey(required: true)
    required String name,
    @JsonKey(required: true)
    required String contentType,
    @JsonKey(required: true)
    required String base64Content,
  }) = _FileContentModel;

  factory FileContentModel.fromJson(Map<String, dynamic> json) =>
      _$FileContentModelFromJson(json);

}
