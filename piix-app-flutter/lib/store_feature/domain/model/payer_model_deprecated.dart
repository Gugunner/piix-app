import 'package:freezed_annotation/freezed_annotation.dart';

part 'payer_model_deprecated.freezed.dart';

part 'payer_model_deprecated.g.dart';

@Deprecated('Will be removed in 4.0')
///This stores all the information pertaining a payer
///
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class PayerModel with _$PayerModel {
  const PayerModel._();

  factory PayerModel({
    @JsonKey(required: true) required String email,
    @JsonKey(required: true) required String names,
    @JsonKey(required: true) required String lastNames,
  }) = _PayerModel;
  factory PayerModel.fromJson(Map<String, dynamic> json) =>
      _$PayerModelFromJson(json);
}
