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

///This widget is a Plan Info Dialog, includes instructions to create a plan
///quote, icon and button to close dialog
///
class PlansInfoDialogDeprecated extends StatelessWidget {
  const PlansInfoDialogDeprecated({super.key});

  List<String> get steps => [
        PiixCopiesDeprecated.verifyMaxProtected,
        PiixCopiesDeprecated.addProtectedInOption,
        PiixCopiesDeprecated.searchProtected,
        PiixCopiesDeprecated.whenFinishClickQuote,
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
                color: PiixColors.errorMain,
              ),
            ),
          ),
          Text(
            PiixCopiesDeprecated.createQuotationInFourSteps,
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
            PiixCopiesDeprecated.importantLabel,
            style: context.primaryTextTheme?.titleSmall,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 12.h),
            child: Text(
              PiixCopiesDeprecated.protectedInfoAfterBuy,
              style: context.textTheme?.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
              height: 26.h,
              child: ElevatedButton(
                  onPressed: () => NavigatorKeyState().getNavigator()?.pop(),
                  child: Text(
                    PiixCopiesDeprecated.understoodLabel.toUpperCase(),
                    style: context.accentTextTheme?.labelMedium?.copyWith(
                      color: PiixColors.space,
                    ),
                  )))
        ],
      ),
    );
  }
}
