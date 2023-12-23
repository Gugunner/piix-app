import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/model_type_utils.dart';
import 'package:piix_mobile/membership_benefits_feature/utils/membership_benefits_model_barrel_file.dart';
import 'package:piix_mobile/utils/model_types/membership_benefit_model_types.dart';

part 'parent_benefits_model.freezed.dart';
part 'parent_benefits_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class ParentBenefitsModel with _$ParentBenefitsModel {
  const ParentBenefitsModel._();
  factory ParentBenefitsModel({
    @Default([]) List<ParentBenefitPerSupplierModel> benefitsPerSupplier,
    @JsonKey(name: 'packageCombos')
    @Default([])
        List<ParentBenefitPerSupplierModel> comboBenefitsPerSupplier,
  }) = _ParentBenefitsModel;

  factory ParentBenefitsModel.fromJson(Map<String, dynamic> json) {
    ModelTypeUtils.addType(
        json, 'benefitsPerSupplier', MembershipBenefitModelType.benefit);
    ModelTypeUtils.addType(
        json, 'packageCombos', MembershipBenefitModelType.combo);
    return _$ParentBenefitsModelFromJson(json);
  }
}
