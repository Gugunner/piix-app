import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/benefit_type_enum.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/branch_type_enum.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';

part 'benefit_type_model.freezed.dart';

part 'benefit_type_model.g.dart';

///This class contains benefit type Id and type name of benefit.
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class BenefitTypeModel with _$BenefitTypeModel {
  const BenefitTypeModel._();

  factory BenefitTypeModel({
    @JsonKey(required: true, name: 'benefitTypeId')
        required BenefitType benefitType,
    @JsonKey(required: true)
        required String name,
    //TODO: Remove readValue
    @JsonKey(
      required: true,
      name: 'branchTypeId',
      readValue: addBranchTypeEmergencyOption,
    )
        required BranchType branchType,
  }) = _BenefitTypeModel;

  factory BenefitTypeModel.fromJson(Map<String, dynamic> json) =>
      _$BenefitTypeModelFromJson(json);
}
