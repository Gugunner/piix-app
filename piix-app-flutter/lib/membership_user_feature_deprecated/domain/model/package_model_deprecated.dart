import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_model_deprecated.freezed.dart';
part 'package_model_deprecated.g.dart';


@Deprecated('Will be removed in 4.0')
///This model contains everything needed for the app to handle a [Package]

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType'
)
class PackageModel with _$PackageModel {
  @JsonSerializable(explicitToJson: true)
  const PackageModel._();
  factory PackageModel({
    @JsonKey(
      required: true,
      name: 'packageId',
    )
        required String id,
    @JsonKey(required: true)
        required String name,
    @JsonKey(required: true)
        required String countryId,
    @Default(0)
        int maxProtectedPerMain,
    String? packagePosterUrl,
    @Default(100)
        int maxAgeCompliance,
  }) = _PackageModel;

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);
}
