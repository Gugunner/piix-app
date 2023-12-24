import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/model/product_rates_model.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/price_with_discount_tile_deprecated.dart';

final marketKey = GlobalKey();
final volumeKey = GlobalKey();
final comboKey = GlobalKey();

@Deprecated('Will be removed in 4.0')

///This widget contains a expansion list for breakdown quote discounts
///includes volume discounts, market discounts, and combo discount when storeModule
///is StoreModules.combo
///
class BreakdownQuoteExpansionListDeprecated extends StatelessWidget {
  const BreakdownQuoteExpansionListDeprecated({
    super.key,
    required this.storeModule,
    required this.productRates,
  });
  final StoreModuleDeprecated storeModule;
  final ProductRatesModel productRates;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  Color get greyWhite => PiixColors.greyWhite;
  Color get darkSkyBlue => PiixColors.darkSkyBlue;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          listTileTheme: ListTileTheme.of(context).copyWith(dense: true)),
      child: ExpansionTile(
        collapsedBackgroundColor: greyWhite,
        backgroundColor: greyWhite,
        textColor: PiixColors.mainText,
        iconColor: darkSkyBlue,
        collapsedIconColor: darkSkyBlue,
        title: Text(
          PiixCopiesDeprecated.breakdownQuote,
          style: context.primaryTextTheme?.headlineSmall,
        ),
        childrenPadding: EdgeInsets.all(mediumPadding.h),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PriceWithDiscountTileDeprecated(
            amount: productRates.finalMarketDiscountAmount,
            label: PiixCopiesDeprecated.marketDiscount,
            tooltipMessage: PiixCopiesDeprecated.tooltipMarketDiscount,
            discount: productRates.marketDiscount,
            labelStyle: context.textTheme?.bodyMedium,
            discountStyle: context.textTheme?.labelMedium,
            tooltipKey: marketKey,
          ).padBottom(mediumPadding.h),
          PriceWithDiscountTileDeprecated(
            amount: productRates.finalVolumeDiscountAmount,
            label: PiixCopiesDeprecated.volumeDiscount,
            tooltipMessage: PiixCopiesDeprecated.tooltipVolumeDiscount,
            discount: productRates.volumeDiscount,
            labelStyle: context.textTheme?.bodyMedium,
            discountStyle: context.textTheme?.labelMedium,
            tooltipKey: volumeKey,
          ),
          if (storeModule == StoreModuleDeprecated.combo)
            PriceWithDiscountTileDeprecated(
              amount: productRates.finalComboDiscountAmount,
              label: PiixCopiesDeprecated.comboDiscount,
              tooltipMessage: PiixCopiesDeprecated.tooltipComboDiscount,
              discount: productRates.comboDiscount,
              labelStyle: context.textTheme?.bodyMedium,
              discountStyle: context.textTheme?.labelMedium,
              tooltipKey: comboKey,
            ).padTop(mediumPadding.h)
        ],
      ),
    );
  }
}
