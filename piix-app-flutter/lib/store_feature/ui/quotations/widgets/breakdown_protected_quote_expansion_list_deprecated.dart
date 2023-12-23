import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/store_feature/domain/bloc/plans_bloc_deprecated.dart';
import 'package:provider/provider.dart';

@Deprecated('Will be removed in 4.0')

///This widget contains a expanded list to protected for plan quotation
///
class BreakdownProtectedQuoteExpansionListDeprecated extends StatelessWidget {
  const BreakdownProtectedQuoteExpansionListDeprecated({super.key});

  double get mediumPadding => ConstantsDeprecated.mediumPadding;
  Color get greyWhite => PiixColors.greyWhite;
  Color get darkSkyBlue => PiixColors.darkSkyBlue;

  @override
  Widget build(BuildContext context) {
    final plansBLoC = context.read<PlansBLoCDeprecated>();
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          listTileTheme: ListTileTheme.of(context).copyWith(dense: true)),
      child: ExpansionTile(
        collapsedBackgroundColor: greyWhite,
        backgroundColor: greyWhite,
        textColor: PiixColors.mainText,
        iconColor: darkSkyBlue,
        collapsedIconColor: darkSkyBlue,
        title: Text(
          PiixCopiesDeprecated.breakdownProtected,
          style: context.primaryTextTheme?.headlineSmall,
        ),
        childrenPadding: EdgeInsets.all(mediumPadding.h),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(PiixCopiesDeprecated.protectedLabel,
                  style: context.primaryTextTheme?.titleSmall?.copyWith(
                    color: PiixColors.primary,
                  )),
              Text(
                PiixCopiesDeprecated.quantity,
                style: context.primaryTextTheme?.titleSmall?.copyWith(
                  color: PiixColors.primary,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ).padBottom(mediumPadding.h),
          ...plansBLoC.planQuotation!.plans.map(
            (e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.name,
                  style: context.primaryTextTheme?.titleSmall,
                ),
                SizedBox(
                  width: 45.w,
                  child: Text(
                    '${e.protectedAcquired}',
                    style: context.primaryTextTheme?.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ).padBottom(10.h),
          ),
        ],
      ),
    );
  }
}
