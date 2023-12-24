import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/store_feature/domain/model/benefit_per_supplier_coverage_model_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/level_model.dart';

part 'purchased_levels_model.freezed.dart';

part 'purchased_levels_model.g.dart';

///This stores all the information pertaining a level list and membership level
///benefits
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class PurchasedLevelsModel with _$PurchasedLevelsModel {
  const PurchasedLevelsModel._();
  factory PurchasedLevelsModel({
    @JsonKey(required: true, readValue: addDefaultType)
    required List<LevelModel> levelList,
    @JsonKey(required: true, readValue: addLevelType)
    required List<BenefitPerSupplierCoverageModel> membershipBenefits,
  }) = _PurchasedLevelsModel;

  factory PurchasedLevelsModel.fromJson(Map<String, dynamic> json) =>
      _$PurchasedLevelsModelFromJson(json);
}
