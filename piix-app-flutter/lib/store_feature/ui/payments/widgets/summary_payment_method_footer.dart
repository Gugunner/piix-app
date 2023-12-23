import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/payments_bloc_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/payments/payment_receipt_home_screen_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/skeletons.dart';
import 'package:provider/provider.dart';

///Render a payment method footer, contains capture line button
///
class SummaryPaymentMethodFooter extends StatelessWidget {
  const SummaryPaymentMethodFooter({super.key});

  Radius get cardRadius => Radius.circular(8.h);
  double get minPadding => ConstantsDeprecated.minPadding;

  @override
  Widget build(BuildContext context) {
    final paymentsBLoC = context.watch<PaymentsBLoCDeprecated>();
    final _paymentMethod = paymentsBLoC.selectedPaymentMethod;
    return Card(
        elevation: 3,
        margin: EdgeInsets.zero,
        color: PiixColors.skeletonGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: cardRadius,
            topRight: cardRadius,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: minPadding.h, bottom: 12.h),
          width: context.width,
          child: Column(
            children: [
              Text(
                PiixCopiesDeprecated.payEasyWithPaymentLine,
                style: context.textTheme?.bodyMedium?.copyWith(
                  color: PiixColors.primary,
                ),
              ).padBottom(minPadding.h),
              Container(
                height: 36.h,
                width: context.width.percentageSize(0.862),
                margin: EdgeInsets.symmetric(vertical: 4.h),
                child: ElevatedButton(
                  onPressed:
                      _paymentMethod != null ? handleGetPaymentLine : null,
                  child: Text(
                    PiixCopiesDeprecated.paymentLineButton.toUpperCase(),
                    style: context.primaryTextTheme?.titleMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  ///This method handle navigate capture line screen.
  void handleGetPaymentLine() => NavigatorKeyState()
      .getNavigator()
      ?.pop(PaymentReceiptHomeScreenDeprecated.routeName);
}
