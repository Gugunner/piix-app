import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/invoice_history_tooltip_content_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/purchase_invoice_instructions_container_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_tooltip_deprecated.dart';
import 'package:provider/provider.dart';

import 'widgets/purchase_invoice_card_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget render purchase invoice cards, title, instructions and tooltip
///
class PurchaseInvoiceDataDeprecated extends StatelessWidget {
  const PurchaseInvoiceDataDeprecated({
    super.key,
  });

  PiixTooltipDeprecated? get tooltipHistory => PiixTooltipDeprecated(
        offsetKey: purchaseInvoiceKey,
        showCloseButton: true,
        backgroundColor: PiixColors.mainText,
        content: const InvoiceHistoryTooltipContentDeprecated(),
      );

  void handleShowTooltip() {
    if (tooltipHistory != null && purchaseInvoiceKey.currentContext != null) {
      tooltipHistory!.controller?.showTooltip();
    }
  }

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 24.h,
      ),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                PiixCopiesDeprecated.purchaseHistory,
                style: context.primaryTextTheme?.displayMedium,
              ),
              GestureDetector(
                onTap: handleShowTooltip,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 4.w,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    key: purchaseInvoiceKey,
                    size: 11.h,
                    color: PiixColors.clearBlue,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          const PurchaseInvoiceInstructionsContainerDeprecated(),
          SizedBox(
            height: 8.h,
          ),
          ...purchaseInvoiceBLoC.purchaseInvoiceList.map(
            (payment) => Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.h,
              ),
              child: PurchaseInvoiceCardDeprecated(
                invoice: payment,
              ),
            ),
          )
        ],
      ),
    );
  }
}
