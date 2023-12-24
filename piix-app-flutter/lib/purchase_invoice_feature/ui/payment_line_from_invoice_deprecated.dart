import 'package:flutter/material.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/payment_line_builder_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')
class PaymentLineFromInvoiceDeprecated extends StatelessWidget {
  static const routeName = '/catch_line_from_ticket';
  const PaymentLineFromInvoiceDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    final paymentLine =
        purchaseInvoiceBLoC.invoice ?? purchaseInvoiceBLoC.paymentLineFromList;

    if (paymentLine == null) return const SizedBox();
    return PaymentLineBuilderDeprecated(
      paymentLine: paymentLine,
    );
  }
}
