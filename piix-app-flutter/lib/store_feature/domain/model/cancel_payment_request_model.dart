import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_payment_request_model.freezed.dart';

part 'cancel_payment_request_model.g.dart';

///This stores all the information pertaining a specific intermediary fee
///
@Freezed(
  copyWith: true,
  fromJson: false,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class CancelPaymentRequestModel with _$CancelPaymentRequestModel {
    @JsonSerializable(explicitToJson: true)
  
  const CancelPaymentRequestModel._();

  factory CancelPaymentRequestModel({
    required String purchaseInvoiceId,
    required String userId,
  }) = _CancelPaymentRequestModel;
}
