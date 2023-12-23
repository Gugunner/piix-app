import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/domain/bloc_deprecated/purchase_invoice_bloc_deprecated.dart';
import 'package:piix_mobile/purchase_invoice_feature/utils/purchase_invoice_enums.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/cancel_payment_request_model.dart';
import 'package:provider/provider.dart';

///This dialog contains info for payments methods
///
class CancelTicketInvoiceDialog extends StatelessWidget {
  const CancelTicketInvoiceDialog({
    super.key,
    required this.purchaseInvoiceId,
  });
  final String purchaseInvoiceId;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    final paymentsBLoC = context.watch<PaymentsBLoCDeprecated>();
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(16.h),
      insetPadding: EdgeInsets.all(16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        children: [
          if (paymentsBLoC.cancelPaymentState == PaymentStateDeprecated.getting)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator.adaptive(),
                Text(
                  'Estamos procesando la cancelación...',
                  style: context.textTheme?.bodyMedium,
                )
              ],
            )
          else if (paymentsBLoC.cancelPaymentState ==
                  PaymentStateDeprecated.error ||
              paymentsBLoC.cancelPaymentState ==
                  PaymentStateDeprecated.unexpectedError ||
              paymentsBLoC.cancelPaymentState ==
                  PaymentStateDeprecated.badRequest ||
              paymentsBLoC.cancelPaymentState ==
                  PaymentStateDeprecated.notFound ||
              paymentsBLoC.cancelPaymentState ==
                  PaymentStateDeprecated.conflict)
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => NavigatorKeyState().getNavigator()?.pop(),
                    child: const Icon(
                      Icons.close,
                      color: PiixColors.errorMain,
                    ),
                  ),
                ),
                Text(
                  'Ocurrió un error no se pudo cancelar el ticket de compra, '
                  'intenta de nuevo.',
                  style: context.textTheme?.bodyMedium,
                  textAlign: TextAlign.center,
                ).padBottom(16.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text(
                    PiixCopiesDeprecated.okButton.toUpperCase(),
                    style: context.accentTextTheme?.labelMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                  ),
                )
              ],
            )
          else if (paymentsBLoC.cancelPaymentState ==
              PaymentStateDeprecated.accomplished)
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      NavigatorKeyState().getNavigator()?.pop();
                      NavigatorKeyState().getNavigator()?.pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: PiixColors.errorMain,
                    ),
                  ),
                ),
                Text(
                  'Se canceló correctamente el ticket de compra',
                  style: context.textTheme?.bodyMedium,
                  textAlign: TextAlign.center,
                ).padBottom(16.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text(
                    PiixCopiesDeprecated.okButton.toUpperCase(),
                    style: context.accentTextTheme?.labelMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                  ),
                )
              ],
            )
          else
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => NavigatorKeyState().getNavigator()?.pop(),
                    child: const Icon(
                      Icons.close,
                      color: PiixColors.errorMain,
                    ),
                  ),
                ),
                Text(
                  PiixCopiesDeprecated.areYouSureToCancelInvoice,
                  style: context.textTheme?.headlineSmall?.copyWith(
                    color: PiixColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ).padBottom(16.h),
                Text(
                  PiixCopiesDeprecated.pressOkCancelInvoice,
                  style: context.textTheme?.bodyMedium,
                  textAlign: TextAlign.center,
                ).padBottom(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        PiixCopiesDeprecated.cancel.toUpperCase(),
                        style: context.primaryTextTheme?.titleMedium?.copyWith(
                          color: PiixColors.active,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => handleCancelTicket(context),
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        PiixCopiesDeprecated.okButton.toUpperCase(),
                        style: context.accentTextTheme?.labelMedium?.copyWith(
                          color: PiixColors.space,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
        ],
      ),
    );
  }

  void handleCancelTicket(BuildContext context) async {
    final paymentsBLoC = context.read<PaymentsBLoCDeprecated>();
    final purchaseInvoiceBLoC = context.read<PurchaseInvoiceBLoCDeprecated>();
    final user = context.read<UserBLoCDeprecated>().user;
    if (user != null) {
      final cancelPaymentRequest = CancelPaymentRequestModel(
        purchaseInvoiceId: purchaseInvoiceId,
        userId: user.userId,
      );
      await paymentsBLoC.cancelUserPayment(
        cancelPaymentRequest: cancelPaymentRequest,
      );
      if (paymentsBLoC.cancelPaymentState ==
          PaymentStateDeprecated.accomplished) {
        purchaseInvoiceBLoC.modifyStatusInPurchaseInvoiceList(
            purchaseInvoiceId, PaymentStatus.cancelled, ProductStatus.inactive);
      }
    }
  }
}
