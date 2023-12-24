import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/model_type_utils.dart';
import 'package:piix_mobile/membership_benefits_feature/utils/membership_benefits_model_barrel_file.dart';
import 'package:piix_mobile/utils/model_types/membership_benefit_model_types.dart';

part 'last_grade_benefits_model.freezed.dart';
part 'last_grade_benefits_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class LastGradeBenefitsModel with _$LastGradeBenefitsModel {
  @JsonSerializable(explicitToJson: true)
  const LastGradeBenefitsModel._();
  factory LastGradeBenefitsModel({
    @Default([]) List<LastGradeBenefitPerSupplierModel> benefitsPerSupplier,
    @Default([]) List<LastGradeBenefitPerSupplierModel> cobenefitsPerSupplier,
    @Default([])
        List<LastGradeBenefitPerSupplierModel> additionalBenefitsPerSupplier,
  }) = _LastGradeBenefitsModel;

  factory LastGradeBenefitsModel.fromJson(Map<String, dynamic> json) {
    ModelTypeUtils.addType(
        json, 'benefitsPerSupplier', MembershipBenefitModelType.benefit);
    ModelTypeUtils.addType(
        json, 'cobenefitsPerSupplier', MembershipBenefitModelType.cobenefit);
    ModelTypeUtils.addType(json, 'additionalBenefitsPerSupplier',
        MembershipBenefitModelType.additional);
    return _$LastGradeBenefitsModelFromJson(json);
  }

  List<LastGradeBenefitPerSupplierModel> get allBenefits => [
        ...benefitsPerSupplier,
        ...cobenefitsPerSupplier,
        ...additionalBenefitsPerSupplier
      ];
}
