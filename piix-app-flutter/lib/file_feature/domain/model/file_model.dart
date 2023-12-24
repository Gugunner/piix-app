import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/file_feature/domain/model/file_content_model.dart';

part 'file_model.freezed.dart';

part 'file_model.g.dart';

///This class contains info for file field.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class FileModel with _$FileModel {
  const FileModel._();

  factory FileModel({
    FileContentModel? fileContent,
  }) = _FileModel;

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);
}
