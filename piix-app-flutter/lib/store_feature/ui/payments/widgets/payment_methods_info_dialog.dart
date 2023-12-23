import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/info_dialog_step_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///This dialog contains info for payments methods
///
class PaymentMethodsInfoDialog extends StatelessWidget {
  const PaymentMethodsInfoDialog({super.key});

  List<String> get steps => [
        PiixCopiesDeprecated.choosePaymentMethod,
        PiixCopiesDeprecated.afterChoosingPaymentMethod,
        PiixCopiesDeprecated.finallyChoosingPaymentMethod,
        PiixCopiesDeprecated.enjoyAcquiredBenefits,
      ];
  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(16.h),
      content: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => NavigatorKeyState().getNavigator()?.pop(),
              child: const Icon(
                Icons.close,
                color: PiixColors.error,
              ),
            ),
          ),
          Text(
            PiixCopiesDeprecated.paymentMethods,
            style: context.textTheme?.headlineSmall,
            textAlign: TextAlign.center,
          ).padBottom(32.h),
          ...steps.map((step) {
            final index = steps.indexWhere((_step) => _step == step) + 1;
            return InfoDialogStepDeprecated(
              step: step,
              stepNumber: index,
            ).padBottom(mediumPadding.h);
          }),
          Text(
            PiixCopiesDeprecated.buyNowToUpgrade,
            style: context.primaryTextTheme?.titleSmall,
            textAlign: TextAlign.center,
          ).padBottom(34.h),
          SizedBox(
            height: 26.h,
            child: ElevatedButton(
              onPressed: () => NavigatorKeyState().getNavigator()?.pop(),
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
}
