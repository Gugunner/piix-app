import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method_model.freezed.dart';

part 'payment_method_model.g.dart';

///This class is used as a response model to map the information of a
///[PaymentMethodModel], all the fields are optional since it is obtained from
///a http request.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class PaymentMethodModel with _$PaymentMethodModel {
  const PaymentMethodModel._();
  factory PaymentMethodModel({
    @JsonKey(required: true) required String id,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String paymentTypeId,
    @JsonKey(required: true) required String secureThumbnail,
    @JsonKey(required: true) required String thumbnail,
    @JsonKey(required: true) required double minAllowedAmount,
    @JsonKey(required: true) required double maxAllowedAmount,
    @JsonKey(required: true) required int accreditationTime,
    @Default([]) List<dynamic> settings,
    @Default([]) List<String> additionalInfoNeeded,
  }) = _PaymentMethodModel;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
}
