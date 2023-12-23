import 'package:freezed_annotation/freezed_annotation.dart';

part 'intermediary_fee_model.freezed.dart';

part 'intermediary_fee_model.g.dart';

///This stores all the information pertaining a specific intermediary fee
///
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class IntermediaryFeeModel with _$IntermediaryFeeModel {
  const IntermediaryFeeModel._();

  factory IntermediaryFeeModel({
    @JsonKey(required: true) required String intermediaryFeeId,
    @JsonKey(required: true) required String intermediaryTypeId,
    @JsonKey(required: true) required double feePercent,
  }) = _IntermediaryFeeModel;

  factory IntermediaryFeeModel.fromJson(Map<String, dynamic> json) =>
      _$IntermediaryFeeModelFromJson(json);
}
