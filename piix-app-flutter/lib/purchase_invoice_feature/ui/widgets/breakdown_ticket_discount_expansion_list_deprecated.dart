import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/product_type_enum_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/discount_and_price.dart';

final marketTicketKey = GlobalKey();
final volumeTicketKey = GlobalKey();
final comboKey = GlobalKey();

@Deprecated('Will be removed in 4.0')

///This widget contains a expansion list for breakdown quote discounts
///includes volume discounts, market discounts, and combo discount when
///storeModule is StoreModules.combo
///
class BreakdownTicketDiscountExpansionListDeprecated extends StatelessWidget {
  const BreakdownTicketDiscountExpansionListDeprecated({
    super.key,
    required this.invoice,
  });
  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    final userQuotation = invoice.userQuotation;
    final productType = userQuotation.productType;
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          listTileTheme: ListTileTheme.of(context).copyWith(dense: true)),
      child: ExpansionTile(
        collapsedBackgroundColor: PiixColors.greyWhite,
        backgroundColor: PiixColors.greyWhite,
        textColor: PiixColors.infoDefault,
        iconColor: PiixColors.darkSkyBlue,
        collapsedIconColor: PiixColors.darkSkyBlue,
        title: Text(
          PiixCopiesDeprecated.breakdownQuote,
          style: context.primaryTextTheme?.titleSmall,
        ),
        childrenPadding: EdgeInsets.all(ConstantsDeprecated.mediumPadding.h),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DiscountAndPriceDeprecated(
            amount: userQuotation.marketDiscountAmount,
            label: PiixCopiesDeprecated.marketDiscount,
            tooltipMessage: PiixCopiesDeprecated.tooltipMarketDiscount,
            discount: userQuotation.marketDiscount,
            tooltipKey: marketTicketKey,
          ),
          SizedBox(
            height: ConstantsDeprecated.mediumPadding.h,
          ),
          DiscountAndPriceDeprecated(
            amount: userQuotation.volumeDiscountAmount,
            label: PiixCopiesDeprecated.volumeDiscount,
            tooltipMessage: PiixCopiesDeprecated.tooltipVolumeDiscount,
            discount: userQuotation.volumeDiscount,
            tooltipKey: volumeTicketKey,
          ),
          if (productType == ProductTypeDeprecated.COMBO)
            Container(
              margin: EdgeInsets.only(
                top: ConstantsDeprecated.mediumPadding.h,
              ),
              child: DiscountAndPriceDeprecated(
                amount: userQuotation.comboDiscountAmount,
                label: PiixCopiesDeprecated.comboDiscount,
                tooltipMessage: PiixCopiesDeprecated.tooltipComboDiscount,
                discount: userQuotation.comboDiscount,
                tooltipKey: comboKey,
              ),
            )
        ],
      ),
    );
  }
}
