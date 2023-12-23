import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/additional_benefits_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/buying_tips_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/managing_deprecated/quotation_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/info_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/obtained_discount_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/quote_detail_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/summary_quotation_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/total_premium_card.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render an additional benefits per supplier quote
///
class AdditionalBenefitsDataQuotationDeprecated extends StatefulWidget {
  const AdditionalBenefitsDataQuotationDeprecated({
    super.key,
  });

  @override
  State<AdditionalBenefitsDataQuotationDeprecated> createState() =>
      _AdditionalBenefitsDataQuotationDeprecatedState();
}

class _AdditionalBenefitsDataQuotationDeprecatedState
    extends State<AdditionalBenefitsDataQuotationDeprecated> {
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
    final additionalBenefitsPerSupplierBLoC =
        context.watch<AdditionalBenefitsPerSupplierBLoCDeprecated>();
    final currentAdditionalBenefitPerSupplier =
        additionalBenefitsPerSupplierBLoC.currentAdditionalBenefitPerSupplier;
    final benefitName = currentAdditionalBenefitPerSupplier?.benefitName ?? '';
    final pendingPurchaseForSameProduct =
        currentAdditionalBenefitPerSupplier?.pendingPurchaseForSameProduct ??
            false;
    final listPurchase =
        currentAdditionalBenefitPerSupplier?.pendingPurchasesOfCombo ?? [];
    return (quotationUiState.showBuyingTips == AlertStateDeprecated.show &&
            (pendingPurchaseForSameProduct || listPurchase.isNotEmpty))
        ? BuyingTipsScreenDeprecated(
            listPurchase: listPurchase,
            samePurchase: pendingPurchaseForSameProduct,
            module: StoreModuleDeprecated.additionalBenefit,
            quotationUiState: quotationUiState,
            quoteProductName:
                currentAdditionalBenefitPerSupplier?.benefit.name ?? '',
          )
        : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ObtainedDiscountCardDeprecated(
                              finalDiscount: additionalBenefitsPerSupplierBLoC
                                  .finalDiscount,
                            ).padRight(minPadding.w),
                            Expanded(
                              child: TotalPremiumCardDeprecated(
                                finalTotalPremiumAmount:
                                    additionalBenefitsPerSupplierBLoC
                                        .finalTotalPremium,
                                totalBuyText:
                                    PiixCopiesDeprecated.priceToBuyBenefit,
                                purchaseName: benefitName,
                              ),
                            ),
                          ],
                        ).padBottom(minPadding.h),
                      ),
                      //Render a info card
                      if (currentAdditionalBenefitPerSupplier
                              ?.quotationRegisterDate !=
                          null)
                        InfoCardDeprecated(
                                quoteDate: currentAdditionalBenefitPerSupplier!
                                    .quotationRegisterDate!)
                            .padBottom(minPadding.h),
                      //Render a quote detail card
                      if (currentAdditionalBenefitPerSupplier?.productRates !=
                          null)
                        QuoteDetailCardDeprecated(
                          storeModule: StoreModuleDeprecated.additionalBenefit,
                          productRates: currentAdditionalBenefitPerSupplier!
                              .productRates!,
                        ),
                      //Render a validity text
                      Text(
                        PiixCopiesDeprecated.yearValidityBenefit,
                        style: context.primaryTextTheme?.titleSmall,
                        textAlign: TextAlign.center,
                      ).padTop(17.h)
                    ],
                  ).padAll(mediumPadding.h),
                ),
              ),
              if (currentAdditionalBenefitPerSupplier?.quotationRegisterDate !=
                      null &&
                  currentAdditionalBenefitPerSupplier?.currentQuotePricePlans !=
                      null)
                //Render a floating summary card
                SummaryQuotationCardDeprecated(
                  endPromotionalText: PiixCopiesDeprecated.uniquePay,
                  finalDiscount:
                      additionalBenefitsPerSupplierBLoC.finalDiscount,
                  finalTotalPremiumAmount:
                      additionalBenefitsPerSupplierBLoC.finalTotalPremium,
                  type: StoreModuleDeprecated.additionalBenefit,
                  purchaseName: benefitName,
                  userQuotePriceId:
                      currentAdditionalBenefitPerSupplier?.userQuotationId ??
                          '',
                  quotationRegisterDate: currentAdditionalBenefitPerSupplier!
                      .quotationRegisterDate!,
                  protectedQuantity: currentAdditionalBenefitPerSupplier
                          .currentQuotePricePlans
                          ?.protectedQuantity
                          .protectedQuantity ??
                      0,
                ),
            ],
          );
  }
}
