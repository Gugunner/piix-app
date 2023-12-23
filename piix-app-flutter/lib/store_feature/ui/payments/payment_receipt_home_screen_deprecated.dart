import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_banner_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/managing/payments_ui_state.dart';
import 'package:piix_mobile/store_feature/ui/payments/payment_receipt_builder_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/exit_receipt_dialog_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This is a home screen of receipt payment of a purchase, include a exit
///dialog, alert for success receipt generation and receipt payment builder
///
class PaymentReceiptHomeScreenDeprecated extends StatefulWidget {
  static const routeName = '/payment_receipt_home_screen';
  const PaymentReceiptHomeScreenDeprecated({Key? key}) : super(key: key);

  @override
  State<PaymentReceiptHomeScreenDeprecated> createState() =>
      _PaymentReceiptHomeScreenDeprecatedState();
}

class _PaymentReceiptHomeScreenDeprecatedState
    extends State<PaymentReceiptHomeScreenDeprecated> {
  late PaymentsUiState paymentUiState;

  @override
  void initState() {
    paymentUiState = PaymentsUiState(setState: setState);
    super.initState();
  }

  @override
  void dispose() {
    if (PiixBannerDeprecated.instance.entry != null) {
      PiixBannerDeprecated.instance.removeEntry();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitReceiptPayment(context),
      child: const Material(
        child: Stack(
          children: [
            Scaffold(
              body: PaymentReceiptBuilderDeprecated(),
            ),
          ],
        ),
      ),
    );
  }

  ///This future shows the dialog when you want to exit or return to the
  ///previous screen
  Future<bool> exitReceiptPayment(BuildContext context) async {
    final shouldPop = await handlePopDialog(context);
    PiixBannerDeprecated.instance.removeEntry();
    return shouldPop ?? false;
  }

  //This feature open a pop dialog to tell the user if he really wants to quit
  Future<bool?> handlePopDialog(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (_) {
          return const ExitReceiptDialogDeprecated();
        },
      );
}
