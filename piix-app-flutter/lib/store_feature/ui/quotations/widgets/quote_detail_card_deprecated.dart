import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/model/product_rates_model.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/breakdown_new_benefits_expansion_list_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/level_benefits_tile_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/additional_benefit_supplier_and_summed_premium_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/additional_benefit_type_and_name.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/breakdown_benefits_quote_expansion_list.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/breakdown_protected_quote_expansion_list_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/breakdown_quote_expansion_list.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/coverage_protected_text_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/package_combo_title_type_tile_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/plan_protected_tile_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/price_with_discount_tile_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/title_detail_quote_container.dart';

final marketQuotationKey = GlobalKey();
final totalDiscountKey = GlobalKey();
final totalAmountKey = GlobalKey();

@Deprecated('Will be removed in 4.0')

///This widget render a quote detail card
///
class QuoteDetailCardDeprecated extends StatelessWidget {
  const QuoteDetailCardDeprecated({
    super.key,
    required this.storeModule,
    required this.productRates,
    this.additionalBenefitsPerSupplier = const [],
  });
  final StoreModuleDeprecated storeModule;
  final ProductRatesModel productRates;
  final List<BenefitPerSupplierModel> additionalBenefitsPerSupplier;

  double get mediumPadding => 12;
  double get horizontalPadding => 16;
  double get tilesPadding => 19;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleDetailQuoteContainerDeprecated(
              title: PiixCopiesDeprecated.quoteDetail),
          if (storeModule == StoreModuleDeprecated.additionalBenefit) ...[
            const AdditionalBenefitTypeAndNameDeprecated()
                .padBottom(4.h)
                .padHorizontal(tilesPadding.w),
            const AdditionalBenefitSupplierAndSummedPremiumDeprecated()
                .padHorizontal(tilesPadding.w)
          ] else if (storeModule == StoreModuleDeprecated.combo)
            const PackageComboTitleTypeTileDeprecated()
                .padHorizontal(tilesPadding.w)
          else if (storeModule == StoreModuleDeprecated.plan)
            const PlanProtectedTileDeprecated()
                .padBottom(mediumPadding.h)
                .padHorizontal(tilesPadding.w)
          else if (storeModule == StoreModuleDeprecated.level)
            const LevelBenefitsTileDeprecated().padHorizontal(tilesPadding.w),
          CoverageProtectedTextDeprecated(
            storeModule: storeModule,
          ).padHorizontal(tilesPadding.w),
          PriceWithDiscountTileDeprecated(
            label: PiixCopiesDeprecated.totalAmount,
            amount: productRates.summedTotalPremium,
            tooltipKey: totalAmountKey,
          ).padBottom(mediumPadding.h).padHorizontal(horizontalPadding.h),
          PriceWithDiscountTileDeprecated(
            label: PiixCopiesDeprecated.totalDiscount,
            amount: productRates.finalTotalDiscountAmount,
            discount: productRates.finalDiscount,
            labelStyle: context.textTheme?.titleMedium?.copyWith(
              color: PiixColors.highlight,
            ),
            discountStyle: context.accentTextTheme?.labelLarge?.copyWith(
              color: PiixColors.highlight,
            ),
            tooltipKey: totalDiscountKey,
          ).padBottom(mediumPadding.h).padHorizontal(horizontalPadding.h),
          PriceWithDiscountTileDeprecated(
            label: PiixCopiesDeprecated.totalToPay,
            amount: productRates.finalTotalPremium,
            discount: productRates.finalDiscount,
            isTotal: true,
            tooltipKey: totalAmountKey,
          ).padBottom(26.h).padHorizontal(horizontalPadding.h),
          BreakdownQuoteExpansionListDeprecated(
            storeModule: storeModule,
            productRates: productRates,
          ),
          if (storeModule == StoreModuleDeprecated.combo)
            BreakdownBenefitsQuoteExpansionListDeprecated(
              additionalBenefitsPerSupplier: additionalBenefitsPerSupplier,
            ).padTop(8.h),
          if (storeModule == StoreModuleDeprecated.plan)
            const BreakdownProtectedQuoteExpansionListDeprecated().padTop(8.h),
          if (storeModule == StoreModuleDeprecated.level)
            const BreakdownNewBenefitsExpansionListDeprecated().padTop(8.h),
        ],
      ),
    );
  }
}
