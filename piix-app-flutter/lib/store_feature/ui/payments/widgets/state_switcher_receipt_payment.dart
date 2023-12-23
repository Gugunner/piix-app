import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/payment_line_builder_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/receipt_payment_skeleton_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget includes a state switcher ui for a receipt payment
///depending on the state is the specific ui displayed
///
class StateSwitcherReceiptPaymentDeprecated extends StatelessWidget {
  const StateSwitcherReceiptPaymentDeprecated(
      {super.key, this.retryMakeUserPayment});
  final void Function()? retryMakeUserPayment;

  static const getting = PaymentStateDeprecated.getting;
  static const idle = PaymentStateDeprecated.idle;
  static const accomplished = PaymentStateDeprecated.accomplished;
  static const empty = PaymentStateDeprecated.empty;

  @override
  Widget build(BuildContext context) {
    final paymentsBLoC = context.watch<PaymentsBLoCDeprecated>();
    final userPaymentModel = paymentsBLoC.userPaymentModel;
    final userPaymentState = paymentsBLoC.userPaymentState;
    switch (userPaymentState) {
      case getting:
      case idle:
        return const ReceiptPaymentSkeletonDeprecated();
      case accomplished:
        return PaymentLineBuilderDeprecated(
          paymentLine: userPaymentModel!,
        );
      case empty:
      case PaymentStateDeprecated.notFound:
        return PiixErrorScreenDeprecated(
          errorMessage: PiixCopiesDeprecated.notInfoInReceipt,
          onTap: retryMakeUserPayment,
        );
      default:
        return PiixErrorScreenDeprecated(
          errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
          onTap: retryMakeUserPayment,
        );
    }
  }
}
