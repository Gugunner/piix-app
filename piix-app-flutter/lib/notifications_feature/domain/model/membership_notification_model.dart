import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/notifications_feature/domain/model/open_ticket_notification_model.dart';
import 'package:piix_mobile/notifications_feature/domain/model/pending_benefit_form_notification_model.dart';
import 'package:piix_mobile/notifications_feature/domain/model/pending_invoice_notification_model.dart';
import 'package:piix_mobile/notifications_feature/domain/model/protected_slot_notification_model.dart';

part 'membership_notification_model.freezed.dart';
part 'membership_notification_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  unionKey: 'modelType',
)
class MembershipNotificationModel with _$MembershipNotificationModel {
  @JsonSerializable(explicitToJson: true)
  const MembershipNotificationModel._();

  factory MembershipNotificationModel.notificationList({
    @JsonKey(required: true)
        required List<PendingBenefitFormNotificationModel> pendingBenefitForms,
    @JsonKey(required: true)
        required List<PendingInvoiceNotificationModel> pendingInvoices,
    @JsonKey(required: true)
        required List<ProtectedSlotNotificationModel> protectedSlots,
    @JsonKey(required: true)
        required List<OpenTicketNotificationModel> openTickets,
  }) = _MembershipNotificationModel;

  factory MembershipNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$MembershipNotificationModelFromJson(json);

  int get count =>
      pendingBenefitForms.length +
      pendingInvoices.length +
      protectedSlots.length +
      openTickets.length;

  int get protectedNotificationCount => protectedSlots.length;
}
