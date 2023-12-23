import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/purchase_invoice_enums.dart';

extension PaymentStatusColorExtension on PaymentStatus {
  Color getColorPaymentStatus(DateTime expirationDate) {
    // final dateNow = DateTime.now();
    // if (dateNow.isAfter(expirationDate)) {
    //   return PiixColors.errorMain;
    // }
    switch (this) {
      case PaymentStatus.approved:
        return PiixColors.successMain;
      case PaymentStatus.in_process:
      case PaymentStatus.pending:
        return PiixColors.discountSolidBackground;
      case PaymentStatus.cancelled:
      //Debit or credit card status
      case PaymentStatus.in_mediation:
      case PaymentStatus.authorized:
      case PaymentStatus.rejected:
      case PaymentStatus.charged_back:
      case PaymentStatus.refunded:
        return PiixColors.errorMain;
      default:
        return Colors.transparent;
    }
  }
}
