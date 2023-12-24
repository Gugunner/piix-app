import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier_model.g.dart';

part 'supplier_model.freezed.dart';

///This class contains all supplier info.
@Freezed(
  copyWith: true,
  fromJson: true,
  toJson: true,
  makeCollectionsUnmodifiable: false,
  unionKey: 'modelType',
)
class SupplierModel with _$SupplierModel {
  @JsonSerializable(explicitToJson: true)
  const SupplierModel._();
  factory SupplierModel({
    @JsonKey(required: true) required String supplierId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String personTypeId,
    @JsonKey(required: true) required String shortName,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String internationalLada,
    @JsonKey(required: true) required String phoneNumber,
    @JsonKey(required: true) required String logo,
    String? taxId,
    //TODO: Delete
    @Default('') String street,
    //TODO: Delete
    @Default('') String externalNumber,
    //TODO: Delete
    @Default('') String subThoroughFare,
    //TODO: Delete
    @Default('') String thoroughFare,
    //TODO: Delete
    @Default('') String countryId,
    //TODO: Delete
    @Default('') String stateId,
    //TODO: Delete
    @Default('') String city,
    //TODO: Delete
    @Default('') String zipCode,
    //TODO: Check if it still is in use
    @Default('') String logoMemory,
    //TODO: Delete
    @Default('') String interiorNumber,
  }) = _SupplierModel;

  factory SupplierModel.fromJson(Map<String, dynamic> json) =>
      _$SupplierModelFromJson(json);
}
