import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/extensions/widget_extend.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/membership_coverage_content.dart';
import 'package:piix_mobile/ui/common/piix_tag.dart';
import 'package:piix_mobile/ui/common/piix_tooltip_deprecated.dart';
import 'package:provider/provider.dart';

/// Creates a card that contains the main details of the membership.
final activeInfoKey = GlobalKey();

class MembershipCoverageStatusCard extends StatelessWidget {
  const MembershipCoverageStatusCard({Key? key}) : super(key: key);
  PiixTooltipDeprecated? get tooltipCoverage => PiixTooltipDeprecated(
        offsetKey: activeInfoKey,
        content: Container(
          padding: EdgeInsets.all(12.w),
          child: const MembershipCoverageContent(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final membership =
        context.watch<MembershipProviderDeprecated>().selectedMembership;

    return Card(
      color: PiixColors.greyCard,
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                PiixCopiesDeprecated.membershipCoverage,
                style: context.textTheme?.headlineSmall,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(
                  left: 16.w,
                  right: 10.w,
                ),
                child: PiixTagDeprecated(
                  text: membership?.isActive ?? false
                      ? PiixCopiesDeprecated.activeMembership
                      : PiixCopiesDeprecated.inactiveMembership,
                  backgroundColor: (membership?.isActive ?? false)
                      ? PiixColors.success
                      : PiixColors.secondary,
                ),
              )),
              GestureDetector(
                onTap: handleShowTooltip,
                child: Icon(
                  Icons.info_outline,
                  key: activeInfoKey,
                  color: PiixColors.active,
                ),
              ),
            ],
          ).padHorizontal(10.w),
          const Divider(),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '${PiixCopiesDeprecated.packageText}: ',
                style: context.accentTextTheme?.headlineLarge?.copyWith(
                  color: PiixColors.infoDefault,
                ),
              ),
              TextSpan(
                text: membership?.package.name ?? '',
                style: context.textTheme?.titleMedium,
              ),
            ]),
          ).padHorizontal(10.w),
          SizedBox(height: 6.w),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '${PiixCopiesDeprecated.levelText}: ',
                style: context.accentTextTheme?.headlineLarge?.copyWith(
                  color: PiixColors.infoDefault,
                ),
              ),
              TextSpan(
                text: membership?.usersMembershipLevel.name ?? '',
                style: context.textTheme?.titleMedium,
              ),
            ]),
            textAlign: TextAlign.start,
          ).padHorizontal(10.w),
        ],
      ).padVertical(12.w),
    );
  }

  void handleShowTooltip() {
    if (tooltipCoverage != null && activeInfoKey.currentContext != null) {
      tooltipCoverage!.controller?.showTooltip();
    }
  }
}
