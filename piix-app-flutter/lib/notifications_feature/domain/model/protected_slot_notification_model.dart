import 'package:freezed_annotation/freezed_annotation.dart';

part 'protected_slot_notification_model.freezed.dart';
part 'protected_slot_notification_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  unionKey: 'modelType',
)
class ProtectedSlotNotificationModel with _$ProtectedSlotNotificationModel {
  @JsonSerializable(explicitToJson: true)
  const ProtectedSlotNotificationModel._();

  factory ProtectedSlotNotificationModel({
    @JsonKey(required: true)
    required String planId,
    @JsonKey(required: true)
    required String planName,
    @JsonKey(required: true)
    required int slots,
  }) = _ProtectedSlotNotificationModel;

  factory ProtectedSlotNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ProtectedSlotNotificationModelFromJson(json);
}
