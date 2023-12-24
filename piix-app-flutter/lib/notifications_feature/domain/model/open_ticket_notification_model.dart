import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_ticket_notification_model.freezed.dart';
part 'open_ticket_notification_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  unionKey: 'modelType',
)
class OpenTicketNotificationModel with _$OpenTicketNotificationModel {
  @JsonSerializable(explicitToJson: true)
  const OpenTicketNotificationModel._();

  factory OpenTicketNotificationModel({
    @JsonKey(required: true) required String ticketId,
    String? benefitName,
    @Default(false) bool showNotification,
  }) = _OpenTicketNotificationModel;

  factory OpenTicketNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$OpenTicketNotificationModelFromJson(json);
}
