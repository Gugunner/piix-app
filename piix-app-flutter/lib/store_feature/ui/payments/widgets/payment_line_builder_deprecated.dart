import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/model/invoice_model.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/payment_line_app_bar_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/payment_line_general_info_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/payment_line_payment_info_deprecated.dart';

///This widget contains payment receipt data, receipt app bar, general info and
///payment info containers
///
///
final GlobalKey repaintKey = GlobalKey();

@Deprecated('Will be removed in 4.0')
class PaymentLineBuilderDeprecated extends StatefulWidget {
  const PaymentLineBuilderDeprecated({
    super.key,
    required this.paymentLine,
  });
  final InvoiceModel paymentLine;

  @override
  State<PaymentLineBuilderDeprecated> createState() =>
      _PaymentLineBuilderDeprecatedState();
}

class _PaymentLineBuilderDeprecatedState
    extends State<PaymentLineBuilderDeprecated> {
  @override
  void dispose() {
    final instance = PiixBannerDeprecated.instance;
    if (instance.entry != null) {
      instance.removeEntry();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: PiixColors.primary,
        child: SafeArea(
          child: SingleChildScrollView(
            child: RepaintBoundary(
              key: repaintKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PaymentLineAppBarDeprecated(paymentLine: widget.paymentLine),
                  PaymentLineGeneralInfoDeprecated(
                      paymentLine: widget.paymentLine),
                  PaymentLinePaymentInfoDeprecated(
                      paymentLine: widget.paymentLine),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
