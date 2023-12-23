import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/package_combos_bloc.dart';
import 'package:piix_mobile/store_feature/ui/additional_benefits_per_supplier_deprecated/buying_tips_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/managing_deprecated/quotation_ui_state_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/info_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/obtained_discount_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/quote_detail_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/summary_quotation_card_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/total_premium_card.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget shows a package combo quotation, includes discounts, amounts,
///breakdown discounts, breakdown benefits ans summary quotation card
///
class PackageComboDataQuotationDeprecated extends StatefulWidget {
  const PackageComboDataQuotationDeprecated({super.key});

  @override
  State<PackageComboDataQuotationDeprecated> createState() =>
      _PackageComboDataQuotationDeprecatedState();
}

class _PackageComboDataQuotationDeprecatedState
    extends State<PackageComboDataQuotationDeprecated> {
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
    final packageComboBLoC = context.watch<PackageComboBLoC>();
    final packageComboWithPrices = packageComboBLoC.packageComboWithPrices;

    final purchaseName = packageComboWithPrices?.name ?? '';
    final pendingPurchaseForSameProduct =
        packageComboWithPrices?.pendingPurchaseForSameProduct ?? false;
    final listPurchase =
        packageComboWithPrices?.pendingPurchasesOfAdditionalBenefit ?? [];

    return (quotationUiState.showBuyingTips == AlertStateDeprecated.show &&
            (pendingPurchaseForSameProduct || listPurchase.isNotEmpty))
        ? BuyingTipsScreenDeprecated(
            listPurchase: listPurchase,
            samePurchase: pendingPurchaseForSameProduct,
            module: StoreModuleDeprecated.combo,
            quotationUiState: quotationUiState,
            quoteProductName: purchaseName,
          )
        : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Sometimes a widget does not know how big it has to be,
                      //because as a general rule, the child widgets are the
                      //ones that determine the size and the parent widgets just
                      //position them, if we know the size of the parent we can
                      //generate the same size in the children, however, here we
                      //do not know the size of the father, since it must be
                      //dynamic depending on the size of the largest child and
                      //we need the smallest widget to fit the size of the
                      //largest widget that's why we use IntrinsicHeight
                      IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ObtainedDiscountCardDeprecated(
                              finalDiscount: packageComboWithPrices
                                      ?.productRates?.finalDiscount ??
                                  0,
                            ).padRight(minPadding.w),
                            Expanded(
                                child: TotalPremiumCardDeprecated(
                              finalTotalPremiumAmount: packageComboWithPrices
                                      ?.productRates?.finalTotalPremium ??
                                  0,
                              totalBuyText:
                                  PiixCopiesDeprecated.priceToBuyCombo,
                              purchaseName: packageComboWithPrices?.name ?? '',
                            )),
                          ],
                        ).padBottom(minPadding.h),
                      ),
                      //Render a info card
                      if (packageComboWithPrices != null) ...[
                        InfoCardDeprecated(
                                quoteDate: packageComboWithPrices
                                    .quotationRegisterDate!)
                            .padBottom(minPadding.h),
                        //Render a quote detail card
                        QuoteDetailCardDeprecated(
                          storeModule: StoreModuleDeprecated.combo,
                          productRates: packageComboWithPrices.productRates!,
                          additionalBenefitsPerSupplier: packageComboWithPrices
                              .additionalBenefitsPerSupplier,
                        ),
                      ],
                      //Render a validity text
                      Text(
                        PiixCopiesDeprecated.yearValidityCombo,
                        style: context.primaryTextTheme?.titleSmall,
                        textAlign: TextAlign.center,
                      ).padTop(
                        17.h,
                      )
                    ],
                  ).padAll(mediumPadding.h),
                ),
              ),
              //Render a floating summary card
              SummaryQuotationCardDeprecated(
                endPromotionalText: PiixCopiesDeprecated.uniquePay,
                finalDiscount:
                    packageComboWithPrices!.productRates!.finalDiscount,
                finalTotalPremiumAmount:
                    packageComboWithPrices.productRates!.finalTotalPremium,
                type: StoreModuleDeprecated.combo,
                purchaseName: packageComboWithPrices.name,
                userQuotePriceId: packageComboWithPrices.userQuotationId,
                quotationRegisterDate:
                    packageComboWithPrices.quotationRegisterDate!,
                protectedQuantity: packageComboWithPrices
                        .currentQuotePricePlansModel
                        ?.protectedQuantity
                        .protectedQuantity ??
                    0,
              ),
            ],
          );
  }
}
