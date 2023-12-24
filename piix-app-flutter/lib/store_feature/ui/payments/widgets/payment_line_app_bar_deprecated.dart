import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/exit_receipt_dialog_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains a receipt app bar, includes a exit action icon button
///with handle pop dialog
///
class PaymentLineAppBarDeprecated extends StatelessWidget {
  const PaymentLineAppBarDeprecated({super.key, required this.paymentLine});
  final InvoiceModel paymentLine;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        PiixCopiesDeprecated.paymentLineTitle,
        style: context.textTheme?.titleLarge?.copyWith(
          color: PiixColors.space,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: !paymentLine.isPaymentInvoice
                ? () => Navigator.pop(context)
                : () => handlePopDialog(context),
            icon: Icon(
              Icons.close,
              size: 22.h,
            ))
      ],
    );
  }

  //This feature open a pop dialog to tell the user if he really wants to quit
  Future<bool?> handlePopDialog(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (_) => const ExitReceiptDialogDeprecated(),
      );
}
