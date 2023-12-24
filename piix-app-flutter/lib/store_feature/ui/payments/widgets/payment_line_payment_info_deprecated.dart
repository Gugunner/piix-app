import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/utils/extensions/string_extend.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/bar_code_container.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/receipt_actions_row_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/receipt_exit_button_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/receipt_payment_images.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/reference_container.dart';
import 'package:piix_mobile/store_feature/utils/store_copies.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains a payment receipt info as payment place, payment
///reference or capture line, and exit button
///
class PaymentLinePaymentInfoDeprecated extends StatelessWidget {
  const PaymentLinePaymentInfoDeprecated({
    super.key,
    required this.paymentLine,
  });
  final InvoiceModel paymentLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      width: context.width,
      color: PiixColors.white,
      child: Column(children: [
        SizedBox(height: 12.h),
        Text(
          PiixCopiesDeprecated.cashToPayment,
          style: context.textTheme?.headlineSmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        ReceiptPaymentImagesDeprecated(
          paymentLine: paymentLine,
        ),
        SizedBox(height: 12.h),
        Text(
          StoreCopiesDeprecated.considerCommission,
          style: context.textTheme?.bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        if (paymentLine.barcode.isNotNullEmpty)
          BarcodeContainer(
            barcode: paymentLine.barcode,
            barcodeType: paymentLine.barcodeType,
          ),
        if (paymentLine.accountNumber.isNotNullEmpty)
          ReferenceContainer(
            accountNumber: paymentLine.accountNumber,
            paymentMethodReferenceId: paymentLine.paymentMethodReferenceId,
          ),
        SizedBox(height: 12.h),
        Text(
          PiixCopiesDeprecated.findPaymentLines,
          style: context.textTheme?.bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        SizedBox(
          child: Text(
            '${StoreCopiesDeprecated.beneficiary}\n ${paymentLine.beneficiaryName}',
            style: context.textTheme?.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        ReceiptActionsRowDeprecated(
          expirationDate: paymentLine.expirationDate,
          paymentMethodId: paymentLine.paymentMethodId,
          paymentMethodName: paymentLine.paymentMethodName,
        ),
        SizedBox(height: 24.h),
        Text(
          PiixCopiesDeprecated.backedUp,
          style: context.primaryTextTheme?.titleSmall,
        ),
        Image.asset(
          PiixAssets.mercadoPagoLogo,
          height: 53.h,
        ),
        SizedBox(height: 12.h),
        ReceiptExitButtonDeprecated(
          paymentLine: paymentLine,
        ),
        SizedBox(height: 24.h),
      ]),
    );
  }
}
