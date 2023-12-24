import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/branch_type_enum.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

extension PackageComboListExtend on List<BenefitPerSupplierModel> {
  String get getSupplierText => map(
            (addtiionalBenefitPerSupplier) =>
                addtiionalBenefitPerSupplier.supplier?.name,
          ).toSet().toList().length >
          1
      ? PiixCopiesDeprecated.supplierPlural
      : PiixCopiesDeprecated.supplier;

  String get getSupplierNames => map((addtiionalBenefitPerSupplier) =>
          addtiionalBenefitPerSupplier.supplier?.name ?? '')
      .toSet()
      .toList()
      .join(', ');

  ///Get benefit types name in a list
  List<String> getAdditionalBenefitsNames() =>
      map((addtiionalBenefitPerSupplier) =>
              addtiionalBenefitPerSupplier.benefitType?.name ?? '')
          .toSet()
          .toList();

  List<BranchType> getUniqueBranchTypes() =>
      map((addtiionalBenefitPerSupplier) =>
          addtiionalBenefitPerSupplier.benefitType?.branchType ??
          BranchType.emergency).toSet().toList();

  ///Get benefit types name in a string
  String get getAdditionalBenefitTypesNameInString =>
      getAdditionalBenefitsNames().join(', ');
}

extension PurchaseComboBenefits on List<BenefitPerSupplierModel> {
  List<BenefitPerSupplierModel> get sortBenefits {
    sort(
      (a, b) => a.benefit.name.compareTo(
        b.benefit.name,
      ),
    );
    return this;
  }
}

extension DiscountExtension on double {
  ///convert double to percentage
  double get toPercentage => this * 100;
}
