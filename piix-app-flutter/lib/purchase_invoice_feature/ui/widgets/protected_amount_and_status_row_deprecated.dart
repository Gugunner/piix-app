import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/currency_extends.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/invoice_tag_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This row contains a transaction amount, total discount, protected covered tag
///and control status tag
///
class ProtectedAmountAndStatusRowDeprecated extends StatelessWidget {
  const ProtectedAmountAndStatusRowDeprecated(
      {super.key, required this.payment});
  final InvoiceModel payment;

  @override
  Widget build(BuildContext context) {
    final protectedQuantity =
        payment.protectedQuantityInCoverage.protectedQuantity;
    final includesMainUser =
        payment.protectedQuantityInCoverage.includesMainUser;
    //Add one to always include the main user
    final personsIncludedInProduct =
        protectedQuantity + (includesMainUser ? 1 : 0);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.width * 0.43,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ConstantsDeprecated.moneySymbol}'
                  '${payment.userQuotation.totalPremium.currencyFormat} '
                  '${ConstantsDeprecated.mxn}',
                  style: context.textTheme?.headlineSmall,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  PiixCopiesDeprecated.includedDiscount(
                    payment.percentageFinalDiscount.toStringAsFixed(2),
                  ),
                  style: context.accentTextTheme?.bodySmall?.copyWith(
                    color: PiixColors.infoDefault,
                  ),
                ),
              ],
            ),
          ),
          Tooltip(
            message: PiixCopiesDeprecated.protectedTooltipMessage(
              protectedQuantity,
              includesMainUser,
            ),
            verticalOffset: 15.h,
            decoration: BoxDecoration(
                color: PiixColors.mainText,
                borderRadius: BorderRadius.circular(4)),
            triggerMode: TooltipTriggerMode.tap,
            textStyle: context.textTheme?.labelMedium?.copyWith(
              color: PiixColors.space,
            ),
            showDuration: const Duration(
              seconds: 3,
            ),
            child: InvoiceTagDeprecated(
              tagColor: PiixColors.mainText,
              tagLabel: '$personsIncludedInProduct',
              tagIcon: Icons.group_outlined,
              width: context.width * 0.111,
            ),
          ),
          InvoiceTagDeprecated(
            tagColor: payment.colorBy(InvoiceElementDeprecated.tag),
            tagLabel: payment.productTag,
            width: context.width * 0.25,
            height: 28.h,
          ),
        ],
      ),
    );
  }
}
