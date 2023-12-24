import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/levels_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/buying_tips_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/level/widgets/enhanced_coverage_button.dart';
import 'package:piix_mobile/store_feature/ui/quotations/managing_deprecated/quotation_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/info_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/obtained_discount_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/quote_detail_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/summary_quotation_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/total_premium_card.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a level quotation data, includes membership general info,
///quote detail card, and summary quotation card
///
class LevelDataQuotationDeprecated extends StatefulWidget {
  const LevelDataQuotationDeprecated({super.key});

  @override
  State<LevelDataQuotationDeprecated> createState() =>
      _LevelDataQuotationDeprecatedState();
}

class _LevelDataQuotationDeprecatedState
    extends State<LevelDataQuotationDeprecated> {
  late QuotationUiStateDeprecated quotationUiState;
  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  double get minPadding => ConstantsDeprecated.minPadding;

  @override
  void initState() {
    super.initState();
    quotationUiState = QuotationUiStateDeprecated(setState: setState);
  }

  @override
  Widget build(BuildContext context) {
    final levelsBLoC = context.watch<LevelsBLoCDeprecated>();
    final levelQuotation = levelsBLoC.levelQuotation;
    final levelInfo = levelQuotation?.level
        .mapOrNull((value) => null, rates: (value) => value);
    final pendingPurchaseForSameProduct =
        levelQuotation?.pendingPurchaseForSameProduct ?? false;

    return (quotationUiState.showBuyingTips == AlertStateDeprecated.show &&
            pendingPurchaseForSameProduct)
        ? BuyingTipsScreenDeprecated(
            listPurchase: [],
            samePurchase: pendingPurchaseForSameProduct,
            module: StoreModuleDeprecated.level,
            quotationUiState: quotationUiState,
            quoteProductName: '',
          )
        : levelQuotation != null && levelInfo != null
            ? Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ObtainedDiscountCardDeprecated(
                                  finalDiscount:
                                      levelInfo.productRates.finalDiscount,
                                ).padRight(minPadding.w),
                                Expanded(
                                    child: TotalPremiumCardDeprecated(
                                  finalTotalPremiumAmount:
                                      levelInfo.productRates.finalTotalPremium,
                                  totalBuyText:
                                      PiixCopiesDeprecated.priceToBuyLevel,
                                  purchaseName: '${levelInfo.name}',
                                )),
                              ],
                            ).padBottom(minPadding.h),
                          ).padTop(mediumPadding.h),
                          InfoCardDeprecated(
                                  quoteDate:
                                      levelQuotation.quotationRegisterDate)
                              .padBottom(12.h),
                          const EnhancedCoverageButton().padBottom(8.h),
                          Text(
                            PiixCopiesDeprecated.viewEnhancedBenefits,
                            style: context.textTheme?.labelMedium?.copyWith(
                              color: PiixColors.primary,
                            ),
                          ).padBottom(mediumPadding.h),
                          QuoteDetailCardDeprecated(
                            storeModule: StoreModuleDeprecated.level,
                            productRates: levelInfo.productRates,
                          ),
                          Text(
                            PiixCopiesDeprecated.yearValidityLevel,
                            style: context.primaryTextTheme?.titleSmall,
                            textAlign: TextAlign.center,
                          ).padTop(20.h).padBottom(16.h)
                        ],
                      ).padHorizontal(mediumPadding.w),
                    ),
                  ),
                  SummaryQuotationCardDeprecated(
                    endPromotionalText: PiixCopiesDeprecated.uniquePay,
                    finalDiscount: levelInfo.productRates.finalDiscount,
                    finalTotalPremiumAmount:
                        levelInfo.productRates.finalTotalPremium,
                    type: StoreModuleDeprecated.level,
                    purchaseName: '${levelInfo.name}\n',
                    userQuotePriceId: levelQuotation.userQuotePriceId,
                    quotationRegisterDate: levelQuotation.quotationRegisterDate,
                    protectedQuantity: levelQuotation.currentQuotePricePlans
                            ?.protectedQuantity.protectedQuantity ??
                        0,
                  ),
                ],
              )
            : const SizedBox();
  }
}
