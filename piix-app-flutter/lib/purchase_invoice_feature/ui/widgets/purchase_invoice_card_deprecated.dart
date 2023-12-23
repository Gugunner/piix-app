import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/protected_amount_and_status_row_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/row_text_invoice_card_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/status_title_container_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/ticket_and_payment_line_buttons_row_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/constants_deprecated/purchase_invoice_copies_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// This card contains the general data of an addition and allows browsing to
/// its detail or depending on the status of the payment to the capture line,
/// to the payment receipt or to the purchase catalog.
class PurchaseInvoiceCardDeprecated extends StatelessWidget {
  const PurchaseInvoiceCardDeprecated({super.key, required this.invoice});
  final InvoiceModel invoice;

  DateTime get dateNow => DateTime.now();
  double get paddingBottom =>
      invoice.invoiceStatus
          .maybeMap((value) => 24, expired: (_) => 8, orElse: () => 24) ??
      24;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusTitleContainerDeprecated(
            payment: invoice,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.w,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: context.width,
                  child: Text(
                    '${invoice.products.productName}',
                    style: context.textTheme?.headlineSmall,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 8.h,
                  ),
                  child: ProtectedAmountAndStatusRowDeprecated(
                    payment: invoice,
                  ),
                ),
                RowTextInvoiceCardDeprecated(
                  leftText: PurchaseInvoiceCopiesDeprecated.paymentReference,
                  rightText: invoice.paymentId,
                  leftStyle: context.primaryTextTheme?.bodyMedium,
                  rightStyle: context.textTheme?.bodyMedium,
                ),
                const Divider(),
                ...invoice.invoiceDates.map(
                  (date) => RowTextInvoiceCardDeprecated(
                    leftText: date.name,
                    rightText: date.date.dateFormatTime,
                    leftStyle: context.primaryTextTheme?.bodyMedium,
                    rightStyle: context.textTheme?.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                TicketAndPaymentLineButtonsRowDeprecated(
                  payment: invoice,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
