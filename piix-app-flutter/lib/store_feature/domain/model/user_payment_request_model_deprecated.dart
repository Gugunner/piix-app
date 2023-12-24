import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/store_feature/domain/model/payer_model_deprecated.dart';

part 'user_payment_request_model_deprecated.freezed.dart';

part 'user_payment_request_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///This stores all the information pertaining a user payment request
@Freezed(
    copyWith: true,
    fromJson: false,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class UserPaymentRequestModel with _$UserPaymentRequestModel {
  @JsonSerializable(explicitToJson: true)
  const UserPaymentRequestModel._();
  factory UserPaymentRequestModel({
    required String userId,
    required String packageId,
    required String paymentMethodId,
    required String userQuotationId,
    required double transactionAmount,
    required PayerModel payer,
  }) = _UserPaymentRequestModel;
}
