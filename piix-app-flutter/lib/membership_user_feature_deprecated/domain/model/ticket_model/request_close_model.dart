import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_close_model.freezed.dart';

part 'request_close_model.g.dart';

///Use when requesting to close a ticket
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class RequestCloseModel with _$RequestCloseModel{
    @JsonSerializable(explicitToJson: true)
    const RequestCloseModel._();
  factory RequestCloseModel({
    @JsonKey(required: true)
    required String ticketId,
    @JsonKey(required: true)
    required double supplierRating,
    double? benefitPerSupplierRating,
    String? comments,
  }) = _RequestCloseModel;

  factory RequestCloseModel.fromJson(Map<String, dynamic> json) =>
      _$RequestCloseModelFromJson(json);

}
