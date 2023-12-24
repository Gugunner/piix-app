import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/cancel_invoice_ticket_button.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/row_text_invoice_card_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/constants_deprecated/purchase_invoice_copies_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class DateAndPaymentSectionDeprecated extends StatelessWidget {
  const DateAndPaymentSectionDeprecated({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              PiixCopiesDeprecated.dateAndPay,
              style: context.textTheme?.headlineSmall?.copyWith(
                color: PiixColors.primary,
              ),
            ),
            if (invoice.isCancelable)
              CancelInvoiceTicketButton(
                purchaseInvoiceId: invoice.purchaseInvoiceId,
              ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.ticketNumber}:',
          rightText: invoice.purchaseInvoiceId,
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.primaryTextTheme?.bodyMedium,
          hasTooltip: true,
        ),
        SizedBox(
          height: 8.h,
        ),
        ...invoice.invoiceDates.map(
          (date) => Container(
            margin: EdgeInsets.symmetric(
              vertical: 4.h,
            ),
            child: RowTextInvoiceCardDeprecated(
              leftText: date.name,
              rightText: date.date.dateFormatTime,
              leftStyle: context.primaryTextTheme?.titleSmall,
              rightStyle: context.textTheme?.bodyMedium,
            ),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PiixCopiesDeprecated.paymentMethod}:',
          rightText: invoice.paymentMethodName,
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.primaryTextTheme?.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        RowTextInvoiceCardDeprecated(
          leftText: '${PurchaseInvoiceCopiesDeprecated.paymentReference}:',
          rightText: invoice.paymentMethodReferenceId,
          leftStyle: context.primaryTextTheme?.titleSmall,
          rightStyle: context.primaryTextTheme?.bodyMedium,
        ),
        Divider(height: 32.h),
      ],
    );
  }
}
