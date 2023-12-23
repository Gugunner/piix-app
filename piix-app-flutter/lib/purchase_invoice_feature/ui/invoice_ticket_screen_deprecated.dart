import 'package:flutter/material.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/invoice_ticket_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class InvoiceTicketScreenDeprecated extends StatelessWidget {
  static const routeName = '/invoice_ticket_screen';
  const InvoiceTicketScreenDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(PiixCopiesDeprecated.purchaseTicket),
        centerTitle: true,
        elevation: 0,
      ),
      body: const InvoiceTicketBuilderDeprecated(),
    );
  }
}
