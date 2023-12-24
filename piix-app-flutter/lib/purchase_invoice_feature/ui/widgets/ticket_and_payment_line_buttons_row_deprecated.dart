import 'package:flutter/material.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/invoice_ticket_screen_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/payment_line_from_invoice_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class TicketAndPaymentLineButtonsRowDeprecated extends StatelessWidget {
  const TicketAndPaymentLineButtonsRowDeprecated(
      {super.key, required this.payment});
  final InvoiceModel payment;

  DateTime get dateNow => DateTime.now();

  @override
  Widget build(BuildContext context) {
    final paymentAvailable = payment.invoiceStatus.paymentAvailable;
    return Row(
      mainAxisAlignment: paymentAvailable
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        if (paymentAvailable)
          ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () => handleNavigateToPaymentLineScreen(context),
              child: Text(
                PiixCopiesDeprecated.paymentLineTitle.toUpperCase(),
                style: context.accentTextTheme?.labelMedium?.copyWith(
                  color: PiixColors.space,
                ),
              )),
        TextButton(
          style: Theme.of(context).textButtonTheme.style,
          onPressed: () => handleNavigateToDetailScreen(context),
          child: Text(
            PiixCopiesDeprecated.viewTicket.toUpperCase(),
            style: context.primaryTextTheme?.titleMedium?.copyWith(
              color: PiixColors.active,
            ),
          ),
        ),
      ],
    );
  }

  void handleNavigateToPaymentLineScreen(BuildContext context) {
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    purchaseInvoiceBLoC.setInvoice(null);
    purchaseInvoiceBLoC.paymentLineFromList = payment;
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PaymentLineFromInvoiceDeprecated.routeName);
  }

  void handleNavigateToDetailScreen(BuildContext context) {
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    purchaseInvoiceBLoC.setInvoice(payment);
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(InvoiceTicketScreenDeprecated.routeName);
  }
}
