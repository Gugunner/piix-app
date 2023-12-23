import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a column of payment method places images rows
///
class ReceiptPaymentImagesDeprecated extends StatelessWidget {
  const ReceiptPaymentImagesDeprecated({
    super.key,
    required this.paymentLine,
  });
  final InvoiceModel paymentLine;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 8.w,
      alignment: WrapAlignment.center,
      children: [
        ...getPaymentPlacesForPaymentLine(
                methodId: paymentLine.paymentMethodId,
                methodName: paymentLine.paymentMethodName)
            .map((e) => Image.asset(
                  e.asset,
                  height: 48.h,
                  fit: BoxFit.cover,
                )),
      ],
    ).padHorizontal(16.w);
  }
}
