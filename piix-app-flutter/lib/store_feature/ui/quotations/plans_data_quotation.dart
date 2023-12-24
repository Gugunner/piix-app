import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/buying_tips_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/managing_deprecated/quotation_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/info_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/obtained_discount_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/quote_detail_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/summary_quotation_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/total_premium_card.dart';
import 'package:piix_mobile/store_feature/utils/plans.dart';
import 'package:provider/provider.dart';

///This widget render a quotation data for a plans module
///
class PlansDataQuotation extends StatefulWidget {
  const PlansDataQuotation({super.key});

  @override
  State<PlansDataQuotation> createState() => _PlansDataQuotationState();
}

class _PlansDataQuotationState extends State<PlansDataQuotation> {
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
    final plansBLoC = context.watch<PlansBLoCDeprecated>();
    final planQuotation = plansBLoC.planQuotation;
    final protectedAdded = planQuotation!.plans.getProtectedAddedNumber;

    final pendingPurchaseForSameProduct =
        planQuotation.existsSimultaneousPurchases;
    return (quotationUiState.showBuyingTips == AlertStateDeprecated.show &&
            pendingPurchaseForSameProduct)
        ? BuyingTipsScreenDeprecated(
            listPurchase: [],
            samePurchase: pendingPurchaseForSameProduct,
            module: StoreModuleDeprecated.plan,
            quotationUiState: quotationUiState,
            quoteProductName: '',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ObtainedDiscountCardDeprecated(
                              finalDiscount:
                                  planQuotation.productRates.finalDiscount,
                            ).padRight(minPadding.w),
                            Expanded(
                                child: TotalPremiumCardDeprecated(
                              finalTotalPremiumAmount:
                                  planQuotation.productRates.finalTotalPremium,
                              totalBuyText: protectedAdded.getProtectedBuyText,
                              purchaseName: protectedAdded.getProtectedLabel,
                            )),
                          ],
                        ).padBottom(minPadding.h),
                      ),
                      //Render a info card
                      InfoCardDeprecated(
                              quoteDate: planQuotation.quotationRegisterDate)
                          .padBottom(minPadding.h),
                      //Render a quote detail card
                      QuoteDetailCardDeprecated(
                        storeModule: StoreModuleDeprecated.plan,
                        productRates: planQuotation.productRates,
                      ),
                      //Render a validity text
                      Text(
                        PiixCopiesDeprecated.yearValidityPlan,
                        style: context.primaryTextTheme?.titleSmall,
                        textAlign: TextAlign.center,
                      ).padTop(20.h).padBottom(16.h)
                    ],
                  ).padAll(mediumPadding.h),
                ),
              ),
              //Render a floating summary card
              SummaryQuotationCardDeprecated(
                endPromotionalText: PiixCopiesDeprecated.protectedUniquePay,
                finalDiscount: planQuotation.productRates.finalDiscount,
                finalTotalPremiumAmount:
                    planQuotation.productRates.finalTotalPremium,
                type: StoreModuleDeprecated.plan,
                purchaseName: protectedAdded.getProtectedLabel,
                userQuotePriceId: planQuotation.userQuotePriceId,
                quotationRegisterDate: planQuotation.quotationRegisterDate,
                protectedQuantity: protectedAdded,
              ),
            ],
          );
  }
}
