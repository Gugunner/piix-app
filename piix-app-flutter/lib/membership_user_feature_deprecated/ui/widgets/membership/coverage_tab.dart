import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/membership_coverage_status_card.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/piix_benefit_deprecated/piix_benefit_list_deprecated.dart';

//TODO: Rename Widget to reflect use
/// Creates a tab with the coverage info of the membership.
class CoverageTab extends StatelessWidget {
  const CoverageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();

    return Column(
      children: [
        const MembershipCoverageStatusCard(),
        Container(
          margin: EdgeInsets.only(top: screenUtil.setHeight(4)),
          child: const PiixBenefitListDeprecated(),
        ),
      ],
    );
  }
}
