import 'package:freezed_annotation/freezed_annotation.dart';

part 'benefit_model.freezed.dart';

part 'benefit_model.g.dart';

/// This class is used as a response model to map the information of 
/// a [BenefitModel], all the fields are optional since it is obtained 
/// from an http request.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class BenefitModel with _$BenefitModel {
  const BenefitModel._();

  factory BenefitModel({
    @JsonKey(required: true) required String benefitId,
    @JsonKey(required: true) required String name,
    @Default('') String benefitImage,
    @Default([]) List<String> haveGuide,
    @Default([]) List<String> askGuide,
    @Default([]) List<String> considerGuide,
  }) = _BenefitModel;

  factory BenefitModel.fromJson(Map<String, dynamic> json) =>
      _$BenefitModelFromJson(json);
}
