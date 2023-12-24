import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/purchase_invoice_feature/ui/widgets/ticket_elevated_button.dart';

@Deprecated('Will be removed in 4.0')

///This widget is a frequent questions dialog for a ticket
///
class FrequentQuestionsDialogDeprecated extends StatelessWidget {
  const FrequentQuestionsDialogDeprecated({Key? key}) : super(key: key);
  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  double get spaceSize => 12;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: mediumPadding.w),
      scrollable: true,
      contentPadding: EdgeInsets.all(mediumPadding.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child:
                          const Icon(Icons.clear, color: PiixColors.errorMain)))
              .padBottom(mediumPadding.h),
          Text(
            PiixCopiesDeprecated.frequentQuestions,
            textAlign: TextAlign.center,
            style: context.textTheme?.headlineMedium,
          ).center().padBottom(12.h),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: PiixCopiesDeprecated.firstFrequentQuestion,
                style: context.primaryTextTheme?.titleSmall,
              ),
              TextSpan(
                text: PiixCopiesDeprecated.firstFrequentAnswer,
                style: context.textTheme?.bodyMedium,
              ),
              TextSpan(
                text: PiixCopiesDeprecated.mailContact,
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                  color: PiixColors.insurance,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: '.',
                style: context.textTheme?.bodyMedium,
              ),
            ]),
            textAlign: TextAlign.justify,
          ).padBottom(spaceSize.h),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: PiixCopiesDeprecated.secondFrequentQuestion,
                style: context.primaryTextTheme?.titleSmall,
              ),
              TextSpan(
                text: PiixCopiesDeprecated.secondFrequentAnswer,
                style: context.textTheme?.bodyMedium,
              ),
            ]),
            textAlign: TextAlign.justify,
          ).padBottom(spaceSize.h),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: PiixCopiesDeprecated.thirdFrequentQuestion,
                style: context.primaryTextTheme?.titleSmall,
              ),
              TextSpan(
                text: PiixCopiesDeprecated.thirdFrequentAnswer,
                style: context.textTheme?.bodyMedium,
              ),
            ]),
            textAlign: TextAlign.justify,
          ).padBottom(spaceSize.h),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: PiixCopiesDeprecated.fourthFrequentQuestion,
                style: context.primaryTextTheme?.titleSmall,
              ),
              TextSpan(
                text: PiixCopiesDeprecated.firstFrequentAnswer,
                style: context.textTheme?.bodyMedium,
              ),
              TextSpan(
                text: PiixCopiesDeprecated.mailContact,
                style: context.primaryTextTheme?.titleMedium?.copyWith(
                    color: PiixColors.insurance,
                    decoration: TextDecoration.underline),
              ),
              TextSpan(
                text: PiixCopiesDeprecated.fourtFrequentAnswerTwo,
                style: context.textTheme?.bodyMedium,
              ),
            ]),
            textAlign: TextAlign.justify,
          ).padBottom(spaceSize.h),
          TicketElevatedButtonDeprecated(
            label: PiixCopiesDeprecated.understoodLabel.toUpperCase(),
            onPressed: () => Navigator.pop(context),
          ).center()
        ],
      ),
    );
  }
}
