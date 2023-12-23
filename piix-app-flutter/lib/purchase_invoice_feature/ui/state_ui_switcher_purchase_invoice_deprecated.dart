import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_repository_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/purchase_invoice_data_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/purchase_invoice_empty.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/skeletons/purchase_invoice_history_skeleton_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///Depending on the state it can
///render the skeleton loader, the data screen, or the error messages or empty
///as well as a button to retry loading the data
///
class StateUiSwitcherPurchaseInvoiceDeprecated extends StatelessWidget {
  const StateUiSwitcherPurchaseInvoiceDeprecated(
      {super.key, required this.retryPurchaseInvoice});
  final void Function()? retryPurchaseInvoice;

  static const getting = InvoiceStateDeprecated.getting;
  static const idle = InvoiceStateDeprecated.idle;
  static const accomplished = InvoiceStateDeprecated.accomplished;
  static const empty = InvoiceStateDeprecated.empty;
  static const unexpectedError = InvoiceStateDeprecated.unexpectedError;
  static const error = InvoiceStateDeprecated.error;

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    final invoiceState = purchaseInvoiceBLoC.invoiceState;
    switch (invoiceState) {
      case getting:
      case idle:
        return const Expanded(
            child: PurchaseInvoiceHistorySkeletonDeprecated());
      case accomplished:
        return const Expanded(child: PurchaseInvoiceDataDeprecated());
      case empty:
      case InvoiceStateDeprecated.notFound:
        return const Expanded(child: PurchaseInvoiceEmptyDeprecated());
      case unexpectedError:
      case error:
      case InvoiceStateDeprecated.conflict:
        return PiixErrorScreenDeprecated(
          errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
          onTap: retryPurchaseInvoice,
        );

      default:
        return const SizedBox();
    }
  }
}
