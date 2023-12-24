import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/store_module_enum_deprecated.dart';
import 'package:piix_mobile/extensions/currency_extends.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/payment_methods_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:piix_mobile/store_feature/utils/store_copies.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a summary quote card
///Includes a total discount, total premium, navigate to payment method button,
///and promotional text
///
class SummaryQuotationCardDeprecated extends StatelessWidget {
  const SummaryQuotationCardDeprecated({
    super.key,
    required this.endPromotionalText,
    required this.finalDiscount,
    required this.finalTotalPremiumAmount,
    required this.type,
    required this.purchaseName,
    required this.userQuotePriceId,
    required this.quotationRegisterDate,
    required this.protectedQuantity,
  });
  final String endPromotionalText;
  final double finalDiscount;
  final double finalTotalPremiumAmount;
  final StoreModuleDeprecated type;
  final String purchaseName;
  final String userQuotePriceId;
  final DateTime quotationRegisterDate;
  final int protectedQuantity;

  Radius get cardRadius => Radius.circular(8.h);
  double get paymentDiscount => finalDiscount;
  double get paymentTotalPremium => finalTotalPremiumAmount;

  @override
  Widget build(BuildContext context) {
    final membershipBLOC = context.watch<MembershipProviderDeprecated>();
    final width = context.width;
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      color: PiixColors.skeletonGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: cardRadius,
          topRight: cardRadius,
        ),
      ),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Render final discount text
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${PiixCopiesDeprecated.cardTotalToPay} ',
                    style: context.primaryTextTheme?.labelMedium?.copyWith(
                      color: PiixColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: '${paymentDiscount.toPercentage.toStringAsFixed(2)}'
                        '${PiixCopiesDeprecated.discountWithTax}',
                    style: context.primaryTextTheme?.labelMedium?.copyWith(
                      color: PiixColors.highlight,
                    ),
                  ),
                ],
              ),
            ).padBottom(4.h).padTop(8.h),
            //Render final total premium text
            Text(
              '${ConstantsDeprecated.moneySymbol}'
              '${paymentTotalPremium.currencyFormat} '
              '${ConstantsDeprecated.mxn}',
              style: context.textTheme?.displaySmall?.copyWith(
                color: PiixColors.primary,
              ),
            ).padVertical(4.h),
            //Render a navigate to payment methods button
            Container(
              height: 36.h,
              width: width.percentageSize(0.862),
              margin: EdgeInsets.symmetric(vertical: 4.h),
              child: ElevatedButton(
                onPressed: membershipBLOC.isActiveMembership
                    ? () => handlePaymentMethodsNavigation(context)
                    : null,
                child: Text(
                  PiixCopiesDeprecated.goToPay.toUpperCase(),
                  style: context.primaryTextTheme?.titleMedium?.copyWith(
                    color: PiixColors.space,
                  ),
                ),
              ),
            ),
            if (!membershipBLOC.isActiveMembership)
              Container(
                width: width.percentageSize(0.862),
                margin: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  StoreCopiesDeprecated.toPurchaseActiveMembership,
                  textAlign: TextAlign.center,
                  style: context.accentTextTheme?.bodySmall?.copyWith(
                    color: PiixColors.highlight,
                  ),
                ),
              ),

            //Render a promotional text
            Text(
              endPromotionalText,
              style: context.accentTextTheme?.bodySmall?.copyWith(
                color: PiixColors.primary,
              ),
            ).padBottom(7.h),
          ],
        ),
      ),
    );
  }

  //Navigate to paymentMethods screen
  void handlePaymentMethodsNavigation(BuildContext context) {
    final paymentsBLoC = context.read<PaymentsBLoCDeprecated>();
    paymentsBLoC
      ..moduleToPay = type
      ..paymentDiscount = paymentDiscount
      ..transactionAmount = paymentTotalPremium
      ..paymentPurchaseName = purchaseName
      ..userQuotationId = userQuotePriceId
      ..quotationRegisterDate = quotationRegisterDate
      ..setProtectedQuantity(protectedQuantity);
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PaymentMethodsScreenDeprecated.routeName);
  }
}
