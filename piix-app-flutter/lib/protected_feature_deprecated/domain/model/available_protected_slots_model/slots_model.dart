import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/available_protected_slots_model/protected_slot_model.dart';

part 'slots_model.freezed.dart';
part 'slots_model.g.dart';

@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: false,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class SlotsModel with _$SlotsModel {
  const SlotsModel._();

  factory SlotsModel({
    @Default(0) int totalAvailableSlots,
    @Default(0) int totalUsedSlots,
    List<ProtectedSlotModel>? protectedSlots,
  }) = _SlotsModel;

  factory SlotsModel.fromJson(Map<String, dynamic> json) =>
      _$SlotsModelFromJson(json);
}
