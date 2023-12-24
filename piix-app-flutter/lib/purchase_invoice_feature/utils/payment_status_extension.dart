import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/purchase_invoice_enums.dart';

///This extension contains all utils for payment status
///
extension PaymentStatusExtends on PaymentStatus {
  String getDateFromStatus(InvoiceModel payment) {
    final dateNow = DateTime.now();
    if (dateNow.isAfter(payment.expirationDate)) {
      return payment.expirationDate.dateFormatTime;
    } else {
      switch (this) {
        case PaymentStatus.approved:
          return payment.approvedDate?.dateFormatTime ?? '';
        case PaymentStatus.cancelled:
          return payment.updateDate?.dateFormatTime ?? '';
        default:
          return '';
      }
    }
  }
}
