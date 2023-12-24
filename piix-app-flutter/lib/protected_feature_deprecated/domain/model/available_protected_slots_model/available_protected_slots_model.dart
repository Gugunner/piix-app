import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/available_protected_slots_model/slots_model.dart';
import 'package:piix_mobile/protected_feature_deprecated/domain/model/protected_model.dart';

part 'available_protected_slots_model.freezed.dart';
part 'available_protected_slots_model.g.dart';

@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: false,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class AvailableProtectedSlotsModel with _$AvailableProtectedSlotsModel {
  const AvailableProtectedSlotsModel._();
  factory AvailableProtectedSlotsModel({
    @JsonKey(required: true) required SlotsModel slots,
    required List<ProtectedModel> protected,
    @Default(false) bool canAddProtected,
  }) = _AvailableProtectedSlotsModel;

  factory AvailableProtectedSlotsModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableProtectedSlotsModelFromJson(json);
}
