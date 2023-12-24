import 'package:flutter/material.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/purchase_invoice_builder_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';

@Deprecated('Will be removed in 4.0')

/// The entire history of user additions is displayed, includes the app bar and
/// purchase invoice builder
///
class PurchaseInvoiceHistoryScreenDeprecated extends StatelessWidget {
  static const routeName = '/purchase_invoice_history';
  const PurchaseInvoiceHistoryScreenDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(PiixCopiesDeprecated.purchaseHistory),
        centerTitle: true,
        elevation: 0,
      ),
      body: const PurchaseInvoiceBuilderDeprecated(),
    );
  }
}
