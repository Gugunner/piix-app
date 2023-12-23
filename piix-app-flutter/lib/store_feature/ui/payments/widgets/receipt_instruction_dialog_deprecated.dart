import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/date_extend_deprecated.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/ui/plans/widgets/info_dialog_step_deprecated.dart';
import 'package:piix_mobile/store_feature/utils/payment_methods.dart';

@Deprecated('Will be removed in 4.0')

///This widget, render a receipt payment instruction dialog, includes seven
///steps to make a correct payment
///
class ReceiptInstructionDialogDeprecated extends StatelessWidget {
  const ReceiptInstructionDialogDeprecated({
    super.key,
    required this.expirationDate,
    required this.paymentMethodId,
    required this.paymentMethodName,
  });
  final DateTime expirationDate;
  final String paymentMethodId;
  final String paymentMethodName;

  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  List<String> get steps => [
        PiixCopiesDeprecated.stepThreeToMakePayment,
        PiixCopiesDeprecated.stepFourToMakePayment,
        PiixCopiesDeprecated.stepFiveToMakePayment,
        PiixCopiesDeprecated.stepSixToMakePayment,
        PiixCopiesDeprecated.stepSevenToMakePayment,
      ];
  int get firstStep => 1;
  int get secondStep => 2;
  int get initialStepInList => 3;

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final differenceInDays = getDifferenceInDaysBetweenDates(
      fromDate: currentDate,
      toDate: expirationDate,
    );
    final differenceInHours = getDifferenceInHoursBetweenDates(
          fromDate: currentDate,
          toDate: expirationDate,
        ) -
        (differenceInDays * 24);

    final addDays = differenceInDays > 0 ? '$differenceInDays días' : '';
    final remainingTimeText = '$addDays y $differenceInHours hrs';
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            PiixCopiesDeprecated.howToMakeAPayment,
            style: context.textTheme?.headlineSmall,
            textAlign: TextAlign.center,
          ).padBottom(24.h),
          InfoDialogStepDeprecated(
            step: PiixCopiesDeprecated.stepOneToMakePayment(remainingTimeText),
            stepNumber: firstStep,
          ).padBottom(mediumPadding.h),
          InfoDialogStepDeprecated(
            step: paymentMethodId.stepTwoToMakePayment,
            stepNumber: secondStep,
          ).padBottom(mediumPadding.h),
          ...steps.map((step) {
            //This list must start in step three since we previously showed the
            // first two steps, that is why we add the initialStepInList to
            // stepNumber
            final stepNumber =
                steps.indexWhere((_step) => _step == step) + initialStepInList;
            return InfoDialogStepDeprecated(
              step: step,
              stepNumber: stepNumber,
            ).padBottom(mediumPadding.h);
          }),
          Text(
            PiixCopiesDeprecated.availablePaymentMethods,
            style: context.primaryTextTheme?.titleSmall,
            textAlign: TextAlign.center,
          ).padBottom(4.h),
          Text(
            availablePaymentPlaces(
                id: paymentMethodId, name: paymentMethodName),
            style: context.textTheme?.bodyMedium,
            textAlign: TextAlign.center,
          ).padBottom(24.h),
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
