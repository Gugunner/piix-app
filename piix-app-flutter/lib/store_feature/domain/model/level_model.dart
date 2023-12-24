import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/store_feature/domain/model/compare_benefits_per_supplier_model.dart';
import 'package:piix_mobile/store_feature/domain/model/product_rates_model.dart';

part 'level_model.freezed.dart';

part 'level_model.g.dart';

///This stores all the information pertaining a level
///
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class LevelModel with _$LevelModel {
  const LevelModel._();

  factory LevelModel({
    @JsonKey(required: true) required String levelId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String pseudonym,
    @JsonKey(required: true) required DateTime registerDate,
    @Default(false) bool isAlreadyAcquired,
    @Default(false) bool isPartiallyAcquired,
    @JsonKey(readValue: addLevelType)
    @Default([])
    List<BenefitPerSupplierModel> benefits,
    DateTime? updateDate,
    @Default('') String membershipLevelImage,
    @Default('') String membershipLevelImageMemory,
  }) = _LevelModel;

  factory LevelModel.rates({
    @JsonKey(required: true) required String levelId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String pseudonym,
    @JsonKey(required: true) required DateTime registerDate,
    @JsonKey(required: true) required ProductRatesModel productRates,
    @Default(false) bool isAlreadyAcquired,
    @Default(false) bool isPartiallyAcquired,
    @JsonKey(readValue: addLevelType)
    @Default([])
    List<BenefitPerSupplierModel> benefits,
    @Default('') String membershipLevelImage,
    @Default('') String membershipLevelImageMemory,
  }) = _LevelModelWithRates;

  factory LevelModel.purchased({
    @JsonKey(required: true) required String levelId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String membershipLevelImage,
  }) = _LevelPurchasedModel;

  factory LevelModel.detail({
    @JsonKey(required: true) required String levelId,
    @JsonKey(required: true) required String folio,
    @JsonKey(required: true) required String name,
    @JsonKey(required: true) required String pseudonym,
    @JsonKey(required: true) required DateTime registerDate,
    @JsonKey(required: true)
    required CompareBenefitsPerSupplierModel comparisonInformation,
    DateTime? updateDate,
    @Default('') String membershipLevelImage,
  }) = _LevelDetailModel;

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);

  @override
  String get levelId => map(
        (value) => value.levelId,
        rates: (value) => value.levelId,
        purchased: (value) => value.levelId,
        detail: (value) => value.levelId,
      );

  @override
  String get folio => map(
        (value) => value.folio,
        rates: (value) => value.folio,
        purchased: (value) => value.folio,
        detail: (value) => value.folio,
      );

  @override
  String get name => map(
        (value) => value.name,
        rates: (value) => value.name,
        purchased: (value) => value.name,
        detail: (value) => value.name,
      );

  String get pseudonym => maybeMap(
        (value) => value.pseudonym,
        rates: (value) => value.pseudonym,
        detail: (value) => value.pseudonym,
        orElse: () => '',
      );

  DateTime? get registerDate => mapOrNull(
        (value) => value.registerDate,
        rates: (value) => value.registerDate,
        detail: (value) => value.registerDate,
      );

  bool get isAlreadyAcquired => maybeMap(
        (value) => value.isAlreadyAcquired,
        rates: (value) => value.isAlreadyAcquired,
        orElse: () => false,
      );

  List<BenefitPerSupplierModel>? get benefits => maybeMap(
        (value) => value.benefits,
        rates: (value) => value.benefits,
        orElse: () => [],
      );

  @override
  String get membershipLevelImage => map(
        (value) => value.membershipLevelImage,
        rates: (value) => value.membershipLevelImage,
        purchased: (value) => value.membershipLevelImage,
        detail: (value) => value.membershipLevelImage,
      );

  String get membershipLevelImageMemory => maybeMap(
        (value) => value.membershipLevelImageMemory,
        rates: (value) => value.membershipLevelImageMemory,
        orElse: () => '',
      );

  ProductRatesModel? get productRates => mapOrNull(
        (value) => null,
        rates: (value) => value.productRates,
      );

  DateTime? get updateDate => mapOrNull(
        (value) => null,
        detail: (value) => value.updateDate,
      );

  CompareBenefitsPerSupplierModel? get comparisonInformation => mapOrNull(
        (value) => null,
        detail: (value) => value.comparisonInformation,
      );
}
