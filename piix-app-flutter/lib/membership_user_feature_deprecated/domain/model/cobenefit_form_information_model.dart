import 'package:freezed_annotation/freezed_annotation.dart';

part 'cobenefit_form_information_model.freezed.dart';
part 'cobenefit_form_information_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class CobenefitFormInformationModel with _$CobenefitFormInformationModel {
  @JsonSerializable(explicitToJson: true)
  const CobenefitFormInformationModel._();

  factory CobenefitFormInformationModel({
    @JsonKey(required: true, name: 'relatedBenefitPerSupplierId')
        required String benefitPerSupplierId,
    @JsonKey(required: true) required String cobenefitPerSupplierId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String benefitFormId,
  }) = _CobenefitFormInformationModel;

  factory CobenefitFormInformationModel.fromJson(Map<String, dynamic> json) =>
      _$CobenefitFormInformationModelFromJson(json);
}
