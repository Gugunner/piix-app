import 'package:freezed_annotation/freezed_annotation.dart';

part 'combo_quote_price_request_model.freezed.dart';

part 'combo_quote_price_request_model.g.dart';

///This class contains properties for a package combo by id request
@Freezed(
  copyWith: true,
  fromJson: false,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class ComboQuotePriceRequestModel with _$ComboQuotePriceRequestModel {
  @JsonSerializable(explicitToJson: true)
  const ComboQuotePriceRequestModel._();
  factory ComboQuotePriceRequestModel({
    required String membershipId,
    required String packageComboId,
    @Default(false) bool isPartialPurchase,
  }) = _ComboQuotePriceRequestModel;
}
