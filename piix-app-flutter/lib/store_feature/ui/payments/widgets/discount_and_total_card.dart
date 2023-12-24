import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/obtained_discount_card.dart';
import 'package:piix_mobile/store_feature/ui/quotations/widgets/total_premium_card.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:provider/provider.dart';

///This is a row with discount and total premium cards
///
class DiscountAndTotalCard extends StatelessWidget {
  const DiscountAndTotalCard({super.key});

  double get minPadding => ConstantsDeprecated.minPadding;

  @override
  Widget build(BuildContext context) {
    final paymentsBLoC = context.read<PaymentsBLoCDeprecated>();
    return IntrinsicHeight(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ObtainedDiscountCardDeprecated(
          finalDiscount: paymentsBLoC.paymentDiscount,
        ).padRight(minPadding.w),
        Expanded(
            child: TotalPremiumCardDeprecated(
          finalTotalPremiumAmount: paymentsBLoC.transactionAmount,
          totalBuyText: paymentsBLoC.moduleToPay!.getTotalBuyTextExtension,
          purchaseName: paymentsBLoC.paymentPurchaseName,
        )),
      ],
    ));
  }
}
