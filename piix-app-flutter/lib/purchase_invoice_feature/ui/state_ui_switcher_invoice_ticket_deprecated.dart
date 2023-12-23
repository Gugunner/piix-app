import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/data/repository/purchase_invoices_repository_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/invoice_ticket_data_deprecated.dart';
import 'package:provider/provider.dart';

import 'skeletons/invoice_ticket_skeleton_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class StateUiSwitcherInvoiceTicketDeprecated extends StatelessWidget {
  const StateUiSwitcherInvoiceTicketDeprecated({
    super.key,
    required this.retryPurchaseDetail,
  });
  final void Function()? retryPurchaseDetail;

  static const getting = InvoiceStateDeprecated.getting;
  static const idle = InvoiceStateDeprecated.idle;
  static const accomplished = InvoiceStateDeprecated.accomplished;
  static const unexpectedError = InvoiceStateDeprecated.unexpectedError;
  static const error = InvoiceStateDeprecated.error;
  static const notFound = InvoiceStateDeprecated.notFound;

  @override
  Widget build(BuildContext context) {
    final purchaseInvoiceBLoC = context.watch<PurchaseInvoiceBLoCDeprecated>();
    final invoiceTicketState = purchaseInvoiceBLoC.invoiceTicketState;
    switch (invoiceTicketState) {
      case getting:
      case idle:
        return const InvoiceTicketSkeletonDeprecated();
      case accomplished:
        return const InvoiceTicketDataDeprecated();
      case notFound:
        return PiixErrorScreenDeprecated(
          errorMessage: PiixCopiesDeprecated.ticketNotFound,
          onTap: () => Navigator.pop(context),
          buttonLabel: PiixCopiesDeprecated.backText,
        );
      case error:
      case unexpectedError:
      case InvoiceStateDeprecated.conflict:
        return PiixErrorScreenDeprecated(
          errorMessage: PiixCopiesDeprecated.unexpectedError,
          onTap: retryPurchaseDetail,
        );
      default:
        return const SizedBox();
    }
  }
}
