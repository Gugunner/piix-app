import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/freezed_utils.dart';
import 'package:piix_mobile/utils/extensions/list_extend.dart';
import 'package:piix_mobile/store_feature/domain/model/combo_model.dart';
import 'package:piix_mobile/store_feature/domain/model/level_model.dart';
import 'package:piix_mobile/store_feature/domain/model/plan_model_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';

part 'product_model.freezed.dart';

part 'product_model.g.dart';

///This stores all the information of products of purchase invoice
///
@Freezed(
    copyWith: true,
    fromJson: true,
    toJson: true,
    makeCollectionsUnmodifiable: false,
    unionKey: 'modelType')
class ProductModel with _$ProductModel {
  const ProductModel._();

  factory ProductModel.purchased({
    @JsonKey(name: 'PackageCombo', readValue: addPurchasedType)
    ComboModel? packageCombo,
    @JsonKey(name: 'Level', readValue: addPurchasedType) LevelModel? level,
    @JsonKey(name: 'AdditionalBenefitsPerSupplier', readValue: addPurchasedType)
    List<BenefitPerSupplierModel>? additionalBenefitsPerSupplier,
    @JsonKey(name: 'Plans', readValue: addPurchasedType) List<PlanModel>? plans,
    @Default(0) int protectedAcquired,
  }) = _ProductPurchasedModel;

  factory ProductModel.detail({
    @JsonKey(
      name: 'PackageCombo',
      readValue: addDefaultType,
    )
    ComboModel? packageCombo,
    @JsonKey(name: 'Level', readValue: addDetailType) LevelModel? level,
    @JsonKey(
      name: 'AdditionalBenefitsPerSupplier',
      readValue: addAdditionalType,
    )
    List<BenefitPerSupplierModel>? additionalBenefitsPerSupplier,
    @JsonKey(name: 'Plans', readValue: addDefaultType) List<PlanModel>? plans,
    @JsonKey(name: 'TotalProtectedAcquired') @Default(0) int protectedAcquired,
  }) = _ProductDetailModel;

  factory ProductModel.payment({
    @JsonKey(name: 'PackageCombo', readValue: addPurchasedType)
    ComboModel? packageCombo,
    @JsonKey(name: 'Level', readValue: addPurchasedType) LevelModel? level,
    @JsonKey(name: 'AdditionalBenefitsPerSupplier', readValue: addPurchasedType)
    List<BenefitPerSupplierModel>? additionalBenefitsPerSupplier,
    @JsonKey(name: 'Plans', readValue: addPurchasedType) List<PlanModel>? plans,
    @Default(0) int protectedAcquired,
  }) = _ProductPaymentModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  @override
  ComboModel? get packageCombo => mapOrNull(
        purchased: (value) => value.packageCombo,
        detail: (value) => value.packageCombo,
      );

  @override
  LevelModel? get level => mapOrNull(
        purchased: (value) => value.level,
        detail: (value) => value.level,
      );

  @override
  List<BenefitPerSupplierModel>? get additionalBenefitsPerSupplier => mapOrNull(
        purchased: (value) => value.additionalBenefitsPerSupplier,
        detail: (value) => value.additionalBenefitsPerSupplier,
      );

  @override
  List<PlanModel>? get plans => mapOrNull(
        purchased: (value) => value.plans,
        detail: (value) => value.plans,
      );

  @override
  int get protectedAcquired => map(
        purchased: (value) => value.protectedAcquired,
        detail: (value) => value.protectedAcquired,
        payment: (value) => value.protectedAcquired,
      );

  String get productName {
    if (additionalBenefitsPerSupplier != null) {
      return additionalBenefitsPerSupplier!.first.benefit.name;
    }
    if (packageCombo != null) {
      return packageCombo!.name;
    }
    if (level != null) {
      return level!.name;
    }
    if (plans.isNotNullOrEmpty) {
      final withS = protectedAcquired > 1 ? 's' : '';
      return '$protectedAcquired protegido$withS nuevo$withS';
    }

    return '';
  }
}

extension ProductModelType on ProductModel {
  StoreModuleDeprecated get module {
    if (additionalBenefitsPerSupplier.isNotNullOrEmpty)
      return StoreModuleDeprecated.additionalBenefit;
    if (packageCombo != null) return StoreModuleDeprecated.combo;
    if (level != null) return StoreModuleDeprecated.level;
    if (plans.isNotNullOrEmpty) return StoreModuleDeprecated.plan;
    return StoreModuleDeprecated.none;
  }

  String get storeModuleName {
    final currentModule = module;
    switch (currentModule) {
      case StoreModuleDeprecated.additionalBenefit:
        return PiixCopiesDeprecated.benefitLabel;
      case StoreModuleDeprecated.combo:
        return PiixCopiesDeprecated.comboLabel;
      case StoreModuleDeprecated.plan:
        return PiixCopiesDeprecated.planLabel;
      case StoreModuleDeprecated.level:
        return PiixCopiesDeprecated.levelLabel;
      default:
        return '';
    }
  }
}
