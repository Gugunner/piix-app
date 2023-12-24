import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_quote_price_request_model_deprecated.freezed.dart';

part 'level_quote_price_request_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///This class contains properties for a level quotation by membership id and
///level id request
@Freezed(
  copyWith: true,
  fromJson: false,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class LevelQuotePriceRequestModel with _$LevelQuotePriceRequestModel {
  @JsonSerializable(explicitToJson: true)
  const LevelQuotePriceRequestModel._();
  factory LevelQuotePriceRequestModel({
    required String membershipId,
    required String levelId,
    @Default(false) bool isPartialPurchase,
  }) = _LevelQuotePriceRequestModel;

}
