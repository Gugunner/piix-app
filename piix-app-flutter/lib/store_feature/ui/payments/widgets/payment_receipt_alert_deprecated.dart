import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_alert_info_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/managing/payments_ui_state.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a payment alert, use a alert type for render a specific color
/// and text depends the state
///
class PaymentReceiptAlertDeprecated extends StatefulWidget {
  const PaymentReceiptAlertDeprecated({
    super.key,
    required this.paymentsUiState,
    required this.alertType,
  });
  final PaymentsUiState paymentsUiState;
  final AlertTypeDeprecated alertType;

  @override
  State<PaymentReceiptAlertDeprecated> createState() =>
      _PaymentReceiptAlertDeprecatedState();
}

class _PaymentReceiptAlertDeprecatedState
    extends State<PaymentReceiptAlertDeprecated> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10), () {
      widget.paymentsUiState.hidePaymentMethodAlert(mounted);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentBLoC = context.watch<PaymentsBLoCDeprecated>();
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: widget.alertType.getPaymentsAlertColor,
        ),
        PiixAlertInfoDeprecated(
          title: widget.alertType.getPaymentTitleAlertMessage,
          subtitle: widget.alertType.getPaymentSubTitleAlertMessage,
          icon: widget.alertType.getPaymentTitleAlertIcon,
          backgroundColor: widget.alertType.getPaymentsAlertColor,
          onClose: () =>
              paymentBLoC.userPaymentState = PaymentStateDeprecated.idle,
        ),
      ],
    );
  }
}
