import 'package:freezed_annotation/freezed_annotation.dart';

part 'kinship_model.freezed.dart';

part 'kinship_model.g.dart';

///This class contains all information of kinship.
/// This model is used to store the user info once the user is logged in.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class KinshipModel with _$KinshipModel {
  @JsonSerializable(explicitToJson: true)
  const KinshipModel._();

  factory KinshipModel({
    @JsonKey(required: true) required String kinshipId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required DateTime registerDate,
  }) = _KinshipModel;

  factory KinshipModel.fromJson(Map<String, dynamic> json) =>
      _$KinshipModelFromJson(json);
}
