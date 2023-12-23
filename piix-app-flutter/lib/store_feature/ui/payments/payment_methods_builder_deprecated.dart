import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/managing/payments_ui_state.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/payment_receipt_alert_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/state_switcher_payment_methods_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget render a payment methods switcher states ui
///
class PaymentMethodsBuilderDeprecated extends StatefulWidget {
  const PaymentMethodsBuilderDeprecated({super.key});

  @override
  State<PaymentMethodsBuilderDeprecated> createState() =>
      _PaymentMethodsBuilderDeprecatedState();
}

class _PaymentMethodsBuilderDeprecatedState
    extends State<PaymentMethodsBuilderDeprecated> {
  late PaymentsUiState paymentUiState;
  late Future<void> getPaymentsMethodsFuture;
  late PaymentsBLoCDeprecated paymentsBLoC;
  static const error = PaymentStateDeprecated.error;
  static const unexpectedError = PaymentStateDeprecated.unexpectedError;
  static const badRequest = PaymentStateDeprecated.badRequest;

  @override
  void initState() {
    getPaymentsMethodsFuture = getPaymentsMethods();
    paymentUiState = PaymentsUiState(setState: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usefullScreenHeight = context.height - kToolbarHeight;
    paymentsBLoC = context.watch<PaymentsBLoCDeprecated>();
    final userPaymentState = paymentsBLoC.userPaymentState;
    return FutureBuilder<void>(
      future: getPaymentsMethodsFuture,
      builder: (_, __) {
        return Stack(
          children: [
            SizedBox(
              height: usefullScreenHeight,
              width: context.width,
              child: StateSwitcherPaymentMethodsDeprecated(
                retryGetPaymentsMethods: retryGetPaymentsMethods,
              ),
            ),
            if (userPaymentState == error ||
                userPaymentState == unexpectedError ||
                userPaymentState == badRequest)
              PaymentReceiptAlertDeprecated(
                alertType: AlertTypeDeprecated.error,
                paymentsUiState: paymentUiState,
              )
          ],
        );
      },
    );
  }

  //This future, retrieve a level quotation to acquire
  Future<void> getPaymentsMethods() async {
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => paymentsBLoC.getPaymentsMethods());
    if (paymentsBLoC.paymentState != PaymentStateDeprecated.accomplished) {
      paymentUiState.paymentMethodAlertState = AlertStateDeprecated.show;
    }
  }

  //This function resets the future of getQuotationLevelByMembership, and
  //reruns it
  void retryGetPaymentsMethods() => setState(() {
        getPaymentsMethodsFuture = getPaymentsMethods();
      });
}
