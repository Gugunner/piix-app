import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/navigation_deprecated/navigation_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/ui/widgets/close_dialog_icon_button_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/purchase_invoice_history_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

/// This widget is a receipt payment exit dialog, renders a text that tells us
///  where we can find the purchase history
///
class ExitReceiptDialogDeprecated extends StatelessWidget {
  const ExitReceiptDialogDeprecated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        children: [
          const CloseDialogIconButtonDeprecated(),
          Text(
            PiixCopiesDeprecated.rememberLabelEllipsis,
            style: context.textTheme?.headlineSmall?.copyWith(
              color: PiixColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: PiixCopiesDeprecated.receiptExitDialogText,
                style: context.textTheme?.bodyMedium,
              ),
              TextSpan(
                text: PiixCopiesDeprecated.purchaseHistory,
                style: context.primaryTextTheme?.titleMedium,
              ),
            ]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 24.h,
            child: ElevatedButton(
              onPressed: () => handleExitReceiptDialog(context),
              child: Text(
                PiixCopiesDeprecated.understoodLabel.toUpperCase(),
                style: context.accentTextTheme?.labelMedium?.copyWith(
                  color: PiixColors.space,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //TODO: Redo the method, this method has a wrong implementation for navigation
  void handleExitReceiptDialog(BuildContext context) {
    final paymentsBLoC = context.read<PaymentsBLoCDeprecated>();
    final navigationProvider = context.read<NavigationProviderDeprecated>();
    paymentsBLoC.userPaymentState = PaymentStateDeprecated.idle;
    navigationProvider.setCurrentNavigationBottomTab(3);
    NavigatorKeyState().navigateToHomeRoute();
    NavigatorKeyState()
        .getNavigator(context)
        ?.pushNamed(PurchaseInvoiceHistoryScreenDeprecated.routeName);
  }
}
