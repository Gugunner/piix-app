import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/payment_methods_builder_deprecated.dart';
import 'package:piix_mobile/ui/common/piix_confirm_alert_deprecated.dart';
import 'package:provider/provider.dart';

import 'widgets/payment_methods_info_dialog.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a main payment methods screen, this screen contains a info
///dialog and exit dialog
///
class PaymentMethodsScreenDeprecated extends StatelessWidget {
  static const routeName = '/payment_methods_screen';
  const PaymentMethodsScreenDeprecated({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitPaymentMethods(context),
      child: Scaffold(
        appBar: AppBar(
            title: const Text(PiixCopiesDeprecated.paymentMethods),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () => handleInfoDialog(context),
                  icon: const Icon(Icons.info_outline)),
            ]),
        body: const PaymentMethodsBuilderDeprecated(),
      ),
    );
  }

  ///This future shows the dialog when you want to exit or return to the
  ///previous screen
  Future<bool> exitPaymentMethods(BuildContext context) async {
    final shouldPop = await handlePopDialog(context);
    if (shouldPop == null || !shouldPop) return false;
    final paymentsBLoC = context.read<PaymentsBLoCDeprecated>();
    paymentsBLoC.clearProvider();
    return shouldPop;
  }

  //This feature open a pop dialog to tell the user if he really wants to quit
  Future<bool?> handlePopDialog(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (_) => PiixConfirmAlertDialogDeprecated(
          title: PiixCopiesDeprecated.youSureToExit,
          titleStyle: context.textTheme?.headlineSmall?.copyWith(
            color: PiixColors.primary,
          ),
          message: PiixCopiesDeprecated.looseYoureProgress,
          onCancel: () => Navigator.pop(context, false),
          onConfirm: () => Navigator.pop(context, true),
        ),
      );

  //This function open a info plans dialog
  void handleInfoDialog(BuildContext context) => showDialog<void>(
        context: context,
        barrierColor: PiixColors.mainText.withOpacity(0.62),
        builder: (context) => const PaymentMethodsInfoDialog(),
      );
}
