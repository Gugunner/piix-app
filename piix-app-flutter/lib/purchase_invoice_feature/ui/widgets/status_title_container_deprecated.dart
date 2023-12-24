import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a status title container for a purchase invoice card
///
class StatusTitleContainerDeprecated extends StatelessWidget {
  const StatusTitleContainerDeprecated({super.key, required this.payment});
  final InvoiceModel payment;

  @override
  Widget build(BuildContext context) {
    final invoiceStatus = payment.invoiceStatus;
    return Container(
      width: context.width,
      height: 32.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: payment.colorBy(InvoiceElementDeprecated.payment),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(4),
        ),
      ),
      child: Text(
        '${invoiceStatus.paymentInvoiceTextStatus}',
        style: context.primaryTextTheme?.titleSmall?.copyWith(
          color: PiixColors.space,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
