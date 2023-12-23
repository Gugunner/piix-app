import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/cancel_ticket_invoice_dialog.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:provider/provider.dart';

class CancelInvoiceTicketButton extends StatelessWidget {
  const CancelInvoiceTicketButton({super.key, required this.purchaseInvoiceId});
  final String purchaseInvoiceId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleCancelTicketInvoice(context),
      child: Text(
        PiixCopiesDeprecated.cancelTicket,
        style: context.accentTextTheme?.headlineLarge?.copyWith(
          color: PiixColors.active,
        ),
      ),
    );
  }

  void handleCancelTicketInvoice(BuildContext context) {
    final paymentBLoC = context.read<PaymentsBLoCDeprecated>();
    paymentBLoC.cancelPaymentState = PaymentStateDeprecated.idle;
    showDialog<bool>(
      context: context,
      barrierColor: PiixColors.mainText.withOpacity(0.62),
      builder: (_) =>
          CancelTicketInvoiceDialog(purchaseInvoiceId: purchaseInvoiceId),
    );
  }
}
