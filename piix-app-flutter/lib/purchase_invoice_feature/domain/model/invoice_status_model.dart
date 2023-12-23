//Use for controlling the invoice shown to the user
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/constants_deprecated/purchase_invoice_copies_deprecated.dart';

part 'invoice_status_model.freezed.dart';
part 'invoice_status_model.g.dart';

enum InvoiceStatus {
  //A new payment line is created
  created,
  //The payment line is waiting payment (happens after
  //4 hours of creating the Invoice)
  awaitingPayment,
  //The payment line has expired and the Invoice can no longer be paid
  expired,
  //Payment was not authorized by provider
  bounced,
  //The payment is being processed  (happens when
  //payment provider is processing the payment)
  paymentInProcess,
  //The payment provider cancelled the operation and the Invoice
  //is cancelled
  canceled,
  //The payment is being mediated by the payment
  //payment provider to see if it is refunded or not
  paymentInMediation,
  //The payment was refunded and the Invoice sets a final state
  refunded,
  //Payment was made by the user and approved by the payment provider
  paid,
  //Payment is approved and the product is in the process
  //of activating (4 hours after user paid the product)
  awaitingFulfilment,
  //The payment has been approved and the product has been activated
  //(even if later is inactive),
  fullfilled,
  //Default value when no recognized status is available
  unknown,
}

@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: false,
    makeCollectionsUnmodifiable: true,
    unionKey: 'modelType')
class InvoiceStatusModel with _$InvoiceStatusModel {
  const InvoiceStatusModel._();
  //Default value when no recognized status is available
  factory InvoiceStatusModel({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _InvoiceStatusModel;
  //A new payment line is created
  factory InvoiceStatusModel.created({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _CreatedInvoiceStatusModel;
  //The payment line is waiting payment (happens after
  //4 hours of creating the Invoice)
  factory InvoiceStatusModel.awaitingPayment({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _AwaitingPaymentInvoiceStatusModel;
  //The payment line has expired and the Invoice can no longer be paid
  factory InvoiceStatusModel.expired({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _ExpiredInvoiceStatusModel;
  //Payment was not authorized by provider
  factory InvoiceStatusModel.bounced({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _BouncedInvoiceStatusModel;
  //The payment is being processed  (happens when
  //payment provider is processing the payment)
  factory InvoiceStatusModel.paymentInProcess({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _PaymentInProcessInvoiceStatusModel;
  //The payment provider cancelled the operation and the Invoice
  //is cancelled
  factory InvoiceStatusModel.canceled({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _CanceledInvoiceStatusModel;
  //The payment is being mediated by the payment
  //payment provider to see if it is refunded or not
  factory InvoiceStatusModel.paymentInMediation({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _PaymentInMediationInvoiceStatusModel;
  //The payment was refunded and the Invoice sets a final state
  factory InvoiceStatusModel.refunded({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _RefundedInvoiceStatusModel;
  //Payment was made by the user and approved by the payment provider
  factory InvoiceStatusModel.paid({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _PaidInvoiceStatusModel;
  //Payment is approved and the product is in the process
  //of activating (4 hours after user paid the product)
  factory InvoiceStatusModel.awaitingFulfilment({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _AwaitingFulfilmentInvoiceStatusModel;
  //The payment has been approved and the product has been activated
  //(even if later is inactive),
  factory InvoiceStatusModel.fullfilled({
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required InvoiceStatus status,
  }) = _FulfilledInvoiceStatusModel;

  factory InvoiceStatusModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceStatusModelFromJson(json);

  String get paymentInvoiceTextStatus => map(
        (_) => '',
        created: (_) => PurchaseInvoiceCopiesDeprecated.orderCreatedLabel,
        awaitingPayment: (_) =>
            PurchaseInvoiceCopiesDeprecated.pendingPaymentLabel,
        expired: (_) => PurchaseInvoiceCopiesDeprecated.expiredPaymentLabel,
        bounced: (_) => PurchaseInvoiceCopiesDeprecated.rejectedPaymentLabel,
        paymentInProcess: (_) =>
            PurchaseInvoiceCopiesDeprecated.paymentInProcessLabel,
        canceled: (_) => PurchaseInvoiceCopiesDeprecated.canceledPaymentLabel,
        paymentInMediation: (_) =>
            PurchaseInvoiceCopiesDeprecated.paymentInMediationLabel,
        refunded: (_) => PurchaseInvoiceCopiesDeprecated.refundedPaymentLabel,
        paid: (_) => PurchaseInvoiceCopiesDeprecated.paidPaymentLabel,
        awaitingFulfilment: (_) =>
            PurchaseInvoiceCopiesDeprecated.paidPaymentLabel,
        fullfilled: (_) => PurchaseInvoiceCopiesDeprecated.paidPaymentLabel,
      );

  String get actionText => map(
        (_) => '',
        created: (_) => PurchaseInvoiceCopiesDeprecated.viewPaymentLine,
        awaitingPayment: (_) => PurchaseInvoiceCopiesDeprecated.viewPaymentLine,
        expired: (_) => PurchaseInvoiceCopiesDeprecated.reQuoteLabel,
        bounced: (_) => PurchaseInvoiceCopiesDeprecated.reQuoteLabel,
        paymentInProcess: (_) =>
            PurchaseInvoiceCopiesDeprecated.viewPaymentLine,
        canceled: (_) => PurchaseInvoiceCopiesDeprecated.reQuoteLabel,
        paymentInMediation: (_) =>
            PurchaseInvoiceCopiesDeprecated.viewPaymentLine,
        refunded: (_) => PurchaseInvoiceCopiesDeprecated.exploreMoreProducts,
        paid: (_) => PurchaseInvoiceCopiesDeprecated.exploreMoreProducts,
        awaitingFulfilment: (_) =>
            PurchaseInvoiceCopiesDeprecated.exploreMoreProducts,
        fullfilled: (_) => PurchaseInvoiceCopiesDeprecated.exploreMoreProducts,
      );

  bool get paymentAvailable => maybeMap(
        (value) => false,
        created: (_) => true,
        awaitingPayment: (_) => true,
        orElse: () => false,
      );
}
