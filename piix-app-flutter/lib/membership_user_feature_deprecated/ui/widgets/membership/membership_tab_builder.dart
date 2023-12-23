import 'package:flutter/material.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_ui_state.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/additions_tab.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/my_membership_coverage_tab.dart';

///This widget contains additions tab and coverage tab
///additions tab contains all purchases data
///coverage tab contains all coverage info and benefits
///
class MembershipTabBuilder extends StatelessWidget {
  const MembershipTabBuilder({
    super.key,
    required this.membershipUiState,
  });

  final MembershipUiState membershipUiState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Builder(
        builder: (BuildContext context) {
          if (membershipUiState.isAdditionsTab) {
            return const AdditionsTab();
          }
          return const MyMembershipCoverageTab();
        },
      ),
    );
  }
}
