import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/info_dialog_step_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class HowToPayDialogDeprecated extends StatelessWidget {
  const HowToPayDialogDeprecated({Key? key}) : super(key: key);

  double get mediumPadding => ConstantsDeprecated.mediumPadding;

  List<String> get steps => [
        PiixCopiesDeprecated.stepOneHowToPay,
        PiixCopiesDeprecated.stepTwoHowToPay,
        PiixCopiesDeprecated.stepThreeHowToPay,
        PiixCopiesDeprecated.stepFourHowToPay,
      ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(12.h),
      insetPadding: EdgeInsets.all(16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            PiixCopiesDeprecated.howToPay,
            style: context.textTheme?.headlineSmall,
            textAlign: TextAlign.center,
          ).padBottom(16.h).center(),
          ...steps.map((step) {
            final index = steps.indexWhere((_step) => _step == step) + 1;
            return InfoDialogStepDeprecated(
              step: step,
              stepNumber: index,
            ).padBottom(mediumPadding.h);
          }),
          Text(
            '${PiixCopiesDeprecated.importantLabel}:',
            style: context.primaryTextTheme?.titleSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            PiixCopiesDeprecated.updatePay,
            style: context.textTheme?.bodyMedium,
            textAlign: TextAlign.start,
          ).padBottom(16.h),
          SizedBox(
            height: 26.h,
            width: context.width * 0.569,
            child: ElevatedButton(
              onPressed: () => NavigatorKeyState().getNavigator()?.pop(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: PiixColors.activeButton),
              child: Text(
                PiixCopiesDeprecated.understoodLabel.toUpperCase(),
                style: context.accentTextTheme?.labelMedium?.copyWith(
                  color: PiixColors.space,
                ),
              ),
            ),
          ).center()
        ],
      ),
    );
  }
}
