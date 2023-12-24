import 'package:piix_mobile/purchase_invoice_feature/utils/purchase_invoice_enums.dart';

extension PaymentStatusBoolExtended on PaymentStatus {

  bool paymentUnavailable(DateTime expirationDate) {
    final now = DateTime.now();
    if (now.isAfter(expirationDate)) {
      return false;
    } else {
      switch (this) {
        case PaymentStatus.authorized:
        case PaymentStatus.in_process:
        case PaymentStatus.pending:
          return true;
        default:
          return false;
      }
    }
  }
}
