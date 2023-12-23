import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/exit_receipt_dialog_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This is a receipt exit button, include a handle exit dialog
///
class ReceiptExitButtonDeprecated extends StatelessWidget {
  const ReceiptExitButtonDeprecated({
    super.key,
    required this.paymentLine,
  });
  final InvoiceModel paymentLine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.width * 0.525,
        height: 30.h,
        child: ElevatedButton(
            onPressed: !paymentLine.isPaymentInvoice
                ? () => Navigator.pop(context)
                : () => handlePopDialog(context),
            child: Text(
              PiixCopiesDeprecated.exit.toUpperCase(),
              style: context.primaryTextTheme?.titleMedium?.copyWith(
                color: PiixColors.space,
              ),
            )));
  }

  //This feature open a pop dialog to tell the user if he really wants to quit
  Future<bool?> handlePopDialog(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (_) => const ExitReceiptDialogDeprecated(),
      );
}
