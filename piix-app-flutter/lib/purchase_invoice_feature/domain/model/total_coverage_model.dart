import 'package:freezed_annotation/freezed_annotation.dart';

part 'total_coverage_model.freezed.dart';

part 'total_coverage_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class TotalCoverageModel with _$TotalCoverageModel {
  const TotalCoverageModel._();

  factory TotalCoverageModel({
    @JsonKey(required: true) required double totalCoverageEvents,
    @JsonKey(required: true) required double totalCoverageSumInsured,
  }) = _TotalCoverageModel;

  factory TotalCoverageModel.fromJson(Map<String, dynamic> json) =>
      _$TotalCoverageModelFromJson(json);
}
