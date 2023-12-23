import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_model.freezed.dart';
part 'package_model.g.dart';

///This model contains everything needed for the app to handle a [Package]

@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class PackageModel with _$PackageModel {
  @JsonSerializable(explicitToJson: true)
  const PackageModel._();
  factory PackageModel({
    @JsonKey(required: true) required String packageId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String countryId,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String clientId,
    @JsonKey(required: true) required String clientName,
    @JsonKey(required: true) required String communityName,
    @JsonKey(required: true) required DateTime fromDate,
    @JsonKey(required: true) required DateTime toDate,
    @JsonKey(required: true) required bool packageIsActive,
    @JsonKey(required: true) required DateTime registerDate,
    @JsonKey(name: 'activeEcommerce') @Default(false) bool activeStore,
    String? claimCallPhoneNumber,
    String? claimSMShoneNumber,
    String? claimChatNumber,

    // String? packagePosterUrl,
  }) = _PackageModel;

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);
}
