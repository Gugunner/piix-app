import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/currency_extends.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

@Deprecated('Will be removed in 4.0')

///This card shos a total premium text and amount, with 'included tax' text
///
class TotalPremiumCardDeprecated extends StatelessWidget {
  const TotalPremiumCardDeprecated({
    super.key,
    required this.finalTotalPremiumAmount,
    required this.totalBuyText,
    required this.purchaseName,
  });

  ///This text introduces us to what we are going to buy
  final String totalBuyText;

  ///This is the name of what we are going to buy (name of the additionañ benefit,
  ///the combo, the plan or the level)
  final String purchaseName;

  ///This is the amount final to pay
  final double finalTotalPremiumAmount;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
      color: PiixColors.skeletonGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '$totalBuyText '),
                TextSpan(
                  text: '$purchaseName ',
                  style: context.primaryTextTheme?.titleMedium?.copyWith(
                    color: PiixColors.primary,
                  ),
                ),
                TextSpan(
                    text: 'es ${ConstantsDeprecated.moneySymbol}'
                        '${finalTotalPremiumAmount.currencyFormat} '
                        '${ConstantsDeprecated.mxn}',)
              ],
            ),
            style: context.primaryTextTheme?.bodyMedium?.copyWith(
              color: PiixColors.primary,
            ),
            textAlign: TextAlign.start,
          ).padBottom(16.h),
          Text(
            PiixCopiesDeprecated.priceIncludesTaxes,
            style: context.accentTextTheme?.bodySmall?.copyWith(
              color: PiixColors.primary,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ).padOnly(
        top: mediumPadding.h,
        bottom: 8.h,
        left: 5.w,
        right: 12.w,
      ),
    );
  }
}
