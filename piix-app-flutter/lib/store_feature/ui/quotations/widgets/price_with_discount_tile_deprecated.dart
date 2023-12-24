import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/currency_extends.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/utils/combos.dart';
import 'package:piix_mobile/ui/common/piix_tooltip_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a row with label, amount and discount
///
class PriceWithDiscountTileDeprecated extends StatelessWidget {
  const PriceWithDiscountTileDeprecated({
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

  String get discountTotal => isTotal
      ? '${PiixCopiesDeprecated.withLabel} ${discount!.toPercentage.toStringAsFixed(2)}% '
          '${PiixCopiesDeprecated.ofDiscount}'
      : '${PiixCopiesDeprecated.discountOf} '
          '${discount!.toPercentage.toStringAsFixed(2)}%';

  String get discountLabel =>
      discount != null ? discountTotal : PiixCopiesDeprecated.withoutDiscount;

  String get amountText => amount.currencyFormat;

  bool get containsDiscount => label.toLowerCase().contains('descuento');

  String get minusSign => containsDiscount ? '-' : '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: labelStyle ?? context.textTheme?.titleMedium,
            ),
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
                            Text(
                              tooltipMessage ?? '',
                              style: context.textTheme?.labelMedium?.copyWith(
                                color: PiixColors.space,
                              ),
                              textAlign: TextAlign.justify,
                            ).padTop(4.h),
                          ],
                        ),
                      )).controller?.showTooltip();
                },
                child: Icon(
                  Icons.info_outline,
                  key: tooltipKey,
                  size: 12.h,
                  color: PiixColors.clearBlue,
                ),
              ).padLeft(4.w),
            Expanded(
              child: Text(
                  '$minusSign${ConstantsDeprecated.moneySymbol}$amountText '
                  '${ConstantsDeprecated.mxn}',
                  textAlign: TextAlign.end,
                  style: rightLabelStyle ??
                      labelStyle ??
                      context.textTheme?.titleMedium),
            )
          ],
        ),
        Text(
          discountLabel,
          style: discountStyle ?? context.textTheme?.labelMedium,
        )
      ],
    );
  }
}
