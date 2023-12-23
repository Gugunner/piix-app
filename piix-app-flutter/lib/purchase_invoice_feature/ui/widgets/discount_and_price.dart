import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/currency_extends.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';
import 'package:piix_mobile/ui/common/piix_tooltip_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a row with label, amoun and discount
///
class DiscountAndPriceDeprecated extends StatelessWidget {
  const DiscountAndPriceDeprecated({
    super.key,
    required this.label,
    required this.tooltipKey,
    this.isTotal = false,
    this.labelStyle,
    this.rightLabelStyle,
    this.amount = 0,
    this.tooltipMessage,
    this.discount,
    this.discountStyle,
  });

  ///It is the amount in currency that you want to show
  final double amount;

  ///It is the copy that you want to show
  final String label;

  ///It is the style for label
  final TextStyle? labelStyle;

  ///It is the style for label
  final TextStyle? rightLabelStyle;

  ///This is the message that is displayed in the tooltip, when you have a
  ///tooltip
  final String? tooltipMessage;

  ///It is the discount in decimal number that you want to show
  final double? discount;

  ///It is the style for discount
  final TextStyle? discountStyle;

  ///This flag helps us to generate the discount text when it is a total and
  ///when it is not.
  final bool isTotal;
  final GlobalKey tooltipKey;

  String get discountTotal => '${PiixCopiesDeprecated.discountOf} '
      '${ConstantsDeprecated.moneySymbol}${amount.currencyFormat}';

  String get discountLabel =>
      discount != null ? discountTotal : PiixCopiesDeprecated.withoutDiscount;

  String get amountText => '${discount!.toPercentage.toStringAsFixed(2)}%';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: labelStyle ?? context.textTheme?.bodyMedium),
            if (tooltipMessage != null)
              GestureDetector(
                onTap: () {
                  PiixTooltipDeprecated(
                    offsetKey: tooltipKey,
                    showCloseButton: true,
                    backgroundColor: PiixColors.mainText,
                    content: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                      ),
                      width: 200.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            tooltipMessage ?? '',
                            style: context.textTheme?.labelMedium?.copyWith(
                              color: PiixColors.space,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ).controller?.showTooltip();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Icon(
                    Icons.info_outline,
                    key: tooltipKey,
                    size: 12.h,
                    color: PiixColors.clearBlue,
                  ),
                ),
              ),
            Expanded(
              child: Text(
                '$amountText ',
                textAlign: TextAlign.end,
                style: rightLabelStyle ??
                    labelStyle ??
                    context.textTheme?.bodyMedium,
              ),
            )
          ],
        ),
        Text(
          '$discountLabel ${ConstantsDeprecated.mxn}',
          style: discountStyle ?? context.textTheme?.labelMedium,
        ),
      ],
    );
  }
}
