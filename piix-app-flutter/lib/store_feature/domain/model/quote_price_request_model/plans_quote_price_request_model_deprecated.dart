import 'package:freezed_annotation/freezed_annotation.dart';

part 'plans_quote_price_request_model_deprecated.freezed.dart';

part 'plans_quote_price_request_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
@JsonSerializable()

///This class contains properties for a plan by id request
@Freezed(
  copyWith: true,
  fromJson: false,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class PlansQuotePriceRequestModel with _$PlansQuotePriceRequestModel {
    @JsonSerializable(explicitToJson: true)
  const PlansQuotePriceRequestModel._();

  factory PlansQuotePriceRequestModel({
    required String membershipId,
    required String planIds,
  }) = _PlansQuotePriceRequestModel;
}
