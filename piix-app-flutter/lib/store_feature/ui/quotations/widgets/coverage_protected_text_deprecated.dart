import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/model/protected_quantity_model.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a coverage protected text
///
class CoverageProtectedTextDeprecated extends StatelessWidget {
  const CoverageProtectedTextDeprecated({super.key, required this.storeModule});
  final StoreModuleDeprecated storeModule;

  @override
  Widget build(BuildContext context) {
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier;
    final additionalProtectedQuantity = currentAdditionalBenefitPerSupplier
        ?.currentQuotePricePlans?.protectedQuantity;
    final packageComboBLoC = context.read<PackageComboBLoC>();
    final packageComboWithPrices =
        packageComboBLoC.packageComboWithPrices?.mapOrNull((value) => value);
    final comboProtectedQuantity =
        packageComboWithPrices?.currentQuotePricePlansModel?.protectedQuantity;
    final levelsBLoC = context.read<LevelsBLoCDeprecated>();
    final levelQuotation = levelsBLoC.levelQuotation;
    final levelProtectedQuantity =
        levelQuotation?.currentQuotePricePlans?.protectedQuantity;
    return Column(
      children: [
        if (storeModule == StoreModuleDeprecated.additionalBenefit)
          Text.rich(TextSpan(children: [
            TextSpan(
              text: '${PiixCopiesDeprecated.coveragePeople}: '
                  '${additionalProtectedQuantity?.totalQuantityCovered} ',
              style: context.textTheme?.bodyMedium,
            ),
            TextSpan(
              text: '(${additionalProtectedQuantity?.protectedInCoverage})',
              style: context.textTheme?.labelMedium,
            ),
          ])).padBottom(16.w)
        else if (storeModule == StoreModuleDeprecated.combo)
          Text.rich(TextSpan(children: [
            TextSpan(
              text: '${PiixCopiesDeprecated.coveragePeople}: '
                  '${comboProtectedQuantity?.totalQuantityCovered} ',
              style: context.textTheme?.bodyMedium,
            ),
            TextSpan(
              text: '(${comboProtectedQuantity?.protectedInCoverage})',
              style: context.textTheme?.labelMedium,
            ),
          ])).padBottom(16.w)
        else if (storeModule == StoreModuleDeprecated.level)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${PiixCopiesDeprecated.coveragePeople}: '
                      '${levelProtectedQuantity?.totalQuantityCovered ?? '-'} ',
                  style: context.textTheme?.bodyMedium,
                ),
                if (levelProtectedQuantity != null)
                  TextSpan(
                    text: '(${levelProtectedQuantity.protectedInCoverage})',
                    style: context.textTheme?.labelMedium,
                  ),
              ],
            ),
          ).padBottom(16.w)
      ],
    );
  }
}
