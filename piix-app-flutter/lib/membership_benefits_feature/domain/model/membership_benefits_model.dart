import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/membership_benefits_feature/utils/membership_benefits_model_barrel_file.dart';

part 'membership_benefits_model.freezed.dart';
part 'membership_benefits_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class MembershipBenefitsModel with _$MembershipBenefitsModel {
  @JsonSerializable(explicitToJson: true)
  const MembershipBenefitsModel._();
  factory MembershipBenefitsModel.benefitDetailList({
    @JsonKey(required: true) required LastGradeBenefitsModel lastGradeBenefits,
    @JsonKey(required: true)
        required ParentBenefitsModel parentBenefits,
  }) = _MembershipBenefitsDetailListModel;

  factory MembershipBenefitsModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipBenefitsModelFromJson(json);
}
