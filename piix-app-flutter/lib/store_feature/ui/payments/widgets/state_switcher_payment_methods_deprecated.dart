import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/piix_error_screen_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/widgets/payments_methods_data.dart';
import 'package:piix_mobile/store_feature/ui/skeletons/payment_method_skeleton.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///Depending on the state it can
///render the skeleton loader, the data screen, or the error messages or empty
///as well as a button to retry loading the data
///
class StateSwitcherPaymentMethodsDeprecated extends StatelessWidget {
  const StateSwitcherPaymentMethodsDeprecated({
    super.key,
    required this.retryGetPaymentsMethods,
  });
  final void Function()? retryGetPaymentsMethods;

  static const getting = PaymentStateDeprecated.getting;
  static const idle = PaymentStateDeprecated.idle;
  static const accomplished = PaymentStateDeprecated.accomplished;
  static const unexpectedError = PaymentStateDeprecated.unexpectedError;
  static const error = PaymentStateDeprecated.error;
  static const empty = PaymentStateDeprecated.empty;

  @override
  Widget build(BuildContext context) {
    final paymentsBLoC = context.watch<PaymentsBLoCDeprecated>();
    final paymentState = paymentsBLoC.paymentState;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (paymentState == getting || paymentState == idle)
          const Expanded(child: PaymentMethodSkeleton())
        else if (paymentState == accomplished)
          const Expanded(child: PaymentsMethodsData())
        else if (paymentState == empty ||
            paymentState == PaymentStateDeprecated.notFound)
          PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.emptyPaymentMethods,
            buttonLabel: PiixCopiesDeprecated.refreshLabel.toUpperCase(),
            onTap: retryGetPaymentsMethods,
          )
        else if (paymentState == unexpectedError ||
            paymentState == error ||
            paymentState == PaymentStateDeprecated.conflict)
          PiixErrorScreenDeprecated(
            errorMessage: PiixCopiesDeprecated.unexpectedErrorStore,
            onTap: retryGetPaymentsMethods,
          )
      ],
    );
  }
}
