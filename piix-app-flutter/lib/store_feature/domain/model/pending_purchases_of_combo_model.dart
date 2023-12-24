import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_purchases_of_combo_model.freezed.dart';

part 'pending_purchases_of_combo_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class PendingPurchasesOfComboModel with _$PendingPurchasesOfComboModel {
  const PendingPurchasesOfComboModel._();

  factory PendingPurchasesOfComboModel({
    @JsonKey(required: true)
    required String name,
  }) = _PendingPurchasesOfComboModel;

  factory PendingPurchasesOfComboModel.fromJson(Map<String, dynamic> json) =>
      _$PendingPurchasesOfComboModelFromJson(json);
}
