import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';

part 'pending_invoice_notification_model.freezed.dart';
part 'pending_invoice_notification_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  unionKey: 'modelType',
)
class PendingInvoiceNotificationModel with _$PendingInvoiceNotificationModel {
  @JsonSerializable(explicitToJson: true)
  const PendingInvoiceNotificationModel._();

  factory PendingInvoiceNotificationModel({
    @JsonKey(required: true) required String purchaseInvoiceId,
    @JsonKey(required: true) required bool earlyExpiration,
    @JsonKey(required: true) required ProductTypeDeprecated productType,
    @JsonKey(required: true) required String productName,
    @Default(false) bool showNotification,
  }) = _PendingInvoiceNotificationModel;

  factory PendingInvoiceNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$PendingInvoiceNotificationModelFromJson(json);
}
