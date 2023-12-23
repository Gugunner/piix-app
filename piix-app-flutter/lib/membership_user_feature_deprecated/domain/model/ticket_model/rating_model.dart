import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_model.freezed.dart';

part 'rating_model.g.dart';

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class RatingModel with _$RatingModel {

 factory RatingModel({
    @JsonKey(required: true)
    required String ticketId,
    @JsonKey(required: true)
    required DateTime registerDate,
    @Default(0.0)
    double benefitPerSupplierRating,
    @Default(0.0)
    double supplierRating,
    @Default('')
    String comments,
  }) = _RatingModel;

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
