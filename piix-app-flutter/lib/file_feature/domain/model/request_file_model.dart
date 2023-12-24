import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_file_model.freezed.dart';

part 'request_file_model.g.dart';


@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class RequestFileModel with _$RequestFileModel {
  @JsonSerializable(explicitToJson: true)
  const RequestFileModel._();
  factory RequestFileModel({
    @JsonKey(required: true) required String userId,
    @JsonKey(required: true) required String filePath,
    String? propertyName,
  }) = _RequestFileModel;

  factory RequestFileModel.fromJson(Map<String, dynamic> json) =>
      _$RequestFileModelFromJson(json);
}
